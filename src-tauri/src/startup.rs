//! Launch-on-startup control.
//!
//! The normal builds (Windows installer, macOS, Linux) use the autostart plugin,
//! which writes a registry Run key / LaunchAgent / .desktop entry. Inside an MSIX
//! package those registry writes are redirected into the package's private hive
//! and never take effect, so the Microsoft Store build (cargo feature `msix`)
//! uses the Windows StartupTask API instead. The matching `windows.startupTask`
//! extension (TaskId below) is declared in `msix/AppxManifest.xml`.

use tauri::AppHandle;

/// Must equal the `TaskId` of the `desktop:StartupTask` in `msix/AppxManifest.xml`.
#[cfg(all(windows, feature = "msix"))]
const STARTUP_TASK_ID: &str = "IntelligentSpeechStartup";

/// Enable or disable launching the app when the user signs in.
#[cfg(desktop)]
pub fn set_enabled(app: &AppHandle, enabled: bool) {
    #[cfg(all(windows, feature = "msix"))]
    {
        let _ = app;
        // WinRT async calls are awaited with a blocking `get()`; do that off the
        // calling (UI) thread.
        std::thread::spawn(move || {
            if let Err(e) = set_startup_task(enabled) {
                log::warn!("Failed to update the MSIX startup task: {e}");
            }
        });
    }

    #[cfg(not(all(windows, feature = "msix")))]
    {
        use tauri_plugin_autostart::ManagerExt;
        let autostart_manager = app.autolaunch();
        let _ = if enabled {
            autostart_manager.enable()
        } else {
            autostart_manager.disable()
        };
    }
}

#[cfg(not(desktop))]
pub fn set_enabled(_app: &AppHandle, _enabled: bool) {}

#[cfg(all(windows, feature = "msix"))]
fn set_startup_task(enabled: bool) -> windows::core::Result<()> {
    use windows::core::HSTRING;
    use windows::ApplicationModel::StartupTask;

    let task = StartupTask::GetAsync(&HSTRING::from(STARTUP_TASK_ID))?.get()?;
    if enabled {
        // The state can come back DisabledByUser/DisabledByPolicy when the user
        // turned it off in Task Manager or IT policy forbids it; that choice wins.
        let state = task.RequestEnableAsync()?.get()?;
        log::info!("MSIX startup task state after enabling: {state:?}");
    } else {
        task.Disable()?;
    }
    Ok(())
}
