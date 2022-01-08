#ifndef PROGRESSOBJECT_H
#define PROGRESSOBJECT_H

#include <QObject>
#include "progressworker.h"
#include <QThread>
#include "general.h"

class ProgressStatus
{
    Q_GADGET
    Q_CLASSINFO("RegisterEnumClassesUnscoped", "false")
public:
    ProgressStatus() = delete;

    enum class Value
    {
        not_initialized,
        initialized,
        started,
        finished,
        blocked
    };
    Q_ENUM(Value)
};

typedef ProgressStatus::Value Status;
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
    void initJob(progress_handler handler, const QString file_name = "fifo_pipe");
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
    Q_INVOKABLE void startJob();
    Q_INVOKABLE void endJob();
    void jobDone(const QString result);

private:
    QThread workerThread;
};

#endif // PROGRESSOBJECT_H
