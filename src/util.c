#include <glib.h>
#include <string.h>
#include <ctype.h>
#include <json-glib/json-glib.h>

gchar *
camelcase_to_dashes(const gchar *s) {
    gchar *result = g_new(gchar, strlen(s) * 2 + 1);
    gchar *cur = result;
    for (; *s != 0; ++s) {
        if (isupper(*s)) {
            *(cur++) = '-';
        }
        *(cur++) = tolower(*s);
    }
    *cur = 0;
    return result;
}

gchar *
capitalize(const gchar *s) {
    gchar *result = g_strdup(s);
    if (strlen(result) > 0) {
        result[0] = toupper(result[0]);
    }
    return result;
}

gchar *
json_to_string(JsonNode *root, gboolean is_pretty) {
    JsonGenerator *gen = json_generator_new();
    json_generator_set_root(gen, root);
    json_generator_set_pretty(gen, is_pretty);
    gchar *result = json_generator_to_data(gen, NULL);
    return result;
}
