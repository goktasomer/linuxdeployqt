include_guard(GLOBAL)

set(BUILD_SHARED_LIBS TRUE CACHE BOOL "Build using shared libraries.")

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING
        "Build type (Debug, Release, RelWithDebInfo, MinSizeRel)." FORCE)
endif()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/install CACHE PATH
        "The directory to put installation files." FORCE)
endif()

set(APP_DEPLOY_DIR ${CMAKE_CURRENT_BINARY_DIR}/deploy CACHE PATH
    "The directory to put deployment packages.")

if(CMAKE_BUILD_TYPE STREQUAL Debug)
    set(APP_DEPLOY_AS_PART_OF_ALL FALSE CACHE BOOL
        "Build deployment packages in the make step.")
else()
    set(APP_DEPLOY_AS_PART_OF_ALL TRUE CACHE BOOL
        "Build deployment packages in the make step.")
endif()
