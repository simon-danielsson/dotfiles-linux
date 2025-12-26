
# ==== general ====

config.load_autoconfig()
c.auto_save.session = True
c.scrolling.smooth = True
c.hints.auto_follow = 'unique-match'
c.downloads.location.directory = '~/Downloads'

c.editor.command = [
    'alacritty', '-e', 'nvim', '{file}'
]
# ==== privacy ====

c.content.autoplay = False
c.content.canvas_reading = False
c.content.geolocation = False
c.content.notifications.enabled = False
c.content.headers.referer = 'same-domain'
c.content.https_only = True
c.downloads.prevent_mixed_content = True

# ==== color settings ====

fg_main  = "#ffffff"
fg_mid   = "#888888"
bg_mid   = "#333333"
bg_mid2  = "#333333"
bg_deep  = "#212121"
bg_deep2 = "#1a1a1a"

c.window.transparent = True
c.colors.webpage.preferred_color_scheme = "dark"

# ==== statusbar ====

c.colors.statusbar.normal.bg = bg_deep2
c.colors.statusbar.command.bg = bg_deep2

# ==== tabs ====

c.colors.tabs.even.bg = bg_deep2
c.colors.tabs.odd.bg = bg_deep2
c.colors.tabs.selected.even.bg = bg_mid2
c.colors.tabs.selected.odd.bg = bg_mid2

c.tabs.show = "always"
c.tabs.position = "top"

# ==== start page ====

c.url.start_pages = ["https://duckduckgo.com"]
c.url.default_page = "https://duckduckgo.com"

# ==== fonts ====

c.fonts.default_family = '0xProto Nerd Font'
c.fonts.default_size = '10pt'
c.fonts.web.family.fixed = 'monospace'
c.fonts.web.family.sans_serif = 'monospace'
c.fonts.web.family.serif = 'monospace'
c.fonts.web.family.standard = 'monospace'

# ==== keybinds ====

# insert mode
config.bind(" i", "mode-enter insert", mode="normal")
# tabs
config.bind("n", "tab-prev")
config.bind("i", "tab-next")

# bookmarks
config.bind("b", "bookmark-list")
config.bind("B", "bookmark-add")

# search
config.bind("<", "search-prev")
config.bind(">", "search-next")

# history
config.bind("h", "history")
config.bind("l", "back")
config.bind("ö", "forward")

# scrolling
config.bind("e", "scroll down")
config.bind("o", "scroll up")


