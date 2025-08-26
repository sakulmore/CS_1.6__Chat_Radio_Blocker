#include <amxmodx>
#include <amxmisc>

#define PLUGIN_NAME    "Chat Radio Blocker"
#define PLUGIN_VERSION "1.0"
#define PLUGIN_AUTHOR  "sakulmore"

new bool:g_bBlockRadio = true;

new g_msgRadioText;
new g_msgTextMsg;
new g_msgSayText;

public plugin_init()
{
    register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR);

    g_msgRadioText = get_user_msgid("RadioText");
    g_msgTextMsg   = get_user_msgid("TextMsg");
    g_msgSayText   = get_user_msgid("SayText");

    register_message(g_msgRadioText, "Hook_RadioText");
    register_message(g_msgTextMsg,   "Hook_TextMsgRadio");
    register_message(g_msgSayText,   "Hook_SayTextMaybeRadio");

    register_concmd("amx_radioturn", "CmdRadioTurn", 0, "on/off");
}

public Hook_RadioText(msg_id, msg_dest, msg_entity)
{
    if (g_bBlockRadio)
    {
        return PLUGIN_HANDLED;
    }
    return PLUGIN_CONTINUE;
}

public Hook_TextMsgRadio(msg_id, msg_dest, msg_entity)
{
    if (!g_bBlockRadio)
        return PLUGIN_CONTINUE;

    new args = get_msg_args();
    for (new i = 1; i <= args; i++)
    {
        if (get_msg_argtype(i) != ARG_STRING)
            continue;

        static s[192];
        get_msg_arg_string(i, s, charsmax(s));

        if (containi(s, "#Game_radio") != -1
         || containi(s, "#Game_radio_location") != -1
         || containi(s, "%!MRAD_") != -1
         || containi(s, "#Cstrike_TitlesTXT_") != -1)
        {
            return PLUGIN_HANDLED;
        }
    }

    return PLUGIN_CONTINUE;
}

public Hook_SayTextMaybeRadio(msg_id, msg_dest, msg_entity)
{
    if (!g_bBlockRadio)
        return PLUGIN_CONTINUE;

    if (get_msg_args() >= 2)
    {
        static s[192];
        get_msg_arg_string(2, s, charsmax(s));
        if (containi(s, "(RADIO)") != -1)
        {
            return PLUGIN_HANDLED;
        }
    }
    return PLUGIN_CONTINUE;
}

public CmdRadioTurn(id, level, cid)
{
    if (read_argc() < 2)
    {
        if (id == 0) server_print("[ChatRadioBlocker] Usage: amx_radioturn on|off");
        else         client_print(id, print_console, "[ChatRadioBlocker] Usage: amx_radioturn on|off");
        return PLUGIN_HANDLED;
    }

    static arg[16];
    read_argv(1, arg, charsmax(arg));

    if (equali(arg, "on"))
    {
        g_bBlockRadio = false;
        if (id == 0) server_print("[ChatRadioBlocker] Radio chat is now ON (visible).");
        else         client_print(id, print_console, "[ChatRadioBlocker] Radio chat is now ON (visible).");
    }
    else if (equali(arg, "off"))
    {
        g_bBlockRadio = true;
        if (id == 0) server_print("[ChatRadioBlocker] Radio chat is now OFF (hidden).");
        else         client_print(id, print_console, "[ChatRadioBlocker] Radio chat is now OFF (hidden).");
    }
    else
    {
        if (id == 0) server_print("[ChatRadioBlocker] Invalid value. Use: on/off");
        else         client_print(id, print_console, "[ChatRadioBlocker] Invalid value. Use: on/off");
    }

    return PLUGIN_HANDLED;
}