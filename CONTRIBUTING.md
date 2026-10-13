# Contributing to Intelligent Speech

Thanks for helping improve Intelligent Speech, an offline speech-to-text app for the desktop with Indian-language support.

## Getting set up

You need [Rust](https://rustup.rs/) (latest stable) and [Bun](https://bun.sh/). Platform-specific prerequisites are in [BUILD.md](BUILD.md).

```bash
git clone https://github.com/Amitsurya2000/intelligent-speech.git
cd intelligent-speech
bun install
bun run tauri dev
```

## Before you open a pull request

```bash
bun run lint               # ESLint
bun run format:check       # Prettier and cargo fmt
bun run check:translations # every language has the same keys as English
```

- Keep changes focused, and describe what you changed and why.
- All text shown in the app goes through i18next. Add new strings to `src/i18n/locales/en/translation.json` and the other languages (see [CONTRIBUTING_TRANSLATIONS.md](CONTRIBUTING_TRANSLATIONS.md)).
- Do not add anything that sends audio or text off the device without an explicit, off-by-default setting, and update [PRIVACY.md](PRIVACY.md) if data handling changes.

## Reporting problems

Open an issue at https://github.com/Amitsurya2000/intelligent-speech/issues. Include your Windows, macOS or Linux version, the app version (shown on the About page), and the steps to reproduce. For privacy questions, see [PRIVACY.md](PRIVACY.md).

## License

By contributing you agree that your contributions are licensed under the MIT License. See [LICENSE](LICENSE).
