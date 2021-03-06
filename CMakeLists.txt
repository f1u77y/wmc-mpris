cmake_minimum_required(VERSION 3.0)
project(web-media-controller C)

option (ENABLE_FIREFOX "Install manifest for Firefox" ON)
option (ENABLE_CHROME "Install manifest for Google Chrome" ON)
option (ENABLE_CHROMIUM "Install manifest for Chromium" ON)

option (INSTALL_FOR_CURRENT_USER "Install for current user only" OFF)
set (CHROMIUM_MANIFEST_DESTINATION "/etc/chromium/native-messaging-hosts" CACHE STRING "Choromium's manifest installation location")
set (CHROME_MANIFEST_DESTINATION "/etc/opt/chrome/native-messaging-hosts" CACHE STRING "Chrome's manifest installation location")
set (FIREFOX_MANIFEST_DESTINATION "/usr/lib/mozilla/native-messaging-hosts" CACHE STRING "Firefox's manifest installation location")
set (CMAKE_INSTALL_PREFIX "/usr/local" CACHE STRING "Install prefix")

if (INSTALL_FOR_CURRENT_USER)
  set (CHROMIUM_MANIFEST_DESTINATION "$ENV{HOME}/.config/chromium/NativeMessagingHosts")
  set (CHROME_MANIFEST_DESTINATION "$ENV{HOME}/.config/google-chrome/NativeMessagingHosts")
  set (FIREFOX_MANIFEST_DESTINATION "$ENV{HOME}/.mozilla/native-messaging-hosts")
endif ()


set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
include (gdbus_codegen)

set (MPRIS_GENERATED_DIR "${PROJECT_BINARY_DIR}/mpris-generated")
if (NOT EXISTS "${MPRIS_GENERATED_DIR}")
  file (MAKE_DIRECTORY "${MPRIS_GENERATED_DIR}")
endif ()

set (MPRIS_SPEC_DIR "${PROJECT_SOURCE_DIR}/third-party/mpris-spec")

generate_gdbus_code (
  OUTPUT "${MPRIS_GENERATED_DIR}/mpris-core"
  INTERFACE "org.mpris"
  INPUT "${MPRIS_SPEC_DIR}/org.mpris.MediaPlayer2.xml"
  )

generate_gdbus_code (
  OUTPUT "${MPRIS_GENERATED_DIR}/mpris-player"
  INTERFACE "org.mpris"
  INPUT "${MPRIS_SPEC_DIR}/org.mpris.MediaPlayer2.Player.xml"
  )

add_executable (${PROJECT_NAME}
  "${MPRIS_GENERATED_DIR}/mpris-core.c"
  "${MPRIS_GENERATED_DIR}/mpris-player.c"
  src/util.c
  src/message.c
  src/proxy.c
  src/mpris2.c
  src/main.c
  )
set_property (TARGET ${PROJECT_NAME} PROPERTY C_STANDARD 99)

if (INSTALL_FOR_CURRENT_USER)
  set (CMAKE_INSTALL_PREFIX "$ENV{HOME}/.local")
endif ()

set (DEST_BINARY_DIR bin)
set (EXECUTABLE_PATH "${CMAKE_INSTALL_PREFIX}/${DEST_BINARY_DIR}/${PROJECT_NAME}")

if (ENABLE_CHROMIUM)
  configure_file (
    me.f1u77y.web_media_controller.chromium.json
    manifest/chromium/me.f1u77y.web_media_controller.json
    ESCAPE_QUOTES
  )
  install (
    FILES "${CMAKE_BINARY_DIR}/manifest/chromium/me.f1u77y.web_media_controller.json"
    DESTINATION "${CHROMIUM_MANIFEST_DESTINATION}"
    )
endif ()

if (ENABLE_CHROME)
  configure_file (
    me.f1u77y.web_media_controller.chromium.json
    manifest/chrome/me.f1u77y.web_media_controller.json
    ESCAPE_QUOTES
  )
  install (
    FILES "${CMAKE_BINARY_DIR}/manifest/chrome/me.f1u77y.web_media_controller.json"
    DESTINATION "${CHROME_MANIFEST_DESTINATION}"
    )
endif ()

if (ENABLE_FIREFOX)
  configure_file (
    me.f1u77y.web_media_controller.firefox.json
    manifest/firefox/me.f1u77y.web_media_controller.json
    ESCAPE_QUOTES
  )
  install (
    FILES "${CMAKE_BINARY_DIR}/manifest/firefox/me.f1u77y.web_media_controller.json"
    DESTINATION "${FIREFOX_MANIFEST_DESTINATION}"
    )
endif ()

install(
  TARGETS ${PROJECT_NAME}
  DESTINATION "${DEST_BINARY_DIR}"
  )

find_package (PkgConfig)
pkg_check_modules (GLIB2 REQUIRED glib-2.0)
pkg_check_modules (GIO_UNIX REQUIRED gio-unix-2.0)
pkg_check_modules (JSON_GLIB REQUIRED json-glib-1.0>=0.16)

target_include_directories (${PROJECT_NAME} PUBLIC
  include
  ${MPRIS_GENERATED_DIR}
  ${GLIB2_INCLUDE_DIRS}
  ${GIO_UNIX_INCLUDE_DIRS}
  ${JSON_GLIB_INCLUDE_DIRS}
  )

target_link_libraries (${PROJECT_NAME}
  ${GLIB2_LIBRARIES}
  ${GIO_UNIX_LIBRARIES}
  ${JSON_GLIB_LIBRARIES}
  m
  )
