{
  description = "Konfigurace pro Thinkpad a Dell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwm-config.url = "github:Mi-Tom/dwm-config/main";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {

      thinkpadX200s = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/thinkpadX200s/configuration.nix
        ];
      };

      dell-latitude = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/dell-latitude/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "michal@thinkpadX200s" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./hosts/thinkpadX200s/home.nix ];
      };

      "michal@dell-latitude" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./hosts/dell-latitude/home.nix ];
      };
    };

  };
}
