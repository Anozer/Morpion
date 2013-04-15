#ifndef STACMD_H
#define STACMD_H

#include <metacmd.h>

class StaCmd : public MetaCmd
{
    public:
        StaCmd();
        virtual ~StaCmd();

        static QString getConstQString();

        //virtual void setArgument(int arg_argument);

    private:
        static const QString s_typeCmd;
        static QString s_codeOp;
};

#endif // STACMD_H
