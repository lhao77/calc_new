//
//  def.h
//  calc
//
//  Created by hao luo on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef calc_def_h
#define calc_def_h

#include <string>
#include <map>
#include <vector>
#include <set>

struct Functions {
    std::string type;
    std::vector<std::string> names;
    Functions(std::string _type,std::vector<std::string> _names):type(_type),names(_names)
    {
    }
    Functions(){}
};
extern std::vector< Functions > g_type_func;

#endif
