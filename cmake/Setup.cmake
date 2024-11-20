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

add_compile_options(-Wall -Wextra -pedantic-errors)
if(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
    add_link_options(-fuse-ld=lld)
endif()

find_package(QT NAMES Qt6 REQUIRED Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED Core)

qt_standard_project_setup(REQUIRES 6.7.3 SUPPORTS_UP_TO 6.9.99)

add_compile_definitions(APP_NAME="${CMAKE_PROJECT_NAME}")
add_compile_definitions(APP_VERSION="${CMAKE_PROJECT_VERSION}")
add_compile_definitions(APP_URL="${CMAKE_PROJECT_HOMEPAGE_URL}")

if(Qt6_DIR)
    set(QT_BINDIR ${Qt6_DIR}/../../../bin)
else()
    list(GET Qt6_LIB_DIRS 0 Qt6_DIR)
    set(QT_BINDIR ${Qt6_DIR}/../bin)
endif()
file(REAL_PATH ${QT_BINDIR} QT_BINDIR)
set(QMAKE_EXECUTABLE ${QT_BINDIR}/qmake)
