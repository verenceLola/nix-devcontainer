### Configure SOPS Nix

To configure sops-nix fot secret management, generate an age key from a SSH key using the following command:

```bash
mkdir -p ~/.config/sops/age; # create directory if not there
nix-shell -p ssh-to-age --run "ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt"
```
