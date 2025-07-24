{ config, pkgs, ... }:
{
  home.packages = [ pkgs.vault-tasks ];

  xdg = {
    enable = true;
    configFile.vault-tasks = {
      enable = true;
      force = true;
      target = "./vault-tasks/config.toml";
      source = pkgs.writers.writeTOML "vault-tasks-config" {
        keybindings = {
          Calendar = {
            # App
            "<q>" = "Quit";
            "<Ctrl-c>" = "Quit";
            "<Ctrl-z>" = "Suspend";
            "<?>" = "Help";
            # Tabs
            "<Shift-Right>" = "TabRight";
            "<Shift-l>" = "TabRight";
            "<Shift-Left>" = "TabLeft";
            "<shift-h>" = "TabLeft";
            # Scrolling
            "<Ctrl-u>" = "ViewUp";
            "<Ctrl-k>" = "ViewUp";
            "<Ctrl-Up>" = "ViewUp";
            "<PageUp>" = "ViewPageUp";
            "<Ctrl-j>" = "ViewDown";
            "<Ctrl-d>" = "ViewDown";
            "<Ctrl-Down>" = "ViewDown";
            "<PageDown>" = "ViewPageDown";
            # Navigation
            "<r>" = "ReloadVault";
            "<t>" = "GotoToday";
            "<j>" = "Down";
            "<Down>" = "Down";
            "<k>" = "Up";
            "<Up>" = "Up";
            "<h>" = "Left";
            "<Left>" = "Left";
            "<l>" = "Right";
            "<Right>" = "Right";
            "<Shift-j>" = "NextMonth";
            "<Shift-Down>" = "NextMonth";
            "<Shift-k>" = "PreviousMonth";
            "<Shift-Up>" = "PreviousMonth";
            "<n>" = "NextYear";
            "<Shift-n>" = "PreviousYear";
          };
          Explorer = {
            # App
            "<q>" = "Quit";
            "<Ctrl-c>" = "Quit";
            "<Ctrl-z>" = "Suspend";
            "<?>" = "Help";
            # Tabs
            "<Shift-Right>" = "TabRight";
            "<Shift-l>" = "TabRight";
            "<Shift-Left>" = "TabLeft";
            "<shift-h>" = "TabLeft";
            # Navigation
            "<j>" = "Down";
            "<Down>" = "Down";
            "<Tab>" = "Down";
            "<k>" = "Up";
            "<Up>" = "Up";
            "<BackTab>" = "Up";
            "<h>" = "Left";
            "<Left>" = "Left";
            "<l>" = "Right";
            "<Right>" = "Right";
            "<Enter>" = "Enter";
            "<Backspace>" = "Cancel";
            "<s>" = "Search";
            "<Esc>" = "Escape";
            "<o>" = "Open";
            "<e>" = "Edit";
            "<t>" = "MarkToDo";
            "<d>" = "MarkDone";
            "<c>" = "MarkCancel";
            "<i>" = "MarkIncomplete";
            "<r>" = "ReloadVault";
            "<+>" = "IncreaseCompletion";
            "<->" = "DecreaseCompletion";
            # Scrolling
            "<Ctrl-u>" = "ViewUp";
            "<Ctrl-k>" = "ViewUp";
            "<Ctrl-Up>" = "ViewUp";
            "<PageUp>" = "ViewPageUp";
            "<Ctrl-j>" = "ViewDown";
            "<Ctrl-d>" = "ViewDown";
            "<Ctrl-Down>" = "ViewDown";
            "<PageDown>" = "ViewPageDown";
            "<Ctrl-l>" = "ViewRight";
            "<Ctrl-Right>" = "ViewRight";
            "<Ctrl-h>" = "ViewLeft";
            "<Ctrl-Left>" = "ViewLeft";
          };
          Filter = {
            # App
            "<q>" = "Quit";
            "<Ctrl-c>" = "Quit";
            "<Ctrl-z>" = "Suspend";
            "<?>" = "Help";
            # Tabs
            "<Shift-Right>" = "TabRight";
            "<Shift-l>" = "TabRight";
            "<Shift-Left>" = "TabLeft";
            "<shift-h>" = "TabLeft";
            # Navigation
            "<Enter>" = "Enter";
            "<s>" = "Search";
            "<Shift-s>" = "SwitchSortingMode";
            "<Esc>" = "Escape";
            "<r>" = "ReloadVault";
            # Scrolling
            "<Ctrl-u>" = "ViewUp";
            "<Ctrl-k>" = "ViewUp";
            "<Ctrl-Up>" = "ViewUp";
            "<PageUp>" = "ViewPageUp";
            "<Ctrl-d>" = "ViewDown";
            "<Ctrl-j>" = "ViewDown";
            "<Ctrl-Down>" = "ViewDown";
            "<PageDown>" = "ViewPageDown";
            "<Ctrl-l>" = "ViewRight";
            "<Ctrl-Right>" = "ViewRight";
            "<Ctrl-h>" = "ViewLeft";
            "<Ctrl-Left>" = "ViewLeft";
          };
          Home = {
            # App
            "<q>" = "Quit";
            "<Ctrl-d>" = "Quit";
            "<Ctrl-c>" = "Quit";
            "<Ctrl-z>" = "Suspend";
            # Tabs
            "<Shift-Right>" = "TabRight";
            "<Shift-l>" = "TabRight";
            "<Shift-Left>" = "TabLeft";
            "<Shift-h>" = "TabLeft";
          };
          TimeManagement = {
            # App
            "<q>" = "Quit";
            "<Ctrl-c>" = "Quit";
            "<Ctrl-z>" = "Suspend";
            "<?>" = "Help";
            # Tabs
            "<Shift-Right>" = "TabRight";
            "<Shift-l>" = "TabRight";
            "<Shift-Left>" = "TabLeft";
            "<shift-h>" = "TabLeft";
            # Navigation
            "<e>" = "Edit";
            "<Esc>" = "Escape";
            "<Enter>" = "Enter";
            "<Space>" = "NextSegment";
            "<p>" = "Pause";
            "<Tab>" = "NextMethod";
            "<BackTab>" = "PreviousMethod";
            "<j>" = "Down";
            "<Down>" = "Down";
            "<k>" = "Up";
            "<Up>" = "Up";
            "<h>" = "Left";
            "<Left>" = "Left";
            "<l>" = "Right";
            "<Right>" = "Right";
          };
        };
        styles = {
          Explorer = {
            preview_headers = "bold rgb 255 153 000";
          };
          Home = {
            highlighted_style = "dark grey on rgb 255 153 000";
            highlighted_bar_style = "rgb 255 153 000";
          };
        };
        tasks_config = {
          use_american_format = true;
          show_relative_due_dates = true;
          indent_length = 2;
          parse_dot_files = false;
          file_tags_propagation = true;
          ignored = [ ];
          vault_path = "${config.home.homeDirectory}/Code/vault-tasks";
          explorer_default_search_string = "- [ ] ";
          filter_default_search_string = "";
          completion_bar_length = 10;
          pretty_symbols = {
            task_done = "✅";
            task_todo = "❌";
            task_incomplete = "⏳";
            task_canceled = "🚫";
            due_date = "📅";
            priority = "❗";
            today_tag = "☀️";
            progress_bar_true = "🟩";
            progress_bar_false = "⬜️";
          };
          task_state_markers = {
            todo = " ";
            done = "x";
            incomplete = "/";
            canceled = "-";
          };
        };
        time_management_methods_settings = {
          FlowTime = [
            {
              name = "Break Factor";
              hint = "Break time is (focus time) / (break factor)";
              value.Int = 5;
            }
            {
              name = "Auto Skip";
              hint = "Whether to wait for user input to enter new segments or not";
              value.Bool = false;
            }
          ];
          Pomodoro = [
            {
              name = "Focus Time";
              hint = "";
              value.Duration = {
                secs = 1500;
                nanos = 0;
              };
            }
            {
              name = "Short Break Time";
              hint = "";
              value.Duration = {
                secs = 300;
                nanos = 0;
              };
            }
            {
              name = "Auto Skip";
              hint = "Whether to wait for user input to enter new segments or not";
              value.Bool = false;
            }
            {
              name = "Long Break Time";
              hint = "";
              value.Duration = {
                secs = 900;
                nanos = 0;
              };
            }
            {
              name = "Long Break Interval";
              hint = "Short breaks before a long break";
              value.Int = 4;
            }
          ];
        };
      };
    };
  };
}
