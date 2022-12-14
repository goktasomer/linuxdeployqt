cmake_minimum_required(VERSION 3.19)

project(linuxdeployqt
    LANGUAGES CXX
    VERSION 2.1.3
    HOMEPAGE_URL omergoktas.com
    DESCRIPTION "Qt dependency deployment tool for Linux."
)

list(APPEND CMAKE_MODULE_PATH
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake
)

include(Options)
include(Setup)

find_package(Qt6 REQUIRED Core)

include(Deploy)

qt_add_executable(linuxdeployqt
    main.cpp
    shared.h
    shared.cpp
)

install(TARGETS linuxdeployqt DESTINATION bin)

deploy(linuxdeployqt deploy)
