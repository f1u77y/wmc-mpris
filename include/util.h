#pragma once

#include <glib.h>
#include <json-glib/json-glib.h>

gchar *
camelcase_to_dashes(const gchar *s);

gchar *
capitalize(const gchar *s);

gchar *
json_to_string(JsonNode *root, gboolean is_pretty);
