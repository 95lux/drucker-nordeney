# import pip
# pip.main(["install", "win32printing"])

from http.server import *
import json
# import serial

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

        printer.print_data(print_string, config.get_printer_name(), config.get_max_jobs())

def check_requirements():
        if printer.check_font_installed() == False:
            print("[x] Required font has to be installed first! Program shutting down... ")
            exit()
        else:
            print("[✓] Font is installed to system")

        # if(printer.check_printer_available()){
        #     print("Printer not available! Program shutting down...")
        #     exit()
        # }

        print("[✓] Printer name: " + config.get_printer_name())
        print("[✓] Configured sentences: ".join(config.get_sentences()))


check_requirements()
port = HTTPServer(('', 5555), GFG)
print("server is running on :5555")
port.serve_forever()


