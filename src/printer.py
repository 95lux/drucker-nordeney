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

def print_data(string, printer_name, max_jobs):
    if not printer_name:
        printer_name = Printer.get_default_printer_name()
    
    
    
    string = "\n \n \n \n          " + string

    with Printer(linegap=1, printer_name=printer_name) as printer:
        printer.text(string, font_config=font)
        
        jobs = printer.get_jobs()
        num_jobs = len(jobs) 
        if num_jobs >= max_jobs:
            for i in range(0, num_jobs - max_jobs):
                printer.del_job(jobs[i].get("JobId"))
        jobs = printer.get_jobs()
        for job in jobs:
            print(job.get("JobId"))
        

# print_data("hallo", "Boca BIDI FGL 26/46 200 DPI")
# def check_printer_available():
