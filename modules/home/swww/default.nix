{ lib, pkgs, name, ... }:
let
  wallpapersDirectory = "/home/${name}/wallpapers/";

  # Collect all the requested file paths from the base url.
  dharmx-wallpapers = import ../../../utils/downloadSelectedFilesFromUrl.nix {
    inherit pkgs;
    baseUrl = "https://github.com/dharmx/walls/raw/main/";
    paths = [
      {
        path = "pixel/a_computer_room_with_a_desk_and_a_computer_monitor.jpg";
        sha256 = "sha256-yV3/5fz5WPGtjl2VQrj9H+azgcALExSBsgyp0bXrI+4=";
      }
      {
        path = "anime/a_city_skyline_with_a_tall_tower_lit_up_at_night.jpeg";
        sha256 = "sha256-gVicNOo+k6bZyaiG0ArggxkvGScb7+LuspY2h0HEsd4=";
      }
      {
        path = "anime/a_cartoon_of_a_man_holding_a_camera.jpg";
        sha256 = "sha256-flEpsts9soSWZu4jNPNGzdCW6CU2ybkKAeyH2UmeO8A=";
      }
      {
        path = "anime/a_cartoon_of_a_woman_sitting_at_a_table_on_a_deck.jpg";
        sha256 = "sha256-YWHHciVPyawrgVL3cvfxuh2Z8kGgx9f2f7IurN6c6WI=";
      }
      {
        path = "anime/a_cartoon_of_a_street_with_buildings.jpeg";
        sha256 = "sha256-sGiFX7E7uy4+w6UTy4ypv8nAjofieZ+WengoglO+QG8=";
      }
      {
        path =
          "anime/a_cartoon_of_a_flying_ship_with_buildings_and_a_person_walking.jpg";
        sha256 = "sha256-F0BFLAIC6ZSPOcuKpSIicWRkmmWqEaWR5H7fRwGeLZY=";
      }
      {
        path = "anime/a_body_of_water_with_a_bridge_and_trees.jpg";
        sha256 = "sha256-oTIq1+yCU/pxEitTy4C/r4/bcVBPZjMYzBWoO9fRpOg=";
      }
      {
        path = "anime/a_cartoon_of_a_woman_holding_a_sword.jpg";
        sha256 = "sha256-DsEJW2dW7ofUvWiknsbsQHlBWL4dSSypGya497/F9F8=";
      }
      {
        path = "anime/a_cartoon_of_a_woman_with_pink_hair.jpg";
        sha256 = "sha256-jt6ocBLX92U4UUNgoEFwaSWeYYyiDUzQdKsVHgURe8s=";
      }
      {
        path = "anime/a_cartoon_of_a_woman_lying_on_a_snake.jpg";
        sha256 = "sha256-2tpellst6dYTSVdYlGTCL8g+JcoOYP9l/ym4p55vmng=";
      }
      {
        path = "anime/a_cartoon_of_a_woman_in_a_short_skirt_and_glasses.jpg";
        sha256 = "sha256-t0I4KDXlKvBMt2SC6NsshjMjkku4g0b+ogroCw62Qmg=";
      }
      {
        path = "anime/a_woman_holding_a_sword.jpg";
        sha256 = "sha256-n4hTg5NQOeeQeHzXcgUA1G4NPoQWr2yKlb/SZc4AZ40=";
      }
    ];
  };

  allWallpapers = dharmx-wallpapers;

  # Generate an AttrSet from the list of fetched paths.
  # (AttrSet -> AttrSets -> AttrSets) -> AttrSets -> [AttrSets] -> AttrSets
  wallpapers = lib.foldr (result: acc:
    acc // {
      "${result.passthru.name}" = {
        target = wallpapersDirectory + result.passthru.name;
        source = result;
      };
    }) { } allWallpapers;

  # Get the path of the first wallpaper and use as default
  preloadedWallpaper = wallpapersDirectory
    + (lib.head allWallpapers).passthru.name;

  currentWallpaperFile = wallpapersDirectory + "current";

  # Script to copy pywal colors files to expected destination
  runAfterPyWal = pkgs.writeShellApplication {
    name = "copy-color-files";
    runtimeInputs = [ ];
    text = ''
      # Copy waybar colors to waybar config directory
      cp "$HOME/.cache/wal/colors-waybar.css" "$HOME/.config/waybar/colors.css";

      # Copy hyprland colors to hyprland config directory
      cp "$HOME/.cache/wal/colors-hyprland.conf" "${
        (dirOf "$HOME/.config/hypr/hyprland.conf") + "/colors-hyprland.conf"
      }"
    '';
  };

  # Script to run pywal to re-generate colorschemes
  # on wallpaper change
  pywalGenerateColorSchemes = pkgs.writeShellApplication {
    name = "pywal-generate-color-schemes";
    runtimeInputs = [ pkgs.pywal16 pkgs.hyprland runAfterPyWal ];
    text = ''
      CURRENT_WALL=${preloadedWallpaper}

      if [ -f ${currentWallpaperFile} ]; then
        CURRENT_WALL=$(cat ${currentWallpaperFile})
      fi

      wal -i "$CURRENT_WALL" -stqe -o copy-color-files
    '';
  };

  # Script to randomly set a wallpaper
  randomizeWallpapers = pkgs.writeShellApplication {
    name = "randomize-wallpapers";
    runtimeEnv = { WALLPAPER_DIR = wallpapersDirectory; };
    runtimeInputs = with pkgs; [ pkgs.hyprland pywalGenerateColorSchemes ];
    text = ''
      CURRENT_WALL=${preloadedWallpaper}

      if [ -f ${currentWallpaperFile} ]; then
        CURRENT_WALL=$(cat ${currentWallpaperFile})
      fi

      # Get a random wallpaper that is not the current one, or the current file
      WALLPAPER=$(find "$WALLPAPER_DIR" -type l,f ! -executable ! -name "$(basename "${currentWallpaperFile}")" ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

      # Apply the selected wallpaper
      swww img -t random "$WALLPAPER"

      # Save the wallpaper to the file
      echo "$WALLPAPER" > ${currentWallpaperFile}

      # Trigger Pywal
      pywal-generate-color-schemes
    '';
  };

  # Start SWWW
  startSWWW = pkgs.writeShellApplication {
    name = "swww";
    runtimeInputs = [ pkgs.swww ];
    text = ''
      swww-daemon -f xrgb;
    '';
  };
in {
  systemd.user.services = {
    randomizeWallpapers = {
      Unit = {
        Description = "Randomly set a new wallpaper every 3 min";
        After = "randomizeWallpapers.service";
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        Restart = "always";
        RestartSec = "180";
        ExecStart = "${randomizeWallpapers}/bin/randomize-wallpapers";
      };
    };
    swww = {
      Unit = {
        Description = "Start SWWW";
        After = "graphical-session.target";
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        ExecStart = "${startSWWW}/bin/swww";
        ConditionFileExists = "/run/user/%U/wayland*.sock";
        Restart = "on-failure";
      };
    };
  };
  home = {
    file = {
      randomizeWallpapers = {
        target = wallpapersDirectory + "randomize-wallpaper";
        source = "${randomizeWallpapers}/bin/randomize-wallpapers";
      };
      pywalGenerateColorSchemes = {
        target = wallpapersDirectory + "pywal-generate-color-schemes";
        source =
          "${pywalGenerateColorSchemes}/bin/pywal-generate-color-schemes";
      };
    } // wallpapers;
  };
}
