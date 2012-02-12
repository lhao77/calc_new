//
//  calc.cpp
//

#include <vector>
#include <math.h>
#include <string>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

//#define FORMAT "��%d�£�%fԪ\n"

//�ȶϢ���ȶ�������
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

//�ȶϢ�����
struct output_eq_installment_payment
{
    double house_price;
    double initial_payment;
    double loan_amount;    
    double payment_amount;
    double interest_amount;
    double payment_permonth;
};

//�ȶ������
struct output_eq_interest_payment
{
    double house_price;
    double initial_payment;
    double loan_amount;    
    double payment_amount;
    double interest_amount;
    std::vector<double> vec_payment_permonth;
};

//����ȶϢ�¾�������
double calc_payment_permonth_eq_installment(double loan_amount,int months,double interest)
{
    double dtmp = pow((1+interest/12),months);
    return loan_amount*interest/12*dtmp/(dtmp-1);
}

//�ȶϢ���
struct output_eq_installment_payment calc_eq_installment_payment(struct input_eq_payment input)
{
    struct output_eq_installment_payment output;
    
    if(input.b_calc_by_loan_amount)
    {
        output.house_price = -1;
        output.initial_payment = -1;
        output.loan_amount = input.loan_amount;
        output.payment_permonth = calc_payment_permonth_eq_installment(input.loan_amount,input.months,input.interest);
        output.payment_amount = output.payment_permonth*input.months;
        output.interest_amount = output.payment_amount-input.loan_amount;
    }
    else
    {
        output.house_price = input.area*input.price_per_centiare;
        output.initial_payment = output.house_price*(1-input.mortgage_percentage);
        output.loan_amount = output.house_price-output.initial_payment;
        output.payment_permonth = calc_payment_permonth_eq_installment(output.loan_amount,input.months,input.interest);
        output.payment_amount = output.payment_permonth*input.months;
        output.interest_amount = output.payment_amount-output.loan_amount;
    }
    
    return output;
}

//����ȶ���ÿ�»���
std::vector<double> calc_equal_interest(double loan_amount,int months,double interest,
                                        std::vector<double> &vec_payment_permonth,double &payment_amount)
{    
    double dg = loan_amount/months;
    payment_amount = 0.0f;
    
    for (int idx=0; idx<months; idx++) {
        double dtmp = (loan_amount - dg*idx)*interest/12+dg;
        vec_payment_permonth.push_back(dtmp);
        payment_amount += dtmp;
    }
    return vec_payment_permonth;
}

//�ȶ�𻹿
struct output_eq_interest_payment calc_eq_interest_payment(struct input_eq_payment input)
{
    struct output_eq_interest_payment output;
    
    if(input.b_calc_by_loan_amount)
    {
        output.house_price = -1;
        output.initial_payment = -1;
        output.loan_amount = input.loan_amount;
        output.vec_payment_permonth = calc_equal_interest(input.loan_amount,input.months,input.interest,
                                                          output.vec_payment_permonth,output.payment_amount);
        output.interest_amount = output.payment_amount-output.loan_amount;
    }
    else
    {
        output.house_price = input.area*input.price_per_centiare;
        output.initial_payment = output.house_price*(1-input.mortgage_percentage);
        output.loan_amount = output.house_price-output.initial_payment;
        output.vec_payment_permonth = calc_equal_interest(output.loan_amount,input.months,input.interest,
                                                          output.vec_payment_permonth,output.payment_amount);
        output.interest_amount = output.payment_amount-output.loan_amount;
    }
    
    return output;
}

//��ʽ��ÿ�»���
std::string format_eq_interest(std::vector<double> vec_db,const char* format)
{
    std::string ret;
    char tmp[100];
    //char sz[20] = "��%d�£�%fԪ\n";
    int size = vec_db.size();
    for(int idx=0;idx<size;idx++)
    {
        sprintf(tmp,format,idx+1,vec_db[idx]);
        ret += tmp;
    }
    ret.erase(ret.length()-1);
    return ret;
}

//-----------------------------��ǰ����-----------------------------
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

//�ȶϢ��n���º���Ƿ���д���Ϊ�� ����A(1+��)^n-X[1+(1+��)+(1+��)^2+��+(1+��)^(n-1)] = A(1+��)^n-X[(1+��)^n-1]/��
double calc_loan_amount_after_n_months(double loan_amount,int months_amount,double pre_interest,int months_passed,double paid_per_month)
{
    //double paid_per_month = calc_payment_permonth_eq_installment(loan_amount,months_amount,pre_interest);
    double dtmp = pow((1+pre_interest/12),months_passed);
    return loan_amount*dtmp-paid_per_month*(dtmp-1)/(pre_interest/12);
}

//��ǰ��������µĵȶϢ��ÿ�»���
double calc_prepayment_permonth_eq_installment(double loan_amount,int months_amount,double pre_interest,double new_interest,int months_passed,double payment)
{
    double paid_per_month = calc_payment_permonth_eq_installment(loan_amount,months_amount,pre_interest);
    double loan = calc_loan_amount_after_n_months(loan_amount,months_amount,pre_interest,months_passed,paid_per_month)-(payment+paid_per_month);//���˰�������12���µģ���ǰ�����Ǹ��»�Ҫ�ึһ���£�Ī���������ǰ�������
    
    double pay = calc_payment_permonth_eq_installment(loan,months_amount-months_passed,new_interest);
    return pay;
}

//���λ���֮��ʣ�������Ŀ
double calc_loan_amount_after_prepayment_eq_installment(double loan,double payment,double paid_per_month)
{
    return loan-(payment+paid_per_month);//���˰�������12���µģ���ǰ�����Ǹ��»�Ҫ�ึһ���£�Ī���������ǰ�������
}

//����ÿ�»����Ȳ���ʱ����Ҫ�Ļ�������
int calc_months_need(double loan_amount,int months_amount,double pre_interest,double paid_per_month)
{
    for(int i=1;i<=months_amount;i++)
    {
        if(calc_loan_amount_after_n_months(loan_amount,months_amount,pre_interest,i,paid_per_month)<0)
        {
            return i-1;
        }
    }
}

//��ǰ�������
struct result_prepayment_eq_installment calc_prepayment_eq_installment(struct input_prepayment_eq_installment input)
{
    struct result_prepayment_eq_installment ret;
    
    if(input.b_wish_pay_all)
    {
        input.wish_payment_this_month = input.loan_amount*10;
    }
    
    double old_payment_permonth = calc_payment_permonth_eq_installment(input.loan_amount,input.months_amount,input.interest_former);
    double loan_amount_after_n_months = calc_loan_amount_after_n_months(input.loan_amount,input.months_amount,input.interest_former,input.months_passed,old_payment_permonth);
    double loan_amount_after_prepayment_eq_installment= calc_loan_amount_after_prepayment_eq_installment(loan_amount_after_n_months,input.wish_payment_this_month,old_payment_permonth);
    
    ret.old_payment_permonth = old_payment_permonth;
    ret.payment_paid = ret.old_payment_permonth*input.months_passed;
    ret.interest_paid = ret.payment_paid-(input.loan_amount-loan_amount_after_n_months);
    ret.months_former = input.months_amount;
    
    if(loan_amount_after_prepayment_eq_installment>0)
    {
        ret.actual_payment_this_month = input.wish_payment_this_month+ret.old_payment_permonth;

        if(input.b_wish_reduce_payment_permonth)
        {
            ret.new_payment_permonth = calc_payment_permonth_eq_installment(loan_amount_after_prepayment_eq_installment,input.months_amount-input.months_passed,input.interest_new);
//            ret.actual_payment_this_month = input.wish_payment_this_month+ret.old_payment_permonth;
        
            ret.saved_interest_expense = ret.old_payment_permonth*(input.months_amount-input.months_passed)-ret.new_payment_permonth*(input.months_amount-input.months_passed)-ret.actual_payment_this_month;
            ret.months_new = input.months_amount;
        }
        else
        {
            int months_need = calc_months_need(loan_amount_after_prepayment_eq_installment,input.months_amount,input.interest_former,old_payment_permonth);
            ret.months_new = months_need+input.months_passed;
            ret.new_payment_permonth = calc_payment_permonth_eq_installment(loan_amount_after_prepayment_eq_installment,months_need,input.interest_new);
            ret.saved_interest_expense = ret.old_payment_permonth*(input.months_amount-input.months_passed)-ret.new_payment_permonth*months_need-ret.actual_payment_this_month;
        }
        ret.bpay_all = false;
    }
    else
    {
        ret.new_payment_permonth = 0.0f;
        ret.actual_payment_this_month = loan_amount_after_n_months*(1+input.interest_new/12);
        
        ret.saved_interest_expense = ret.old_payment_permonth*(input.months_amount-input.months_passed)-ret.new_payment_permonth*(input.months_amount-input.months_passed)-ret.actual_payment_this_month;
        ret.months_new = 0;
        ret.bpay_all = true;
    }
    
    return ret;
}

void test_calc_eq_installment_payment()
{
    printf("========test_calc_prepayment_eq_installment=========\n");
    printf("====================================================\n");
}

void test_calc_eq_interest_payment()
{
    printf("========test_calc_prepayment_eq_installment=========\n");
    printf("====================================================\n");
}

void test_calc_prepayment_eq_installment()
{
    printf("========test_calc_prepayment_eq_installment=========\n");

    struct input_prepayment_eq_installment input = {40*10000,20*12,4.9/100,4.9/100,1*12,10*10000,false,false};
    struct result_prepayment_eq_installment ret = calc_prepayment_eq_installment(input);

    printf("ret.old_payment_permonth==%f==\n",ret.old_payment_permonth);
    printf("ret.new_payment_permonth==%f==\n",ret.new_payment_permonth);
    printf("ret.actual_payment_this_month==%f==\n",ret.actual_payment_this_month);
    printf("ret.saved_interest_expense==%f==\n",ret.saved_interest_expense);
    printf("ret.payment_paid==%f==\n",ret.payment_paid);
    printf("ret.interest_paid==%f==\n",ret.interest_paid);
    printf("ret.months_former==%d==\n",ret.months_former);
    printf("ret.months_new==%d==\n",ret.months_new);
    printf("====================================================\n");
}

int main()
{
    test_calc_eq_installment_payment();
    test_calc_eq_installment_payment();
    test_calc_prepayment_eq_installment();
    
    system("pause");
}

