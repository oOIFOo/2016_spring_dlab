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
static const char *ng0 = "C:/xilinx/demo/counter.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static int ng3[] = {7, 0};
static int ng4[] = {8, 0};



static void Always_30_0(char *t0)
{
    char t6[8];
    char t20[8];
    char t27[8];
    char t55[8];
    char t71[8];
    char t87[8];
    char t95[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    char *t26;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    char *t32;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t41;
    char *t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    char *t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    char *t62;
    char *t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t72;
    char *t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    char *t86;
    char *t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    char *t94;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    char *t99;
    char *t100;
    char *t101;
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    char *t109;
    char *t110;
    unsigned int t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    unsigned int t118;
    int t119;
    int t120;
    unsigned int t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    char *t127;
    unsigned int t128;
    unsigned int t129;
    unsigned int t130;
    unsigned int t131;
    unsigned int t132;
    char *t133;
    char *t134;

LAB0:    t1 = (t0 + 3328U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(30, ng0);
    t2 = (t0 + 3648);
    *((int *)t2) = 1;
    t3 = (t0 + 3360);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(31, ng0);

LAB5:    xsi_set_current_line(32, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);
    memset(t6, 0, 8);
    t4 = (t5 + 4);
    t7 = *((unsigned int *)t4);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB6;

LAB7:    if (*((unsigned int *)t4) != 0)
        goto LAB8;

LAB9:    t13 = (t6 + 4);
    t14 = *((unsigned int *)t6);
    t15 = (!(t14));
    t16 = *((unsigned int *)t13);
    t17 = (t15 || t16);
    if (t17 > 0)
        goto LAB10;

LAB11:    memcpy(t27, t6, 8);

LAB12:    memset(t55, 0, 8);
    t56 = (t27 + 4);
    t57 = *((unsigned int *)t56);
    t58 = (~(t57));
    t59 = *((unsigned int *)t27);
    t60 = (t59 & t58);
    t61 = (t60 & 1U);
    if (t61 != 0)
        goto LAB20;

LAB21:    if (*((unsigned int *)t56) != 0)
        goto LAB22;

LAB23:    t63 = (t55 + 4);
    t64 = *((unsigned int *)t55);
    t65 = *((unsigned int *)t63);
    t66 = (t64 || t65);
    if (t66 > 0)
        goto LAB24;

LAB25:    memcpy(t95, t55, 8);

LAB26:    t127 = (t95 + 4);
    t128 = *((unsigned int *)t127);
    t129 = (~(t128));
    t130 = *((unsigned int *)t95);
    t131 = (t130 & t129);
    t132 = (t131 != 0);
    if (t132 > 0)
        goto LAB38;

LAB39:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t12 = (t4 + 4);
    t13 = (t5 + 4);
    t7 = *((unsigned int *)t4);
    t8 = *((unsigned int *)t5);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t12);
    t11 = *((unsigned int *)t13);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t12);
    t17 = *((unsigned int *)t13);
    t21 = (t16 | t17);
    t22 = (~(t21));
    t23 = (t15 & t22);
    if (t23 != 0)
        goto LAB44;

LAB41:    if (t21 != 0)
        goto LAB43;

LAB42:    *((unsigned int *)t6) = 1;

LAB44:    t19 = (t6 + 4);
    t24 = *((unsigned int *)t19);
    t25 = (~(t24));
    t28 = *((unsigned int *)t6);
    t29 = (t28 & t25);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB45;

LAB46:    xsi_set_current_line(37, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng2)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 32, t4, 31, t5, 32);
    t12 = (t0 + 2088);
    xsi_vlogvar_assign_value(t12, t6, 0, 0, 31);

LAB47:
LAB40:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t6, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t7 = *((unsigned int *)t3);
    t8 = *((unsigned int *)t2);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t4);
    t11 = *((unsigned int *)t5);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t4);
    t17 = *((unsigned int *)t5);
    t21 = (t16 | t17);
    t22 = (~(t21));
    t23 = (t15 & t22);
    if (t23 != 0)
        goto LAB51;

LAB48:    if (t21 != 0)
        goto LAB50;

LAB49:    *((unsigned int *)t6) = 1;

LAB51:    t13 = (t6 + 4);
    t24 = *((unsigned int *)t13);
    t25 = (~(t24));
    t28 = *((unsigned int *)t6);
    t29 = (t28 & t25);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB52;

LAB53:
LAB54:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t3 + 4);
    t7 = *((unsigned int *)t2);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB56;

LAB57:    if (*((unsigned int *)t2) != 0)
        goto LAB58;

LAB59:    t5 = (t6 + 4);
    t14 = *((unsigned int *)t6);
    t15 = (!(t14));
    t16 = *((unsigned int *)t5);
    t17 = (t15 || t16);
    if (t17 > 0)
        goto LAB60;

LAB61:    memcpy(t27, t6, 8);

LAB62:    t41 = (t27 + 4);
    t57 = *((unsigned int *)t41);
    t58 = (~(t57));
    t59 = *((unsigned int *)t27);
    t60 = (t59 & t58);
    t61 = (t60 != 0);
    if (t61 > 0)
        goto LAB70;

LAB71:    xsi_set_current_line(49, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);

LAB72:    xsi_set_current_line(50, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2408);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(51, ng0);
    t2 = (t0 + 2248);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t12 = (t4 + 4);
    t13 = (t5 + 4);
    t7 = *((unsigned int *)t4);
    t8 = *((unsigned int *)t5);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t12);
    t11 = *((unsigned int *)t13);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t12);
    t17 = *((unsigned int *)t13);
    t21 = (t16 | t17);
    t22 = (~(t21));
    t23 = (t15 & t22);
    if (t23 != 0)
        goto LAB76;

LAB73:    if (t21 != 0)
        goto LAB75;

LAB74:    *((unsigned int *)t6) = 1;

LAB76:    t19 = (t6 + 4);
    t24 = *((unsigned int *)t19);
    t25 = (~(t24));
    t28 = *((unsigned int *)t6);
    t29 = (t28 & t25);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB77;

LAB78:
LAB79:    goto LAB2;

LAB6:    *((unsigned int *)t6) = 1;
    goto LAB9;

LAB8:    t12 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB9;

LAB10:    t18 = (t0 + 1528U);
    t19 = *((char **)t18);
    memset(t20, 0, 8);
    t18 = (t19 + 4);
    t21 = *((unsigned int *)t18);
    t22 = (~(t21));
    t23 = *((unsigned int *)t19);
    t24 = (t23 & t22);
    t25 = (t24 & 1U);
    if (t25 != 0)
        goto LAB13;

LAB14:    if (*((unsigned int *)t18) != 0)
        goto LAB15;

LAB16:    t28 = *((unsigned int *)t6);
    t29 = *((unsigned int *)t20);
    t30 = (t28 | t29);
    *((unsigned int *)t27) = t30;
    t31 = (t6 + 4);
    t32 = (t20 + 4);
    t33 = (t27 + 4);
    t34 = *((unsigned int *)t31);
    t35 = *((unsigned int *)t32);
    t36 = (t34 | t35);
    *((unsigned int *)t33) = t36;
    t37 = *((unsigned int *)t33);
    t38 = (t37 != 0);
    if (t38 == 1)
        goto LAB17;

LAB18:
LAB19:    goto LAB12;

LAB13:    *((unsigned int *)t20) = 1;
    goto LAB16;

LAB15:    t26 = (t20 + 4);
    *((unsigned int *)t20) = 1;
    *((unsigned int *)t26) = 1;
    goto LAB16;

LAB17:    t39 = *((unsigned int *)t27);
    t40 = *((unsigned int *)t33);
    *((unsigned int *)t27) = (t39 | t40);
    t41 = (t6 + 4);
    t42 = (t20 + 4);
    t43 = *((unsigned int *)t41);
    t44 = (~(t43));
    t45 = *((unsigned int *)t6);
    t46 = (t45 & t44);
    t47 = *((unsigned int *)t42);
    t48 = (~(t47));
    t49 = *((unsigned int *)t20);
    t50 = (t49 & t48);
    t51 = (~(t46));
    t52 = (~(t50));
    t53 = *((unsigned int *)t33);
    *((unsigned int *)t33) = (t53 & t51);
    t54 = *((unsigned int *)t33);
    *((unsigned int *)t33) = (t54 & t52);
    goto LAB19;

LAB20:    *((unsigned int *)t55) = 1;
    goto LAB23;

LAB22:    t62 = (t55 + 4);
    *((unsigned int *)t55) = 1;
    *((unsigned int *)t62) = 1;
    goto LAB23;

LAB24:    t67 = (t0 + 2408);
    t68 = (t67 + 56U);
    t69 = *((char **)t68);
    t70 = ((char*)((ng1)));
    memset(t71, 0, 8);
    t72 = (t69 + 4);
    t73 = (t70 + 4);
    t74 = *((unsigned int *)t69);
    t75 = *((unsigned int *)t70);
    t76 = (t74 ^ t75);
    t77 = *((unsigned int *)t72);
    t78 = *((unsigned int *)t73);
    t79 = (t77 ^ t78);
    t80 = (t76 | t79);
    t81 = *((unsigned int *)t72);
    t82 = *((unsigned int *)t73);
    t83 = (t81 | t82);
    t84 = (~(t83));
    t85 = (t80 & t84);
    if (t85 != 0)
        goto LAB30;

LAB27:    if (t83 != 0)
        goto LAB29;

LAB28:    *((unsigned int *)t71) = 1;

LAB30:    memset(t87, 0, 8);
    t88 = (t71 + 4);
    t89 = *((unsigned int *)t88);
    t90 = (~(t89));
    t91 = *((unsigned int *)t71);
    t92 = (t91 & t90);
    t93 = (t92 & 1U);
    if (t93 != 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t88) != 0)
        goto LAB33;

LAB34:    t96 = *((unsigned int *)t55);
    t97 = *((unsigned int *)t87);
    t98 = (t96 & t97);
    *((unsigned int *)t95) = t98;
    t99 = (t55 + 4);
    t100 = (t87 + 4);
    t101 = (t95 + 4);
    t102 = *((unsigned int *)t99);
    t103 = *((unsigned int *)t100);
    t104 = (t102 | t103);
    *((unsigned int *)t101) = t104;
    t105 = *((unsigned int *)t101);
    t106 = (t105 != 0);
    if (t106 == 1)
        goto LAB35;

LAB36:
LAB37:    goto LAB26;

LAB29:    t86 = (t71 + 4);
    *((unsigned int *)t71) = 1;
    *((unsigned int *)t86) = 1;
    goto LAB30;

LAB31:    *((unsigned int *)t87) = 1;
    goto LAB34;

LAB33:    t94 = (t87 + 4);
    *((unsigned int *)t87) = 1;
    *((unsigned int *)t94) = 1;
    goto LAB34;

LAB35:    t107 = *((unsigned int *)t95);
    t108 = *((unsigned int *)t101);
    *((unsigned int *)t95) = (t107 | t108);
    t109 = (t55 + 4);
    t110 = (t87 + 4);
    t111 = *((unsigned int *)t55);
    t112 = (~(t111));
    t113 = *((unsigned int *)t109);
    t114 = (~(t113));
    t115 = *((unsigned int *)t87);
    t116 = (~(t115));
    t117 = *((unsigned int *)t110);
    t118 = (~(t117));
    t119 = (t112 & t114);
    t120 = (t116 & t118);
    t121 = (~(t119));
    t122 = (~(t120));
    t123 = *((unsigned int *)t101);
    *((unsigned int *)t101) = (t123 & t121);
    t124 = *((unsigned int *)t101);
    *((unsigned int *)t101) = (t124 & t122);
    t125 = *((unsigned int *)t95);
    *((unsigned int *)t95) = (t125 & t121);
    t126 = *((unsigned int *)t95);
    *((unsigned int *)t95) = (t126 & t122);
    goto LAB37;

LAB38:    xsi_set_current_line(33, ng0);
    t133 = ((char*)((ng2)));
    t134 = (t0 + 2408);
    xsi_vlogvar_assign_value(t134, t133, 0, 0, 1);
    goto LAB40;

LAB43:    t18 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t18) = 1;
    goto LAB44;

LAB45:    xsi_set_current_line(35, ng0);
    t26 = ((char*)((ng1)));
    t31 = (t0 + 2088);
    xsi_vlogvar_assign_value(t31, t26, 0, 0, 31);
    goto LAB47;

LAB50:    t12 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(39, ng0);

LAB55:    xsi_set_current_line(40, ng0);
    t18 = ((char*)((ng1)));
    t19 = (t0 + 2248);
    xsi_vlogvar_assign_value(t19, t18, 0, 0, 1);
    xsi_set_current_line(41, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1928);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(42, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2408);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB54;

LAB56:    *((unsigned int *)t6) = 1;
    goto LAB59;

LAB58:    t4 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t4) = 1;
    goto LAB59;

LAB60:    t12 = (t0 + 1528U);
    t13 = *((char **)t12);
    memset(t20, 0, 8);
    t12 = (t13 + 4);
    t21 = *((unsigned int *)t12);
    t22 = (~(t21));
    t23 = *((unsigned int *)t13);
    t24 = (t23 & t22);
    t25 = (t24 & 1U);
    if (t25 != 0)
        goto LAB63;

LAB64:    if (*((unsigned int *)t12) != 0)
        goto LAB65;

LAB66:    t28 = *((unsigned int *)t6);
    t29 = *((unsigned int *)t20);
    t30 = (t28 | t29);
    *((unsigned int *)t27) = t30;
    t19 = (t6 + 4);
    t26 = (t20 + 4);
    t31 = (t27 + 4);
    t34 = *((unsigned int *)t19);
    t35 = *((unsigned int *)t26);
    t36 = (t34 | t35);
    *((unsigned int *)t31) = t36;
    t37 = *((unsigned int *)t31);
    t38 = (t37 != 0);
    if (t38 == 1)
        goto LAB67;

LAB68:
LAB69:    goto LAB62;

LAB63:    *((unsigned int *)t20) = 1;
    goto LAB66;

LAB65:    t18 = (t20 + 4);
    *((unsigned int *)t20) = 1;
    *((unsigned int *)t18) = 1;
    goto LAB66;

LAB67:    t39 = *((unsigned int *)t27);
    t40 = *((unsigned int *)t31);
    *((unsigned int *)t27) = (t39 | t40);
    t32 = (t6 + 4);
    t33 = (t20 + 4);
    t43 = *((unsigned int *)t32);
    t44 = (~(t43));
    t45 = *((unsigned int *)t6);
    t46 = (t45 & t44);
    t47 = *((unsigned int *)t33);
    t48 = (~(t47));
    t49 = *((unsigned int *)t20);
    t50 = (t49 & t48);
    t51 = (~(t46));
    t52 = (~(t50));
    t53 = *((unsigned int *)t31);
    *((unsigned int *)t31) = (t53 & t51);
    t54 = *((unsigned int *)t31);
    *((unsigned int *)t31) = (t54 & t52);
    goto LAB69;

LAB70:    xsi_set_current_line(47, ng0);
    t42 = ((char*)((ng2)));
    t56 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t56, t42, 0, 0, 1, 0LL);
    goto LAB72;

LAB75:    t18 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t18) = 1;
    goto LAB76;

LAB77:    xsi_set_current_line(52, ng0);

LAB80:    xsi_set_current_line(53, ng0);
    t26 = (t0 + 1208U);
    t31 = *((char **)t26);
    t26 = (t31 + 4);
    t34 = *((unsigned int *)t26);
    t35 = (~(t34));
    t36 = *((unsigned int *)t31);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB81;

LAB82:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t6, 0, 8);
    t12 = (t4 + 4);
    t13 = (t5 + 4);
    t7 = *((unsigned int *)t4);
    t8 = *((unsigned int *)t5);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t12);
    t11 = *((unsigned int *)t13);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t12);
    t17 = *((unsigned int *)t13);
    t21 = (t16 | t17);
    t22 = (~(t21));
    t23 = (t15 & t22);
    if (t23 != 0)
        goto LAB88;

LAB85:    if (t21 != 0)
        goto LAB87;

LAB86:    *((unsigned int *)t6) = 1;

LAB88:    memset(t20, 0, 8);
    t19 = (t6 + 4);
    t24 = *((unsigned int *)t19);
    t25 = (~(t24));
    t28 = *((unsigned int *)t6);
    t29 = (t28 & t25);
    t30 = (t29 & 1U);
    if (t30 != 0)
        goto LAB89;

LAB90:    if (*((unsigned int *)t19) != 0)
        goto LAB91;

LAB92:    t31 = (t20 + 4);
    t34 = *((unsigned int *)t20);
    t35 = *((unsigned int *)t31);
    t36 = (t34 || t35);
    if (t36 > 0)
        goto LAB93;

LAB94:    memcpy(t55, t20, 8);

LAB95:    t68 = (t55 + 4);
    t81 = *((unsigned int *)t68);
    t82 = (~(t81));
    t83 = *((unsigned int *)t55);
    t84 = (t83 & t82);
    t85 = (t84 != 0);
    if (t85 > 0)
        goto LAB103;

LAB104:    xsi_set_current_line(61, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_unary_minus(t6, 32, t5, 32);
    memset(t20, 0, 8);
    t12 = (t4 + 4);
    t13 = (t6 + 4);
    t7 = *((unsigned int *)t4);
    t8 = *((unsigned int *)t6);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t12);
    t11 = *((unsigned int *)t13);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t12);
    t17 = *((unsigned int *)t13);
    t21 = (t16 | t17);
    t22 = (~(t21));
    t23 = (t15 & t22);
    if (t23 != 0)
        goto LAB110;

LAB107:    if (t21 != 0)
        goto LAB109;

LAB108:    *((unsigned int *)t20) = 1;

LAB110:    memset(t27, 0, 8);
    t19 = (t20 + 4);
    t24 = *((unsigned int *)t19);
    t25 = (~(t24));
    t28 = *((unsigned int *)t20);
    t29 = (t28 & t25);
    t30 = (t29 & 1U);
    if (t30 != 0)
        goto LAB111;

LAB112:    if (*((unsigned int *)t19) != 0)
        goto LAB113;

LAB114:    t31 = (t27 + 4);
    t34 = *((unsigned int *)t27);
    t35 = *((unsigned int *)t31);
    t36 = (t34 || t35);
    if (t36 > 0)
        goto LAB115;

LAB116:    memcpy(t71, t27, 8);

LAB117:    t68 = (t71 + 4);
    t81 = *((unsigned int *)t68);
    t82 = (~(t81));
    t83 = *((unsigned int *)t71);
    t84 = (t83 & t82);
    t85 = (t84 != 0);
    if (t85 > 0)
        goto LAB125;

LAB126:    xsi_set_current_line(65, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t7 = *((unsigned int *)t2);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB129;

LAB130:    xsi_set_current_line(67, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t7 = *((unsigned int *)t2);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB132;

LAB133:
LAB134:
LAB131:
LAB127:
LAB105:
LAB83:    goto LAB79;

LAB81:    xsi_set_current_line(54, ng0);

LAB84:    xsi_set_current_line(55, ng0);
    t32 = ((char*)((ng1)));
    t33 = (t0 + 1928);
    xsi_vlogvar_assign_value(t33, t32, 0, 0, 8);
    goto LAB83;

LAB87:    t18 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t18) = 1;
    goto LAB88;

LAB89:    *((unsigned int *)t20) = 1;
    goto LAB92;

LAB91:    t26 = (t20 + 4);
    *((unsigned int *)t20) = 1;
    *((unsigned int *)t26) = 1;
    goto LAB92;

LAB93:    t32 = (t0 + 1368U);
    t33 = *((char **)t32);
    memset(t27, 0, 8);
    t32 = (t33 + 4);
    t37 = *((unsigned int *)t32);
    t38 = (~(t37));
    t39 = *((unsigned int *)t33);
    t40 = (t39 & t38);
    t43 = (t40 & 1U);
    if (t43 != 0)
        goto LAB96;

LAB97:    if (*((unsigned int *)t32) != 0)
        goto LAB98;

LAB99:    t44 = *((unsigned int *)t20);
    t45 = *((unsigned int *)t27);
    t47 = (t44 & t45);
    *((unsigned int *)t55) = t47;
    t42 = (t20 + 4);
    t56 = (t27 + 4);
    t62 = (t55 + 4);
    t48 = *((unsigned int *)t42);
    t49 = *((unsigned int *)t56);
    t51 = (t48 | t49);
    *((unsigned int *)t62) = t51;
    t52 = *((unsigned int *)t62);
    t53 = (t52 != 0);
    if (t53 == 1)
        goto LAB100;

LAB101:
LAB102:    goto LAB95;

LAB96:    *((unsigned int *)t27) = 1;
    goto LAB99;

LAB98:    t41 = (t27 + 4);
    *((unsigned int *)t27) = 1;
    *((unsigned int *)t41) = 1;
    goto LAB99;

LAB100:    t54 = *((unsigned int *)t55);
    t57 = *((unsigned int *)t62);
    *((unsigned int *)t55) = (t54 | t57);
    t63 = (t20 + 4);
    t67 = (t27 + 4);
    t58 = *((unsigned int *)t20);
    t59 = (~(t58));
    t60 = *((unsigned int *)t63);
    t61 = (~(t60));
    t64 = *((unsigned int *)t27);
    t65 = (~(t64));
    t66 = *((unsigned int *)t67);
    t74 = (~(t66));
    t46 = (t59 & t61);
    t50 = (t65 & t74);
    t75 = (~(t46));
    t76 = (~(t50));
    t77 = *((unsigned int *)t62);
    *((unsigned int *)t62) = (t77 & t75);
    t78 = *((unsigned int *)t62);
    *((unsigned int *)t62) = (t78 & t76);
    t79 = *((unsigned int *)t55);
    *((unsigned int *)t55) = (t79 & t75);
    t80 = *((unsigned int *)t55);
    *((unsigned int *)t55) = (t80 & t76);
    goto LAB102;

LAB103:    xsi_set_current_line(58, ng0);

LAB106:    xsi_set_current_line(59, ng0);
    t69 = ((char*)((ng3)));
    t70 = (t0 + 1928);
    xsi_vlogvar_assign_value(t70, t69, 0, 0, 8);
    goto LAB105;

LAB109:    t18 = (t20 + 4);
    *((unsigned int *)t20) = 1;
    *((unsigned int *)t18) = 1;
    goto LAB110;

LAB111:    *((unsigned int *)t27) = 1;
    goto LAB114;

LAB113:    t26 = (t27 + 4);
    *((unsigned int *)t27) = 1;
    *((unsigned int *)t26) = 1;
    goto LAB114;

LAB115:    t32 = (t0 + 1528U);
    t33 = *((char **)t32);
    memset(t55, 0, 8);
    t32 = (t33 + 4);
    t37 = *((unsigned int *)t32);
    t38 = (~(t37));
    t39 = *((unsigned int *)t33);
    t40 = (t39 & t38);
    t43 = (t40 & 1U);
    if (t43 != 0)
        goto LAB118;

LAB119:    if (*((unsigned int *)t32) != 0)
        goto LAB120;

LAB121:    t44 = *((unsigned int *)t27);
    t45 = *((unsigned int *)t55);
    t47 = (t44 & t45);
    *((unsigned int *)t71) = t47;
    t42 = (t27 + 4);
    t56 = (t55 + 4);
    t62 = (t71 + 4);
    t48 = *((unsigned int *)t42);
    t49 = *((unsigned int *)t56);
    t51 = (t48 | t49);
    *((unsigned int *)t62) = t51;
    t52 = *((unsigned int *)t62);
    t53 = (t52 != 0);
    if (t53 == 1)
        goto LAB122;

LAB123:
LAB124:    goto LAB117;

LAB118:    *((unsigned int *)t55) = 1;
    goto LAB121;

LAB120:    t41 = (t55 + 4);
    *((unsigned int *)t55) = 1;
    *((unsigned int *)t41) = 1;
    goto LAB121;

LAB122:    t54 = *((unsigned int *)t71);
    t57 = *((unsigned int *)t62);
    *((unsigned int *)t71) = (t54 | t57);
    t63 = (t27 + 4);
    t67 = (t55 + 4);
    t58 = *((unsigned int *)t27);
    t59 = (~(t58));
    t60 = *((unsigned int *)t63);
    t61 = (~(t60));
    t64 = *((unsigned int *)t55);
    t65 = (~(t64));
    t66 = *((unsigned int *)t67);
    t74 = (~(t66));
    t46 = (t59 & t61);
    t50 = (t65 & t74);
    t75 = (~(t46));
    t76 = (~(t50));
    t77 = *((unsigned int *)t62);
    *((unsigned int *)t62) = (t77 & t75);
    t78 = *((unsigned int *)t62);
    *((unsigned int *)t62) = (t78 & t76);
    t79 = *((unsigned int *)t71);
    *((unsigned int *)t71) = (t79 & t75);
    t80 = *((unsigned int *)t71);
    *((unsigned int *)t71) = (t80 & t76);
    goto LAB124;

LAB125:    xsi_set_current_line(62, ng0);

LAB128:    xsi_set_current_line(63, ng0);
    t69 = ((char*)((ng4)));
    memset(t87, 0, 8);
    xsi_vlog_signed_unary_minus(t87, 32, t69, 32);
    t70 = (t0 + 1928);
    xsi_vlogvar_assign_value(t70, t87, 0, 0, 8);
    goto LAB127;

LAB129:    xsi_set_current_line(66, ng0);
    t4 = (t0 + 1928);
    t5 = (t4 + 56U);
    t12 = *((char **)t5);
    t13 = ((char*)((ng2)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 32, t12, 8, t13, 32);
    t18 = (t0 + 1928);
    xsi_vlogvar_assign_value(t18, t6, 0, 0, 8);
    goto LAB131;

LAB132:    xsi_set_current_line(68, ng0);
    t4 = (t0 + 1928);
    t5 = (t4 + 56U);
    t12 = *((char **)t5);
    t13 = ((char*)((ng2)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_minus(t6, 32, t12, 8, t13, 32);
    t18 = (t0 + 1928);
    xsi_vlogvar_assign_value(t18, t6, 0, 0, 8);
    goto LAB134;

}


extern void work_m_00000000002374184389_2582214024_init()
{
	static char *pe[] = {(void *)Always_30_0};
	xsi_register_didat("work_m_00000000002374184389_2582214024", "isim/test_isim_beh.exe.sim/work/m_00000000002374184389_2582214024.didat");
	xsi_register_executes(pe);
}
