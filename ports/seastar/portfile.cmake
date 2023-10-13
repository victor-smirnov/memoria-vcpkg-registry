vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO scylladb/seastar
	REF 4dc3871ed9f32816e7a03895e98c86a5502d980f
	SHA512 22b762e6e5af38b48f7686f65ee62b11fb3d2a2ab8d5705d2437ad4ac177ff3fa4edfd4e6d249701b29f7b4af2d28dca0082a560248fc949f13ce60184ec1673
	HEAD_REF master
)

vcpkg_configure_cmake(
	SOURCE_PATH "${SOURCE_PATH}"
	PREFER_NINJA
    OPTIONS
        -DSeastar_DEMOS=OFF
        -DSeastar_TESTING=OFF
        -DSeastar_APPS=OFF
        -DSeastar_DOCS=OFF
        -DSeastar_SANITIZE=OFF
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
