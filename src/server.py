import serial
import config
from http.server import *
import json

class GFG(BaseHTTPRequestHandler):
    
    def do_POST(self):
        # self._set_headers()
        self.data_string = self.rfile.read(int(self.headers['Content-Length']))
        print(self.data_string)
        self.send_response(200)
        self.end_headers()
        data = json.loads(self.data_string)
        name = data.name
        score = data.score
        sentences = config.get_sentences()
        

# serial_connection = serial.create_connection(config.get_comport(), config.get_baudrate())
# serial_connection.isOpen()
port = HTTPServer(('', 5555), GFG)
port.serve_forever()


