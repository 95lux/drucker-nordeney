from win32 import win32api
from win32 import win32print
from pythonwin.win32ui import *
import win32ui  

import config

def set_printer(printer_name):
    win32print.SetDefaultPrinter(printer_name)

def get_printer():
    return win32print.GetDefaultPrinter()

def open_printer(printer_name):
    return win32print.OpenPrinter(printer_name)

def print_data(string):
    string = "\n \n \n \n          " + string
    

    # U must install pywin32 and import modules:
    # X from the left margin, Y from top margin 
    # both in pixels
    X=50; Y=50
    # Separate lines from Your string 
    # for example:input_string and create 
    # new string for example: multi_line_string 
    multi_line_string = string.splitlines()  
    hDC = win32ui.CreateDC ()
    # Set default printer from Windows:
    win32print.StartDoc(hDC, ("doc", None, None, 0))
    hDC.StartPage ()
    for line in multi_line_string:
        hDC.TextOut(X,Y,line)
        Y += 100
    hDC.EndPage ()
    hDC.EndDoc ()


    # win32api.ShellExecute(0, "print", string, None, ".", 0)

# printer_handle = open_printer(config.get_printer_name())
set_printer(config.get_printer_name())
print_data("Hallo mein name ist jonehrs")