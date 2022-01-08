#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>

#include <progressworker.h>
#include <progressobject.h>

#include <progresswriterworker.h>
#include <progresswriterobject.h>

#include <QQmlContext>
#include "general.h"
#include <QTimer>


void named_pipe_progress_handler(ProgressWorker *ptr_pw)
{
    show_thread();
    if (ptr_pw->isFinishing())
    {
        return;
    }
    if (!ptr_pw->isPipeExist())
    {
        bool result = ptr_pw->createPipe();
        if (!result)
        {
            qDebug() << "error : named pipe wasn't created" << endl;
            return;
        }
    }
    QString line = ptr_pw->readPipe();
    if (line.compare("finished") == 0)
    {
        ptr_pw->endJob();
        return;
    }
    progressState state = ptr_pw->parseForProgress(line);
    if (state.match)
    {
        if (ptr_pw->m_current != state.current)
        {
            ptr_pw->m_current = state.current;
            emit ptr_pw->currentStepChanged(state.current);
        }

        if (ptr_pw->m_total_step != state.total)
        {
            ptr_pw->m_total_step = state.total;
            emit ptr_pw->totalStepChanged(state.total);
        }
        if (ptr_pw->m_progress != state.progress)
        {

            ptr_pw->m_progress = state.progress;
            emit ptr_pw->progressChanged(state.progress);
        }
    }
    qDebug() << "read content from named piped file: " << line << endl;
    QTimer::singleShot(1000, ptr_pw, &ProgressWorker::startJob);
}

void named_pipe_progress_writer_handler(ProgressWriterWorker *ptr_pw)
{
    show_thread();
    int step = ptr_pw->m_current;
    int total_step = ptr_pw->m_total_step;

    if (!ptr_pw->isPipeExist())
    {
        if (!ptr_pw->isFinishing())
        {
            // not possible to write. Wait for fifo pipe readiness.
            QTimer::singleShot(1000, ptr_pw, &ProgressWriterWorker::nextStep);
            return;
        }
        // nothing to do. Thread is finishing.
        return;
    }

    if (step > total_step || ptr_pw->isFinishing())
    {
        ptr_pw->writePipe("finished\n");
        ptr_pw->endJob();
        return;
    }

    QString line = QString("Step %1 of 10\n").arg(step);
    ptr_pw->writePipe(line);
    QThread::sleep(5);
    qDebug() << "Piped file content writed: " << line << endl;
    ptr_pw->m_current++;
    QTimer::singleShot(1000, ptr_pw, &ProgressWriterWorker::nextStep);
}

int main(int argc, char *argv[])
{
    set_thread_name("main thread");

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QTranslator qtTranslator;
    qtTranslator.load(":/i18n/strings_en_US", ".");
    app.installTranslator(&qtTranslator);

    QQmlApplicationEngine engine;
    QString path = QGuiApplication::applicationDirPath();
    engine.addImportPath("qrc:/");
    engine.addImportPath("qrc:/imports");
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    ProgressObject prog_obj;
    ProgressWriterObject prog_writer_obj;
    prog_obj.initJob(named_pipe_progress_handler, "fifo_pipe");
    prog_obj.prepareJob();

    prog_writer_obj.initJob(named_pipe_progress_writer_handler, "fifo_pipe");
    prog_writer_obj.prepareJob();

    engine.rootContext()->setContextProperty("ProgressObj", &prog_obj);
    engine.rootContext()->setContextProperty("ProgressWriterObj", &prog_writer_obj);

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app, [url, &prog_obj, &prog_writer_obj](QObject *obj, const QUrl &objUrl)
        {
            if (!obj && (url == objUrl))
                QCoreApplication::exit(-1);
            //emit prog_obj.startJob();
           // emit prog_writer_obj.startJob();
    },
        Qt::QueuedConnection);

    engine.load(url);

    show_thread();

    QObject::connect(&app, &QGuiApplication::aboutToQuit,[&prog_writer_obj,&prog_obj](){
        if(prog_obj.isFinished()) return;
        InterfaceNamedPipe * pipeWriter = Factory::createNamedPipeObject("fifo_pipe");
        pipeWriter->pipeWrite("finished\n");
        delete pipeWriter;

    } );

    return app.exec();
}
