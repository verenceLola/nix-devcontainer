{
  age = {
    secrets = {
      "admin_private_key" = {
        file = ./private-key.age;
        mode = "0644";
        owner = "admin";
        group = "admin";
      };
    };
  };
}
