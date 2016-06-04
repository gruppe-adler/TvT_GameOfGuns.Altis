/*  Defines uniforms and vests available to teams
*
*/

waitUntil {!isNil "ISWOODLAND"};

//WOODLAND =====================================================================
if (ISWOODLAND) then {
  randomUniforms = [
    //VANILLA
    ['U_B_CombatUniform_mcam', 'V_PlateCarrier1_rgr'],
    ['U_I_CombatUniform', 'V_Chestrig_oli'],
    ['U_B_CTRG_1', 'V_PlateCarrier1_rgr'],
    ['U_O_CombatUniform_ocamo', 'V_TacVest_khk'],
    ['U_B_CombatUniform_mcam_vest', 'V_PlateCarrier1_rgr'],

    //ARC
    ['ARC_Common_MC_Uniform', 'ARC_Common_TAN_PlateCarrier_1'],
    ['ARC_GER_Flecktarn_Uniform', 'ARC_GER_Flecktarn_Plate_Carrier'],

    //THAI
    ['U_AFASoldierUni_A', 'V_PlateCarrier1_rgr'],
    ['U_CombatUniVest_A', 'V_Chestrig_blk'],
    ['U_CDFSoldierUni_A', 'V_PlateCarrier1_rgr'],
    ['U_CombatUniLong_A', 'V_PlateCarrier1_rgr'],
    ['U_CombatUniFatigue_A', 'V_PlateCarrier1_blk'],
    ['U_CDGCombatUni_C', 'V_TacVest_khk'],
    ['U_CDGCombatUni_B', 'V_TacVest_khk'],
    ['U_InsUniShirt_B', 'V_I_G_resistanceLeader_F'],
    ['U_InsUniShirt_A', 'V_I_G_resistanceLeader_F'],
    ['U_TKOfficerUni_B', 'V_TacVest_TK'],
    ['U_TKSoldierUni_B', 'V_TacVestEX_C'],
    ['U_CombatUniShirtMercB_D', 'V_TacVestEX_C'],
    ['U_CombatUniShirtMercB_H', 'V_TacVest_camo'],
    ['U_MilitiaSport_C', 'V_TacVest_brn'],
    ['U_CombatUniSleevesShort_C', 'V_FlakJacket_SH_Woodland'],
    ['U_CombatUniSleeves_B', 'V_TacVest_oli'],
    ['U_CombatUniSleeves_A', 'V_TacVest_oli'],
    ['U_CombatUniSleeves_D', 'V_TacVest_oli'],

    //RHS
    ['rhs_uniform_cu_ocp', 'rhsusf_iotv_ocp_SAW'],
    ['rhs_uniform_emr_patchless', 'rhs_6b23_digi_rifleman'],
    ['rhs_uniform_flora_patchless', 'rhs_6b13_Flora'],
    ['rhs_uniform_flora_patchless_alt', 'rhs_6b23_ML'],
    ['rhs_uniform_FROG01_wd', 'rhsusf_spc'],
    ['rhs_uniform_g3_blk', 'V_TacVest_oli'],
    ['rhs_uniform_g3_m81', 'V_TacVest_oli'],
    ['rhs_uniform_g3_mc', 'rhsusf_spc'],
    ['rhs_uniform_g3_rgr', 'V_TacVest_khk'],
    ['rhs_uniform_mvd_izlom', 'V_I_G_resistanceLeader_F'],
    ['rhsgref_uniform_para_ttsko_mountain', 'rhsgref_6b23_ttsko_mountain'],
    ['rhsgref_uniform_para_ttsko_urban', 'rhsgref_6b23_ttsko_mountain'],
    ['rhsgref_uniform_vsr', 'rhsgref_6b23_khaki_rifleman'],
    ['rhsgref_uniform_ttsko_forest', 'rhsgref_6b23_khaki_rifleman'],
    ['rhsgref_uniform_ttsko_mountain', 'rhsgref_6b23_ttsko_mountain'],
    ['rhsgref_uniform_alpenflage', 'rhs_6b23'],
    ['rhsgref_uniform_tigerstripe', 'rhs_6b13_Flora'],
    ['rhsgref_uniform_woodland', 'rhs_6b13_Flora'],
    ['rhsgref_uniform_specter', 'rhsgref_6b23_khaki_rifleman']
  ];

//DESERT =======================================================================
} else {
  randomUniforms = [
    //VANILLA
    ['U_O_CombatUniform_oucamo', 'V_TacVest_blk'],

    //ARC
    ['ARC_GER_Tropentarn_Uniform', 'ARC_GER_Tropentarn_Plate_Carrier'],

    //THAI
    ['U_MilitiaUniTShirt_E', 'V_TacVest_brn'],
    ['U_InsUniShirt_C', 'V_ChestRig_light_A'],
    ['U_TKSpecialUni_A', 'V_TacVestEX_A'],
    ['U_TKSoldierUni_A', 'V_TacVestEX_A'],
    ['U_CombatUniShirtMercB_C', 'V_TacVestEX_A'],
    ['U_CombatUniShirtMercC_B', 'V_TacVest_khk'],
    ['U_CombatUniShirtMercC_A', 'V_TacVest_khk'],
    ['U_DressTKLocalUni_E_A', 'V_TacVest_khk'],
    ['U_TKLocalUni_A', 'V_Vest_light_Invisible'],
    ['U_MilitiaUniShirt_E', 'V_Chestrig_khk'],
    ['U_CombatUniSleeves_F', 'V_ChestRig_light_C'],

    //RHS
    ['rhs_uniform_cu_ucp', 'rhsusf_iotv_ucp_SAW'],
    ['rhs_uniform_emr_des_patchless', 'V_TacVest_brn'],
    ['rhs_uniform_FROG01_d', 'rhsusf_spc'],
    ['rhs_uniform_g3_tan', 'V_TacVest_khk'],
    ['rhs_uniform_m88_patchless', 'rhs_6b23_ML'],
    ['rhs_uniform_mflora_patchless', 'rhs_6b13_6sh92_vog'],

    //SMA
    ['SMA_UNIFORMS_TAN', 'V_Chestrig_khk']
  ];
};
