find_program (GDBUS_CODEGEN gdbus-codegen)
if (NOT GDBUS_CODEGEN)
  message (SEND_ERROR "Could not find gdbus-codegen program")
endif ()

function (generate_gdbus_code)
  set (OPTIONS GENERATE_OBJECT_MANAGER)
  set (ONE_VALUE_ARGS OUTPUT INTERFACE NAMESPACE GENERATE_AUTOCLEANUP INPUT)
  set (MUTLI_VALUE_ARGS)
  cmake_parse_arguments (ARG "${OPTIONS}"
                             "${ONE_VALUE_ARGS}"
                             "${MUTLI_VALUE_ARGS}"
                             ${ARGN}
    )
  set (GDBUS_OPTIONS )
  if ("${ARG_GENERATE_OBJECT_MANAGER}")
    set (GDBUS_OPTIONS ${GDBUS_OPTIONS} --c-generate-object-manager)
  endif ()
  # TODO depend on version
  #if ("${ARG_GENERATE_AUTOCLEANUP}")
    #set (GDBUS_OPTIONS ${GDBUS_OPTION} --c-generate-autocleanup ${ARG_GENERATE_AUTOCLEANUP})
  #else ()
    #set (GDBUS_OPTIONS ${GDBUS_OPTIONS} --c-generate-autocleanup none)
  #endif ()
  if ("${ARG_NAMESPACE}")
    set (GDBUS_OPTIONS ${GDBUS_OPTIONS} --c-namespace "${ARG_NAMESPACE}")
  endif ()
  add_custom_command (
    OUTPUT "${ARG_OUTPUT}.c" "${ARG_OUTPUT}.h"
    COMMAND ${GDBUS_CODEGEN} --generate-c-code "${ARG_OUTPUT}"
                             --interface-prefix "${ARG_INTERFACE}"
                             ${GDBUS_OPTIONS}
                             "${ARG_INPUT}"
    MAIN_DEPENDENCY "${ARG_INPUT}"
    )
endfunction ()
