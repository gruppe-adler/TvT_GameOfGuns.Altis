//TYPES AND STYLES =============================================================
#define CT_STATIC           0

#define ST_LEFT           0x00
#define ST_CENTER         0x02

//KILLCAM ======================================================================
#define KILLCAMTITLE_DIALOG 5000
#define KILLCAMTITLE_TITLE 5001

#define kc_W (1 * X_SCALE)
#define kc_H (0.1 * Y_SCALE)
#define kc_titleX CENTER(1, kc_W)
#define kc_titleY (0.65 * Y_SCALE)

//SCOREBOARD ===================================================================
#define SCOREBOARD_DIALOG 4000
#define SCOREBOARD_ITEM1 4001
#define SCOREBOARD_ITEM2 4002
#define SCOREBOARD_ITEM3 4003
#define SCOREBOARD_ITEM4 4004
#define SCOREBOARD_SCORE1 4011
#define SCOREBOARD_SCORE2 4012
#define SCOREBOARD_SCORE3 4013
#define SCOREBOARD_SCORE4 4014

#define sb_itemW (0.25 * X_SCALE)
#define sb_itemH (0.025 * Y_SCALE)
#define sb_scoreW (sb_itemH * 0.75)
#define sb_totalX (SZ_RIGHT - 0.25)
#define sb_totalY (0.01 * Y_SCALE)
#define sb_itemSpacingX (0.03 * sb_itemH * X_SCALE)
#define sb_itemSpacingY (0.03 * sb_itemH * Y_SCALE)
