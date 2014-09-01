#include "validationthread.h"

ValidationThread::ValidationThread(QObject *parent) :
    QThread(parent)
{
}

void ValidationThread::setFileLocation(QString fileName)
{
    this->fileName = fileName;
}

void ValidationThread::run()
{
    QMutex mutex;
    mutex.lock();

    QCryptographicHash c(QCryptographicHash::Md5);
    QFile file(this->fileName);
    file.open(QFile::ReadOnly);
    while(!file.atEnd())
    {
        c.addData(file.read(8192));
    }
    QByteArray hashData = c.result();
    QString hash = hashData.toHex();

    mutex.unlock();

    emit CalculationPerformed(hash);
}
