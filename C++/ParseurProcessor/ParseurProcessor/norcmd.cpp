#include "norcmd.h"

const QString NorCmd::s_typeCmd = "NOR";
QString NorCmd::s_codeOp = "00";

NorCmd::NorCmd()
:MetaCmd(s_codeOp)
{
}

NorCmd::~NorCmd()
{}

QString NorCmd::getConstQString()
{
    return s_typeCmd;
}
/*
void NorCmd::setArgument(int arg_argument)
{
    m_argument = arg_argument;
}
*/
