{ config, ... }: {
  home = {
    username = "admin";
    stateVersion = "25.05";
    homeDirectory = "/home/${config.home.username}";
    file = {
      ssh_private_key = {
        target = ".ssh/id_rsa";
        source = ../../secrets/ssh.key;
      };
      ssh_public_key = {
        target = ".ssh/id_rsa.pub";
        text = ''
          ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHlaUrnS2mQ7vB4C3beKYmz2sNrnF5TXouWXotoP8oEIiR05B8tpscJ3zcufFz3E+0Q9X0p2Tb27j23Rsqr81W5K5VOfS0t5AdJn8r4OaMDKx280Ewgc04X0HhHI8mQ3qoqqN71T8gFfElz8LxK2ft3cPYj2wFbwIMP8GclUZO7+DS60Idqm1x64q7GntfjYjVXXfyOseTr4nDF5vuXY1gPhMIZ78YEOwNSfnQmdmQyBE+mN5imvuhedQ6Jy7dEglc3hrErLNGZz1xNYo4qKxO0tWwGmvBAKaIUbV5KrONfeBcAxdZlGamN/bgnsRBehwo3llXvCGG/ctiY3rWnBYOZcFJ7mGAiMELhyJeL1K5VN6Rfu0Byhh/8/RnHwiDmU6f0cx/o/UDfsANeaBIQ4e2Q4vxB85X6WNtIGwY4w1Nv1N0mkW1wFCOY3UyYl7CyIcLtqcR3fW6yG4A+5Zz5PuWhkufZxKPPB//RSZro9uaRz6vfGAs6kDF6scIqlLW6WfIk1rABgb8zlF5sDpCxnbFBMOKGq4Hohbk0DE26ghr9oXhj+FSR4UZKaTriDHOpF3z5dkZrcDWUMUL9jqNeEEYXrzXEyMj7qmso76reUwW9LpjpxYsfD+WLj8Lbqjl4UodWWeOcVZiB7m0y5HtgTpfwZrkO/wTTlXgfilhqKfF/w==
        '';
      };
    };
  };
  programs.home-manager.enable = true;
}
