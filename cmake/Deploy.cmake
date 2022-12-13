include_guard(GLOBAL)

function(deploy TARGET DEPLOY_SOURCE_DIR)
    if(APP_DEPLOY_AS_PART_OF_ALL)
        set(ALL ALL)
    endif()

    if(NOT TARGET deploy)
        add_custom_target(deploy ${ALL} DEPENDS ${TARGET})
    endif()

    if(NOT IS_ABSOLUTE ${DEPLOY_SOURCE_DIR})
        string(JOIN / DEPLOY_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} ${DEPLOY_SOURCE_DIR})
    endif()
    
    set(LINUXDEPLOYQT_EXECUTABLE $<TARGET_FILE:${TARGET}>)
    set(DEPLOY_APPDIR_PATH ${APP_DEPLOY_DIR}/$<TARGET_FILE_NAME:${TARGET}>.AppDir)
    set(DEPLOY_PREFIX_PATH ${DEPLOY_APPDIR_PATH}/usr)
    
    find_program(APPIMAGETOOL_EXECUTABLE appimagetool)

    if(NOT APPIMAGETOOL_EXECUTABLE)
        message(STATUS "Could NOT find appimagetool, downloading...")
        set(APPIMAGETOOL_EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/appimagetool)
        set(APPIMAGETOOL_URL "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage")
        file(DOWNLOAD ${APPIMAGETOOL_URL} ${APPIMAGETOOL_EXECUTABLE} SHOW_PROGRESS)
        file(CHMOD ${APPIMAGETOOL_EXECUTABLE} PERMISSIONS OWNER_READ OWNER_EXECUTE)
    endif()
    
    add_custom_command(TARGET deploy VERBATIM
        COMMAND ${CMAKE_COMMAND} -E make_directory
            ${DEPLOY_APPDIR_PATH}
    )

    add_custom_command(TARGET deploy VERBATIM
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${DEPLOY_SOURCE_DIR}/Template.AppDir ${DEPLOY_APPDIR_PATH}
    )

    add_custom_command(TARGET deploy VERBATIM
        COMMAND ${CMAKE_COMMAND} -E make_directory
            ${DEPLOY_PREFIX_PATH}/bin
    )
    
    add_custom_command(TARGET deploy VERBATIM
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            $<TARGET_FILE:${TARGET}> ${DEPLOY_PREFIX_PATH}/bin
    )

    if(Qt6_DIR)
        set(QMAKE_EXECUTABLE ${Qt6_DIR}/../../../bin/qmake)
    else()
        list(GET Qt6_LIB_DIRS 0 Qt6_DIR)
        set(QMAKE_EXECUTABLE ${Qt6_DIR}/../bin/qmake)
    endif()

    add_custom_command(TARGET deploy VERBATIM
        COMMAND ${LINUXDEPLOYQT_EXECUTABLE}
            ${DEPLOY_PREFIX_PATH}/bin/$<TARGET_FILE_NAME:${TARGET}>
            -appimage
            -qmake="${QMAKE_EXECUTABLE}"
        WORKING_DIRECTORY ${APP_DEPLOY_DIR}
    )
endfunction()
