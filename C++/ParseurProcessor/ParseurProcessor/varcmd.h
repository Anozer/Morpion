#ifndef VARCMD_H
#define VARCMD_H

#include <metacmd.h>

class VarCmd : public MetaCmd
{
    public:
        VarCmd();
        virtual ~VarCmd();

        static QString getConstQString();

        //virtual void setArgument(int arg_argument);

    private:
        static const QString s_typeCmd;
        static QString s_codeOp;
};

#endif // VARCMD_H
