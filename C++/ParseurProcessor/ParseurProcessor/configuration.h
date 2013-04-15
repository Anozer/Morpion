#ifndef CONFIGURATION_H
#define CONFIGURATION_H

class Configuration
{
    public:
        static Configuration * getInstance();
        ~Configuration();

        int getSizeCodeOp();
        int getSizeBus();
        int getSizeData();

        void setSizeCodeOp(int arg_newSize);
        void setSizeBus(int arg_newSize);

    private:
        Configuration();

        static Configuration * m_instance;

        int m_sizeCodeOp;
        int m_sizeBus;
};

#endif // CONFIGURATION_H
