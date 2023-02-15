
from http.server import *
import json

import serial
import config
import printer

class GFG(BaseHTTPRequestHandler):
    
    def do_POST(self):
        # self._set_headers()
        self.data_string = self.rfile.read(int(self.headers['Content-Length']))
        print(self.data_string)
        self.send_response(200)
        self.end_headers()
        data = json.loads(self.data_string)
        name = data['name']
        score = data['score']
        sentences = config.get_sentences()

        if score <= 20:
            print_string = sentences[0] + " " + name + "!"
        elif score <= 40:
            print_string = sentences[1] + " " + name + "!"
        elif score <= 60:
            print_string = sentences[2] + " " + name + "!"
        elif score > 61:
            print_string = sentences[3] + " " + name + "!"

        printer.print_data(print_string)

port = HTTPServer(('', 5555), GFG)
port.serve_forever()


