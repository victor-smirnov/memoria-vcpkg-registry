#if ("with-boost" IN_LIST FEATURES)
#    set(PATCHES_FOR_SEASTAR fix-build.patch)
#endif()


vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO scylladb/seastar
	REF 8df8212e53577e1d8477a5c901457cd61d88afc7
	SHA512 aeb84803d488de7c149bd71fa847646bbeed4b3c86e947e575f8f3b96c6a8c054403c8a347ee885dabf4f9a6431c3daca4ef821bee487b56df7b0fab2a978b5b
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
