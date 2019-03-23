
if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
    set(MPC_STATIC_FLAG -static)
    set(SLN_SUFFIX _static)
    set(DLL_DECORATOR s)
else()
    set(SLN_SUFFIX "")
    set(DLL_DECORATOR "")
endif()

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO soft-way/hiredis-ccc
    HEAD_REF <master>
    REF v1.0.0
    SHA512 ecf2c3f02f0507adab72785b45358578bfb01dc9139a71a9622d734b15afa3af3a07d83d422fc938ac527bb4e30da7f97fad3eeb76fafcb1255ad3cad2a08c09
)

set(HIREDIS_CCC_ROOT ${SOURCE_PATH})

if (TRIPLET_SYSTEM_ARCH MATCHES "arm")
    message(FATAL_ERROR "ARM is currently not supported.")
elseif (TRIPLET_SYSTEM_ARCH MATCHES "x86")
    set(MSBUILD_PLATFORM "x86")
    set(MSBUILD_OUT "Win32")
else ()
    set(MSBUILD_PLATFORM ${TRIPLET_SYSTEM_ARCH})
    set(MSBUILD_OUT "x64")
endif()

if(VCPKG_PLATFORM_TOOLSET MATCHES "v141")
    set(SOLUTION_TYPE vs2017)
else()
    set(SOLUTION_TYPE vc14)
endif()

vcpkg_build_msbuild(
    PROJECT_PATH ${HIREDIS_CCC_ROOT}/build_msvc/hiredisccc${SLN_SUFFIX}.sln
    RELEASE_CONFIGURATION Release
    PLATFORM ${MSBUILD_PLATFORM}
    TARGET libhiredisccc${SLN_SUFFIX}
    USE_VCPKG_INTEGRATION
)

file(GLOB HEADER_FILES ${SOURCE_PATH}/libhiredisccc/include/*.h)
file(INSTALL ${HEADER_FILES}
     DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(GLOB HEADER_FILES ${SOURCE_PATH}/libhiredisccc/include/adapters/*.h)
file(INSTALL ${HEADER_FILES}
     DESTINATION ${CURRENT_PACKAGES_DIR}/include/adapters)

# Install the lib files
file(INSTALL
    ${SOURCE_PATH}/build_msvc/MSBuild.Release.${MSBUILD_OUT}/libhiredisccc${DLL_DECORATOR}.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/lib
)

file(INSTALL
    ${SOURCE_PATH}/build_msvc/MSBuild.Debug.${MSBUILD_OUT}/libhiredisccc${DLL_DECORATOR}d.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib
)

if (NOT VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(INSTALL
        ${SOURCE_PATH}/build_msvc/MSBuild.Release.${MSBUILD_OUT}/libhiredisccc.dll
        DESTINATION ${CURRENT_PACKAGES_DIR}/bin
    )
    
    file(INSTALL
        ${SOURCE_PATH}/build_msvc/MSBuild.Debug.${MSBUILD_OUT}/libhirediscccd.dll
        DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin
    )
endif()


# Handle copyright
file(COPY ${HIREDIS_CCC_ROOT}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/hiredisccc)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/hiredisccc/COPYING ${CURRENT_PACKAGES_DIR}/share/hiredisccc/copyright)
