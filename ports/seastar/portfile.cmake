if ("with-boost" IN_LIST FEATURES)
    set(PATCHES_FOR_SEASTAR fix-build.patch)
endif()


vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO scylladb/seastar
	REF 8febce5f9ed54a76e7ca08c38c22c407b84cc39d
	SHA512 125cd51cdf5571c6376d0037a52cd4c14b4bb451fef577a9d35ab8d3c5004e2b50e8e3e28224465adf853dbc764169197d997eb61e84e77f7bb56a13dce0617e
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
