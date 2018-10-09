const connections = [];

function dsnet_ws_supported() {
    return ("WebSocket" in window);
}

function dsnet_ws_connect(host, port) {
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
    };

    connection.ws_handle.onclose = function() {
        console.log('Connected to ' + host + ":" + port + " is lost.");
        connection.connected = false;
    };

    return connection;
}

function dsnet_ws_send(connection, message) {
    connection.ws_handle.send(message);
}