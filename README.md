# Digital Logic Sim on Nix ❄️

A reproducible Nix flake to run Sebastian Lague’s [Digital Logic Simulator](https://github.com/SebLague/Digital-Logic-Sim) on NixOS or any Linux with Nix installed.

> Status: working • x86_64‑linux • tested on NixOS unstable (Wayland & X11)

## Why does this flake exist?

The project distributes pre‑built binaries on [itch.io](https://sebastian.itch.io/digital-logic-sim) there are no versioned GitHub releases. This flake snapshots that Linux ZIP in a GitHub release so you can install the simulator with a single nix run and creates an override so you can install it on your system.

If you prefer, replace the bundled archive with one you downloaded yourself just copy ./package.nix and point src = to your file.


## Features

Two variants

- `packages.<system>.default` – upstream vanilla build.

- `packages.<system>.fork16bit` – community fork that merges [16‑bit I/O](https://github.com/parshwa282011/Digital-Logic-Sim) and [Port I/O](https://github.com/squigglesdev/Digital-Logic-Sim) support thanks to parshwa282011, squigglesdev and [alice39](https://github.com/alice39/Digital-Logic-Sim).

- `nix run` friendly – run the simulator without touching your profile.



## 🖌️ Screenshoot 

<img src="https://github.com/regalk13/digital-logic-sim-flake/blob/main/assets/screenshoot.png?raw=true" />

(Running on x86 NixOs Unstable machine using Wayland)


## Quick start

1 . Add the input

```nix
{
  inputs.digital-logic-sim.url = "github:regalk13/digital-logic-sim-flake";
}
```

2 . Install (NixOS / home‑manager)
```nix
environment.systemPackages = [
  # vanilla
  inputs.digital-logic-sim.packages.${pkgs.system}.default

  # or the extended fork
  # inputs.digital-logic-sim.packages.${pkgs.system}.fork16bit
];
```
A binary called digital-logic-sim will be on your $PATH, and the app appears in your launcher.


3 . Or run immediately
```bash
nix run github:regalk13/digital-logic-sim-flake
```

## Building the game yourself (optional)

Have the Unity editor installed? Clone the original project, build a Linux export (il2cpp), then duplicate ./package.nix and set src = to your freshly built ZIP. Everything else in the flake stays the same.


### 📙 Resources 

This override is based on existing overrides in the nixpkgs of Unity apps/games.

- [Clone Hero](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/cl/clonehero/package.nix)

- [Yarg](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ya/yarg/package.nix)


### Contributing

Found a bug? PRs and issues are welcome!
