vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO victor-smirnov/seastar
	REF 714a88ddd2459c0b0a2dd1e068382e6cf766331a
	SHA512 c4ebdae2893db455ba7b1c2ed6cc3bcbe4568d1e94d556409a564d4f962066acbd2625ed43cd77c14db2766f3ab66fcb4d10f07874ddf3b00f5d289e9ed96527
	HEAD_REF memoria
)

vcpkg_configure_cmake(
	SOURCE_PATH "${SOURCE_PATH}"
	PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(
	INSTALL "${SOURCE_PATH}/LICENSE"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
	RENAME copyright)

file(
	INSTALL "${SOURCE_PATH}/NOTICE"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
