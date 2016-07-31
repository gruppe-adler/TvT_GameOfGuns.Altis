#include "defines.sqf"

class leaderboard
{
  idd = leaderboard_dialog;
  movingEnable = false;
  enableSimulation = true;

  class ControlsBackground
  {
    #define lb_elementPaddingY (0.05 * Y_SCALE)

    #define lb_cellW (0.015 * X_SCALE)
    #define lb_cellH (0.015 * Y_SCALE)
    #define lb_cellPaddingX (0.01 * X_SCALE)
    #define lb_cellPaddingY (0.01 * Y_SCALE)

    #define lb_columnW (0.02 * X_SCALE)
    #define lb_numberOfRows (5)
    #define lb_numberOfColumns (5)

    #define lb_titleH (0.075 * lb_cellH)
    #define lb_mainW ((lb_numberOfColumns * lb_cellW) + ((lb_numberOfColumns+1) * lb_cellPaddingX))
    #define lb_mainH (lb_cellPaddingY + lb_titleH + lb_cellPaddingY + ((lb_cellH + lb_cellPaddingY) * lb_numberOfRows))
    #define lb_mystatsH (lb_cellPaddingY + lb_titleH + lb_cellPaddingY + lb_cellH + lb_cellPaddingY)

    #define lb_mainX CENTER(1, lb_mainW)
    #define lb_mainY CENTER(1, lb_mainH)
    #define lb_titleY (lb_mainY - lb_elementPaddingY - lb_titleH)
    #define lb_mystatsTitleY (lb_mainY + lb_mainH + 2*lb_elementPaddingY)
    #define lb_mystatsY (lb_mystatsTitleY + lb_titleH + lb_elementPaddingY)

    class TitleBar: w_RscText
    {
      idc = -1;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0])",1};

      x = lb_mainX;
      y = lb_titleY;
      w = lb_mainW;
      h = lb_titleH;

      text = "GAME OF GUNS - LEADERBOARD";
    };

    class MainBackground: IGUIBack
    {
      idc = -1;
      colorBackground[] = {0, 0, 0, 0.6};

      x = lb_mainX;
      y = lb_mainY;
      w = lb_mainW;
      h = lb_mainH;
    };

    class MyStatsTitle: w_RscText
    {
      idc = -1;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0])",1};

      x = lb_mainX;
      y = lb_mystatsTitleY;
      w = lb_mainW;
      h = lb_titleH;

      text = "YOUR STATS THIS GAME";
    };

    class MyStatsBG: IGUIBACK
    {
      idc = -1;
      colorBackground[] = {0, 0, 0, 0.6};

      x = lb_mainX;
      y = lb_mystatsY;
      w = lb_mainW;
      h = lb_mystatsH;
    };

  };

  class Controls
  {

  };
};
