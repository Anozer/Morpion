#ifndef PARSEUR_H
#define PARSEUR_H

#include <QString>
#include <QStringList>
#include <map>

using namespace std;

#include <variable.h>
#include <address.h>

class Parseur
{
    public:
        Parseur(QString arg_dataIn);
        QString createExe();

        void firstParse();
        void secondParse();

        Address * findAdd(QString &arg_str);
        Variable *findVar(QString &arg_str);
private:
        QStringList m_dataIn;
        QString m_dataOut;

        int m_lastLineNotEmpty;
        int m_firstLineNotEmpty;
        map<QString, Variable> m_mapVariable;
        map<QString, Address> m_mapAddress;
};

#endif // PARSEUR_H
