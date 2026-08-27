# Resonance 32:9 & Gameplay FOV Patcher

A graphical runtime patcher for **Resonance: A Plague Tale Legacy** on
ultrawide and 32:9 displays. Developed and tested with game version **1.2.0.0**.

The release is a native x64 Windows application. It is distributed as one
small, self-contained executable and does not require .NET or any other
separately installed runtime.

## Usage

1. Start the game through Steam, Xbox, or the Microsoft Store.
2. Open `Resonance32x9Patcher.exe`.
3. Select a VFOV or HFOV value and click **APPLY 32:9 & FOV**.
4. Keep the patcher open or minimized while playing.

The patcher looks exclusively for the running `Resonance.exe` process, so the
installation path and storefront do not matter. It validates the expected byte
signatures before making any changes. If a Steam or future game build differs,
the patcher stops safely instead of modifying unknown code.

If the wider viewport is not immediately visible after applying the patch,
press `Alt+Enter` once.

## Gameplay FOV

The patcher hooks the FOV value used by the visible gameplay camera. The user
interface provides:

- VFOV: set the vertical field of view directly
- HFOV: convert a desired horizontal field of view automatically for 32:9
- Live slider: apply changes immediately after connecting
- Restore FOV: disable the FOV override and restore the game's dynamic FOV

**80° VFOV** is a noticeably wider but practical starting point. **105° VFOV**
is extremely wide and mainly useful for testing or personal preference.

## Camera distance

Gameplay camera distance is not stored as one stable global value. The game
uses different distances for individual states and camera areas, combined with
camera collision. This version intentionally does not change camera distance
to avoid breaking aiming, tight spaces, or scripted camera sequences.

## Technical notes

No game files are modified. Every change is made only in the running game's
memory and disappears when `Resonance.exe` exits.

The command-line options `--vfov`, `--hfov`, `--reset-fov`, and `--once` remain
available for scripts.

## Native build

```powershell
.\build-native.ps1
```

Building requires the Visual Studio C++ build tools. End users only need the
resulting `artifacts\Resonance32x9Patcher.exe`.
