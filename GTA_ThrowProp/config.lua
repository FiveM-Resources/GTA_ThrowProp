listObject = {
    "p_amb_coffeecup_01", --> Coffee
    "p_ing_coffeecup_02", --> Coffee2
    "p_ing_coffeecup_01", --> Coffee3
	"prop_fib_coffee", --> Coffee4
    "ng_proc_coffee_01a", --> Coffee5
    "ng_proc_coffee_02a", --> Coffee6
    "ng_proc_coffee_03b", --> Coffee7
    "ng_proc_coffee_04b", --> Coffee8

	"ng_proc_sodacan_02a", --> ng_proc_sodacan_02a
    "ng_proc_sodacan_02b", --> ng_proc_sodacan_02b
    "ng_proc_sodacan_02c", --> ng_proc_sodacan_02c
	"ng_proc_sodacan_02d", --> ng_proc_sodacan_02d
    "ng_proc_sodacan_03a", --> ng_proc_sodacan_03a
    "ng_proc_sodacan_03b", --> ng_proc_sodacan_03b
    "ng_proc_sodacan_04a", --> ng_proc_sodacan_04a


	"prop_donut_01", --> prop_donut_01
    "prop_amb_donut", --> prop_amb_donut
    "prop_donut_02", --> prop_donut_02
    "prop_donut_02b", --> prop_donut_02b

	"prop_sh_cigar_01", --> prop_sh_cigar_01
    "prop_cigar_02", --> prop_cigar_02
    "prop_cigar_03", --> prop_cigar_03
    "prop_cigar_01", --> prop_cigar_01
    "ng_proc_cigar01a", --> ng_proc_cigar01a
    "ng_proc_cigarette01a", --> ng_proc_cigarette01a
    "ng_proc_cigbuts01a", --> ng_proc_cigbuts01a
    "prop_cigar_pack_01", --> prop_cigar_pack_01
    "prop_cigar_pack_02", --> prop_cigar_pack_02
    "prop_cs_ciggy_01b", --> prop_cs_ciggy_01b
    "prop_cs_ciggy_01", --> prop_cs_ciggy_01
    "p_cs_ciggy_01b_s", --> p_cs_ciggy_01b_s
	
    "prop_shot_glass", --> prop_shot_glass
    "prop_shots_glass_cs", --> prop_shots_glass_cs
    "prop_pint_glass_02", --> prop_pint_glass_02
    "prop_brandy_glass", --> prop_brandy_glass
    "prop_pint_glass_tall", --> prop_pint_glass_tall
    "prop_pint_glass_01", --> prop_pint_glass_01

    "prop_glass_stack_07", --> prop_glass_stack_07
    "prop_wine_glass", --> prop_wine_glass

    "prop_npc_phone_02", --> Phone
    "prop_npc_phone", --> Phone2
    "prop_amb_phone", --> Phone2
    "prop_player_phone_01", --> Phone2
    "prop_phone_overlay_03", --> Phone2
    "p_cs_cam_phone", --> Phone2
    "prop_npc_phone", --> Phone2

    "prop_roadcone01a", --> prop_roadcone01a
    "prop_roadcone01c", --> prop_roadcone01c
    "prop_roadcone01b", --> prop_roadcone01b
    "prop_roadcone02a", --> prop_roadcone02a
    "prop_roadcone02c", --> prop_roadcone02c
    "prop_roadcone02b", --> prop_roadcone02b
    "prop_cone_float_1", --> prop_cone_float_1
    "prop_mp_cone_01", --> prop_mp_cone_01
    "prop_mp_cone_02", --> prop_mp_cone_02

    "prop_oilcan_01a", --> prop_oilcan_01a
    "ng_proc_paintcan01a", --> ng_proc_paintcan01a
    "ng_proc_paintcan02a", --> ng_proc_paintcan02a
    "prop_paints_can03", --> prop_paints_can03
    "prop_paints_can01", --> prop_paints_can01
    "prop_paints_can04", --> prop_paints_can04
    "prop_paints_can02", --> prop_paints_can02

}

Config = {}
Config.BaseVelocity = 30.0
Config.Animations = {
	idle = {dict = "weapons@projectile@", name = "grip_idle", flag = 25},
	idleWalking = {dict = "weapons@projectile@", name = "grip_walk", flag = 25},
	aimingLow = {dict = "weapons@projectile@", name = "aim_l", flag = 25},
	aimingMed = {dict = "weapons@projectile@", name = "grenade_throw_drop", flag = 25}, --aim_m
	aimingHigh = {dict = "weapons@projectile@", name = "aim_h", flag = 25},
	aimingFullLow = {dict = "weapons@projectile@", name = "aimlive_l", flag = 25},
	aimingFullMed = {dict = "weapons@projectile@", name = "aimlive_m", flag = 25},
	aimingFullHigh = {dict = "weapons@projectile@", name = "aimlive_h", flag = 25},
	throwingLow = {dict = "weapons@projectile@", name = "throw_l_fb_stand", flag = 2},
	throwingMed = {dict = "weapons@projectile@", name = "throw_m_fb_stand", flag = 2},
	throwingHigh = {dict = "weapons@projectile@", name = "throw_h_fb_stand", flag = 2},
}