{pkgs, ...}: let
  bg = "default";
  fg = "default";
  bg2 = "brightblack";
  fg2 = "white";
  color = c: "#{@${c}}";

  indicator = let
    accent = color "indicator_color";
    content = "  ";
  in "#[reverse,fg=${accent}]#{?client_prefix,${content},}";

  current_window = let
    accent = color "main_accent";
    index = "#[reverse,fg=${accent},bg=${fg}] #I ";
    name = "#[fg=${bg2},bg=${fg2}] #W ";
    # flags = "#{?window_flags,#{window_flags}, }";
  in "${index}${name}";

  window_status = let
    accent = color "window_color";
    index = "#[reverse,fg=${accent},bg=${fg}] #I ";
    name = "#[fg=${bg2},bg=${fg2}] #W ";
    # flags = "#{?window_flags,#{window_flags}, }";
  in "${index}${name}";

  time = let
    accent = color "main_accent";
    format = "%H:%M";
    icon = pkgs.writeShellScript "icon" ''
      hour=$(date +%H)
      if   [ "$hour" == "00" ] || [ "$hour" == "12" ]; then printf "󱑖"
      elif [ "$hour" == "01" ] || [ "$hour" == "13" ]; then printf "󱑋"
      elif [ "$hour" == "02" ] || [ "$hour" == "14" ]; then printf "󱑌"
      elif [ "$hour" == "03" ] || [ "$hour" == "15" ]; then printf "󱑍"
      elif [ "$hour" == "04" ] || [ "$hour" == "16" ]; then printf "󱑎"
      elif [ "$hour" == "05" ] || [ "$hour" == "17" ]; then printf "󱑏"
      elif [ "$hour" == "06" ] || [ "$hour" == "18" ]; then printf "󱑐"
      elif [ "$hour" == "07" ] || [ "$hour" == "19" ]; then printf "󱑑"
      elif [ "$hour" == "08" ] || [ "$hour" == "20" ]; then printf "󱑒"
      elif [ "$hour" == "09" ] || [ "$hour" == "21" ]; then printf "󱑓"
      elif [ "$hour" == "10" ] || [ "$hour" == "22" ]; then printf "󱑔"
      elif [ "$hour" == "11" ] || [ "$hour" == "23" ]; then printf "󱑕"
      fi
    '';
  in "#[reverse,fg=${accent}] ${format} #(${icon}) ";

  battery = let
    percentage = pkgs.writeShellScript "percentage" (
      if pkgs.stdenv.isDarwin
      then ''
        echo $(pmset -g batt | grep -o "[0-9]\+%" | tr '%' ' ')
      ''
      else ''
        path="/org/freedesktop/UPower/devices/DisplayDevice"
        echo $(${pkgs.upower}/bin/upower -i $path | grep -o "[0-9]\+%" | tr '%' ' ')
      ''
    );
    state = pkgs.writeShellScript "state" (
      if pkgs.stdenv.isDarwin
      then ''
        echo $(pmset -g batt | awk '{print $4}')
      ''
      else ''
        path="/org/freedesktop/UPower/devices/DisplayDevice"
        echo $(${pkgs.upower}/bin/upower -i $path | grep state | awk '{print $2}')
      ''
    );
    icon = pkgs.writeShellScript "icon" ''
      percentage=$(${percentage})
      state=$(${state})
      if [ "$state" == "charging" ] || [ "$state" == "fully-charged" ]; then echo "󰂄"
      elif [ $percentage -ge 75 ]; then echo "󱊣"
      elif [ $percentage -ge 50 ]; then echo "󱊢"
      elif [ $percentage -ge 25 ]; then echo "󱊡"
      elif [ $percentage -ge 0  ]; then echo "󰂎"
      fi
    '';
    color = pkgs.writeShellScript "color" ''
      percentage=$(${percentage})
      state=$(${state})
      if [ "$state" == "charging" ] || [ "$state" == "fully-charged" ]; then echo "green"
      elif [ $percentage -ge 75 ]; then echo "green"
      elif [ $percentage -ge 50 ]; then echo "${fg2}"
      elif [ $percentage -ge 30 ]; then echo "yellow"
      elif [ $percentage -ge 0  ]; then echo "red"
      fi
    '';
  in "#[fg=#(${color})]#(${icon}) #[fg=${fg}]#(${percentage})%";

  pwd = let
    accent = color "main_accent";
    icon = "#[fg=${accent}] ";
    format = "#[fg=${fg}]#{b:pane_current_path}";
  in "${icon}${format}";

  git = let
    icon = pkgs.writeShellScript "branch" ''
      git -C "$1" branch && echo " "
    '';
    branch = pkgs.writeShellScript "branch" ''
      git -C "$1" rev-parse --abbrev-ref HEAD
    '';
  in "#[fg=magenta]#(${icon} #{pane_current_path})#(${branch} #{pane_current_path})";

  separator = "#[fg=${fg}]|";

in {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
    ];
    prefix = "C-Space";
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    shell = "${pkgs.nushell}/bin/nu";
    extraConfig = ''
      set -g @plugin 'aserowy/tmux.nvim'
      set-option -sa terminal-overrides ",xterm*:Tc"
      bind y copy-mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key b set-option status
      bind-key -n C-J next-window
      bind-key -n C-K previous-window

      bind-key -n C-v split-window -h
      bind-key -n C-s split-window -v

      bind-key -n C-n new-window
      bind h split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"

      # navigation
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

      bind-key -n 'M-H' if-shell "$is_vim" 'send-keys M-H' 'select-pane -L'
      bind-key -n 'M-J' if-shell "$is_vim" 'send-keys M-J' 'select-pane -D'
      bind-key -n 'M-K' if-shell "$is_vim" 'send-keys M-K' 'select-pane -U'
      bind-key -n 'M-L' if-shell "$is_vim" 'send-keys M-L' 'select-pane -R'

      bind-key -T copy-mode-vi 'M-H' select-pane -L
      bind-key -T copy-mode-vi 'M-J' select-pane -D
      bind-key -T copy-mode-vi 'M-K' select-pane -U
      bind-key -T copy-mode-vi 'M-L' select-pane -R

      # resize
      bind -n 'C-M-h' if-shell "$is_vim" 'send-keys C-M-h' 'resize-pane -L 1'
      bind -n 'C-M-j' if-shell "$is_vim" 'send-keys C-M-j' 'resize-pane -D 1'
      bind -n 'C-M-k' if-shell "$is_vim" 'send-keys C-M-k' 'resize-pane -U 1'
      bind -n 'C-M-l' if-shell "$is_vim" 'send-keys C-M-l' 'resize-pane -R 1'

      bind-key -T copy-mode-vi C-M-h resize-pane -L 1
      bind-key -T copy-mode-vi C-M-j resize-pane -D 1
      bind-key -T copy-mode-vi C-M-k resize-pane -U 1
      bind-key -T copy-mode-vi C-M-l resize-pane -R 1

      set-option -g default-terminal "screen-256color"
      set-option -g status-right-length 100
      set-option -g @indicator_color "yellow"
      set-option -g @window_color "magenta"
      set-option -g @main_accent "blue"
      set-option -g pane-active-border fg=black
      set-option -g pane-border-style fg=black
      set-option -g status-style "bg=${bg} fg=${fg}"
      set-option -g status-left "${indicator}"
      set-option -g status-right "${git} ${pwd} ${separator} ${battery} ${time}"
      set-option -g window-status-current-format "${current_window}"
      set-option -g window-status-format "${window_status}"
      set-option -g window-status-separator ""
    '';
  };
}
