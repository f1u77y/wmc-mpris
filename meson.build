project('web-media-controller-mpris', 'c',
        default_options: ['c_std=c99'],
        version: '0.1.0',
        license: 'Unlicense')

gnome = import('gnome')
cc = meson.get_compiler('c')

m_dep = cc.find_library('m', required: false)
glib_dep = dependency('glib-2.0', required: true)
gio_unix_dep = dependency('gio-unix-2.0', required: true)
json_glib_dep = dependency('json-glib-1.0', required: true)

wmc_deps = [m_dep, glib_dep, gio_unix_dep, json_glib_dep]

mpris2_core_src = gnome.gdbus_codegen('mpris-core',
  sources: 'third-party/mpris-spec/org.mpris.MediaPlayer2.xml',
  interface_prefix: 'org.mpris.',
)

mpris2_player_src = gnome.gdbus_codegen('mpris-player',
  sources: 'third-party/mpris-spec/org.mpris.MediaPlayer2.Player.xml',
  interface_prefix: 'org.mpris.',
)

wmc_exe_name = 'web-media-controller-mpris'
wmc_exe = executable(wmc_exe_name,
  mpris2_core_src,
  mpris2_player_src,
  'src/main.c',
  'src/message.c',
  'src/mpris2.c',
  'src/proxy.c',
  'src/util.c',

  include_directories: include_directories('include'),
  dependencies: wmc_deps,
  install: true,
)

config_data = configuration_data({
  'EXECUTABLE_PATH': get_option('prefix') / get_option('bindir') / wmc_exe_name
})

configure_file(input: 'me.f1u77y.web_media_controller.firefox.json',
               output: '@PLAINNAME@',
               configuration: config_data)
install_data(meson.build_root() / 'me.f1u77y.web_media_controller.firefox.json',
             install_dir: '/usr/lib/mozilla/native-messaging-hosts',
             rename: 'me.f1u77y.web_media_controller.json')

configure_file(input: 'me.f1u77y.web_media_controller.chromium.json',
               output: '@PLAINNAME@',
               configuration: config_data)
install_data(meson.build_root() / 'me.f1u77y.web_media_controller.chromium.json',
             install_dir: '/etc/opt/chrome/native-messaging-hosts',
             rename: 'me.f1u77y.web_media_controller.json')
install_data(meson.build_root() / 'me.f1u77y.web_media_controller.chromium.json',
             install_dir: '/etc/chromium/native-messaging-hosts',
             rename: 'me.f1u77y.web_media_controller.json')
