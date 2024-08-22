{lib, flutter313, fetchFromGitHub, makeDesktopItem, pkg-config}:

flutter313.buildFlutterApplication rec {
  pname = "fehviwer";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "3003h";
    repo = "Eros-FE";
    rev = "v1.4.10%2B520.ci3.linux";
    hash = "sha256-qle9wvg5914zaSKQgK4qtg/lAuhMt4dov7H8/9ALQek=";
  };

  autoPubspecLock = src + "/pubspec.lock";
  gitHashes = {
    archive_async = "sha256-pc4lb0NiGAN8a9y/5Ui67Z70Roo0aOgNeDHJMRQNgIQ=";
    flutter_android_volume_keydown = "sha256-TGDmstmY3x+Nvw6LZ1KAZgArG3IhQnM43exZ6O/bnx0=";
    flutter_boring_avatars = "sha256-MlTImFAThm3aiXy41SK846cNpi/YeHLWZLh39FDTaAs=";
    flutter_downloader = "sha256-ADjvQ1r+LpqNrBFxIBKW9NldVftWblEZWPpNYKL9hlE=";
    flutter_egg = "sha256-hfB8NRPZywFbP4lHtDG3SRn+4jVXZKZX68h4W2o8g2s=";
    google_translator = "sha256-fcEb/skxTaq8SsoJJB2m7oVuFjnh/C5knl3gP9PQgWk=";
    json_to_model = "sha256-4aB4CXkavVrHAifaMe7wuypJJJI9PYgyQDzFOvUHdQc=";
    learning_language = "sha256-oiGTwPfscVB3eZeugXgU+wnUdsY68fMth+j7A6DI49o=";
    linkfy_text = "sha256-9vK2bjwboTf/ZwA2ZbEiKfbRsFDBTnjvZxnh4bTGVYc=";
    open_by_default = "sha256-e4GRjIe5Hw1GxxCNTv/xw1xlmGGeHMKEn1PZ2gysT/g=";
    receive_sharing_intent = "sha256-CRR5GUQ/wJtbGIIfEBUa+aycWLNtMcjqY12zHWMNrL8=";
    saf = "sha256-5ZtcRLAUPYkDO8k+Wmmvrj3PVG+lXAqqRruAcHpX4H8=";
    system_network_proxy = "sha256-DgXnqhJbD0YPSA+9aExYgu9saR8NNbRatc5lCLvaF7A=";
    window_size = "sha256-71PqQzf+qY23hTJvcm0Oye8tng3Asr42E2vfF1nBmVA=";
  };

  prePatch = ''
    mv lib/config/config.dart.sample lib/config/config.dart 
  '';

  postInstall = ''
    rm -rf $out/bin/*
    makeWrapper $out/app/fehviewer $out/bin/fehviewer  \
            --prefix LD_LIBRARY_PATH : $out/app/lib
  '';

  meta = with lib; {
    description = "View E-Hentai and ExHentai libraries!";
    homepage = "https://github.com/3003h/FEhViewer";
    license =  "Apache 2.0";
    maintainers = with maintainers; [  ];
    platforms = platforms.linux;
  };
}
