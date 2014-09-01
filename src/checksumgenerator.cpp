#include "checksumgenerator.h"
#include "ui_checksumgenerator.h"

ChecksumGenerator::ChecksumGenerator(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::ChecksumGenerator)
{
    ui->setupUi(this);
    QRect position = frameGeometry();
    position.moveCenter(QDesktopWidget().availableGeometry().center());
    move(position.topLeft());

    connect(ui->bBrowseFile, SIGNAL(clicked()), this, SLOT(onBrowseButtonClicked()));
    connect(ui->bGenerate, SIGNAL(clicked()), this, SLOT(onGenerateButtonClicked()));

    this->working = false;
}

ChecksumGenerator::~ChecksumGenerator()
{
    delete ui;
}

void ChecksumGenerator::onBrowseButtonClicked()
{
    QString fileName =
            QFileDialog::getOpenFileName(
                this,
                tr("Open File"),
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

void ChecksumGenerator::onGenerateButtonClicked()
{
    QString f = ui->leFile->text();

    QFile file(f);

    if(f.isEmpty())
    {
        QMessageBox::critical(0, "Error", "You need to supply a location!");
    }
    else if(!file.exists())
    {
        QMessageBox::critical(0, "Not Found", "That file cannot be found!");
    }
    else
    {
        this->mThread = new ValidationThread();
        this->mThread->setFileLocation(f);
        connect(this->mThread, SIGNAL(CalculationPerformed(QString)), this, SLOT(onCalculationPerformed(QString)));
        this->mThread->start();

        ui->bGenerate->setEnabled(false);
        ui->bGenerate->setText("Generating Checksum, please wait..");
        this->working = true;
    }
}

void ChecksumGenerator::onCalculationPerformed(QString hash)
{
    ui->bGenerate->setEnabled(true);
    ui->bGenerate->setText("Generate Checksum");

    ui->leFile->setText(hash);

    QMessageBox::information(0, "Success", "A new checksum has been successfully generated for you. You may copy it from the text field.");
    this->working = false;
}

void ChecksumGenerator::closeEvent(QCloseEvent *event)
{
    if(this->working)
    {
        QMessageBox::StandardButton reply;
        reply = QMessageBox::question(this, "Close", "The generator is still hard at work, are you sure you want to exit?", QMessageBox::Yes|QMessageBox::No);
        if(reply == QMessageBox::Yes)
        {
            event->accept();
        }
        else
        {
            event->ignore();
        }
    }
}
