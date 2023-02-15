import serial
import config
from http.server import *

class GFG(BaseHTTPRequestHandler):
    
    def do_GET(self):
        # Success Response --> 200
        self.send_response(200)
        self.send_header('content-type', 'text/html')
        self.end_headers()
        html = '<h1>' + self.path + '</h1>'
        self.wfile.write(html.encode())
        handle_request(self.path)

def handle_request(path):
    split_string = path.split('/')
    name = split_string[1]
    punkte = split_string[2]
    imput = name + punkte
    serial.connection.write(input + '\r\n')

serial_connection = serial.create_connection(config.get_comport(), config.get_baudrate())
serial_connection.isOpen()
port = HTTPServer(('', 5555), GFG)
port.serve_forever()


