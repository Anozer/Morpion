#include "configuration.h"
#include <cstddef>

Configuration * Configuration::m_instance = NULL;

Configuration::Configuration()
:m_sizeCodeOp(2)
,m_sizeBus(8)
{
}

Configuration *Configuration::getInstance()
{
    if( m_instance == NULL )
    {
        m_instance = new Configuration();
    }
    return m_instance;
}

Configuration::~Configuration()
{
    if( m_instance != NULL )
    {
        delete m_instance;
        m_instance = NULL;
    }
}

int Configuration::getSizeCodeOp()
{
    return m_sizeCodeOp;
}

int Configuration::getSizeBus()
{
    return m_sizeBus;
}

int Configuration::getSizeData()
{
    return m_sizeBus - m_sizeCodeOp;
}

void Configuration::setSizeCodeOp(int arg_newSize)
{
    m_sizeCodeOp = arg_newSize;
}

void Configuration::setSizeBus(int arg_newSize)
{
    m_sizeBus = arg_newSize;
}
