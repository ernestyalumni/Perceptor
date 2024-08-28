import asyncio
from aioquic.asyncio import connect
from aioquic.quic.configuration import QuicConfiguration
from aioquic.quic.events import HandshakeCompleted, StreamDataReceived


class SimpleQuicClientProtocol(QuicConnectionProtocol):
    def quic_event_received(self, event):
        if isinstance(event, HandshakeCompleted):
            print("Handshake completed with server")
            self._quic.send_stream_data(0, b"Hello, QUIC!")
            self._quic.send_stream_data(0, b"", end_stream=True)
        elif isinstance(event, StreamDataReceived):
            print(f"Data received on stream {event.stream_id}: {event.data}")
            self._quic.send_stream_data(event.stream_id, b"Echo: " + event.data)
            self._quic.send_stream_data(event.stream_id, b"", end_stream=True)


async def run_client():
    configuration = QuicConfiguration(is_client=True)
    async with connect(
        "localhost", 4433, configuration=configuration, create_protocol=SimpleQuicClientProtocol
    ) as protocol:
        await protocol._quic.wait_for_connection_closed()


if __name__ == "__main__":
    asyncio.run(run_client())
