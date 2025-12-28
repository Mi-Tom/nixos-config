{
  description = "Konfigurace pro Thinkpad a Dell"

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; 
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {

      thinkpadX200s = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/thinkpadX200s/configuration.nix
        ];
      };


      dell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/dell/configuration.nix
        ];
      };
    };
  };
}
