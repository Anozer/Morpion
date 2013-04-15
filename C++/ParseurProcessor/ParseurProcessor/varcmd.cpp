#include "varcmd.h"

const QString VarCmd::s_typeCmd = "VAR";
QString VarCmd::s_codeOp = "00";

VarCmd::VarCmd()
:MetaCmd(s_codeOp)
{
}

VarCmd::~VarCmd()
{
}

QString VarCmd::getConstQString()
{
    return s_typeCmd;
}
/*
void VarCmd::setArgument(int arg_argument)
{
    m_argument = arg_argument;
}
*/
