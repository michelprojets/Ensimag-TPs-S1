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

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/user/6/.base/yoeungm/home/ensimag_1/Architecture/TP/TP3/src_etd/vhd/Compteur.vhd";
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1006216973935652998_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_1242562249_sub_1434220770695818471_1035706684(char *, char *, char *, char *, char *);


static void work_a_1527060950_3271922888_p_0(char *t0)
{
    char t6[16];
    char t24[16];
    char t26[16];
    char t31[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned char t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t21;
    char *t23;
    char *t25;
    char *t27;
    char *t28;
    int t29;
    unsigned int t30;
    char *t32;
    int t33;
    unsigned char t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;

LAB0:    xsi_set_current_line(35, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 5968U);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t3 = (t0 + 5952U);
    t5 = ieee_p_1242562249_sub_1434220770695818471_1035706684(IEEE_P_1242562249, t2, t1, t4, t3);
    if (t5 != 0)
        goto LAB3;

LAB4:
LAB7:    t19 = (t0 + 6045);
    t21 = (t0 + 6046);
    t25 = ((IEEE_P_1242562249) + 2976);
    t27 = (t26 + 0U);
    t28 = (t27 + 0U);
    *((int *)t28) = 0;
    t28 = (t27 + 4U);
    *((int *)t28) = 0;
    t28 = (t27 + 8U);
    *((int *)t28) = 1;
    t29 = (0 - 0);
    t30 = (t29 * 1);
    t30 = (t30 + 1);
    t28 = (t27 + 12U);
    *((unsigned int *)t28) = t30;
    t28 = (t31 + 0U);
    t32 = (t28 + 0U);
    *((int *)t32) = 0;
    t32 = (t28 + 4U);
    *((int *)t32) = 15;
    t32 = (t28 + 8U);
    *((int *)t32) = 1;
    t33 = (15 - 0);
    t30 = (t33 * 1);
    t30 = (t30 + 1);
    t32 = (t28 + 12U);
    *((unsigned int *)t32) = t30;
    t23 = xsi_base_array_concat(t23, t24, t25, (char)97, t19, t26, (char)97, t21, t31, (char)101);
    t30 = (1U + 16U);
    t34 = (17U != t30);
    if (t34 == 1)
        goto LAB9;

LAB10:    t32 = (t0 + 3648);
    t35 = (t32 + 56U);
    t36 = *((char **)t35);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    memcpy(t38, t23, 17U);
    xsi_driver_first_trans_fast(t32);

LAB2:    t39 = (t0 + 3552);
    *((int *)t39) = 1;

LAB1:    return;
LAB3:    t7 = (t0 + 1672U);
    t8 = *((char **)t7);
    t7 = (t0 + 5968U);
    t9 = ieee_p_1242562249_sub_1006216973935652998_1035706684(IEEE_P_1242562249, t6, t8, t7, 1);
    t10 = (t6 + 12U);
    t11 = *((unsigned int *)t10);
    t12 = (1U * t11);
    t13 = (17U != t12);
    if (t13 == 1)
        goto LAB5;

LAB6:    t14 = (t0 + 3648);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t9, 17U);
    xsi_driver_first_trans_fast(t14);
    goto LAB2;

LAB5:    xsi_size_not_matching(17U, t12, 0);
    goto LAB6;

LAB8:    goto LAB2;

LAB9:    xsi_size_not_matching(17U, t30, 0);
    goto LAB10;

}

static void work_a_1527060950_3271922888_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(36, ng0);

LAB3:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 3712);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 17U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 3568);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1527060950_3271922888_init()
{
	static char *pe[] = {(void *)work_a_1527060950_3271922888_p_0,(void *)work_a_1527060950_3271922888_p_1};
	xsi_register_didat("work_a_1527060950_3271922888", "isim/tb_lecture_memoire_isim_beh.exe.sim/work/a_1527060950_3271922888.didat");
	xsi_register_executes(pe);
}
