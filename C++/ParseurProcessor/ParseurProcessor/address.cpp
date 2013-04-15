#include "address.h"

Address::Address()
:m_name("")
,m_value(0)
,m_nbLine(0)
{}

Address::Address(QString arg_name, qlonglong arg_value, qlonglong arg_nbLine)
:m_name(arg_name)
,m_value(arg_value)
,m_nbLine(arg_nbLine)
{}

Address::~Address()
{}

void Address::setName(QString arg_name)
{
    m_name = arg_name;
}

void Address::setValue(qlonglong arg_value)
{
    m_value = arg_value;
}

void Address::setNbLine(qlonglong arg_nbLine)
{
    m_nbLine = arg_nbLine;
}

QString Address::getName()
{
    return m_name;
}

qlonglong Address::getValue()
{
    return m_value;
}

qlonglong Address::getNbLine()
{
    return m_nbLine;
}
