from win32printing import *

font = {
    "height": 8,
    "faceName": "Felt Tip"
}

# print(Printer.get_default_printer_name())

# print(get_system_fonts())

def check_font_installed():
    if "Felt Tip" in get_system_fonts():
        return True
    else: 
        return False
        
    

def print_data(string, printer_name):
    

    if not printer_name:
        printer_name = Printer.get_default_printer_name()
        
    with Printer(linegap=1, printer_name=printer_name) as printer:
        printer.text(string, font_config=font)