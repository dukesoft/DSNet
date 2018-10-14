const connections = [];

function dsnet_js_ws_supported() {
    return ("WebSocket" in window);
}

function dsnet_js_connect(host, port) {
    if (!dsnet_ws_supported()) {
        alert("WebSockets are not supported by this browser.");
        return 0;
    }

    let connection = {
        host: host,
        port: port,
        connected: false,
        ws_handle: undefined,
    };

    connections.push(connection);

    // Let us open a web socket
    connection.ws_handle = new WebSocket('ws://'+host+':'+port);

    connection.ws_handle.onopen = function() {
        connection.connected = true;
        console.log('Connected to ' + host + ":" + port);
    };

    connection.ws_handle.onmessage = function (evt) {
        console.log('Received message from ' + host + ":" + port + ":", evt.data);
        //connection.ws_handle.send(evt.data);
        gml_Script_gmcallback_dsnet_message(-1, -1, evt.data);
    };

    connection.ws_handle.onclose = function() {
        console.log('Connected to ' + host + ":" + port + " is lost.");
        connection.connected = false;
    };

    return connection;
}

function dsnet_js_send_buffer(socket, buffer) {
    socket.ws_handle.send(buffer);
}

/*
function dsnet_ws_send(connection, message) {
    connection.ws_handle.send(message);
}

function dsnet_test_buffer(buffer) {
    console.log(buffer);
}

function dsnet_test_callback() {
    console.log("Js got request for callback:");
    gmcallback_dsnet_message(-1, -1, "Is this a valid callback?");
}
*/