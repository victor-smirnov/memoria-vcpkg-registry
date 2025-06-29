vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO victor-smirnov/memoria
	REF 9f4daf5ba5e2a75d7e32aaf76d8384c7990a63b0
	SHA512 780800d5848004c6812f7f81c1135b389bc07f6353c658780b8208e62feb1f69675caad16dc4072e5675da6724629ce9e05b81dc3fb0169d6c67199bb2d9489a
	HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS MEMORIA_FEATURES
    FEATURES
        seastar             BUILD_SEASTAR
        seastar-with-boost  BUILD_SEASTAR_WITH_BOOST
        with-boost          BUILD_WITH_VCPKG_BOOST
        core-only           BUILD_CORE_ONLY
)


if (BUILD_WITH_VCPKG_BOOST OR BUILD_SEASTAR_WITH_BOOST)
    set(WITH_BOOST ON)
else()
    set(WITH_BOOST OFF)
endif()

if (BUILD_SEASTAR OR BUILD_SEASTAR_WITH_BOOST)
    set(WITH_SEASTAR ON)
else()
    set(WITH_SEASTAR OFF)
endif()

vcpkg_configure_cmake(
	SOURCE_PATH "${SOURCE_PATH}"
	PREFER_NINJA
    OPTIONS
        -DBUILD_CORE_ONLY=${BUILD_CORE_ONLY}
        -DBUILD_WITH_VCPKG_BOOST=${WITH_BOOST}
        -DBUILD_SEASTAR=${WITH_SEASTAR}
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

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")