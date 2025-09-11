// src/register_types.cpp
#include "gdexample.h"

#include <godot_cpp/godot.hpp>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/utility_functions.hpp>

using namespace godot;

static void initialize_example_module(ModuleInitializationLevel level) {
    if (level != MODULE_INITIALIZATION_LEVEL_SCENE) return;
    UtilityFunctions::print("[gdext] init SCENE: registering GDExample");
    ClassDB::register_class<GDExample>();           // (Use GDREGISTER_CLASS if you prefer the macro)
}

static void uninitialize_example_module(ModuleInitializationLevel) {}

// ---- ENTRY SYMBOL (exact name, C linkage, default visibility) ----
// ---- ENTRY SYMBOL (exact name, C linkage, default visibility) ----
extern "C"
#ifdef _WIN32
__declspec(dllexport)  // Windows (MSVC, MinGW)
#else
__attribute__((visibility("default")))  // Linux, macOS
#endif
GDExtensionBool example_library_init(
    GDExtensionInterfaceGetProcAddress get_proc,
    GDExtensionClassLibraryPtr library,
    GDExtensionInitialization* r_init) {

    GDExtensionBinding::InitObject init(get_proc, library, r_init);
    init.register_initializer(initialize_example_module);
    init.register_terminator(uninitialize_example_module);
    init.set_minimum_library_initialization_level(MODULE_INITIALIZATION_LEVEL_SCENE);
    return init.init();
}

