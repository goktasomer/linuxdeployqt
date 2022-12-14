include_guard(GLOBAL)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_CXX_EXTENSIONS FALSE)
set(CMAKE_AUTOMOC TRUE)
set(CMAKE_AUTOUIC TRUE)
set(CMAKE_AUTORCC TRUE)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN TRUE)

list(APPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_BINARY_DIR})

include(GenerateExportHeader)

add_compile_options(-Wall -Wextra -pedantic-errors)
if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
    add_link_options(-fuse-ld=lld)
endif()

add_compile_definitions(APP_VERSION="${CMAKE_PROJECT_VERSION}")
