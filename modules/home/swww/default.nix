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
        path = "nord/a_blue_and_grey_logo.png";
        sha256 = "sha256-jB7q1PAMKS0tfk0Ck6pGkbsfwO+7FHwI83dUHO86ftM=";
      }
      {
        path = "nord/a_road_with_cars_and_buildings_in_the_background.png";
        sha256 = "sha256-nEjw6B4s1ewWO+Vz6hMhFRs5gXGcrJ6bd+wbpvQsNmU=";
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
        path = "nord/a_city_street_with_buildings_and_windows.jpg";
        sha256 = "sha256-Ahw4384uU9ozeem9769gdjK/YNSNVkFhi9HjWsVRyBU=";
      }
      {
        path = "lightbulb/a_light_bulb_from_the_ceiling.jpg";
        sha256 = "sha256-l3MaoeyGAcW0OlAJldtSB6U4s/ZMxSw5jDC1DsNPGPk=";
      }
      {
        path = "nord/a_cartoon_of_a_man's_face.png";
        sha256 = "sha256-aEswEiwQra1db9wjazCqNB3yBWKqEM+JMbc8E1aL11k=";
      }
      {
        path = "nord/a_woman_sitting_on_a_couch_looking_out_a_window.png";
        sha256 = "sha256-axxFPAIlSs0T6D8Hv7RmaQp3+EJUXqVfoifIifG/66k=";
      }
      {
        path = "nord/a_car_on_a_street.png";
        sha256 = "sha256-XPo9Yen0oAUVGQhjkivCZtdRhCWrA3OsvYW+C6a92Yk=";
      }
      {
        path = "nord/a_city_street_with_buildings_and_windows.jpg";
        sha256 = "sha256-Ahw4384uU9ozeem9769gdjK/YNSNVkFhi9HjWsVRyBU=";
      }
      {
        path = "anime/a_cartoon_of_a_girl_playing_a_guitar.jpg";
        sha256 = "sha256-wV+sy+ehFXsL42k2Kwt2I6NhZKrRWsrTa5Qvz+w01hc=";
      }
      {
        path =
          "anime/a_girl_sitting_at_desks_in_a_classroom_with_flowers_flying_out_of_her_head.jpg";
        sha256 = "sha256-ll4aOiFDc2pFA3IaIp9rZdaFIUCKIAwowA2v7kPQU4Y=";
      }
      {
        path =
          "anime/a_cartoon_of_a_woman_in_a_red_dress_with_a_large_weapon.jpg";
        sha256 = "sha256-TQV5DD+Cfqcpcm0Hr3UajttS34ZUa6BuQmeUWv1SZB0=";
      }
      {
        path = "anime/power_lines_and_trees_at_sunset.jpg";
        sha256 = "sha256-kB3Zz0eMarp8yYBIz8n/FCdn3RaYURTWKoOI8IETvDk=";
      }
      {
        path = "anime/a_bench_next_to_a_river.jpg";
        sha256 = "sha256-CT2kaSmogPNCPvI0F9fYfYmAoj+xoYXSBkmH6JfzLoM=";
      }
      {
        path =
          "anime/a_cartoon_of_a_woman_sitting_on_a_building_with_a_cat_on_a_leash.jpg";
        sha256 = "sha256-Efkg2eTeeUBS/atGjt2YF7eWbq0nzFFTzq4ArmbaZ5Q=";
      }
      {
        path = "anime/a_door_with_a_doorway_and_shoes_on_the_ground.jpg";
        sha256 = "sha256-ajM6QsCPMHUkHRauhyGeihjs01Lp9mJHXHBPgbrC7qM=";
      }
      {
        path = "anime/rain_drops_of_water_on_a_tile_surface.jpg";
        sha256 = "sha256-+8d16vlTRC4Ld6XyXoHNFfZA3ZQ+/NozpGPEIekksC8=";
      }
      {
        path = "anime/a_train_on_tracks_in_a_snowy_city.jpg";
        sha256 = "sha256-n0KbFU9tCwQo28oYUN4gUS/5gH0DY3hGabx6epDQVGU=";
      }
      {
        path = "anime/a_building_with_trees_in_the_background.jpg";
        sha256 = "sha256-jEeoUJ31jw1w8XHRdZS9kS2s8bO15GpAXe244uVB4Bk=";
      }
      {
        path =
          "anime/a_cartoon_of_a_woman_sitting_on_a_table_with_an_umbrella.jpg";
        sha256 = "sha256-pdnADpCjtWTsvGFJCdVxdrQqCf17rfpSBAExLfhwdq8=";
      }
      {
        path = "anime/a_city_with_buildings_and_lights.jpg";
        sha256 = "sha256-/pLQnHIkl45ShsAeJiPQRuy+uF8298oD+f5SctReNvY=";
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

      # Copy wofi colors file to wofi config folder
      cp "$HOME/.cache/wal/colors" "$HOME/.config/wofi/colors"

      # Copy kitty colors to kitty config folder
      cp "$HOME/.cache/wal/colors-kitty.conf" "$HOME/.config/kitty/colors-kitty.conf"
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
        ConditionEnvironment = "WAYLAND_DISPLAY";
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
