#include "StringMgr.h"
#include "tinyxml.h"
#include "def.h"
#include "stdlib.h"

#define XML_FILENAME    "string.xml"
#define ITEM            "item"
#define DESCRIPT        "descript"

std::string xml_path;
StringMgr* StringMgr::p_StrMgr = 0;

StringMgr* StringMgr::GetStringMgr()
{
    if(!p_StrMgr)
    {
        p_StrMgr = new StringMgr();
    }

    return p_StrMgr;
}

void StringMgr::init()
{
    //const char* filepath = XML_FILENAME;  
    TiXmlDocument doc(xml_path.c_str());  
    bool loadOkay = doc.LoadFile();  
    ASSERT(loadOkay);   // faile to load.

    //get dom root and read xml.  
    TiXmlElement* root = doc.RootElement();
    for( TiXmlNode*  item = root->FirstChild(ITEM);item;item = item->NextSibling(ITEM))
    {
        TiXmlAttribute* nameAttribute = item->ToElement()->FirstAttribute();
        const char* name = nameAttribute->Value(); 

        std::map<int,std::string> mapIdxDescript;
        for( TiXmlNode* child = item->FirstChild();child;child = child->NextSibling(DESCRIPT))
        {
            const char* lang = child->ToElement()->FirstAttribute()->Value();
            int idx = atoi(lang);

            //ASSERT(-1 != sscanf(lang,"%d",idx));
            //child = item->IterateChildren(child);  

            const char* descript = child->ToElement()->GetText();

            mapIdxDescript.insert( std::pair<int,std::string>(idx,std::string(descript)) );
        }

        mapTypeString.insert( std::pair<std::string,TypeString>(std::string(name),mapIdxDescript) );
    }
}

std::string StringMgr::GetDescript(std::string name,int lang_idx)
{
    std::string ret("Unknow String");

    std::map<std::string,TypeString>::iterator iter = mapTypeString.find(name);
    if(iter!=mapTypeString.end())
    {
        ret =  (iter->second)[lang_idx];
    }

    return ret;
}