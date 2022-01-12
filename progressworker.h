#ifndef PROGRESSWORKER_H
#define PROGRESSWORKER_H

#include <QObject>
#include <interfacenamedpipe.h>
#include <factory.h>
#include "general.h"

struct progressState
{
    int total;
    int current;
    float progress;
    bool match;
};

/**
 * Brief:
 * This class helps to reading the progress of a working thread from a FIFO file. 
 * To use this object, handler should be set by calling setHandler method. 
 * Handler works in a different thread and can use this class as a library for reading purposes.
 * handler is not thread-safe. Be careful.
 *
 * More:
 * This class is the Qt bridge for the named fifo file handler object for only reading.
 * This class limited the real InterfaceNamedPipe derived class into only read access.
 * Real handler object created by a factory and this class behaves like an interface for every IntarfaceNamedPipe derived object.
 * This class uses InterfaceNamedPipe class for only reading purposes.
 *
 *
 * Architecture Description:
 * This class uses for thread signalling for the main Qt Application thread.
 * Object for this class should be created by a controller class and should be moved to a new thread.
 * In this way, we can start a long-term job in a separate thread and emit signals to the main Qt Application thread.
 * @link: https://doc.qt.io/qt-5/qthread.html
 */

class ProgressWorker : public QObject
{
    Q_OBJECT
    QString m_file_name = "fifo_pipe";
    bool m_named = false;
    InterfaceNamedPipe *m_ptr_named_pipe = nullptr;
    progress_handler m_handler = nullptr;
    bool m_finishing = false;
    bool m_blocked = false;

public:
    float m_progress = 0.0;
    int m_current = 0;
    int m_total_step = 0;

public:
    explicit ProgressWorker(QObject *parent = nullptr);
    ~ProgressWorker();
    /*  set FIFO file name before calling startJob   */
    void setInputFileName(const QString input, bool named = false);
    /* 
    * progress_handler runs in a different thread, it gets this class as a parameter to read the FIFO channel for getting progress results 
    * Be careful!. Read operation block the thread. To end of the thread, "finished" text shoulb be written from different thread.
    */
    void setHandler(progress_handler);
    bool isPipeExist();
    bool isBlocked();
    bool createPipe();
    bool isFinishing();
    /* parse message and load the values into m_progress, m_current and m_total_step */
    progressState parseForProgress(const QString &message);
    /* read from FIFO file. Be careful it blocks the thread */
    QString readPipe();
    bool deletePipe();

public slots:
    void startJob();
    void endJob();

signals:
    void progressChanged(float);
    void currentStepChanged(int);
    void totalStepChanged(int);
    /* before reading this signal emitted. Therefore we know this thread will be blocked. */
    void beforeBlock(QString file_name);
    /* After reading this signal emitted. Therefore we know this thread will be unblocked again. */
    void afterBlock(QString file_name);
    /* this signal emitted when the reading is finished */
    void finished();
    /* this signal emitted when the reading is started */
    void started();
};

#endif // PROGRESSWORKER_H
