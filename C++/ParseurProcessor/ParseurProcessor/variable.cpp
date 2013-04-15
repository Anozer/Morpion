#include "variable.h"

Variable::Variable()
:m_name("")
,m_value(0)
,m_nbLine(0)
{}

Variable::Variable(QString arg_name, qlonglong arg_value, qlonglong arg_nbLine)
:m_name(arg_name)
,m_value(arg_value)
,m_nbLine(arg_nbLine)
{}

Variable::~Variable()
{}

void Variable::setName(QString arg_name)
{
    m_name = arg_name;
}

void Variable::setValue(qlonglong arg_value)
{
    m_value = arg_value;
}

void Variable::setNbLine(qlonglong arg_nbLine)
{
    m_nbLine = arg_nbLine;
}

QString Variable::getName()
{
    return m_name;
}

qlonglong Variable::getValue()
{
    return m_value;
}

qlonglong Variable::getNbLine()
{
    return m_nbLine;
}
