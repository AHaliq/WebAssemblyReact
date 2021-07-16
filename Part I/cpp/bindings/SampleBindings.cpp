#include <emscripten.h>
#include <emscripten/bind.h>
#include "src/Sample.h"
#include <string>

using namespace emscripten;

EMSCRIPTEN_BINDINGS(Sample) {
    function("add", optional_override([](int a, int b) -> int {
        return Sample::add(a, b);
    }));
    function("greet", optional_override([]() -> std::string {
        return Sample::greet();
    }));
}
