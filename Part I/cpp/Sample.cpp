#include "Sample.h"
#include <string>
#include <Snark/Snark.h>

int Sample::add(int a, int b) {
    return a+b;
}

std::string Sample::greet() {
    return "hello world";
}