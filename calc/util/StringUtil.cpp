//
//  StringUtil.cpp
//  tab
//
//  Created by lei zhang on 12-1-18.
//  Copyright (c) 2012年 gameloft. All rights reserved.
//

#include <iostream>
#include <stdio.h>
#include <string>
#include "def.h"

bool isValidNumber(const char *src)
{
    ASSERT(src);
    
    int len = strlen(src);
    if (len==0) {
        return true;
    }
    const char *p = src;
    
    if(!isdigit(*p))
    {
        return false;
    }
    p++;
    int count_dot = 0;
    while (*p) {
        
        if (isdigit(*p)) {
            p++;
            continue;
        }
        else if (*p=='.' && count_dot==0)
        {
            p++;
            count_dot++;
            continue;
        }
        else
            return false;
    }
    
    return true;
}