class KillCamTitle
{
    idd = KILLCAMTITLE_DIALOG;
    enableDisplay = true;
    enableSimulation = true;
	duration = 8;
	onLoad = "uiNamespace setVariable [""KillCamTitle_Display"", _this select 0]";

    class ControlsBackground
    {
        class Title: KillCamText
        {
            idc = KILLCAMTITLE_TITLE;
            x = kc_titleX;
            y = kc_titleY;
            w = kc_W;
            h = kc_H;
        };
    };
};
