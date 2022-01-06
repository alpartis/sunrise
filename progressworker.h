#ifndef PROGRESSWORKER_H
#define PROGRESSWORKER_H

#include <QObject>
#include <interfacenamedpipe.h>
#include <factory.h>
#include "general.h"

typedef struct progressState
{
    int total;
    int current;
    float progress;
    bool match;
};

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
    void setInputFileName(const QString input, bool named = false);
    void setHandler(progress_handler);
    bool isPipeExist();
    bool isBlocked();
    bool createPipe();
    bool isFinishing();
    progressState parseForProgress(const QString &message);
    QString readPipe();
    void writePipe(const QString content);
    bool deletePipe();

public slots:
    void startJob();
    void endJob();

signals:
    void progressChanged(float);
    void currentStepChanged(int);
    void totalStepChanged(int);
};

#endif // PROGRESSWORKER_H
