#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <parseur.h>
#include <configuration.h>

#include <QString>
#include <QStringList>
#include <iostream>

using namespace std;

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    connect(ui->pB_compile, SIGNAL(clicked()), this, SLOT(traitement()));
    m_config = Configuration::getInstance();
    m_config->setSizeBus(8);
    m_config->setSizeCodeOp(2);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::traitement()
{
    m_config->setSizeBus(ui->sB_sizeBus->value());
    m_config->setSizeCodeOp(ui->sB_sizeCodeOp->value());
    Parseur myParseur(ui->pTE_in->toPlainText());
    QString l_data = myParseur.createExe();
    ui->pTE_out->setPlainText(l_data);

    /*
    QString l_data = ui->pTE_in->toPlainText();
    ui->pTE_out->setPlainText(l_data);
    */
}
