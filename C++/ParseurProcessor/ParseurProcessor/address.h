#ifndef ADDRESS_H
#define ADDRESS_H

#include <QString>

class Address
{
    public:
        Address();
        Address(QString arg_name, qlonglong arg_value, qlonglong arg_nbLine);
        virtual ~Address();

        void setName(QString arg_name);
        void setValue(qlonglong arg_value);
        void setNbLine(qlonglong arg_nbLine);

        QString getName();
        qlonglong getValue();
        qlonglong getNbLine();

private:
        QString m_name;
        int m_value;
        int m_nbLine;
};

#endif // ADDRESS_H
