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
