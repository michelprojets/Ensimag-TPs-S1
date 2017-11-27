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
static const char *ng0 = "/user/6/.base/yoeungm/home/ensimag_1/Architecture/TP/TP3/src_etd/vhd/lecture_memoire.vhd";
extern char *IEEE_P_1242562249;



static void work_a_0871606977_3271922888_p_0(char *t0)
{
    char t6[16];
    char t8[16];
    char t13[16];
    char *t1;
    char *t3;
    char *t5;
    char *t7;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;
    char *t14;
    int t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;

LAB0:    xsi_set_current_line(35, ng0);

LAB3:    t1 = (t0 + 5885);
    t3 = (t0 + 5886);
    t7 = ((IEEE_P_1242562249) + 2976);
    t9 = (t8 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 0;
    t10 = (t9 + 4U);
    *((int *)t10) = 0;
    t10 = (t9 + 8U);
    *((int *)t10) = 1;
    t11 = (0 - 0);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t12;
    t10 = (t13 + 0U);
    t14 = (t10 + 0U);
    *((int *)t14) = 0;
    t14 = (t10 + 4U);
    *((int *)t14) = 15;
    t14 = (t10 + 8U);
    *((int *)t14) = 1;
    t15 = (15 - 0);
    t12 = (t15 * 1);
    t12 = (t12 + 1);
    t14 = (t10 + 12U);
    *((unsigned int *)t14) = t12;
    t5 = xsi_base_array_concat(t5, t6, t7, (char)97, t1, t8, (char)97, t3, t13, (char)101);
    t12 = (1U + 16U);
    t16 = (17U != t12);
    if (t16 == 1)
        goto LAB5;

LAB6:    t14 = (t0 + 3368);
    t17 = (t14 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t5, 17U);
    xsi_driver_first_trans_fast(t14);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(17U, t12, 0);
    goto LAB6;

}


extern void work_a_0871606977_3271922888_init()
{
	static char *pe[] = {(void *)work_a_0871606977_3271922888_p_0};
	xsi_register_didat("work_a_0871606977_3271922888", "isim/tb_lecture_memoire_isim_beh.exe.sim/work/a_0871606977_3271922888.didat");
	xsi_register_executes(pe);
}
