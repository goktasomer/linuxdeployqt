cmake_minimum_required(VERSION 3.22)

project(linuxdeployqt VERSION 2.0.0 HOMEPAGE_URL omergoktas.com LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(StandardSetup)

execute_process(
    COMMAND bash ${CMAKE_CURRENT_SOURCE_DIR}/generate-excludelist.sh
    OUTPUT_VARIABLE EXCLUDELIST
    TIMEOUT 10
)

qt_add_executable(linuxdeployqt
    main.cpp
    excludelist.h
    shared.h
    shared.cpp
)

install(TARGETS linuxdeployqt)
