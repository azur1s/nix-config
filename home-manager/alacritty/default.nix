{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 16;
          y = 16;
        };
      };
      colors = {
        primary = {
            background = "#161616";
            foreground = "#ffffff";
        };
        normal = {
            black = "#262626";
            magenta = "#ff7eb6";
            green = "#42be65";
            yellow = "#ffe97b";
            blue = "#33b1ff";
            red = "#ee5396";
            cyan = "#3ddbd9";
            white = "#dde1e6";
        };
        bright = {
            black = "#393939";
            magenta = "#ff7eb6";
            green = "#42be65";
            yellow = "#ffe97b";
            blue = "#33b1ff";
            red = "#ee5396";
            cyan = "#3ddbd9";
            white = "#ffffff";
        };
      };
    };
  };
}