#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>

#include <progressworker.h>
#include <progressobject.h>


#include <QQmlContext>
#include "general.h"
#include <QTimer>
#include <models/favoritegirlmodel.h>

QObject * booty_bp_invoke = nullptr;


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
            //Direct call and set
            if(booty_bp_invoke != nullptr)
            {
                booty_bp_invoke->setProperty("value",state.progress);
                QMetaObject::invokeMethod(booty_bp_invoke,"invokeExample",Qt::QueuedConnection,Q_ARG(QVariant,(state.progress + 0.25)));
            }
        }
        if(ptr_pw->m_progress >= 1.0)
        {
            emit ptr_pw->finished();
        }
    }
    qDebug() << "read content from named piped file: " << line << endl;
    QTimer::singleShot(1000, ptr_pw, &ProgressWorker::startJob);
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
    prog_obj.initJob(named_pipe_progress_handler, "fifo_pipe");
    prog_obj.prepareJob();

    // Model C++ to qml connection
    FavoriteGirlModel fg_model;
    fg_model.addFavoriteGirl(FavoriteGirl("Amy","Bredwell"));
    fg_model.addFavoriteGirl(FavoriteGirl("Ruby","Sherwood"));
    engine.rootContext()->setContextProperty("list_of_favorite_girls", QVariant::fromValue(&fg_model));
    // End of Model C++ to qml connection


    engine.rootContext()->setContextProperty("ProgressObj", &prog_obj);
    qRegisterMetaType<Status>("Status");
    qmlRegisterUncreatableType<ProgressStatus>("thundernet.general", 1, 0, "Status", "Not creatable generic status enum");

    QObject::connect(
                &engine,
                &QQmlApplicationEngine::objectCreated,
                &app,
                [url,&prog_obj](QObject *obj, const QUrl &objUrl)
                    {
                        if (!obj && (url == objUrl))
                        QCoreApplication::exit(-1);
                        if(url == objUrl)
                        {
                            booty_bp_invoke = obj->findChild<QObject*>("booty_pb_invoke");
                            //Starting reading FIFO
                            prog_obj.startJob();
                            
                        }

                    },
                Qt::QueuedConnection
                );

    engine.load(url);

    show_thread();

    QObject::connect(&app, &QGuiApplication::aboutToQuit,[&prog_obj](){
        if(prog_obj.isFinished()) return;
        InterfaceNamedPipe * pipeWriter = Factory::createNamedPipeObject(prog_obj.getFileName());
        pipeWriter->pipeWrite("finished\n");
        delete pipeWriter;

    } );

    return app.exec();
}
