#ifndef NORCMD_H
#define NORCMD_H

#include <metacmd.h>

class NorCmd : public MetaCmd
{
    public:
        NorCmd();
        virtual ~NorCmd();

        static QString getConstQString();

        //virtual void setArgument(int arg_argument);

    private:
        static const QString s_typeCmd;
        static QString s_codeOp;
};

#endif // NORCMD_H
