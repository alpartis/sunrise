#ifndef PROGRESSOBJECT_H
#define PROGRESSOBJECT_H

#include <QObject>
#include "progressworker.h"
#include <QThread>
#include "general.h"


class ProgressObject : public QObject
{
    Q_OBJECT
    float m_current = 0.0; // current progress percentage
    int m_step = 0; // current step
    int m_total_step = 0; // total step
    progress_handler m_handler = nullptr;
    QString m_fifo_name;
    Q_PROPERTY(float current READ current WRITE setCurrent NOTIFY currentChanged)
    Q_PROPERTY(int currentStep READ currentStep WRITE setCurrentStep NOTIFY currentStepChanged)
    Q_PROPERTY(int totalStep READ totalStep WRITE setTotalStep NOTIFY totalStepChanged)
public:
    explicit ProgressObject(QObject *parent = nullptr);
    ~ProgressObject();
    float current();
    int totalStep();
    int currentStep();
    void setCurrent(float);
    void setTotalStep(int);
    void setCurrentStep(int);
    void initJob(progress_handler handler, const QString file_name = "fifo_pipe");
    Q_INVOKABLE void prepareJob();

signals:
    void currentChanged(float);
    void currentStepChanged(int);
    void totalStepChanged(int);
    Q_INVOKABLE void startJob();
    Q_INVOKABLE void endJob();
    void jobDone(const QString result);

private:
    QThread workerThread;
};

#endif // PROGRESSOBJECT_H
