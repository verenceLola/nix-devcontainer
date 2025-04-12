{ ... }@args: {
  laptop = import ./laptop.nix args;
  vm = import ./vm.nix args;
}
