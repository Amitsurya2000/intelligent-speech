import { type } from "@tauri-apps/plugin-os";

/**
 * True on Android/iOS. Desktop-only concepts (global keyboard shortcuts,
 * autostart, system tray, the floating recording overlay) don't exist on
 * mobile, so UI for them should be hidden rather than shown non-functional.
 */
export function isMobilePlatform(): boolean {
  const osType = type();
  return osType === "android" || osType === "ios";
}
