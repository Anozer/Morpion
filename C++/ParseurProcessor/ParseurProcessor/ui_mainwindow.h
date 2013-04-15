/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created: Mon 9. Apr 14:09:07 2012
**      by: Qt User Interface Compiler version 4.7.4
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QGridLayout>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QMainWindow>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QSpinBox>
#include <QtGui/QTextEdit>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralWidget;
    QGridLayout *gridLayout;
    QHBoxLayout *horizontalLayout_2;
    QLabel *lbl_sizeBus;
    QSpinBox *sB_sizeBus;
    QSpacerItem *horizontalSpacer_2;
    QLabel *lbl_sizeCodeOp;
    QSpinBox *sB_sizeCodeOp;
    QSpacerItem *horizontalSpacer_3;
    QVBoxLayout *verticalLayout;
    QLabel *lbl_in;
    QTextEdit *pTE_in;
    QVBoxLayout *verticalLayout_2;
    QLabel *lbl_out;
    QTextEdit *pTE_out;
    QHBoxLayout *horizontalLayout;
    QPushButton *pB_compile;
    QSpacerItem *horizontalSpacer;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QString::fromUtf8("MainWindow"));
        MainWindow->resize(648, 434);
        centralWidget = new QWidget(MainWindow);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        gridLayout = new QGridLayout(centralWidget);
        gridLayout->setSpacing(6);
        gridLayout->setContentsMargins(11, 11, 11, 11);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setSpacing(6);
        horizontalLayout_2->setObjectName(QString::fromUtf8("horizontalLayout_2"));
        lbl_sizeBus = new QLabel(centralWidget);
        lbl_sizeBus->setObjectName(QString::fromUtf8("lbl_sizeBus"));
        QFont font;
        font.setFamily(QString::fromUtf8("Times New Roman"));
        font.setPointSize(14);
        font.setBold(true);
        font.setWeight(75);
        lbl_sizeBus->setFont(font);

        horizontalLayout_2->addWidget(lbl_sizeBus);

        sB_sizeBus = new QSpinBox(centralWidget);
        sB_sizeBus->setObjectName(QString::fromUtf8("sB_sizeBus"));
        sB_sizeBus->setMinimum(8);
        sB_sizeBus->setMaximum(64);

        horizontalLayout_2->addWidget(sB_sizeBus);

        horizontalSpacer_2 = new QSpacerItem(80, 20, QSizePolicy::Fixed, QSizePolicy::Minimum);

        horizontalLayout_2->addItem(horizontalSpacer_2);

        lbl_sizeCodeOp = new QLabel(centralWidget);
        lbl_sizeCodeOp->setObjectName(QString::fromUtf8("lbl_sizeCodeOp"));
        lbl_sizeCodeOp->setFont(font);

        horizontalLayout_2->addWidget(lbl_sizeCodeOp);

        sB_sizeCodeOp = new QSpinBox(centralWidget);
        sB_sizeCodeOp->setObjectName(QString::fromUtf8("sB_sizeCodeOp"));
        sB_sizeCodeOp->setMinimum(2);
        sB_sizeCodeOp->setMaximum(63);

        horizontalLayout_2->addWidget(sB_sizeCodeOp);

        horizontalSpacer_3 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout_2->addItem(horizontalSpacer_3);


        gridLayout->addLayout(horizontalLayout_2, 0, 0, 1, 2);

        verticalLayout = new QVBoxLayout();
        verticalLayout->setSpacing(6);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        lbl_in = new QLabel(centralWidget);
        lbl_in->setObjectName(QString::fromUtf8("lbl_in"));
        lbl_in->setFont(font);

        verticalLayout->addWidget(lbl_in);

        pTE_in = new QTextEdit(centralWidget);
        pTE_in->setObjectName(QString::fromUtf8("pTE_in"));
        QSizePolicy sizePolicy(QSizePolicy::MinimumExpanding, QSizePolicy::Expanding);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(pTE_in->sizePolicy().hasHeightForWidth());
        pTE_in->setSizePolicy(sizePolicy);
        pTE_in->setMinimumSize(QSize(310, 0));
        pTE_in->setFont(font);
        pTE_in->setLineWrapMode(QTextEdit::NoWrap);

        verticalLayout->addWidget(pTE_in);


        gridLayout->addLayout(verticalLayout, 1, 0, 1, 1);

        verticalLayout_2 = new QVBoxLayout();
        verticalLayout_2->setSpacing(6);
        verticalLayout_2->setObjectName(QString::fromUtf8("verticalLayout_2"));
        lbl_out = new QLabel(centralWidget);
        lbl_out->setObjectName(QString::fromUtf8("lbl_out"));
        lbl_out->setFont(font);

        verticalLayout_2->addWidget(lbl_out);

        pTE_out = new QTextEdit(centralWidget);
        pTE_out->setObjectName(QString::fromUtf8("pTE_out"));
        sizePolicy.setHeightForWidth(pTE_out->sizePolicy().hasHeightForWidth());
        pTE_out->setSizePolicy(sizePolicy);
        pTE_out->setMinimumSize(QSize(310, 0));
        pTE_out->setFont(font);
        pTE_out->setLineWrapMode(QTextEdit::NoWrap);

        verticalLayout_2->addWidget(pTE_out);


        gridLayout->addLayout(verticalLayout_2, 1, 1, 1, 1);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setSpacing(6);
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        pB_compile = new QPushButton(centralWidget);
        pB_compile->setObjectName(QString::fromUtf8("pB_compile"));

        horizontalLayout->addWidget(pB_compile);

        horizontalSpacer = new QSpacerItem(300, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout->addItem(horizontalSpacer);


        gridLayout->addLayout(horizontalLayout, 2, 0, 1, 2);

        MainWindow->setCentralWidget(centralWidget);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "MainWindow", 0, QApplication::UnicodeUTF8));
        lbl_sizeBus->setText(QApplication::translate("MainWindow", "Taille du Bus", 0, QApplication::UnicodeUTF8));
        lbl_sizeCodeOp->setText(QApplication::translate("MainWindow", "Taille des CodeOp", 0, QApplication::UnicodeUTF8));
        lbl_in->setText(QApplication::translate("MainWindow", "Taper le programme ci-dessous :", 0, QApplication::UnicodeUTF8));
        lbl_out->setText(QApplication::translate("MainWindow", "Programme en hexad\303\251cimal :", 0, QApplication::UnicodeUTF8));
        pB_compile->setText(QApplication::translate("MainWindow", "Complier", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
