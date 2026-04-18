{
  home.username = "redson";
  home.homeDirectory = "/home/redson";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
        name = "Redson";
        email = "redson@riseup.net";
    };
    #userName = "Redson";
    #userEmail = "redson@riseup.net";
    #signing = {
    #  key = "A55CD2880240ABD7";
    #  signByDefault = true;
    #};
  };
}