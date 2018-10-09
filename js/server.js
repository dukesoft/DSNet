const ws_port = 8001;
const server_port = 8000;

const WebSocket = require('ws');

const ws = require("ws");
const net = require('net');

// Scream server example: "hi" -> "HI!!!"
const server = new ws.Server({port: ws_port});

console.log('Websocket server listening on port ' + ws_port);

server.on('connection', function (ws) {
        console.log("New connection");

        ws.on('message', function incoming(message) {
            console.log('received: %s', message);
            ws.send(message.toUpperCase()+"!!!");
        });
    }
);


/*
const client = new net.Socket();
client.connect(server_port, '127.0.0.1', function() {
    console.log('Connected to TCP server on port ' + server_port);
});

client.on('data', function(data) {
    console.log('Received: ' + data);
    client.destroy(); // kill client after server's response
});

client.on('close', function() {
    console.log('Connection closed');
});
*/