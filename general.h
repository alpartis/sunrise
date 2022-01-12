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

// this function works in a different thread. It gets ProgressWorker as a parameter and uses it like library to process fifo file.
// It is created for reading purpose of progress bar messages. It can finish the thread when it reads the "finish" text message text message
void named_pipe_progress_handler(ProgressWorker *ptr_pw);


#endif
