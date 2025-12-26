
#!/bin/sh

# Listen for all window events, line-buffered
stdbuf -oL i3-msg -m -t subscribe '[ "window" ]' |
        while IFS= read -r _; do
                # Current focused workspace
                WS=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
                [ -z "$WS" ] && continue

                NUM=${WS%%:*}

    # Focused window class (X11)
    APP=$(i3-msg -t get_tree | jq -r '
    .. | objects |
            select(.focused? == true) |
            .window_properties.class // empty
    ')

    case "$APP" in
            Firefox)    LABEL=\ 󰖟\ Browser;;
            Alacritty)  LABEL=\ \ Terminal;;
            Pcmanfm)     LABEL=\ \ Files;;
            qutebrowser)     LABEL=\ 󰖟\ Browser;;
            vlc)     LABEL=\ 󰕼\ Media;;
            Gimp)     LABEL=\ \ GIMP;;
            REAPER)     LABEL=\ \ REAPER;;
            OBS)     LABEL=\ 󰄀\ OBS;;
            *) continue ;;
    esac

    i3-msg "rename workspace \"$WS\" to \"$NUM:$LABEL\"" >/dev/null
done
