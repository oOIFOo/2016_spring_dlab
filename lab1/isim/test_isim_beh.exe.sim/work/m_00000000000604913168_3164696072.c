/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/USER/Desktop/DEMO/MULT.v";
static int ng1[] = {8, 0};
static int ng2[] = {0, 0};
static int ng3[] = {1, 0};



static void Cont_32_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 3488U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 2248);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4152);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 65535U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 15);
    t18 = (t0 + 4056);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_33_1(char *t0)
{
    char t4[8];
    char t31[8];
    char t32[8];
    char t41[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;

LAB0:    t1 = (t0 + 3736U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(33, ng0);
    t2 = (t0 + 4072);
    *((int *)t2) = 1;
    t3 = (t0 + 3768);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(34, ng0);
    t5 = (t0 + 1208U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t5 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t5) == 0)
        goto LAB5;

LAB7:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;

LAB8:    t13 = (t4 + 4);
    t14 = (t6 + 4);
    t15 = *((unsigned int *)t6);
    t16 = (~(t15));
    *((unsigned int *)t4) = t16;
    *((unsigned int *)t13) = 0;
    if (*((unsigned int *)t14) != 0)
        goto LAB10;

LAB9:    t21 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t21 & 1U);
    t22 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t22 & 1U);
    t23 = (t4 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t4);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB11;

LAB12:    xsi_set_current_line(41, ng0);

LAB15:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng2)));
    memset(t4, 0, 8);
    xsi_vlog_signed_greater(t4, 32, t5, 32, t6, 32);
    t12 = (t4 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB16;

LAB17:
LAB18:
LAB13:    goto LAB2;

LAB5:    *((unsigned int *)t4) = 1;
    goto LAB8;

LAB10:    t17 = *((unsigned int *)t4);
    t18 = *((unsigned int *)t14);
    *((unsigned int *)t4) = (t17 | t18);
    t19 = *((unsigned int *)t13);
    t20 = *((unsigned int *)t14);
    *((unsigned int *)t13) = (t19 | t20);
    goto LAB9;

LAB11:    xsi_set_current_line(34, ng0);

LAB14:    xsi_set_current_line(35, ng0);
    t29 = ((char*)((ng1)));
    t30 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t30, t29, 0, 0, 32, 0LL);
    xsi_set_current_line(36, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(37, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    goto LAB13;

LAB16:    xsi_set_current_line(43, ng0);

LAB19:    xsi_set_current_line(44, ng0);
    t13 = (t0 + 2408);
    t14 = (t13 + 56U);
    t23 = *((char **)t14);
    t29 = ((char*)((ng3)));
    memset(t31, 0, 8);
    xsi_vlog_signed_minus(t31, 32, t23, 32, t29, 32);
    t30 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t30, t31, 0, 0, 32, 0LL);
    xsi_set_current_line(45, ng0);
    t2 = (t0 + 2248);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng3)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_lshift(t4, 16, t5, 16, t6, 32);
    t12 = (t0 + 2248);
    xsi_vlogvar_assign_value(t12, t4, 0, 0, 16);
    xsi_set_current_line(46, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t0 + 1488U);
    t5 = (t2 + 72U);
    t6 = *((char **)t5);
    t12 = (t0 + 2408);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t23 = ((char*)((ng3)));
    memset(t31, 0, 8);
    xsi_vlog_signed_minus(t31, 32, t14, 32, t23, 32);
    xsi_vlog_generic_get_index_select_value(t4, 32, t3, t6, 2, t31, 32, 1);
    t29 = ((char*)((ng3)));
    memset(t32, 0, 8);
    t30 = (t4 + 4);
    t33 = (t29 + 4);
    t7 = *((unsigned int *)t4);
    t8 = *((unsigned int *)t29);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t30);
    t11 = *((unsigned int *)t33);
    t15 = (t10 ^ t11);
    t16 = (t9 | t15);
    t17 = *((unsigned int *)t30);
    t18 = *((unsigned int *)t33);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB23;

LAB20:    if (t19 != 0)
        goto LAB22;

LAB21:    *((unsigned int *)t32) = 1;

LAB23:    t35 = (t32 + 4);
    t22 = *((unsigned int *)t35);
    t24 = (~(t22));
    t25 = *((unsigned int *)t32);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB24;

LAB25:
LAB26:    goto LAB18;

LAB22:    t34 = (t32 + 4);
    *((unsigned int *)t32) = 1;
    *((unsigned int *)t34) = 1;
    goto LAB23;

LAB24:    xsi_set_current_line(47, ng0);

LAB27:    xsi_set_current_line(48, ng0);
    t36 = (t0 + 2248);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t0 + 1368U);
    t40 = *((char **)t39);
    memset(t41, 0, 8);
    xsi_vlog_unsigned_add(t41, 16, t38, 16, t40, 8);
    t39 = (t0 + 2248);
    xsi_vlogvar_assign_value(t39, t41, 0, 0, 16);
    goto LAB26;

}


extern void work_m_00000000000604913168_3164696072_init()
{
	static char *pe[] = {(void *)Cont_32_0,(void *)Always_33_1};
	xsi_register_didat("work_m_00000000000604913168_3164696072", "isim/test_isim_beh.exe.sim/work/m_00000000000604913168_3164696072.didat");
	xsi_register_executes(pe);
}
