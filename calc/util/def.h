//
//  def.h
//  calc
//
//  Created by hao luo on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef calc_def_h
#define calc_def_h

#include <assert.h>

#ifdef _DEBUG
# define ASSERT(x) assert(x)
#else
# define ASSERT(x) (void*)0
#endif 


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


//等额本息、等额本金的输入
struct input_eq_payment
{
    //bool   b_eq_installment;
    bool   b_calc_by_loan_amount;
    double loan_amount;
    int    months;
    double interest;
    
    double area;
    double price_per_centiare;
    double mortgage_percentage;
};

//等额本息的输出
struct output_eq_installment_payment
{
    double house_price;
    double initial_payment;
    double loan_amount;    
    double payment_amount;
    double interest_amount;
    double payment_permonth;
};

//等额本金的输出
struct output_eq_interest_payment
{
    double house_price;
    double initial_payment;
    double loan_amount;    
    double payment_amount;
    double interest_amount;
    std::vector<double> vec_payment_permonth;
};

//-----------------------------提前还贷-----------------------------
//Prepayment Input Struct
struct input_prepayment_eq_installment
{
    double loan_amount;
    int    months_amount;
    double interest_former;
    double interest_new;
    int    months_passed;
    double wish_payment_this_month;
    bool   b_wish_pay_all;
    bool   b_wish_reduce_payment_permonth;
};

//Prepayment Result Struct
struct result_prepayment_eq_installment
{
    double old_payment_permonth;
    double new_payment_permonth;
    double actual_payment_this_month;
    double saved_interest_expense;
    double payment_paid;
    double interest_paid;
    int    months_former;
    int    months_new;
    bool   bpay_all;
};
#endif
