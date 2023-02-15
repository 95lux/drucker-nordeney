from win32printing import Printer

font = {
    "height": 8,
}

print(Printer.get_default_printer_name())
with Printer(linegap=1, printer_name="HP OfficeJet Pro 7740 series PCL-3") as printer:
    printer.text("test123", font_config=font)
    # printer.text("title2", font_config=font)
    # printer.text("title3", font_config=font)
    # printer.text("title4", font_config=font)
    # printer.new_page()
    # printer.text("title5", font_config=font)
    # printer.text("title6", font_config=font)
    # printer.text("title7", font_config=font)
    # printer.text("title8", font_config=font)