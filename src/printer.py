from win32printing import *

font = {
    "height": 15,
    "faceName": "Felt Tip",
}

def check_font_installed():
    if "Felt Tip" in get_system_fonts():
        return True
    else: 
        return False

def print_data(string, printer_name):
    if not printer_name:
        printer_name = Printer.get_default_printer_name()
    
    
    
    string = "\n \n \n \n          " + string

    with Printer(linegap=1, printer_name=printer_name) as printer:
        printer.text(string, font_config=font)
        print(printer.get_jobs())
        printer.del_jobs()
        

print_data("hallo", "Boca BIDI FGL 26/46 200 DPI")
# def check_printer_available():
