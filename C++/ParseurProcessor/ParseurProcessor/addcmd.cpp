#include "addcmd.h"

const QString AddCmd::s_typeCmd = "ADD";
QString AddCmd::s_codeOp = "01";

AddCmd::AddCmd()
:MetaCmd(s_codeOp)
{
}

AddCmd::~AddCmd()
{}

QString AddCmd::getConstQString()
{
    return s_typeCmd;
}

/*
void AddCmd::setArgument(qlonglong arg_argument)
{
    m_argument = arg_argument;
}
*/
