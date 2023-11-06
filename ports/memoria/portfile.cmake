vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO victor-smirnov/memoria
	REF 4ca8372fb64561a34a3025f324db7489af3c98c3
	SHA512 3a398e33b6eaf6d23fde2447aaa7a8be76fe322869e2ef2d52005c0fa80d58b59a666c966650f81ddb45591b5217389a4b0a67c642e476bcd31d360515d39c89
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