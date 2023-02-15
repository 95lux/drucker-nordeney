import time
import serial

def create_connection(port, baudrate):
    connection = serial.Serial(
        port=port,
        baudrate=baudrate,
        parity=serial.PARITY_ODD,
        stopbits=serial.STOPBITS_TWO,
        bytesize=serial.SEVENBITS
    )
    return connection

# serial_connection = serial.create_connection(config.get_comport(), config.get_baudrate())
# serial_connection.isOpen()