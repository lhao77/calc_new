#ifndef STRINGMGR_H
#define STRINGMGR_H

#include <string>
#include <map>

//class TypeString
//{
//public:
//    //std::string name;
//    std::map<int,std::string> mapLangTypes;
//
//    TypeString(/*const char* _name,*/int _i,const char* _descript)/*:name(_name)*/
//    {
//        mapLangTypes.insert( std::pair<int,std::string>(_i,std::string(_descript)) );
//    }
//};

typedef std::map<int,std::string> TypeString;

class StringMgr
{
private:
    static StringMgr *p_StrMgr;
    StringMgr(){}
    std::map<std::string,TypeString> mapTypeString;
    int lang_idx;
public:
    static StringMgr* GetStringMgr();
    
    void init();
    std::string GetDescript(std::string name,int lang_idx);
    std::string GetDescript(std::string name);
    
    void setLang_idx(int idx){lang_idx = idx;}
    int  getLang_idx(){return lang_idx;};
};

#endif