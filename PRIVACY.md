# Privacy Policy

**Intelligent Speech** · Published by intelligent advisory · Last updated: 13 October 2026

Intelligent Speech turns your voice into text on your own computer. **Your audio is never uploaded**, and the app has no accounts, no ads, no analytics and no crash reporting. This page explains exactly what the app does with your microphone, what it stores on your device, and the few cases where it connects to the internet.

## Short version

- Speech recognition runs **on your device**. Audio never leaves it.
- The text you dictate never leaves it either, **unless you turn on the optional AI post-processing feature** (off by default) and point it at an online AI service.
- The app connects to the internet only to **download speech models**, to **check for app updates**, and, only if you enable it, for **AI post-processing**.
- We do not collect, receive, sell or share your data. The developers run no server that receives anything from the app.

## What the microphone is used for

The microphone is used for one purpose: capturing your voice for dictation.

- A recording starts only when you press your dictation shortcut, and stops when you release it (push-to-talk) or press it again, depending on your setting.
- While a recording is active, the app also uses the microphone signal to draw the level indicator and to detect speech versus silence so it can trim silence before transcription. All of this happens on your device.
- **Always-On Microphone** is an optional setting, off by default. When on, the microphone stream stays open so recording starts faster. Audio is still only kept while you are actively dictating; outside of a dictation it is discarded immediately.
- Your operating system controls microphone access. You can revoke it for the app at any time in your system's privacy settings.

## Does audio or text leave your device?

| What | When | What is sent | Where |
|---|---|---|---|
| **Speech recognition** | Every dictation | Nothing. It runs locally. | n/a |
| **Model downloads** | When you choose to download a speech model | A normal download request (your IP address and standard HTTP details). No audio, text or personal data. | `blob.handy.computer` and `github.com` (GitHub Releases) |
| **Update checks** | At startup and when you click "Check for updates", if enabled (on by default in the standard installer) | A normal request for the update file (your IP address and standard HTTP details). If an update exists and you accept, it is downloaded from GitHub. No audio or text. | `github.com` (this app's Releases page) |
| **AI post-processing** | Only if you turn it on, add an API key, and dictate with the post-processing shortcut | The **transcribed text** and the prompt you chose (no audio), plus your API key to authenticate | The AI provider you select (see below) |
| **Listing AI models** | Only when you click refresh or switch provider in the post-processing settings | Your API key, to ask the provider which models it offers. No dictated text. | The AI provider you select |

### Optional AI post-processing

Post-processing lets an AI model clean up or reformat your transcript. It is **off by default** and does nothing until you enable it and enter your own API key.

When you use it, the app sends the transcribed text and your prompt to the provider you picked. The built-in choices are OpenAI, Anthropic, OpenRouter, Groq, Cerebras, Z.ai, AWS Bedrock, or any OpenAI-compatible address you enter. You can also point it at a service on your own computer (for example Ollama at `localhost`), in which case nothing leaves your device. On supported Macs, Apple Intelligence can be used, which runs on-device.

Once the text reaches a third-party provider, **that provider's own privacy policy and terms apply**, and we have no control over it. If you don't want any text to leave your device, leave post-processing off.

### Standard installer and Microsoft Store version

- The **standard installer** (Windows, macOS, Linux) can check for updates itself. You can turn this off: press `Ctrl+Shift+D` (`Cmd+Shift+D` on macOS) to show the Debug page, then switch off **Check for Updates**.
- The **Microsoft Store version** never checks for updates itself. The Store handles updates, so the app makes no update-check connection.

## What is stored on your device

Everything below stays on your computer. Nothing is uploaded.

| Data | Details |
|---|---|
| **Recordings** | Each dictation is saved as an audio file so you can replay it from History or retry a failed transcription. By default only the latest 5 are kept (starred entries are exempt). In Settings you can choose to delete after 3 days, 2 weeks or 3 months, or never delete automatically. |
| **History** | A local database with the transcribed text of each dictation, plus the AI-processed text and prompt if you used post-processing. History size is limited by the same setting. You can delete entries individually. |
| **Settings** | Your preferences, shortcuts, custom words, and any AI API key you enter. **API keys are stored as plain text in the settings file**, so only use keys on a computer you trust, and consider using restricted keys. |
| **Speech models** | The model files you download. |
| **Log file** | A small diagnostic log (`handy.log` in the standard installer, `intelligent-speech.log` in the Microsoft Store version; rotated at about 500 KB, with one older copy kept). **At the default log level the log includes the text of each transcription.** To stop this, open the Debug page and set **Log Level** to Warning or Error. You can also delete the log files at any time. |

**Where:** in the app's data folder. On Windows this is `%APPDATA%\com.intelligentspeech.app` (settings, history, recordings, models) and `%LOCALAPPDATA%\com.intelligentspeech.app\logs` (logs). On macOS it is `~/Library/Application Support/com.intelligentspeech.app`, and on Linux `~/.local/share/com.intelligentspeech.app`. The About page shows the exact paths and has buttons to open them. In the Microsoft Store version this data lives in the app's package storage and is removed when you uninstall. In portable mode everything is kept in a `Data` folder next to the app.

## Keyboard, clipboard and typing into other apps

- **Shortcuts:** to react to your dictation shortcut, the app listens for key presses system-wide. It checks them only against your configured shortcuts. Keystrokes are not recorded, stored or sent anywhere. (When you rebind a shortcut in Settings, the app briefly captures the keys you press to learn the new combination.)
- **Inserting text:** the app puts the transcript into the app you are using, usually by briefly placing it on the clipboard, pressing paste, and then restoring what the clipboard held before. If you enable "copy to clipboard", the transcript is left on your clipboard on purpose. Clipboard managers or other apps that watch the clipboard may see this text.

## Your choices and control

- Delete any history entry, or all data, from History and by deleting the app data folder shown above.
- Uninstalling the app removes the program; delete the data folder to remove the rest.
- Choose how long recordings are kept, or reduce what is logged, as described above.
- Keep post-processing off to ensure no text ever leaves your device.
- Turn off update checks in the standard installer, as described above.

## Children

Intelligent Speech is a general-purpose tool and is not directed at children. We do not knowingly collect any information from anyone, including children.

## Open source and third parties

Intelligent Speech is open source (MIT License) and is based on [Handy](https://github.com/cjpais/Handy). You can read exactly what it does in the [source code](https://github.com/Amitsurya2000/intelligent-speech). The only third parties it can contact are the ones named in this policy: `blob.handy.computer` and GitHub for downloads and updates, and an AI provider of your choosing if you enable post-processing.

## Changes to this policy

If the app's data practices change, we will update this page and its "Last updated" date. Because the policy lives in the project's repository, the full history of changes is public.

## Contact

Questions or requests about privacy: **rajan@intelligentadvisory.in**
