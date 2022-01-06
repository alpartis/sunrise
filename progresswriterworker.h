#ifndef PROGRESSWWORKER_H
#define PROGRESSWWORKER_H

#include <QObject>
#include <interfacenamedpipe.h>
#include <factory.h>
#include "general.h"

class ProgressWriterWorker : public QObject
{
    Q_OBJECT
    QString m_file_name = "fifo_pipe";
    bool m_named = false;
    InterfaceNamedPipe *m_ptr_named_pipe = nullptr;
    progress_writer_handler m_handler = nullptr;
    bool m_finishing = false;

public:
    float m_progress = 0.0;
    int m_current = 0;
    int m_total_step = 10;

public:
    explicit ProgressWriterWorker(QObject *parent = nullptr);
    ~ProgressWriterWorker();
    void setInputFileName(const QString input, bool named = false);
    void setHandler(progress_writer_handler);
    bool isPipeExist();
    bool isBlocked();
    bool createPipe();
    bool isFinishing();
    void writePipe(const QString content);

public slots:
    void startJob();
    void nextStep();
    void endJob();

signals:
    void progressChanged(float);
    void currentStepChanged(int);
    void totalStepChanged(int);
    void jobEnded();
};

#endif // PROGRESSWWORKER_H
