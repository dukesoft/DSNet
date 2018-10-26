let __dsnet__connections = [];
let __dsnet__socket_counter = 0;
function dsnet_js_ws_supported() {
    return ("WebSocket" in window);
}

function dsnet_js_connect(host, port) {
    if (!dsnet_js_ws_supported()) {
        alert("WebSockets are not supported by this browser.");
        return 0;
    }

    let connection = {
        host: host,
        port: port,
        connected: false,
        ws_handle: undefined,
    };
    let mySocket = __dsnet__socket_counter;
    __dsnet__socket_counter++;

    __dsnet__connections[mySocket] = connection;

    // Let us open a web socket
    connection.ws_handle = new WebSocket('ws://'+host+':'+port, 'dsnet');

    connection.ws_handle.onopen = function() {
        connection.connected = true;
        console.log('DSNET_WS: Connected to ' + host + ":" + port + " on socket " + mySocket);
        gml_Script_gmcallback_dsnet_connect(-1, -1, mySocket, connection.host);
    };

    connection.ws_handle.onmessage = function (evt) {
        console.log('DSNET_WS: Received message from socket ' + mySocket + "; " + host + ":" + port + ":", evt.data);
        //connection.ws_handle.send(evt.data);
        gml_Script_gmcallback_dsnet_data(-1, -1, mySocket, mySocket, evt.data);
    };

    connection.ws_handle.onclose = function() {
        console.log('DSNET_WS: Connection to ' + host + ":" + port + " is lost.");
        connection.connected = false;
        gml_Script_gmcallback_dsnet_disconnect(-1, -1, mySocket);
    };

    return mySocket;
}

function dsnet_js_send(socket, buffer) {
    __dsnet__connections[socket].ws_handle.send(buffer);
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