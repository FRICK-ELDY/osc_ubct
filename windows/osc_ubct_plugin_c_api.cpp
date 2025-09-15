#include "include/osc_ubct/osc_ubct_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "osc_ubct_plugin.h"

void OscUbctPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  osc_ubct::OscUbctPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
