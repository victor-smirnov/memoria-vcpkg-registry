vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO victor-smirnov/memoria
	REF 4ece151a359b1f520dd32e801ce5344380b3f549
	SHA512 2d7c463f7562d27205e919411122640da35c72f5eb49e049b8f822b21652b43f284061905b8dfdf77e454c07222190700317222256d6c430b3f14b41bae0ca53
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
	INSTALL "${SOURCE_PATH}/LICENSE-2.0"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
	RENAME copyright)

file(
	INSTALL "${SOURCE_PATH}/NOTICE"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
