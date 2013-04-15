#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <configuration.h>

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
        Q_OBJECT
        
    public:
        explicit MainWindow(QWidget *parent = 0);
        ~MainWindow();
        
    private:
        Ui::MainWindow *ui;
        Configuration * m_config;

    private slots:
        void traitement();
};

#endif // MAINWINDOW_H
