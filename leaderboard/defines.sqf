//STYLES =======================================================================
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0c

//IDCs =========================================================================
#define leaderboard_dialog 3999
#define lb_0_0 4000
#define lb_0_1 4001
#define lb_0_2 4002
#define lb_0_3 4003
#define lb_0_4 4004
#define lb_1_0 4100
#define lb_1_1 4101
#define lb_1_2 4102
#define lb_1_3 4103
#define lb_1_4 4104
#define lb_2_0 4200
#define lb_2_1 4201
#define lb_2_2 4202
#define lb_2_3 4203
#define lb_2_4 4204
#define lb_3_0 4300
#define lb_3_1 4301
#define lb_3_2 4302
#define lb_3_3 4303
#define lb_3_4 4304
#define lb_4_0 4400
#define lb_4_1 4401
#define lb_4_2 4402
#define lb_4_3 4403
#define lb_4_4 4404
#define mystats_0 4500
#define mystats_1 4501
#define mystats_2 4502
#define mystats_3 4503
#define mystats_4 4504

//COORDS AND DIMS ==============================================================
#define lb_cellW (0.075 * X_SCALE)
#define lb_cellH (0.025 * Y_SCALE)

#define lb_elementPaddingY (0.005 * Y_SCALE)

#define lb_cellPaddingX (0.01 * X_SCALE)
#define lb_cellPaddingY (0.01 * Y_SCALE)

#define lb_numberOfRows (5)
#define lb_numberOfColumns (5)

#define lb_titleH (0.025 * Y_SCALE)
#define lb_mainW ((lb_numberOfColumns * lb_cellW) + ((lb_numberOfColumns+1) * lb_cellPaddingX))
#define lb_mainH (lb_cellPaddingY + lb_titleH + lb_cellPaddingY + ((lb_cellH + lb_cellPaddingY) * lb_numberOfRows))
#define lb_mystatsH (lb_cellPaddingY + lb_titleH + lb_cellPaddingY + lb_cellH + lb_cellPaddingY)

#define lb_mainX CENTER(1, lb_mainW)
#define lb_titleY CENTER(1, lb_titleH + lb_mainH + lb_titleH + lb_mystatsH)
#define lb_mainY (lb_titleY + lb_titleH + lb_elementPaddingY)

#define lb_mystatsTitleY (lb_mainY + lb_mainH + 2*lb_elementPaddingY)
#define lb_mystatsY (lb_mystatsTitleY + lb_titleH + lb_elementPaddingY)
