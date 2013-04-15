#include "stacmd.h"

const QString StaCmd::s_typeCmd = "STA";
QString StaCmd::s_codeOp = "10";

StaCmd::StaCmd()
:MetaCmd(s_codeOp)
{
}

StaCmd::~StaCmd()
{}

QString StaCmd::getConstQString()
{
    return s_typeCmd;
}
/*
void StaCmd::setArgument(int arg_argument)
{
    m_argument = arg_argument;
}
*/
