import os
import winreg


def install_font(font_file_path):

    dirname = os.path.dirname(__file__)
    filename = os.path.join(dirname, "fonts/Felt Tip Roman.ttf")
    
    # Open the registry key where the font information is stored
    key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", 0,
                         winreg.KEY_ALL_ACCESS)

    # Get the name of the font file
    font_file_name = os.path.basename(font_file_path)

    # Set the font information in the registry
    winreg.SetValueEx(key, font_file_name, 0, winreg.REG_SZ, font_file_path)

    # Close the registry key
    winreg.CloseKey(key)


install_font(font_file_path)