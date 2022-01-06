#ifndef GENERAL_H
#define GENERAL_H
#include <QThread>
#include <QDebug>
class ProgressWorker;
class ProgressWriterWorker;

typedef void (*progress_handler)(ProgressWorker *);
typedef void (*progress_writer_handler)(ProgressWriterWorker *);

void show_thread();

void set_thread_name(QString name);

#endif
