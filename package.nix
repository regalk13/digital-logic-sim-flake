{
  lib,
  stdenv,
  fetchzip,
  autoPatchelfHook,
  makeDesktopItem,
  makeWrapper,

  alsa-lib,
  gtk3,
  zlib,
  dbus,
  hidapi,
  libGL,
  libXcursor,
  libXext,
  libXi,
  libXinerama,
  libxkbcommon,
  libXrandr,
  libXScrnSaver,
  libXxf86vm,
  udev,
  vulkan-loader,
  wayland,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "digital-logic-sim";
  version = "0.0.1";

  src = fetchzip {
    url = "https://github.com/regalk13/digital-logic-sim-flake/releases/download/${finalAttrs.version}/Digital-Logic-Sim-Linux.zip";
    hash = "sha256-vYr3JUGJQVSYY3Hoa6EqqagJ7tZB56A74fEjVStnB2Q=";
    stripRoot = true;
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    alsa-lib
    gtk3
    stdenv.cc.cc.lib
    zlib
    dbus
    libGL
    libXcursor
    libXext
    libXi
    libXinerama
    libxkbcommon
    libXrandr
    libXScrnSaver
    libXxf86vm
    udev
    vulkan-loader
    wayland
    hidapi
  ];

  desktopItem = makeDesktopItem {
    name = "digital-logic-sim";
    desktopName = "Digital Logic Sim";
    comment = finalAttrs.meta.description;
    icon = "digital-logic-sim";
    exec = "digital-logic-sim";
    categories = [
      "Education"
      "Science"
    ];
  };

  installPhase = ''
    runHook preInstall

    # Install main executable and libraries
     for f in \
        Digital-Logic-Sim.x86_64 \
        GameAssembly.so \
        UnityPlayer.so \
        libdecor-0.so.0 \
        libdecor-cairo.so; do
      install -Dm755 $f $out/libexec/dls/$f
    done
    # Install game data
    cp -r Digital-Logic-Sim_Data "$out/libexec/dls/"

    # Create wrapper script
    makeWrapper "$out/libexec/dls/Digital-Logic-Sim.x86_64" "$out/bin/digital-logic-sim" \
      --chdir "$XDG_RUNTIME_DIR" \
      --add-flags "-force-glcore"

    # Desktop integration
    install -Dm644 "$desktopItem/share/applications/digital-logic-sim.desktop" \
                   "$out/share/applications/digital-logic-sim.desktop"

    runHook postInstall
  '';

  postFixup = ''
    # Patch UnityPlayer.so
    patchelf \
      --add-needed libasound.so.2 \
      --add-needed libdbus-1.so.3 \
      --add-needed libGL.so.1 \
      --add-needed libpthread.so.0 \
      --add-needed libudev.so.1 \
      --add-needed libvulkan.so.1 \
      --add-needed libwayland-client.so.0 \
      --add-needed libwayland-cursor.so.0 \
      --add-needed libwayland-egl.so.1 \
      --add-needed libX11.so.6 \
      --add-needed libXcursor.so.1 \
      --add-needed libXext.so.6 \
      --add-needed libXi.so.6 \
      --add-needed libXinerama.so.1 \
      --add-needed libxkbcommon.so.0 \
      --add-needed libXrandr.so.2 \
      --add-needed libXss.so.1 \
      --add-needed libXxf86vm.so.1 \
      "$out/libexec/dls/UnityPlayer.so"

    # Fix data path reference
    patchelf --set-rpath "$out/libexec/dls:${lib.makeLibraryPath finalAttrs.buildInputs}" \
      "$out/libexec/dls/Digital-Logic-Sim.x86_64"
  '';

  meta = with lib; {
    description = "Interactive digital-logic simulator built with Unity";
    homepage = "https://github.com/regalk13/digital-logic-sim-flake";
    license = licenses.mit;
    maintainers = [ "regalk" ];
    platforms = [ "x86_64-linux" ];
  };
})
