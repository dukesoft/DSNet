let __dsnet__connections = [];
let __dsnet__socket_counter = 0;

let __dsnet_js_debug = false;
let __dsnet_js_verbose = false;

function dsnet_js_ws_supported() {
    return ("WebSocket" in window);
}

function dsnet_js_connect(host, port, receive_buffer) {
    if (!dsnet_js_ws_supported()) {
        alert("WebSockets are not supported by this browser.");
        return 0;
    }

    let connection = {
        host: host,
        port: port,
        connected: false,
        ws_handle: undefined,
        receive_buffer: receive_buffer,
        receive_buffer_view: new Uint8Array(receive_buffer, receive_buffer.byteOffset, receive_buffer.byteLength)
    };

    let mySocket = __dsnet__socket_counter;
    __dsnet__socket_counter++;

    __dsnet__connections[mySocket] = connection;

    // Let us open a web socket
    let wsProtocol = 'ws:';

    //if (location.protocol === "https:") {
    //    let wsProtocol = 'wss:';
    //}

    connection.ws_handle = new WebSocket(wsProtocol + '//'+host+':'+port, 'dsnet');

    connection.ws_handle.onopen = function() {
        connection.connected = true;
        if (__dsnet_js_debug) console.log('DSNET_WS: Connected to ' + host + ":" + port + " on socket " + mySocket);
        gml_Script_gmcallback_dsnet_connect(-1, -1, mySocket, connection.host);
    };

    connection.ws_handle.onmessage = function (evt) {
        if (__dsnet_js_debug)console.log('DSNET_WS: Received message from socket ' + mySocket + "; " + host + ":" + port + ":", evt.data);
        let fileReader = new FileReader();
        fileReader.onload = function(event) {
            let resultBuffer = event.target.result;
            let readBuffer = new Uint8Array(resultBuffer, resultBuffer.byteOffset, resultBuffer.byteLength);
            for (let i = 0; i < resultBuffer.byteLength; i++) {
                connection.receive_buffer_view[i] = readBuffer[i];
            }
            gml_Script_gmcallback_dsnet_data(-1, -1, mySocket,mySocket,  resultBuffer.byteLength);
        };
        fileReader.readAsArrayBuffer(evt.data);
    };

    connection.ws_handle.onclose = function() {
        if (__dsnet_js_debug) console.log('DSNET_WS: Connection to ' + host + ":" + port + " is lost.");
        connection.connected = false;
        gml_Script_gmcallback_dsnet_disconnect(-1, -1, mySocket);
    };

    return mySocket;
}

function dsnet_js_disconnect(socket) {
    if (__dsnet_js_debug) console.log("DSNET_WS: Disconnecting socket " + socket);
    __dsnet__connections[socket].ws_handle.close();
}

function dsnet_js_send(socket, buffer, length) {
    let newBuffer = new Uint8Array(buffer.slice(0,length));
    if (__dsnet_js_verbose) console.log("DSNET_WS: Sending: ", newBuffer);
    __dsnet__connections[socket].ws_handle.send(newBuffer);
}