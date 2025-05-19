# Digital Logic Sim on Nix ❄️

This flake and the override package try to simplify the execution of the https://github.com/SebLague/Digital-Logic-Sim project (A minimalistic digital logic simulator) on Nix.

This project has no releases on github or any other platform that we can easily fetch, instead SebLague uses ItchiIO https://sebastian.itch.io/digital-logic-sim, for this I downloaded the linux build from itch.io and uploaded it to this project as a release. But you can do the same by copying my ./package.nix and replacing it wherever you have the zip file found on [here](https://sebastian.itch.io/digital-logic-sim/download/eyJleHBpcmVzIjoxNzQ3NjU5NzY5LCJpZCI6MzQ1NjMxOH0%3d%2eVF8YkFNrB7IOVfkR1ZS1k%2bA3xZw%3d).

> This project is made on Unity so if you have the Unity Editor you can build the project by yourself. 

> I'm not responsible for the code that is executed since the project, even though it is open-source, is uploaded to an external platform which the owner uses.

> This flake for now provides artifacts (the zip) I encourage you to change to your personal download from the ItchiIO page.

## 🖌️ Screenshoot 

<img src="https://github.com/regalk13/digital-logic-sim-flake/blob/main/assets/screenshoot.png?raw=true" />

(Running on x86 NixOs Unstable machine using Wayland)

## 🖥️ Installation 

To use it add the input to the relevant Nix configuration flake inputs:

```nix
inputs = {
    digital-logic-sim.url = "github:regalk13/digital-logic-sim-flake";
}
```

This flake just provides the package from the main repository that is `x86_64-linux` for now.

If you're on NixOS and/or home-manager, you should install on your configuration. For example like this:

```nix
environment.systemPackages = [
    inputs.digital-logic-sim.packages.x86_64-linux.default
];
```
A command called `digital-logic-sim` should appear, as well as a desktop file that should show up in app launchers.

## 🚀 Run the Flake 

You can run the app using the Flake:

```bash
nix run .
```

### 📙 Resources 

This override is based on existing overrides in the nixpkgs of Unity apps/games.

- [Clone Hero](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/cl/clonehero/package.nix)

- [Yarg](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ya/yarg/package.nix)