from win32printing import Printer

font = {
    "height": 8,
}

# print(Printer.get_default_printer_name())

def print_data(string):
    with Printer(linegap=1) as printer:
        printer.text(string, font_config=font)