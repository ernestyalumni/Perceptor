import asyncio
from aioquic.asyncio import QuicConnectionProtocol, serve
from aioquic.asyncio.protocol import QuicConnection, QuicListener
from aioquic.asyncio.server import QuicServer
from aioquic.asyncio.tls import SessionTicketFetcher
from aioquic.asyncio.utils import create_standalone_client_and_server
from aioquic.quic.configuration import QuicConfiguration
from aioquic.quic.events import HandshakeCompleted, StreamDataReceived


class SimpleQuicServerProtocol(QuicConnectionProtocol):
    def quic_event_received(self, event):
        if isinstance(event, HandshakeCompleted):
            print("Handshake completed with client")
        elif isinstance(event, StreamDataReceived):
            print(f"Data received on stream {event.stream_id}: {event.data}")
            self._quic.send_stream_data(event.stream_id, b"Echo: " + event.data)
            self._quic.send_stream_data(event.stream_id, b"", end_stream=True)


async def run_server():
    configuration = QuicConfiguration(is_client=False)
    server = await serve(
        "localhost", 4433, configuration=configuration, create_protocol=SimpleQuicServerProtocol
    )
    await server.wait_closed()


if __name__ == "__main__":
    asyncio.run(run_server())
