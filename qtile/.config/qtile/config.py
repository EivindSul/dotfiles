# config by EivindSul

from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.backend.wayland import InputConfig

mod = "mod4"
terminal = guess_terminal()
myTerminal = "alacritty"

qtile.core.cmd_set_keymap(layout="no")


# Colors
colors = dict(

    # pastels
    pastelRed = "#FFADAD",
    pastelOrange = "#FFD6A5",
    pastelYellow = "#FDFFB6",
    pastelGreen = "#CAFFBF",
    pastelBlue = "#9BF6FF",
    pastelIndigo = "#A0C4FF",
    pastelPurple = "#BDB2FF",
    pastelPink = "#FFC6FF",
    pastelCream = "#FFFFFC",

    # dark neutrals
    eerieBlack = "#1A1D1A",
    blackOlive = "#3D3B30",

    # medium neutrals
    davysGray = "#4D5061",

    # light neutrals
    romance = "#F5F2EA",

    # copper palette
    copper = "#EB9C5C",
    greenCopper = "#53917E",
    greyGreen = "#3B3C36",

    # dark copper palette
    sourDough = "#CAB19B",
    santeFe = "#A76B50",
    rope = "#8C5638",
    darkGreenCopper = "#4A756E",
    deepTeal = "#1B4B43",
    darkOliveDrab = "#0B0E03",

    # purples
    wenge = "#655560",
    englishViolet = "#624763",
    darkPurple = "#42273B",
)


pastels = [
    colors.get("pastelRed"),
    colors.get("pastelOrange"),
    colors.get("pastelYellow"),
    colors.get("pastelGreen"),
    colors.get("pastelBlue"),
    colors.get("pastelIndigo"),
    colors.get("pastelPurple"),
    colors.get("pastelPink"),
    colors.get("pastelCream"),
]

purpleTheme = dict(
    background = colors.get("eerieBlack"),
    foreground = colors.get("romance"),
    accent = colors.get("greyGreen"),
    widgetBackground1 = colors.get("englishViolet"),
    widgetBackground2 = colors.get("darkPurple"),
)


copperTheme = dict(
    background = colors.get("eerieBlack"),
    foreground = colors.get("pastelCream"),
    accent = colors.get("wenge"),
    widgetBackground1 = colors.get("englishViolet"),
    widgetBackground2 = colors.get("davysGray"),
)

darkCopperTheme = dict(
    background = colors.get("darkOliveDrab"),
    foreground = colors.get("copper"),
    accent = colors.get("rope"),
    widgetBackground1 = colors.get("darkGreenCopper"),
    widgetBackground2 = colors.get("deepTeal"),
)

earthTheme = dict(
    background = colors.get("eerieBlack"),
    foreground = colors.get("romance"),
    accent = colors.get("greyGreen"),
    widgetBackground1 = colors.get("englishViolet"),
    widgetBackground2 = colors.get("darkPurple"),
)

background = colors.get("eerieBlack"),
foreground = colors.get("sourDough"),
accent = colors.get("wenge"),
widgetBackground1 = colors.get("englishViolet"),
widgetBackground2 = colors.get("davysGray"),

theme = darkCopperTheme
theme = purpleTheme
# theme = earthTheme

background = theme.get("background")
foreground = theme.get("foreground")
accent = theme.get("accent")
widgetBackground1 = theme.get("widgetBackground1")
widgetBackground2 = theme.get("widgetBackground2")


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(myTerminal), desc="Launch terminal"),
    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "space", lazy.spawn("rofi -show combi"), desc="Launch rofi"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]


group_names = "111 222 333 444 555 666 777 888 999".split()
groups = [Group(name,layout='columns') for name in group_names]
for i, name in enumerate(group_names):
    index = str(i + 1)
    keys += [
        Key([mod], index, lazy.group[name].toscreen()),
        Key([mod, "shift"], index, lazy.window.togroup(name))]

layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=0),
    layout.Max(),
    # layout.MonadTall(), #Master stack midtdelt
    layout.MonadThreeCol(), #Master stack midtdelt
    # layout.MonadWide(), #Master stack midtdelt med breie vinduer. Kan helt sikkert konfigureres til å bli bra til koding, men tvilsom. Liker den egentlig ganske godt hvis eg gjør toppvinduet større
    layout.Zoomy(), #må prøves, kan være fett. er som å minimere vinduer.
]


widget_defaults = dict(
    background = widgetBackground2,
    foreground = foreground,
    font="Ubuntu Bold",
    fontsize=12,
    padding=5,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(
                    active = foreground, 
                    inactive = accent,
                    background = widgetBackground1,
                    foreground = foreground,
                    this_current_screen_border = pastels[6],
                    disable_drag = True,
                    highlight_color = [widgetBackground1,background],
                    highlight_method = "line",
                    spacing = 5,
                    
                ), 
                widget.Prompt(background = background),
                widget.Spacer(background = background),
                widget.CurrentLayout(background = widgetBackground2),
                widget.Wallpaper(
                    label = "wallpaper",
                    directory = "~/Pictures/wallpapers",
                    background = widgetBackground1,
                    wallpaper_command = None,
                ),
                widget.Clock(format="%d-%m-%Y %H:%M"),
                widget.QuickExit(
                    background = widgetBackground1,
                    # font = "Lekton Nerd Font Mono Bold",
                    # font = "JetBrainsMono Nerd Font",
                )
            ],
            30,
        ),
        wallpaper = "/home/eivind/Pictures/wallpapers/1644038304724.jpg",
        wallpaper_mode = "fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = {
    "type:pointer"  : InputConfig(accel_profile="flat", pointer_accel=(-0.2)),
}

wmname = "LG3D"
