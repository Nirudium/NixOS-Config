{pkgs, ...}: {
  home.packages = with pkgs; let
    # TODO: ADD SCRIPTS TO HANDLE VIDEO IN DIRECTORIES WITH MPV
    # TODO: MAKE THAT BOOKMARK HANDLER
    # TODO: RIP MORE STUFF OFF (WHY WRITE IT YOURSELF!!!!!!)
    emoji = pkgs.writeShellScriptBin "emoji" builtins.readFile ./emoji.sh;
    zipmenu = pkgs.writeShellScriptBin "zipmenu" builtins.readFile ./zipmenu.sh;
    rgmenu = pkgs.writeShellScriptBin "rgmenu" builtins.readFile ./rgmenu.sh;
    sshmenu = pkgs.writeShellScriptBin "sshmenu" builtins.readFile ./sshmenu.sh;
  in [
    # for compatibility sake
    (writeScriptBin "dmenu" ''exec ${lib.getExe tofi}'')
    tofi
    emoji
    wtype
    zipmenu
    rgmenu
    sshmenu
  ];
  xdg.configFile."tofi/config".text = ''
    font = FiraCode Nerd Font
    font-size = 11
    horizontal = true
    anchor = bottom
    width = 100%
    height = 16
    outline-width = 0
    border-width = 0
    min-input-width = 120
    result-spacing = 30
    padding-top = 0
    padding-bottom = 0
    padding-left = 0
    padding-right = 0
    margin-top = 0
    margin-bottom = 3
    margin-left = 15
    margin-right = 0
    prompt-text = "-> "
    prompt-padding = 301
    background-color = #1a1b26
    text-color = #cfc9c2
    prompt-color = #bb9af7
    prompt-background = #1a1b26
    prompt-background-padding = 4, 10
    prompt-background-corner-radius = 12
    input-background = #1a1b26
    input-background-padding = 4, 10
    input-background-corner-radius = 12
    selection-color = #7aa2f7
    selection-background = #1a1b26
    selection-background-padding = 4, 10
    selection-background-corner-radius = 12
    selection-match-color = #73daca
    clip-to-padding = false
  '';
}
