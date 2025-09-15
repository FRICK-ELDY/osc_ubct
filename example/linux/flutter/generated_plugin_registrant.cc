//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <osc_ubct/osc_ubct_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) osc_ubct_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "OscUbctPlugin");
  osc_ubct_plugin_register_with_registrar(osc_ubct_registrar);
}
