{ ... }:
{
  programs.git = {
    enable = true;

    signing = {
      format = "openpgp";
      key = "5C8B71284AB3000D4AC662349B8135A24A75CB86";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Jade Lynn Masker";
        email = "donottellmetonottellyou@gmail.com";
      };

      push.gpgSign = "if-asked";

      core = {
        editor = "hx";
        pager = "less -F -X";
      };
    };
  };
}
