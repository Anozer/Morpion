#ifndef VARIABLE_H
#define VARIABLE_H

#include <QString>

class Variable
{
    public:
        Variable();
        Variable(QString arg_name, qlonglong arg_value, qlonglong arg_nbLine);
        virtual ~Variable();


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

#endif // VARIABLE_H
