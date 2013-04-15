#include "factorycmd.h"
#include <cstddef>
#include <iostream>

using namespace std;

// include de commande
#include <jcccmd.h>
#include <addcmd.h>
#include <norcmd.h>
#include <stacmd.h>
#include <varcmd.h>

MetaCmd * factoryCmd::createCmd( QString arg_str )
{
    MetaCmd * returnValue = NULL;
    if(QString::compare(arg_str, AddCmd::getConstQString(), Qt::CaseInsensitive) == 0)
    {
        returnValue = new AddCmd();
    }
    else if(QString::compare(arg_str, NorCmd::getConstQString(), Qt::CaseInsensitive) == 0)
    {
        returnValue = new NorCmd();
    }
    else if(QString::compare(arg_str, JccCmd::getConstQString(), Qt::CaseInsensitive) == 0)
    {
        returnValue = new JccCmd();
    }
    else if(QString::compare(arg_str, StaCmd::getConstQString(), Qt::CaseInsensitive) == 0)
    {
        returnValue = new StaCmd();
    }
    else if(QString::compare(arg_str, VarCmd::getConstQString(), Qt::CaseInsensitive) == 0)
    {
        returnValue = new VarCmd();
    }
    else
    {
        // Commande inconnue
        returnValue = NULL;
    }
    return returnValue;
}

factoryCmd::factoryCmd()
{}
