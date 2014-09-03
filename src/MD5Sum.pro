#-------------------------------------------------
#
# Project created by QtCreator 2014-08-24T01:18:56
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = MD5Sum
TEMPLATE = app

RC_FILE = icon.rc

SOURCES += main.cpp\
        mainwindow.cpp \
    validationthread.cpp \
    checksumgenerator.cpp \
    aboutdialog.cpp

HEADERS  += mainwindow.h \
    validationthread.h \
    checksumgenerator.h \
    aboutdialog.h

FORMS    += mainwindow.ui \
    checksumgenerator.ui \
    aboutdialog.ui

RESOURCES += \
    gear_icon_resource.qrc
