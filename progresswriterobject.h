#ifndef PROGRESSWOBJECT_H
#define PROGRESSWOBJECT_H

#include <QObject>
#include "progressworker.h"
#include <QThread>
#include "general.h"


class ProgressWriterObject : public QObject
{
    Q_OBJECT
    float m_current = 0.0; // current progress percentage
    int m_step = 0; // current step
    int m_total_step = 0; // total step
    progress_writer_handler m_handler = nullptr;
    QString m_fifo_name;
    Q_PROPERTY(float current READ current WRITE setCurrent NOTIFY currentChanged)
    Q_PROPERTY(int currentStep READ currentStep WRITE setCurrentStep NOTIFY currentStepChanged)
    Q_PROPERTY(int totalStep READ totalStep WRITE setTotalStep NOTIFY totalStepChanged)
public:
    explicit ProgressWriterObject(QObject *parent = nullptr);
    ~ProgressWriterObject();
    float current();
    int totalStep();
    int currentStep();
    void setCurrent(float);
    void setTotalStep(int);
    void setCurrentStep(int);
    void initJob(progress_writer_handler handler, const QString file_name = "fifo_pipe");
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

#endif // PROGRESSWOBJECT_H
