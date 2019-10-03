/*  Defines uniforms and vests available to teams
*
*/

private _isWoodLand = toLower ([missionConfigFile >> "cfgGradIslands" >> worldName,"isWoodland",1] call BIS_fnc_returnConfigEntry) == "true";


//WOODLAND =====================================================================
private _uniformsArray = if (_isWoodLand) then {
    [
        //VANILLA
        'U_B_CombatUniform_mcam',
        'U_I_CombatUniform',
        'U_B_CTRG_1',
        'U_O_CombatUniform_ocamo',
        'U_B_CombatUniform_mcam_vest',

        //ARC
        'ARC_GER_Flecktarn_Uniform',

        //RHS
        'rhs_uniform_cu_ocp',
        'rhs_uniform_emr_patchless',
        'rhs_uniform_flora_patchless_alt',
        'rhs_uniform_FROG01_wd',
        'rhs_uniform_g3_blk',
        'rhs_uniform_g3_m81',
        'rhs_uniform_g3_mc',
        'rhs_uniform_g3_rgr',
        'rhs_uniform_mvd_izlom',
        'rhsgref_uniform_para_ttsko_mountain',
        'rhsgref_uniform_para_ttsko_urban',
        'rhsgref_uniform_vsr',
        'rhsgref_uniform_ttsko_forest',
        'rhsgref_uniform_ttsko_mountain',
        'rhsgref_uniform_alpenflage',
        'rhsgref_uniform_tigerstripe',
        'rhsgref_uniform_woodland'
    ]

//DESERT =======================================================================
} else {
    [
        //VANILLA
        'U_O_CombatUniform_oucamo',

        //ARC
        'ARC_GER_Tropentarn_Uniform',

        //RHS
        'rhs_uniform_cu_ucp',
        'rhs_uniform_emr_des_patchless',
        'rhs_uniform_FROG01_d',
        'rhs_uniform_g3_tan',
        'rhs_uniform_m88_patchless',
        'rhs_uniform_mflora_patchless'
    ]
};


_uniformsArray
