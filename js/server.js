const ws_port = 8001;
const server_port = 8000;

const ws = require("ws");
const net = require('net');

// Scream server example: "hi" -> "HI!!!"
const server = new ws.Server({port: ws_port});

console.log('Websocket server listening on port ' + ws_port);

server.on('connection', function (ws) {
        console.log("New connection");

        //Setup connection to TCP server
        const client = new net.Socket();
        client.connect(server_port, '127.0.0.1', function() {
            console.log('Connected to TCP server on port ' + server_port);
        });

        client.on('close', function() {
            console.log('Connection to TCP closed');
            ws.close();
        });

        client.on('data', function(data) {
            console.log('Received from TCP:', data);
            ws.send(data);
        });

        ws.on('message', function incoming(message) {
            console.log('Received from WS:', message);
            let buffer = new Buffer.from(message);
            client.write(buffer);
        });

        ws.on('close', function close() {
            console.log('Connection to WS closed');
            client.destroy();
        });
    }
);
