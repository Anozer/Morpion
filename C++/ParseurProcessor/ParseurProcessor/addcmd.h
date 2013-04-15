#ifndef ADDCMD_H
#define ADDCMD_H

#include <metacmd.h>

class AddCmd : public MetaCmd
{
    public:
        AddCmd();
        virtual ~AddCmd();

        static QString getConstQString();

        //virtual void setArgument(qlonglong arg_argument);

    private:
        static const QString s_typeCmd;
        static QString s_codeOp;
};

#endif // ADDCMD_H
