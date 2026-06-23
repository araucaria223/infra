{
  inputs,
  lib,
  self,
  ...
}: {
  flake-file.inputs.noctalia-plugins = {
    url = "github:noctalia-dev/noctalia-plugins";
    flake = false;
  };

  flake.wrappers.noctalia = {
    wlib,
    config,
    ...
  }: {
    imports = [wlib.wrapperModules.noctalia-shell];

    options.theme = lib.mkOption {
      default = self.theme;
    };

    config = {
      outOfStoreConfig = "/home/araucaria/.config/noctalia";

      preInstalledPlugins = {
        keybind-cheatsheet = {
          enabled = true;
          src = "${inputs.noctalia-plugins.outPath}/keybind-cheatsheet";
        };
      };

      #settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings
      colors = with config.theme.palette; {
        mPrimary = base0D;
        mOnPrimary = base00;
        mSecondary = base0E;
        mOnSecondary = base00;
        mTertiary = base0C;
        mOnTertiary = base00;
        mError = base08;
        mOnError = base00;
        mSurface = base00;
        mOnSurface = base05;
        mHover = base0C;
        mOnHover = base00;
        mSurfaceVariant = base01;
        mOnSurfaceVariant = base04;
        mOutline = base03;
        mShadow = base00;
      };

      settings = {
        colorSchemes = {};
        appLauncher = {
          customLaunchPrefixEnabled = false;
          density = "compact";

          iconMode = "tabler";
          ignoreMouseInput = false;
          terminalCommand = "kitty -e";
          showCategories = true;
          sortByMostUsed = true;
          useApp2Unit = false;
          viewMode = "list";
          position = "center";
          pinnedExecs = [];
          enableClipPreview = true;
          enableClipboardHistory = false;
        };

        audio = {
          preferredPlayer = "";
          volumeFeedback = true;
          volumeFeedbackSoundFile = ./assets/sounds/all-eyes-on-me-465.mp3;
          volumeStep = 5;
        };

        bar = {
          autoHideDelay = 500;
          autoShowDelay = 150;
          backgroundOpacity = 0.93;
          barType = "simple";
          capsuleColorKey = "none";
          capsuleOpacity = 1;
          contentPadding = 2;
          density = "default";
          displayMode = "always_visible";
          fontScale = 1;
          frameRadius = 12;
          frameThickness = 8;
          hideOnOverview = false;
          marginHorizontal = 4;
          marginVertical = 4;
          middleClickAction = "none";
          middleClickCommand = "";
          middleClickFollowMouse = false;
          monitors = [];
          mouseWheelAction = "none";
          mouseWheelWrap = true;
          outerCorners = false;
          position = "top";
          reverseScroll = false;
          rightClickAction = "controlCenter";
          rightClickCommand = "";
          rightClickFollowMouse = false;
          screenOverrides = [];
          showCapsule = true;
          showOnWorkspaceSwitch = true;
          showOutline = false;
          useSeparateOpacity = false;
          widgetSpacing = 6;
          widgets = let
            spacer = {
              id = "Spacer";
              width = 5;
            };
          in {
            center = [
              {
                id = "Workspace";
                labelMode = "index";
                characterCount = 2;
                colorizeIcons = false;
                focusedColor = "primary";
                emptyColor = "secondary";
                occupiedColor = "secondary";
                enableScrollWheel = true;
                followFocusedScreen = false;
                fontWeight = "bold";
                groupedBorderOpacity = 1;
                hideUnoccupied = false;
                iconScale = 0.8;
                pileSize = 0.6;
                showApplications = true;
                showApplicationsHover = true;
                showBadge = true;
                showLabelsOnlyWhenOccupied = true;
                unfocusedIconsOpacity = 1;
              }
            ];

            left = [
              {
                id = "Launcher";
                icon = "rocket";
                iconColor = "none";
                useDistroLogo = false;
                enableColorization = false;
              }
              {
                id = "Clock";
                clockColor = "none";
                formatHorizontal = "HH:mm ddd, dd MMM";
                formatVertical = "HH mm - dd MM";
                tooltipFormat = "HH:mm:ss dddd, dd MMMM yyyy";
              }
              {
                id = "SystemMonitor";
                diskPath = "/";
                iconColor = "none";
                showCpuUsage = true;
                showCpuTemp = true;
                showMemoryUsage = true;
                useMonospaceFont = true;
                usePadding = false;
              }
              {
                id = "ActiveWindow";
                hideMode = "hidden";
                scrollingMode = "hover";
                maxWidth = 145;
                useFixedWidth = false;
                showIcon = true;
                showText = false;
              }
              {
                id = "MediaMini";
                compactMode = false;
                hideWhenIdle = false;
                maxWidth = 145;
                useFixedWidth = false;
                panelShowAlbumArt = true;
                scrollingMode = "hover";
                hideMode = "hidden";
                showAlbumArt = true;
                showProgressRing = true;
              }
            ];

            right = [
              {
                id = "Tray";
                drawerEnabled = true;
                hidePassive = false;
              }
              spacer
              {
                id = "VPN";
                displayMode = "onhover";
                iconColor = "none";
                textColor = "none";
              }
              {
                id = "Network";
                displayMode = "onhover";
              }
              spacer
              {
                id = "Volume";
                displayMode = "onhover";
              }
              {
                id = "Brightness";
                applyToAllMonitors = false;
                displayMode = "onhover";
              }
              {
                id = "NotificationHistory";
                showUnreadBadge = true;
                unreadBadgeColor = "primary";

                hideWhenZero = false;
                hideWhenZeroUnread = false;
              }
              {
                id = "Battery";
                deviceNativePath = "__default__";
                displayMode = "graphic-clean";
                hideIfIdle = false;
                hideIfNotDetected = true;
                showNoctaliaPerformance = true;
                showPowerProfiles = true;
              }
              spacer
              {
                id = "ControlCenter";
                useDistroLogo = true;
                enableColorization = true;
              }
            ];
          };
        };

        brightness = {
          backlightDeviceMappings = [];
          brightnessStep = 5;
          enableDdcSupport = false;
          enforceMinimum = true;
        };

        calendar = {
          cards = [
            {
              id = "calendar-header-card";
              enabled = true;
            }
            {
              id = "calendar-month-card";
              enabled = true;
            }
            {
              id = "weather-card";
              enabled = true;
            }
          ];
        };

        controlCenter = {
          cards = [
            {
              id = "profile-card";
              enabled = true;
            }
            {
              id = "shortcuts-card";
              enabled = true;
            }
            {
              id = "audio-card";
              enabled = true;
            }
            {
              id = "brightness-card";
              enabled = true;
            }
            {
              id = "weather-card";
              enabled = true;
            }
            {
              id = "media-sysmon-card";
              enabled = true;
            }
          ];

          diskPath = "/";
          position = "close_to_bar_button";
          shortcuts = {
            left = [
              {id = "Network";}
              {id = "Bluetooth";}
              {id = "WallpaperSelector";}
              {id = "NoctaliaPerformance";}
            ];
            right = [
              {id = "Notifications";}
              {id = "PowerProfile";}
              {id = "KeepAwake";}
              {id = "NightLight";}
            ];
          };
        };

        desktopWidgets.enabled = false;
        dock.enabled = false;

        general = {
          allowPanelsOnScreenWithoutBar = true;
          boxRadiusRatio = 1;
          enableBlurBehind = true;
          enableShadows = true;
          forceBlackScreenCorners = false;
          iRadiusRatio = 1;
          keybinds = {
            keyDown = ["Down"];
            keyUp = ["Up"];
            keyRight = ["Right"];
            keyLeft = ["Left"];
            keyEscape = ["Esc"];
            keyRemove = ["Del"];
            keyEnter = ["Return" "Enter"];
          };

          lockOnSuspend = true;
          lockScreenAnimations = true;
          lockScreenBlur = 0.5;
          lockScreenCountdownDuration = 10000;
          compactLockScreen = false;
          enableLockScreenCountdown = true;
          enableLockScreenMediaControls = true;
          showHibernateOnLockScreen = true;
          showSessionButtonsOnLockScreen = true;
          allowPasswordWithFprintd = true;
          autoStartAuth = true;

          showChangelogOnStartup = false;
          telemetryEnabled = false;
        };

        idle.enabled = true;
        location.autoLocate = true;
        network.networkPanelView = "wifi";
        nightLight = {
          enabled = true;
          autoSchedule = true;
          dayTemp = "6500";
          nightTemp = "5000";
        };

        notifications = {
          enabled = true;
          enableMarkdown = true;
          sounds = {
            enabled = true;
            excludedApps = "discord,firefox,chrome,chromium";
            separateSounds = true;
            volume = 0.5;
            lowSoundFile = ./assets/sounds/i-demand-attention-244.mp3;
            normalSoundFile = ./assets/sounds/graceful-285.mp3;
            criticalSoundFile = ./assets/sounds/maidenly-212.mp3;
          };
        };

        osd = {
          enabled = true;
          enabledTypes = [0 1 2];
          location = "top_right";
          autoHideMs = 2000;
          overlayLayer = true;
        };

        plugins = {
          autoUpdate = false;
          notifyUpdates = true;
        };

        sessionMenu = {
          enableCountdown = true;
          countdownDuration = 10000;
          largeButtonsStyle = false;
          position = "center";

          powerOptions = [
            {
              action = "lock";
              enabled = true;
              keybind = "1";
            }
            {
              action = "suspend";
              enabled = true;
              keybind = "2";
            }
            {
              action = "hibernate";
              enabled = true;
              keybind = "3";
            }
            {
              action = "logout";
              enabled = true;
              keybind = "4";
            }
            {
              action = "shutdown";
              enabled = true;
              keybind = "5";
            }
            {
              action = "reboot";
              enabled = true;
              keybind = "6";
            }
          ];
          showHeader = true;
          showKeybinds = true;
        };
        settingsVersion = 59;
        ui = {
          scrollbarAlwaysVisible = false;
          fontDefault = "Sans Serif";
          fontDefaultScale = 0.95;
          settingsPanelMode = "attached";
          settingsPanelSideBarCardStyle = true;
        };
        wallpaper = {
          enabled = false;
          # automationEnabled = true;
          # directory = ./assets/wallpapers;
          # wallpaperChangeMode = "random";
          # randomIntervalSec = 300;
          # transitionDuration = 1500;
          # transitionType = [
          #   "fade"
          #   "disc"
          #   "stripes"
          #   "wipe"
          #   "pixelate"
          #   "honeycomb"
          # ];
          # transitionEdgeSmoothness = 0.05;
          # setWallpaperOnAllMonitors = true;
          # viewMode = "single";
          # overviewEnabled = true;
        };
      };
    };
  };
}
