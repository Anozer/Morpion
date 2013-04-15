#include "jcccmd.h"

const QString JccCmd::s_typeCmd = "JCC";
QString JccCmd::s_codeOp = "11";

JccCmd::JccCmd()
:MetaCmd(s_codeOp)
{
}

JccCmd::~JccCmd()
{}

QString JccCmd::getConstQString()
{
    return s_typeCmd;
}
