#if ("with-boost" IN_LIST FEATURES)
#    set(PATCHES_FOR_SEASTAR fix-build.patch)
#endif()


vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO scylladb/seastar
	REF 8df8212e53577e1d8477a5c901457cd61d88afc7
	SHA512 165023416e0117178725621097e55dc874a34c7ba706200e11236e92b7e767669c07f1e53ee899ad149cf7fe9cc78f6bf2f1112d0ed46bedd8f855939d85e27d
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
