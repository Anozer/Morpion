#ifndef METACMD_H
#define METACMD_H

#include <QString>
#include <configuration.h>

class MetaCmd
{
    public:
        MetaCmd(QString arg_str);
        virtual ~MetaCmd();

        virtual void setArgument(qlonglong arg_argument);
        virtual qlonglong getCodeInstruction();

    protected:
        QString m_codeOp;
        qlonglong m_argument;
};

#endif // METACMD_H
