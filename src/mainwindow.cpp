#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QRect position = frameGeometry();
    position.moveCenter(QDesktopWidget().availableGeometry().center());
    move(position.topLeft());

    ui->statusBar->showMessage("Ready");

    this->establishUIConnections();
    this->working = false;
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::establishUIConnections()
{
    // Menubar action connections
    connect(ui->actionExit, SIGNAL(triggered()), this, SLOT(onExitActionTriggered()));
    connect(ui->actionChecksum_Generator, SIGNAL(triggered()), this, SLOT(OpenChecksumGeneratorWindow()));
    connect(ui->actionAbout, SIGNAL(triggered()), this, SLOT(onAboutActionTriggered()));

    // Connect browse buttons with SIGNALS and SLOTS
    connect(ui->bBrowseFile, SIGNAL(clicked()), this, SLOT(onBrowseFileButtonClicked()));
    connect(ui->bBrowseHash, SIGNAL(clicked()), this, SLOT(onBrowseHashButtonClicked()));

    // Connect validate button
    connect(ui->bValidate, SIGNAL(clicked()), this, SLOT(onValidateButtonClicked()));
}

// Browse File Button Slot
void MainWindow::onBrowseFileButtonClicked()
{
    // Grab filename to get path for leFile
    QString fileName =
            QFileDialog::getOpenFileName(
                this,
                tr("Open File to Validate"),
                "/",
                tr("All Files (*)")
            );

    if(!fileName.isEmpty())
    {
        // Append location to leFile, but change / if on windows machine
        #ifdef Q_OS_WIN32
            ui->leFile->setText(fileName.replace("/", "\\"));
        #else
            ui->leFile->setText(fileName);
        #endif
    }
}

// Browse Hash Button Slot
void MainWindow::onBrowseHashButtonClicked()
{
    // Grab filename to read and obtain hash
    QString fileName =
            QFileDialog::getOpenFileName(
                this,
                tr("Open Checksum Hash File"),
                "/",
                tr("MD5 Hash Files (*.md5)")
            );

    // check if user selected anything
    if(!fileName.isEmpty())
    {
        // Open file, but in read only!
        QFile file(fileName);
        if(!file.open(QIODevice::ReadOnly))
        {
            this->alert("File Error", file.errorString(), true);
        }

        // Create stream and list for lines
        QTextStream in(&file);
        QStringList lines;

        while(!file.atEnd())
        {
            QString line = in.readLine();
            lines = line.split("  ");
        }

        // Append hash to leHash
        ui->leHash->setText(lines[0]);
    }
}

void MainWindow::onValidateButtonClicked()
{
    // Instantiate mThread
    this->mThread = new ValidationThread();

    QString file = ui->leFile->text();
    QString hash = ui->leHash->text();

    // Get filename for statusbar
    QStringList pieces = file.split("\\");
    QString fileName = pieces.value(pieces.length() - 1);

    // For checking if file exists
    QFile filed(file);

    if(file.isEmpty())
    {
        this->alert("No File", "You need to supply the file's location!", true);
    }
    else if(hash.isEmpty())
    {
        this->alert("No Hash", "You need to supply the hash or browse for a hash file!", true);
    }
    else if(!filed.exists())
    {
        this->alert("File Not Found", "That file cannot be found!", true);
    }
    else
    {
        this->mThread->setFileLocation(file);
        connect(mThread, SIGNAL(CalculationPerformed(QString)), this, SLOT(onCalculationPerformed(QString)));
        this->mThread->start();

        // Status Bar
        ui->statusBar->showMessage("Computing MD5 hash of file: " + fileName + " | Please Wait...");

        // Validate Button
        ui->bValidate->setEnabled(false);
        ui->bValidate->setText("Validating..");

        // set working to true
        this->working = true;
    }
}

void MainWindow::onCalculationPerformed(QString hash)
{
    if(ui->leHash->text() == hash)
    {
        this->alert("Success", "The file checksum is valid!");
        ui->statusBar->showMessage("Validation successful!");
    }
    else
    {
        this->alert("Failed", "The file checksum did not match the MD5 checksum supplied!");
        ui->statusBar->showMessage("Validation failed!");
    }
    ui->bValidate->setEnabled(true);
    ui->bValidate->setText("Run Validator");

    // revert working to false
    this->working = false;
}

void MainWindow::alert(QString title, QString message, bool critical)
{
    if(critical)
    {
        QMessageBox::critical(0, title, message);
    }
    else
    {
        QMessageBox::information(0, title, message);
    }
}

void MainWindow::OpenChecksumGeneratorWindow()
{
    ChecksumGenerator *w = new ChecksumGenerator();
    w->show();
}

void MainWindow::onAboutActionTriggered()
{
    AboutDialog *w = new AboutDialog();
    w->setAppVersion("1.0.1");
    w->setGenVersion("1.0.1");
    w->show();
}

// Used from actionExit to trigger closeEvent()
void MainWindow::onExitActionTriggered()
{
    if(this->working)
    {
        QMessageBox::StandardButton reply;
        reply = QMessageBox::question(this, "Close", "MD5Sum is still hard at work, are you sure you want to exit?", QMessageBox::Yes|QMessageBox::No);
        if(reply == QMessageBox::Yes)
        {
            QApplication::quit();
        }
    }
    else
    {
        QApplication::quit();
    }
}

// Override main window closeEvent to shutdown app upon close
void MainWindow::closeEvent(QCloseEvent *event)
{
    if(this->working)
    {
        QMessageBox::StandardButton reply;
        reply = QMessageBox::question(this, "Close", "MD5Sum is still hard at work, are you sure you want to exit?", QMessageBox::Yes|QMessageBox::No);
        if(reply == QMessageBox::Yes)
        {
            qApp->quit();
        }
        else
        {
            event->ignore();
        }
    }
    else
    {
        qApp->quit();
    }
}
