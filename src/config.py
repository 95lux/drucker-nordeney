from configparser import ConfigParser
  
conf = ConfigParser()
conf.read('config.ini')

def get_sentences():
    sentences = []

    for (each_key, each_val) in conf.items('sentences'):
        sentences.append(each_val)

    return sentences

def get_baudrate():
    conf.getint('com','baudrate')

def get_comport():
    conf.getint('com','comport')

def get_printer_name():
    return conf.get('printer', 'printername')

def get_max_jobs():
    return conf.get('printer', 'maxjobs')
