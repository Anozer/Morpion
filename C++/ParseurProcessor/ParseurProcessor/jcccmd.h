#ifndef JCCCMD_H
#define JCCCMD_H

#include <metacmd.h>

class JccCmd : public MetaCmd
{
    public:
        JccCmd();
        virtual ~JccCmd();

        static QString getConstQString();

        //virtual void setArgument(qlonglong arg_argument);

    private:
        static const QString s_typeCmd;
        static QString s_codeOp;
};

#endif // JCCCMD_H
