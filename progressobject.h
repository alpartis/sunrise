#ifndef PROGRESSOBJECT_H
#define PROGRESSOBJECT_H

#include <QObject>
#include "progressworker.h"
#include <QThread>
#include "general.h"

/**
 * brief :
 * ProgressStatus enum Qt Class created for QML environment.
 */
class ProgressStatus
{
    Q_GADGET
    Q_CLASSINFO("RegisterEnumClassesUnscoped", "false")
public:
    ProgressStatus() = delete;

    enum class Value
    {
        not_initialized, //Before any settings
        initialized, //Settings ok, but not a progress reading is not started
        started, //A progress reading started
        finished, //A progress finished
        blocked // A progress reading started and reading thread is blocked for a new text message
    };
    Q_ENUM(Value)
};

typedef ProgressStatus::Value Status;
/**
 * brief :
 * ProgressObject used for creating and controlling a ProgressWorker object.
 * It creates a ProgressWorker object and moves it into to new thread and listens signals of the ProgressWorker object.
 * Then when the progress values is changed, it automatically changes QML object with new values. 
 * 
 */
class ProgressObject : public QObject
{
    Q_OBJECT
    float m_current = 0.0; // current progress percentage
    int m_step = 0;        // current step
    int m_total_step = 0;  // total step
    progress_handler m_handler = nullptr;
    QString m_fifo_name;
    bool m_finished = false;
    Status m_status = Status::not_initialized;
    Q_PROPERTY(float current READ current WRITE setCurrent NOTIFY currentChanged)
    Q_PROPERTY(int currentStep READ currentStep WRITE setCurrentStep NOTIFY currentStepChanged)
    Q_PROPERTY(int totalStep READ totalStep WRITE setTotalStep NOTIFY totalStepChanged)
    Q_PROPERTY(bool finished READ isFinished WRITE setFinish NOTIFY finished)
    Q_PROPERTY(Status status READ status WRITE setStatus NOTIFY statusChanged )
public:
    explicit ProgressObject(QObject *parent = nullptr);
    ~ProgressObject();
    float current();
    int totalStep();
    bool isFinished();
    void setFinish(bool yes);
    Status status();
    int currentStep();
    void setCurrent(float);
    void setTotalStep(int);
    void setCurrentStep(int);
    void setStatus(Status st);
    QString getFileName();
    /* need for initialization for the job. progress_handler and m_fifo_name should be set before starting the job */
    void initJob(progress_handler handler, const QString file_name = "fifo_pipe");
    /* this method for creating a thread and worker object. It should be called after the initJob */
    Q_INVOKABLE void prepareJob();
public slots:
    void startHandler();
    void finishHandler();

signals:
    void currentChanged(float);
    void currentStepChanged(int);
    void totalStepChanged(int);
    void finished(QString file_name);
    void started(QString file_name);
    void statusChanged(Status);
    //invoke the startJob method to start the ProgressWorker Object that conected in the preparJob
    Q_INVOKABLE void startJob();
    //invoke the endJob method to stop the ProgressWorker Object 
    Q_INVOKABLE void endJob();
    void jobDone(const QString result);

private:
    QThread workerThread;
};

#endif // PROGRESSOBJECT_H
