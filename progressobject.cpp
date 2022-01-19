#include "progressobject.h"
#include "progressworker.h"

ProgressObject::ProgressObject(QObject *parent)
    : QObject{parent}
{
    workerThread.setObjectName("progressThread");
}

float ProgressObject::current()
{
    return m_current;
}

int ProgressObject::currentStep()
{
    return m_step;
}

int ProgressObject::totalStep()
{
    return m_total_step;
}

void ProgressObject::setCurrent(float current)
{
    if (m_current == current)
    {
        return;
    }

    m_current = current;
    emit currentChanged(current);
}

void ProgressObject::setTotalStep(int total)
{
    if (m_total_step == total)
    {
        return;
    }

    m_total_step = total;
    emit totalStepChanged(total);
}

void ProgressObject::startHandler()
{
    setStatus(Status::started);
}

void ProgressObject::finishHandler()
{
    setFinish(true);
}

void ProgressObject::setCurrentStep(int current_step)
{
    if (m_step == current_step)
        return;

    m_step = current_step;
    emit currentStepChanged(m_step);
}

void ProgressObject::setStatus(Status st)
{
    if(st == m_status)
    {
        return;
    }
    m_status = st;

    emit statusChanged(m_status);

}

bool ProgressObject::isFinished()
{
    if (m_status == Status::finished)
    {
        return true;
    }
    return false;
}

void ProgressObject::setFinish(bool yes)
{
    if (yes && !isFinished())
    {
        setStatus(Status::finished);
        emit finished(m_fifo_name);
    }
}

Status ProgressObject::status()
{
    return m_status;
}

void ProgressObject::initJob(progress_handler handler, QString file_name)
{
    m_handler = handler;
    m_fifo_name = file_name;
}

void ProgressObject::prepareJob()
{
    ProgressWorker *worker = new ProgressWorker;

    worker->setInputFileName(m_fifo_name);
    if (m_handler != nullptr)
    {
        worker->setHandler(m_handler);
    }

    worker->moveToThread(&workerThread);

    connect(worker, &ProgressWorker::progressChanged, this, &ProgressObject::setCurrent);
    connect(worker, &ProgressWorker::currentStepChanged, this, &ProgressObject::setCurrentStep);
    connect(worker, &ProgressWorker::totalStepChanged, this, &ProgressObject::setTotalStep);
    connect(worker, &ProgressWorker::started, this, &ProgressObject::startHandler);
    connect(worker, &ProgressWorker::finished, this, &ProgressObject::finishHandler);
    connect(this, &ProgressObject::startJob, worker, &ProgressWorker::startJob);
    connect(this, &ProgressObject::endJob, worker, &ProgressWorker::endJob);

    workerThread.start();
}

QString ProgressObject::getFileName()
{
    return m_fifo_name;
}

ProgressObject::~ProgressObject()
{
    this->endJob();
    workerThread.wait();
    qDebug() << "end of process" << endl;
}

