{
  age = {
    secrets = {
      gnupg = {
        file = "gnu.age";
        mode = "0400";
        owner = "admin";
        path = "~/.gnupg/gnu.age";
      };
      ssh = {
        file = "ssh.age";
        mode = "0600";
        owner = "admin";
      };
    };
  };
}
