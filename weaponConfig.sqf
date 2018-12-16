/*  Available weapons and scopes, sorted by tier
*
*   preprocessed in server\setup\chooseWeapons.sqf
*
*   keep numberOfTiers updated when adding new tiers!
*/

numberOfTiers = 5;

sniperscopes_0 = [
  //vanilla
  "optic_AMS",
  "optic_DMS",
  "optic_KHS_blk",
  "optic_KHS_old",
  "optic_SOS",
  "optic_LRPS",

  //rhs
  "rhs_acc_pso1m2",
  "rhs_acc_pso1m21",
  "rhs_acc_rakursPM",
  "rhsusf_acc_premier",
  "rhsusf_acc_LEUPOLDMK4",
  "rhsusf_acc_LEUPOLDMK4_2",
  "rhsusf_acc_LEUPOLDMK4_2_d",

  //fhq
  "FHQ_optic_LeupoldERT",
  "FHQ_optic_LeupoldERT_tan"
];

weaponstier_1 = [
  //vanilla
  "srifle_GM6_camo_F",
  "srifle_GM6_F",
  "MMG_01_hex_F",
  "MMG_01_tan_F",
  "arifle_Katiba_F",
  "MMG_02_black_F",
  "MMG_02_camo_F",
  "srifle_LRR_F",
  "srifle_LRR_camo_F",
  "arifle_MX_F",
  "arifle_MX_Black_F",
  "arifle_MX_SW_F",
  "arifle_MX_SW_Black_F",
  "arifle_MXM_F",
  "arifle_MXM_Black_F",
  "LMG_Zafir_F",
  "srifle_DMR_01_F",

  //rhs
  "rhs_weap_hk416d145",
  "rhs_weap_M107_d",
  "rhs_weap_M107",
  "rhs_weap_m14ebrri",
  "rhs_weap_XM2010",
  "rhs_weap_XM2010_wd",
  "rhs_weap_m240B",
  "rhs_weap_m240G",
  "rhs_weap_m249_pip_L",
  "rhs_weap_m27iar",
  "rhs_weap_sr25",
  "rhs_weap_pkp",
  "rhs_weap_svdp",
  "rhs_weap_svdp_npz",
  "rhs_weap_svds",
  "rhs_weap_svds_npz",

  //hlc
  "hlc_lmg_MG3KWS_b",
  "hlc_lmg_mg42kws_b",
  "hlc_lmg_mg42kws_g",
  "hlc_lmg_MG3_optic",
  "hlc_rifle_g3ka4",
  "hlc_rifle_g3a3v",
  "hlc_rifle_g3a3"
];

scopestier_1 = [
  //vanilla
  "optic_Arco",
  "optic_SOS",
  "optic_MRCO",
  "optic_Hamr",
  "optic_Holosight",
  "optic_ACO_grn",
  "optic_Aco",

  //rhs
  "rhsusf_acc_ACOG_USMC",
  "rhsusf_acc_ACOG",
  "rhsusf_acc_eotech_552",
  "rhsusf_acc_SpecterDR",
  "rhsusf_acc_SpecterDR_OD",
  "rhsusf_acc_ACOG_d",
  "rhsusf_acc_ACOG_wd",
  "rhs_acc_1p29",
  "rhs_acc_1p63",
  "rhs_acc_pso1m2",
  "rhs_acc_pso1m21",
  "rhs_acc_pkas",
  "rhs_acc_ekp1",

  //fhq
  "FHQ_optic_AC11704",
  "FHQ_optic_AC11704_tan",
  "FHQ_optic_ACOG",
  "FHQ_optic_ACOG_tan",
  "FHQ_optic_AimM_BLK",
  "FHQ_optic_AimM_TAN",
  "FHQ_optic_AIM",
  "FHQ_optic_AIM_tan",
  "FHQ_optic_HWS_G33",
  "FHQ_optic_HWS_G33_tan",
  "FHQ_optic_MCCO_M_BLK",
  "FHQ_optic_MCCO_M_TAN",
  "FHQ_optic_MicroCCO",
  "FHQ_optic_MicroCCO_tan"
];

//MODERN ASSAULT RIFLES 5.56, SHITTY MGs, SHITTY SNIPERS =======================
weaponstier_2 = [
  //vanilla
  "srifle_DMR_03_F",
  "arifle_TRG21_F",

  //rhs
  "rhs_weap_ak103",
  "rhs_weap_ak104",
  "rhs_weap_ak104_npz",
  "rhs_weap_ak105",
  "rhs_weap_ak105_npz",
  "rhs_weap_hk416d10",
  "rhs_weap_hk416d145",
  "rhs_weap_m249_pip_L",
  "rhs_weap_m249_pip_S",
  "rhs_weap_m27iar",
  "rhs_weap_m4",
  "rhs_weap_m4a1_carryhandle",
  "rhs_weap_m4a1_blockII",
  "rhs_weap_m4a1",
  "rhs_weap_mk18",
  "rhs_weap_pkm"
];

scopestier_2 = [
  //vanilla
  "optic_ACO_grn",
  "optic_Aco",
  "optic_Holosight",

  //rhs
  "rhs_acc_1p29",
  "rhs_acc_1p63",
  "rhs_acc_1p78",
  "rhs_acc_ekp1",
  "rhs_acc_pkas",
  "rhs_acc_rakursPM",
  "rhsusf_acc_EOTECH",
  "rhsusf_acc_eotech_552",
  "rhsusf_acc_eotech_552_d",
  "rhsusf_acc_compm4",
  "rhsusf_acc_eotech_xps3",

  //fhq
  "FHQ_optic_AC11704",
  "FHQ_optic_AC11704_tan",
  "FHQ_optic_AC12136_tan",
  "FHQ_optic_AIM",
  "FHQ_optic_AIM_tan",
  "FHQ_optic_AimM_BLK",
  "FHQ_optic_AimM_TAN",
  "FHQ_optic_HWS_G33",
  "FHQ_optic_HWS_G33_tan",
  "FHQ_optic_HWS",
  "FHQ_optic_HWS_tan",
  "FHQ_optic_MARS",
  "FHQ_optic_MARS_tan",
  "FHQ_optic_MicroCCO",
  "FHQ_optic_MicroCCO_tan",
  "FHQ_optic_MCCO_M_BLK",
  "FHQ_optic_MCCO_M_TAN",
  "FHQ_optic_MicroCCO_low",
  "FHQ_optic_MicroCCO_low_tan",
  "FHQ_optic_VCOG",
  "FHQ_optic_VCOG_tan",
  "FHQ_optic_ACOG",
  "FHQ_optic_ACOG_tan"
];


// SHITTY ASSAULT RIFLES =======================================================
weaponstier_3 = [
  //vanilla
  "arifle_Mk20_plain_F",
  "arifle_MXC_F",

  //rhs
  "rhs_weap_akm",
  "rhs_weap_akms",
  "rhs_weap_aks74u",
  "rhs_weap_aks74un",
  "rhs_weap_m21a",
  "rhs_weap_m21a_pr",
  "rhs_weap_m70ab2",
  "rhs_weap_m70b1",
  "rhs_weap_m92",
  "rhs_weap_m16a4",
  "rhs_weap_sr25",
  "rhs_weap_ak74m",
  "rhs_weap_ak74m_camo",
  "rhs_weap_ak74m_camo_npz",

  //hlc
  "hlc_rifle_hl33a2RIS"
];

scopestier_3 = [
  //vanilla
  "optic_ACO_grn",
  "optic_Holosight",

  //rhs
  "rhs_acc_rakursPM",
  "rhsusf_acc_EOTECH",
  "rhsusf_acc_eotech_552",
  "rhsusf_acc_eotech_552_d",
  "rhsusf_acc_compm4",
  "rhsusf_acc_eotech_xps3",
  "rhs_acc_1p29",
  "rhs_acc_1p63",
  "rhs_acc_ekp1",
  "rhs_acc_pkas",
  "rhs_acc_1p78",

  //fhq
  "FHQ_optic_AC11704",
  "FHQ_optic_AC11704_tan",
  "FHQ_optic_AC12136",
  "FHQ_optic_AIM",
  "FHQ_optic_AIM_tan",
  "FHQ_optic_AimM_BLK",
  "FHQ_optic_AimM_TAN",
  "FHQ_optic_HWS_G33",
  "FHQ_optic_HWS",
  "FHQ_optic_HWS_tan",
  "FHQ_optic_MARS",
  "FHQ_optic_MARS_tan",
  "FHQ_optic_MicroCCO",
  "FHQ_optic_MicroCCO_tan",
  "FHQ_optic_MCCO_M_BLK",
  "FHQ_optic_MCCO_M_TAN",
  "FHQ_optic_MicroCCO_low_tan"
];

//SMGs, SHOTGUNS, OLD RIFLES ===================================================
weaponstier_4 = [
  //vanilla
  "hgun_PDW2000_F",
  "srifle_DMR_04_F",
  "srifle_DMR_04_Tan_F",
  "SMG_02_F",
  "SMG_01_F",

  //rhs
  "rhs_weap_kar98k",
  "rhs_weap_M590_8RD",
  "rhs_weap_M590_5RD",
  "rhs_weap_m38",
  "rhsusf_weap_MP7A1_base_f",
  "rhsusf_weap_MP7A1_aor1",
  "rhsusf_weap_MP7A1_desert",
  "rhs_weap_pp2000",
  "rhs_weap_asval",
  "rhs_weap_asval_grip",
  "rhs_weap_asval_npz",
  "rhs_weap_m3a1",
  "rhs_weap_scorpion",
  "rhs_weap_pp2000_folded",
  "rhs_wepa_lzh18",

  //LOP
  "LOP_Weap_LeeEnfield",

  //hlc
  "hlc_rifle_hk53",
  "hlc_rifle_hk53RAS"
];

scopestier_4 = [
  //vanilla
  "optic_Holosight",
  "optic_Holosight_smg",

  //rhs
  "rhs_acc_rakursPM",
  "rhsusf_acc_EOTECH",
  "rhsusf_acc_eotech_552",
  "rhsusf_acc_eotech_552_d",
  "rhsusf_acc_compm4",
  "rhsusf_acc_eotech_xps3",
  "rhs_acc_1p63",
  "rhs_acc_pkas",
  "rhs_acc_ekp1",

  //fhq
  "FHQ_optic_AC12136",
  "FHQ_optic_AC12136_tan",
  "FHQ_optic_AIM",
  "FHQ_optic_AIM_tan",
  "FHQ_optic_HWS",
  "FHQ_optic_HWS_tan",
  "FHQ_optic_MARS",
  "FHQ_optic_MARS_tan",
  "FHQ_optic_MicroCCO",
  "FHQ_optic_MicroCCO_tan",
  "FHQ_optic_MicroCCO_low",
  "FHQ_optic_MicroCCO_low_tan"
];


//PISTOLS ======================================================================
weaponstier_5 = [
  //vanilla
  "hgun_Pistol_heavy_02_F",
  "hgun_ACPC2_F",
  "hgun_Pistol_heavy_01_F",
  "hgun_Rook40_F",
  "hgun_P07_F",

  //rhs
  "rhsusf_weap_glock17g4",
  "rhsusf_weap_m1911a1",
  "rhsusf_weap_m9",
  "rhs_weap_pya",
  "rhs_weap_makarov_pm",
  "rhs_weap_makarov_pmm"
];

scopestier_5 = [
  "optic_Yorris",
  "optic_MRD"
];
