#if ("with-boost" IN_LIST FEATURES)
#    set(PATCHES_FOR_SEASTAR fix-build.patch)
#endif()

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO scylladb/seastar
	REF 8df8212e53577e1d8477a5c901457cd61d88afc7
	SHA512 85f85c4eab310edf583a39318ba396d31819510300ab4225f55ec69587ffcb15f19003dc8c7ac8383d7aab497e92e750e0ee4226573444db4d6732f4713d7817
	HEAD_REF master
    PATCHES
        ${PATCHES_FOR_SEASTAR}
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS SEASTAR_FEATURE_OPTIONS
    FEATURES
      sanitize Seastar_SANITIZE
      tests    Seastar_TESTING
)



vcpkg_configure_cmake(
	SOURCE_PATH "${SOURCE_PATH}"
	PREFER_NINJA
    OPTIONS
        ${SEASTAR_FEATURE_OPTIONS}
        -DSeastar_CXX_FLAGS=-Wno-error
)

vcpkg_install_cmake()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME Seastar
    CONFIG_PATH lib/cmake/Seastar
    DO_NOT_DELETE_PARENT_CONFIG_PATH
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(
	INSTALL "${SOURCE_PATH}/LICENSE"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
	RENAME copyright)

file(
	INSTALL "${SOURCE_PATH}/NOTICE"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
