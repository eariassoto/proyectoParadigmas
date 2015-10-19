import re;
import urllib.request;

def getURL(a, m, d, e):
    return "http://weather.uwyo.edu/cgi-bin/sounding?region=naconf&TYPE=TEXT%3ALIST&YEAR=" + a + "&MONTH=" + m + "&FROM=" + d + "12&TO=" + d + "12&STNM=" + e;

def limpiarPagina(p):
    m = re.search('(.+)</H3><PRE>(.+)</PRE>(.+)', pagina, re.DOTALL);
    if m == None:
        return None
    else:
        return m.group(2);
    
    
url = getURL('2008', '09', '13', 'MROC');
pagina = urllib.request.urlopen(url).read().decode('utf-8');


#print(pagina);
print(limpiarPagina(pagina));



