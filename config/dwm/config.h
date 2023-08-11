/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

#define TERMINAL "kitty"
#define TERMCLASS "st-256color"
#define BROWSER "qutebrowser"
#define EMACS "emacsclient -c -a 'emacs' "

/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft  = 0;   /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */

static const char *fonts[]          = {"Iosevka:style:medium:size=13" ,"JetBrainsMono Nerd Font Mono:style:medium:size=19" };

static const char col_gray1[]       = "#000000";
static const char col_gray2[]       = "#000000";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#000000";
static const char col_cyan[]        = "#00ff00";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};


/* tagging */
static const char *tags[] = { "󰈹", "", "", "", "" };

static const unsigned int ulinepad	= 5;	/* horizontal padding between the underline and tag */
static const unsigned int ulinestroke	= 2;	/* thickness / height of the underline */
static const unsigned int ulinevoffset	= 0;	/* how far above the bottom of the bar the line should appear */
static const int ulineall 		= 0;	/* 1 to show underline on all tags, 0 for just the active ones */

// #include "/home/salion/.cache/wal/colors-wal-dwm.h"
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "Gimp",    NULL,     NULL,           0,         1,          0,           0,        -1 },
	{ "Firefox", NULL,     NULL,           1 << 8,    0,          0,          -1,        -1 },
	{ "kitty",      NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG)												\
	&((Keychord){1, {{MODKEY, KEY}},								view,           {.ui = 1 << TAG} }), \
		&((Keychord){1, {{MODKEY|ControlMask, KEY}},					toggleview,     {.ui = 1 << TAG} }), \
		&((Keychord){1, {{MODKEY|ShiftMask, KEY}},						tag,            {.ui = 1 << TAG} }), \
		&((Keychord){1, {{MODKEY|ControlMask|ShiftMask, KEY}},			toggletag,      {.ui = 1 << TAG} }),

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *termcmd[]  = { "kitty", NULL };
static const char *browser[]  = { BROWSER, NULL };

static Keychord *keychords[] = {
	/* Keys        function        argument */
	&((Keychord){1, {{MODKEY|ShiftMask, XK_Return}}, spawn,          {.v = dmenucmd } }),
	&((Keychord){1, {{MODKEY, XK_Return}}, spawn,          {.v = termcmd } }),
	&((Keychord){2, {{MODKEY, XK_e}, {MODKEY, XK_e}},			spawn,          {.v = termcmd } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_b}},							togglebar,      {0} }),
	&((Keychord){1, {{MODKEY, XK_j}},							focusstack,     {.i = +1 } }),
	&((Keychord){1, {{MODKEY, XK_k}},							focusstack,     {.i = -1 } }),
	&((Keychord){1, {{MODKEY, XK_i}},							incnmaster,     {.i = +1 } }),
	&((Keychord){1, {{MODKEY, XK_d}},							incnmaster,     {.i = -1 } }),
	&((Keychord){1, {{MODKEY, XK_h}},							setmfact,       {.f = -0.05} }),
	&((Keychord){1, {{MODKEY, XK_l}},							setmfact,       {.f = +0.05} }),
	&((Keychord){1, {{MODKEY|ControlMask, XK_Return}},						zoom,           {0} }),
	&((Keychord){1, {{MODKEY, XK_Tab}},							view,           {0} }),
	&((Keychord){1, {{MODKEY, XK_w}},					killclient,     {0} }),
        &((Keychord){1, {{MODKEY, XK_q}},                                       killclient,     {0} }),
	&((Keychord){1, {{MODKEY, XK_t}},							setlayout,      {.v = &layouts[0]} }),
	&((Keychord){1, {{MODKEY, XK_f}},							setlayout,      {.v = &layouts[1]} }),
	&((Keychord){1, {{MODKEY, XK_m}},							setlayout,      {.v = &layouts[2]} }),
	&((Keychord){1, {{MODKEY, XK_space}},						setlayout,      {0} }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_space}},				togglefloating, {0} }),
	&((Keychord){1, {{MODKEY, XK_0}},							view,           {.ui = ~0 } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_0}},					tag,            {.ui = ~0 } }),
	&((Keychord){1, {{MODKEY, XK_comma}},						focusmon,       {.i = -1 } }),
	&((Keychord){1, {{MODKEY, XK_period}},						focusmon,       {.i = +1 } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_comma}},				tagmon,         {.i = -1 } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_period}},			tagmon,         {.i = +1 } }),
 	&((Keychord){1, {{MODKEY, XK_minus}},  setgaps,        {.i = -1 } }),
	&((Keychord){1, {{MODKEY, XK_equal}},  setgaps,        {.i = +1 } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_equal}},  setgaps,        {.i = 0  } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_j}},      movestack,      {.i = +1 } }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_k}},      movestack,      {.i = -1 } }),
  // apps 
  &((Keychord){1, {{MODKEY, XK_b}},                spawn,     {.v = browser }}),
  &((Keychord){1, {{MODKEY, XK_o}},                spawn,     SHCMD("pcmanfm")}),
  &((Keychord){1, {{MODKEY|Mod1Mask, XK_h}},       spawn,     SHCMD(TERMINAL " -e htop")}),
  // dunst
  &((Keychord){2, {{MODKEY, XK_d}, {0, XK_q}},     spawn,     SHCMD("dunstctl close-all")}),
  &((Keychord){2, {{MODKEY, XK_d}, {0, XK_h}},     spawn,     SHCMD("dunstctl history-pop")}),
  &((Keychord){2, {{MODKEY, XK_d}, {0, XK_w}},     spawn,     SHCMD("dunstctl close")}),
  // emacs
  &((Keychord){2, {{MODKEY, XK_e}, {0, XK_e}},     spawn,     SHCMD( EMACS "--eval '(dashboard-refresh-buffer)'")}),
  &((Keychord){2, {{MODKEY, XK_e}, {0, XK_b}},     spawn,     SHCMD( EMACS "--eval '(ibuffer)'") }),
  &((Keychord){2, {{MODKEY, XK_e}, {0, XK_d}},     spawn,     SHCMD( EMACS "--eval '(dired nil)'") }),
  &((Keychord){2, {{MODKEY, XK_e}, {0, XK_i}},     spawn,     SHCMD( EMACS "--eval '(erc)'") }),
  &((Keychord){2, {{MODKEY, XK_e}, {0, XK_s}},     spawn,     SHCMD( EMACS "--eval '(eshell)'") }),
  &((Keychord){2, {{MODKEY, XK_e}, {0, XK_v}},     spawn,     SHCMD( EMACS "--eval '(+vterm/here nil)'") }),
  // multimedia
  &((Keychord){1,{{0, XF86XK_AudioLowerVolume}},   spawn,     SHCMD("Bajar Volumen")}),
  &((Keychord){1,{{0, XF86XK_AudioRaiseVolume}},   spawn,     SHCMD("Subir Volumen")}),
  &((Keychord){1,{{0, XF86XK_AudioMute}},          spawn,     SHCMD("Mutear Volumen")}),
  // my scripts
  &((Keychord){2, {{MODKEY, XK_p}, {0, XK_p}},     spawn,     SHCMD("rofi -show drun")}),
  &((Keychord){2, {{MODKEY, XK_p}, {0, XK_m}},     spawn,     SHCMD("tilix")}),
  &((Keychord){1, {{MODKEY, XK_F2}},                spawn,    SHCMD("conky")}),
  &((Keychord){1, {{MODKEY, XK_F1}},                spawn,    SHCMD("rofi -show drun")}),
  &((Keychord){1, {{MODKEY, XK_F3}},                spawn,    SHCMD("nitrogen")}),
  &((Keychord){1, {{MODKEY, XK_F4}},                spawn,    SHCMD("kill")}),
  &((Keychord){1, {{MODKEY, XK_d}},                 spawn,    SHCMD("dmenu_run")}),
  &((Keychord){1, {{MODKEY, XK_u}},                 spawn,    SHCMD("thunar")}),
  &((Keychord){1, {{MODKEY, XK_p}},                 spawn,    SHCMD("rofi -show drun")}),
  &((Keychord){1, {{MODKEY, XK_F5}},                spawn,    SHCMD("dmenu_run")}),
  &((Keychord){1, {{MODKEY, XK_F6}},                spawn,    SHCMD("tilix")}),
  &((Keychord){1, {{MODKEY, XK_F9}},                spawn,    SHCMD("filezilla")}),
  &((Keychord){1, {{MODKEY, XK_F7}},                spawn,    SHCMD("alacritty")}),
  &((Keychord){1, {{MODKEY, XK_F8}},                spawn,    SHCMD("terminator")}),
  &((Keychord){1, {{MODKEY, XK_F10}},               spawn,    SHCMD("cool-retro-term")}),
  &((Keychord){1, {{MODKEY, XK_F12}},               spawn,    SHCMD("exec /usr/bin/bar.sh")}),
  &((Keychord){1, {{MODKEY, XK_F11}},               spawn,    SHCMD("flameshot")}),

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
  &((Keychord){1, {{MODKEY|ShiftMask, XK_q}},					spawn,          SHCMD("killall dwm") }),
	&((Keychord){1, {{MODKEY|ShiftMask, XK_r}},					quit,           {0} }),
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
