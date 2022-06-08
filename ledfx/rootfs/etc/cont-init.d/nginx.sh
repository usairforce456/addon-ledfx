#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: ledfx
# Configures NGINX
# ==============================================================================
declare admin_port

admin_port=$(bashio::addon.port 80)
if bashio::var.has_value "${admin_port}"; then
    bashio::config.require.ssl
    bashio::var.json \
    certfile "$(bashio::config 'certfile')" \
    keyfile "$(bashio::config 'keyfile')" \
    ssl "^$(bashio::config 'ssl')" \
    leave_front_door_open "^$(bashio::config 'leave_front_door_open')" \
    | tempio \
        -template /etc/nginx/templates/direct.gtpl \
        -out /etc/nginx/servers/direct.conf
fi
