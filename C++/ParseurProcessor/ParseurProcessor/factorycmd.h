#ifndef FACTORYCMD_H
#define FACTORYCMD_H

#include <metacmd.h>
#include <QString>

class factoryCmd
{
    public:
        static MetaCmd * createCmd(QString arg_str);

    private:
        factoryCmd();
};

#endif // FACTORYCMD_H
