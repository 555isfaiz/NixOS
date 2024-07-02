let
  name = "555isfaiz";
in {
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "${ pkgs.git.override { withLibsecret = true; } }/bin/git-credential-libsecret";
      github.user = name;
      push.autoSetupRemote = true;
    };
    userEmail = "1244274837@qq.com";
    userName = name;
  };
}
