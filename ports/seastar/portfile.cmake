vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO scylladb/seastar
	REF 8febce5f9ed54a76e7ca08c38c22c407b84cc39d
	SHA512 61665b4f69cddf99f9f8e2a4a8c0c7ab0ce061061cce1853557c1db3613ae46df97d1cfed72963b845b50d1610115c282f69575e44331bf8d6edcc8640f4f471
	HEAD_REF master
    PATCHES
        fix-build.patch
)

vcpkg_configure_cmake(
	SOURCE_PATH "${SOURCE_PATH}"
	PREFER_NINJA
    OPTIONS
        -DSeastar_TESTING=OFF
        -DSeastar_SANITIZE=OFF
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
