# Set up package options
set(CPACK_PACKAGE_NAME "OSVR-RenderManager")
set(CPACK_PACKAGE_VENDOR "Sensics, Inc.")
set(CPACK_PACKAGE_CONTACT "<support@osvr.com>")
set(CPACK_PACKAGE_VERSION_MAJOR 0)
set(CPACK_PACKAGE_VERSION_MINOR 6)
set(OSVR_RENDERMANAGER_VERSION ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION ${OSVR_RENDERMANAGER_VERSION})

include(GetGitRevisionDescription)
git_describe(GIT_REVISION_DESCRIPTION --tags --match v*)
if(GIT_REVISION_DESCRIPTION)
    string(REPLACE "v" ""
        GIT_REVISION_DESCRIPTION
        "${GIT_REVISION_DESCRIPTION}")
    set(CPACK_PACKAGE_VERSION "${GIT_REVISION_DESCRIPTION}")
    message(STATUS "Git reports version ${CPACK_PACKAGE_VERSION}")
else()
    message(STATUS "Could not get revision information from Git! Calling this just version ${CPACK_PACKAGE_VERSION}!")
endif()

if(WIN32)
    set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CMAKE_CXX_COMPILER_ID}")
    if(MSVC)
        include(GetMSVCVersion)
        get_msvc_major_minor_version(_vs_major _vs_minor)
        set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}${_vs_major}${_vs_minor}")
    endif()
    if(CMAKE_CXX_SIZEOF_DATA_PTR EQUAL 8)
        set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}-64bit")
    else()
        set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}-32bit")
    endif()
endif()

