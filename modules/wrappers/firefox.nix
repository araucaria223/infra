{
  flake-file.inputs.firefox-addons = {
    url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    packages.firefox = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        FirefoxHome = {
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };

        DisableAppUpdate = true;
        ExtensionUpdate = false;

        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        SearchSuggestEnabled = false;

        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisablePocket = true;
        DisableProfileImport = true;

        DisableSetDesktopBackground = true;
        DisableFirefoxScreenshots = true;
        DisplayBookmarksToolbar = "never";

        DisableMasterPasswordCreation = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;

        DontCheckDefaultBrowser = true;

        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";

        Preferences = let
          lock = Value: {
            inherit Value;
            Status = "locked";
          };
        in {
          "browser.sessionstore.resume_from_crash" = lock true;
          "browser.aboutConfig.showWarning" = lock false;
          "gfx.webrender.all" = lock true;
        };

        ExtensionSettings = with builtins; let
          ext = addon: {
            name = addon.addonId;
            value = {
              installation_mode = "force_installed";
              install_url = "file://${addon}/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/${addon.addonId}.xpi";
            };
          };
        in
          with inputs'.firefox-addons.packages; (listToAttrs [
            (ext ublock-origin)
            (ext sponsorblock)
            (ext youtube-shorts-block)
            (ext search-by-image)
            (ext clearurls)
            (ext old-reddit-redirect)
            (ext reddit-enhancement-suite)
            (ext keepassxc-browser)
          ]);
      };
    };
  };
}
