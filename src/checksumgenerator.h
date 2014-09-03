#ifndef CHECKSUMGENERATOR_H
#define CHECKSUMGENERATOR_H

#include <QWidget>
#include <QFile>
#include <QFileDialog>
#include <QMessageBox>
#include <QRect>
#include <QDesktopWidget>
#include <QCloseEvent>

#include "validationthread.h"

namespace Ui {
class ChecksumGenerator;
}

class ChecksumGenerator : public QWidget
{
    Q_OBJECT

public:
    explicit ChecksumGenerator(QWidget *parent = 0);
    ~ChecksumGenerator();
    ValidationThread *mThread;

private:
    Ui::ChecksumGenerator *ui;
    bool working;
    void closeEvent(QCloseEvent *);

private slots:
    void onBrowseButtonClicked();
    void onGenerateButtonClicked();
    void onCalculationPerformed(QString);

};

#endif // CHECKSUMGENERATOR_H
