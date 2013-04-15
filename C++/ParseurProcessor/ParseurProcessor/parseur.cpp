#include "parseur.h"
#include <configuration.h>

#include <metacmd.h>
#include <varcmd.h>
#include <factorycmd.h>
#include <QStringList>

Parseur::Parseur(QString arg_dataIn)
{
    m_dataIn = arg_dataIn.split(QString('\n'));
    m_dataOut = "";

    int nbLine = m_dataIn.size();
    m_lastLineNotEmpty = 0;
    m_firstLineNotEmpty = 0;

    for(int idx = 0; idx != nbLine; ++idx)
    {
        m_dataIn[idx].replace(QRegExp("\t+", Qt::CaseInsensitive), QString(' '));
        m_dataIn[idx].replace(QRegExp(" +", Qt::CaseInsensitive), QString(' '));
        m_dataIn[idx].replace(QRegExp("^ $", Qt::CaseInsensitive), "");
        m_dataIn[idx].replace(QRegExp(" $", Qt::CaseInsensitive), "");

        if(!(m_dataIn[idx].isEmpty()))
        {
            m_lastLineNotEmpty = idx;
        }

        if((m_dataIn[idx].isEmpty()) && (m_lastLineNotEmpty <= m_firstLineNotEmpty))
        {
            m_firstLineNotEmpty = idx + 1;
        }
    }
    m_lastLineNotEmpty += 1;

    m_mapVariable.clear();
    m_mapAddress.clear();
}

QString Parseur::createExe()
{
    firstParse();
    secondParse();

    return m_dataOut;
}

void Parseur::firstParse()
{
    for(int idx = m_firstLineNotEmpty; idx != m_lastLineNotEmpty; ++idx)
    {
        if( m_dataIn[idx].contains(VarCmd::getConstQString(), Qt::CaseInsensitive) )
        {
            if( m_dataIn[idx].contains(QString(":="), Qt::CaseInsensitive) )
            {
                QStringList l_list = m_dataIn[idx].split(QString(' '));
                if( (l_list.size() >= 4) && (QString::compare(l_list[2], ":=") == 0 ) )
                {
                    qlonglong value = 0;
                    if( l_list[3].startsWith("0x") || l_list[3].startsWith("0X") )
                    {
                        value = l_list[3].mid(2).toLongLong(0, 16);
                    }
                    else if( l_list[3].startsWith("0b") || l_list[3].startsWith("0B") )
                    {
                        value = l_list[3].mid(2).toLongLong(0, 2);
                    }
                    else if( l_list[3].startsWith("0") )
                    {
                        value = l_list[3].mid(1).toLongLong(0, 8);
                    }
                    else
                    {
                        value = l_list[3].toLongLong();
                    }
                    Variable var(l_list[1], value, qlonglong(idx - m_firstLineNotEmpty));
                    m_mapVariable.insert(pair<QString, Variable>(l_list[1], var));
                }
            }
        }
        else if( m_dataIn[idx].contains(QString("<="), Qt::CaseInsensitive) )
        {
            QStringList l_list = m_dataIn[idx].split(" ");
            if( (l_list.size() >= 4) && (QString::compare(l_list[2], "<=") == 0) )
            {
                qlonglong value = qlonglong(idx - m_firstLineNotEmpty);
                Address add(l_list[3], value, value);
                m_mapAddress.insert(pair<QString, Address>(l_list[3], add));
            }
        }
    }
}

Address * Parseur::findAdd(QString & arg_str)
{
    Address * value = NULL;
    map<QString, Address>::iterator it;
    for(it = m_mapAddress.begin(); it != m_mapAddress.end(); ++it)
    {
        if( QString::compare(it->first, arg_str, Qt::CaseInsensitive) == 0 )
        {
            value = &(it->second);
            break;
        }
    }
    return value;
}

Variable * Parseur::findVar(QString & arg_str)
{
    Variable * value = NULL;
    map<QString, Variable>::iterator it;
    for(it = m_mapVariable.begin(); it != m_mapVariable.end(); ++it)
    {
        if( QString::compare(it->first, arg_str, Qt::CaseInsensitive) == 0 )
        {
            value = &(it->second);
            break;
        }
    }
    return value;
}

void Parseur::secondParse()
{
    Configuration * myConfig = Configuration::getInstance();
    for(int idx = m_firstLineNotEmpty; idx != m_lastLineNotEmpty; ++idx)
    {
        QStringList l_list = m_dataIn[idx].split(" ");
        if( (l_list.size() >= 2) )
        {
            MetaCmd * myCmd = factoryCmd::createCmd(l_list[0]);
            if( myCmd != NULL )
            {
                Address * add = findAdd(l_list[1]);
                Variable * var = findVar(l_list[1]);
                if( add != NULL )
                {
                    myCmd->setArgument(add->getNbLine());
                }
                else if( var != NULL )
                {
                    myCmd->setArgument(var->getNbLine());
                }
                else
                {
                    // On ne fait rien car c'est un cas d'erreur.
                }

                if( QString::compare(l_list[0], VarCmd::getConstQString(), Qt::CaseInsensitive) == 0 )
                {
                    myCmd->setArgument(var->getValue());
                }

                if((add != NULL) || (var != NULL))
                {
                    QString str;
                    qlonglong instruction = myCmd->getCodeInstruction();
                    if( myConfig != NULL )
                    {
                        m_dataOut += QString::number(idx - m_firstLineNotEmpty, 10);

                        if( (myConfig->getSizeBus() % 4) == 0 )
                        {
                            str = QString::number(instruction, 16).toUpper();
                            m_dataOut += " => x\"";

                            if( (str.size() * 4) >= myConfig->getSizeBus() )
                            {
                                str = str.right(myConfig->getSizeBus()/4);
                            }
                            else
                            {
                                while( (str.size() * 4) != myConfig->getSizeBus() )
                                {
                                    str = "0" + str;
                                }
                            }
                        }
                        else
                        {
                            str = QString::number(instruction, 2);
                            m_dataOut += " => \"";

                            if( str.size() >= myConfig->getSizeBus() )
                            {
                                str = str.right(myConfig->getSizeBus());
                            }
                            else
                            {
                                while( str.size() != myConfig->getSizeBus() )
                                {
                                    str = "0" + str;
                                }
                            }
                        }
                        m_dataOut += str;
                        m_dataOut += "\",";

                        if( idx != m_lastLineNotEmpty - 1 )
                        {
                            m_dataOut += "\n";
                        }
                        else
                        {
                            m_dataOut += "\nothers => ";
                            str = "0";
                            if( (myConfig->getSizeBus() % 4) == 0 )
                            {
                                m_dataOut += "x\"";
                                while( (str.size() * 4) != myConfig->getSizeBus() )
                                {
                                    str += "0";
                                }
                            }
                            else
                            {
                                m_dataOut += "\"";
                                while( str.size() != myConfig->getSizeBus() )
                                {
                                    str += "0";
                                }
                            }
                            m_dataOut += str;
                            m_dataOut += "\"";
                        }
                    }
                }
                else
                {
                    /*
                    m_dataOut += QString::number(idx - m_firstLineNotEmpty, 10);

                    m_dataOut += " => x\"00\";";
                    if( idx != m_lastLineNotEmpty - 1 )
                    {
                        m_dataOut += "\n";
                    }
                    else
                    {
                        m_dataOut += "\nothers => x\"00\"";
                    }
                    */
                    /// Code jamais atteignable sauf si commande inconnu
                }
            }
            delete myCmd;
            myCmd = NULL;
        }
    }
}
