{ lib, ... }: with lib;
{
  # config = {
  #   services = {
  #     openssh = {
  #       hostKeys = [
  #         {
  #           bits = 4096;
  #           path = "/etc/ssh/ssh_host_rsa_key";
  #           type = "rsa";
  #         }
  #         {
  #           path = "/etc/ssh/ssh_host_ed25519_key";
  #           type = "ed25519";
  #         }
  #       ];
  #     };
  #   };
  # };
}
