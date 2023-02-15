from win32printing import Printer

font = {
    "height": 8,
}

# print(Printer.get_default_printer_name())

def print_data(string, printer_name):
    if not printer_name:
        printer_name = Printer.get_default_printer_name()
        
    with Printer(linegap=1, printer_name=printer_name) as printer:
        printer.text(string, font_config=font)