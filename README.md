# Intelligent Speech

**Offline speech-to-text for your desktop, with first-class Indian-language support.**

Press a shortcut, speak, and your words appear in whatever app you're using. Transcription runs entirely on your own computer: no audio ever leaves your machine.

Intelligent Speech is a fork of the open-source [Handy](https://github.com/cjpais/Handy) (MIT), extended with Indian-language models and its own branding.

## Features

- **Works in any app**: dictate into browsers, editors, chat, email, anywhere you can type
- **Private by design**: all speech recognition is local, nothing is sent to the cloud
- **Indian languages**: Vistaar IndicWhisper (best Hindi), IndicConformer (8 Indian languages, fast), Nemotron 3.5 ASR (Hindi + 40 languages)
- **Many models**: Whisper (Small / Medium / Turbo / Large), Parakeet V3, Moonshine, SenseVoice, Canary and more, with GPU acceleration where available
- **Smart silence handling**: Silero VAD trims silence before transcription
- **Push-to-talk or toggle** recording, fully configurable shortcuts
- **Custom words** and optional post-processing of transcripts
- **Auto-update**: new versions are signed and delivered from GitHub Releases
- **Windows, macOS and Linux**

## Install

Download the installer for your system from the [latest release](https://github.com/Amitsurya2000/intelligent-speech/releases/latest), install it, and grant the microphone (and, on macOS, accessibility) permission when asked. Pick a model in the first-run screen; it downloads once and is then used offline.

> Installers are not yet code-signed with a paid certificate, so Windows SmartScreen and macOS Gatekeeper may warn on first launch. Updates are separately verified with a minisign signature.

## How it works

1. **Press** your shortcut to start recording (or hold it, in push-to-talk mode)
2. **Speak**
3. **Release / press again**: the audio is transcribed locally
4. **Done**: the text is pasted into the app you were using

## Phones

Android and iPhone don't let one app type into another, so the shortcut-and-paste model can't work as-is. An Android build using an Accessibility Service is in progress; iOS is not planned. See `src-tauri/gen/android`.

## Development

See [BUILD.md](BUILD.md) for platform prerequisites.

```bash
bun install
bun run tauri dev      # run the app
bun run lint           # eslint
bun run format:check   # prettier + cargo fmt
```

Stack: Tauri 2 (Rust backend) + React, TypeScript and Tailwind (settings UI).

### Releasing

1. Bump `version` in `src-tauri/tauri.conf.json`, commit and push.
2. Run the **Release** workflow from the GitHub Actions tab. It builds every platform, signs the updater artifacts and uploads `latest.json` to a **draft** release.
3. Review the draft and click **Publish**. Installed apps update from `releases/latest`, so the update only goes live once the release is published.

The updater signing key must be set once as repository secrets `TAURI_SIGNING_PRIVATE_KEY` and `TAURI_SIGNING_PRIVATE_KEY_PASSWORD` (the matching public key is in `tauri.conf.json`). Keep the private key backed up: if it's lost, installed apps can no longer be updated.

### Command-line flags

Run the installed app executable (shown here as `intelligent-speech`) with these flags. Remote-control flags are sent to the already-running instance.

```bash
intelligent-speech --toggle-transcription    # toggle recording in a running instance
intelligent-speech --toggle-post-process     # toggle recording with post-processing
intelligent-speech --cancel                  # cancel the current operation
intelligent-speech --start-hidden            # start without showing the main window
intelligent-speech --no-tray                 # start without the tray icon
intelligent-speech --debug                   # verbose logging
```

### Linux notes

For reliable text input install `xdotool` (X11) or `wtype` / `dotool` (Wayland). On Wayland, bind your desktop's custom shortcut to the app executable with `--toggle-transcription`. If startup fails with `libgtk-layer-shell.so.0` missing, install `libgtk-layer-shell0` (Debian/Ubuntu), `gtk-layer-shell` (Fedora/Arch).

## License and credits

MIT. Built on [Handy](https://github.com/cjpais/Handy) by CJ Pais, [whisper.cpp](https://github.com/ggml-org/whisper.cpp), [transcribe-rs](https://github.com/cjpais/transcribe-rs) and [Silero VAD](https://github.com/snakers4/silero-vad).
