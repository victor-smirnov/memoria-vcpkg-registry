vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO victor-smirnov/memoria
	REF f4a438b62832f14c00181e37059c498ee6db8945
	SHA512 e29c12c231fe8bea8023b7679142a8fbb0d611e8b40e67c237ae4d24dfe35c4b90835dcdf113f48c2aa9671ca46f1a9d532e309fc2e3844f061900a5ea775a70
	HEAD_REF master
)

vcpkg_configure_cmake(
	SOURCE_PATH "${SOURCE_PATH}"
	PREFER_NINJA
    OPTIONS
        -DBUILD_SEASTAR=ON
)

vcpkg_install_cmake()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME memoria
)

file(
	INSTALL "${SOURCE_PATH}/LICENSE"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
	RENAME copyright)

file(
	INSTALL "${SOURCE_PATH}/NOTICE"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
