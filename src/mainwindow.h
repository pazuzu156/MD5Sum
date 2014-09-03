#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QFileDialog>
#include <QFile>
#include <QMessageBox>
#include <QTextStream>
#include <QProgressBar>
#include <QRect>
#include <QDesktopWidget>
#include <QCloseEvent>

#include "validationthread.h"
#include "checksumgenerator.h"
#include "aboutdialog.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    ValidationThread *mThread;

private:
    Ui::MainWindow *ui;
    void alert(QString, QString, bool critical = false);
    void establishUIConnections();
    bool working;

protected:
    void closeEvent(QCloseEvent * e = NULL);

private slots:
    void onExitActionTriggered();
    void onAboutActionTriggered();
    void onBrowseFileButtonClicked();
    void onBrowseHashButtonClicked();
    void onValidateButtonClicked();
    void onCalculationPerformed(QString);
    void OpenChecksumGeneratorWindow();
};

#endif // MAINWINDOW_H
