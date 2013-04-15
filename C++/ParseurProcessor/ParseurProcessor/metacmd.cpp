#include "metacmd.h"

MetaCmd::MetaCmd(QString arg_codeOp)
:m_codeOp(arg_codeOp)
{
}

MetaCmd::~MetaCmd()
{}

void MetaCmd::setArgument(qlonglong arg_argument)
{
    m_argument = arg_argument;
}

qlonglong MetaCmd::getCodeInstruction()
{
    qlonglong value = 0;
    Configuration * myConfig = Configuration::getInstance();
    value = m_codeOp.toLongLong(0, 2);

    if( myConfig != NULL )
    {
        value <<= myConfig->getSizeData();
    }

    value += m_argument;

    return value;
}
