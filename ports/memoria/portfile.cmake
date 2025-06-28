vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO victor-smirnov/memoria
	REF a461119853d628679df528ab230d66bd31c89dcf
	SHA512 cc7bed724e0ac7ad664156237ebf6860f9ea68147abe3a9b499fbe7c37c0e80095d93a8809ca50ac2e1c9eaf499719bb4b3bc0e4d851a3e03be36c46ef318751
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