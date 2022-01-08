#include "progressworker.h"
#include "general.h"
#include <QTimer>
#include <QCoreApplication>
#include <QRegularExpression>
#include <QRegularExpressionMatch>

ProgressWorker::ProgressWorker(QObject *parent)
    : QObject{parent}
{
}

ProgressWorker::~ProgressWorker()
{
    if (m_ptr_named_pipe != nullptr)
    {
        delete m_ptr_named_pipe;
    }
}

void ProgressWorker::setInputFileName(const QString file_name, bool named)
{
    this->m_file_name = file_name;
    this->m_named = named;
}

void ProgressWorker::setHandler(progress_handler handler)
{
    m_handler = handler;
}

bool ProgressWorker::isBlocked()
{
    return m_blocked;
}

bool ProgressWorker::isPipeExist()
{
    if (this->m_ptr_named_pipe == nullptr)
    {
        return false;
    }

    return this->m_ptr_named_pipe->isExist();
}

bool ProgressWorker::createPipe()
{
    if (this->m_ptr_named_pipe != nullptr)
    {
        delete this->m_ptr_named_pipe;
    }

    this->m_ptr_named_pipe = Factory::createNamedPipeObject(this->m_file_name);

    if (this->m_ptr_named_pipe != nullptr)
    {
        m_ptr_named_pipe->setName(m_file_name);
        return m_ptr_named_pipe->create();
    }

    return false;
}

QString ProgressWorker::readPipe()
{
    if (!isPipeExist())
    {
        return QString("");
    }

    m_blocked = true;
    emit beforeBlock(m_file_name);
    // this will block the thread.
    QString result = m_ptr_named_pipe->pipeRead();
    emit afterBlock(m_file_name);
    m_blocked = false;
    return result;
}

void ProgressWorker::writePipe(const QString content)
{
    if (!isPipeExist())
    {
        return;
    }

    m_ptr_named_pipe->pipeWrite(content);
}

bool ProgressWorker::deletePipe()
{

    if (!isPipeExist())
    {
        return true;
    }

    return m_ptr_named_pipe->deletePipe();
}

void ProgressWorker::startJob()
{
    emit started();
    set_thread_name(m_file_name + " thread");

    if (m_handler == nullptr)
    {
        return;
    }
    m_handler(this);
}

progressState ProgressWorker::parseForProgress(const QString &message)
{
    progressState progress_state;
    QRegularExpression re("^Step (\\d+) of (\\d+)$");
    QRegularExpressionMatch match = re.match(message);
    bool hasMatch = match.hasMatch(); // true
    if (!hasMatch)
    {
        progress_state.match = false;
        return progress_state;
    }
    progress_state.current = match.captured(1).toInt();
    progress_state.total = match.captured(2).toInt();
    if (progress_state.total == 0)
    {
        progress_state.match = false;
        return progress_state;
    }
    progress_state.progress = float(progress_state.current) / float(progress_state.total);
    return progress_state;
}

bool ProgressWorker::isFinishing()
{
    return m_finishing;
}

void ProgressWorker::endJob()
{
    qDebug() << "ending job" << endl;
    m_finishing = true;
    deletePipe();

    if (m_ptr_named_pipe != nullptr)
    {
        delete m_ptr_named_pipe;
        m_ptr_named_pipe = nullptr;
    }

    QThread::currentThread()->quit();
    emit finished();
}
