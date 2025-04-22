{ ... }: {
  programs.git = {
    enable = true;

    userName = "Jade Lynn Masker";
    userEmail = "donottellmetonottellyou@gmail.com";

    extraConfig = {
      user.signingkey = "5C8B71284AB3000D4AC662349B8135A24A75CB86";

      commit.gpgSign = true;
      push.gpgSign = "if-asked";
      tag.gpgSign = true;

      core = {
        editor = "hx";
        pager = "less -F -X";
      };
    };
  };
}
