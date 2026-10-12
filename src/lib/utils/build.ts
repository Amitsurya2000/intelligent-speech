/**
 * True in the Microsoft Store (MSIX) build, where the Store delivers updates and
 * the in-app updater is disabled. Set by scripts/build-msix.ps1 (VITE_MSIX=1),
 * together with the Rust `msix` cargo feature.
 */
export const IS_MSIX_BUILD = import.meta.env.VITE_MSIX === "1";
