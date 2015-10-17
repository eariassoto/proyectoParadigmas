import re;
import urllib2;

def getURL(a, m, d, e):
    return "http://weather.uwyo.edu/cgi-bin/sounding?region=naconf&TYPE=TEXT%3ALIST&YEAR=" + a + "&MONTH=" + m + "&FROM=" + d + "12&TO=" + d + "12&STNM=" + e;

def limpiarPagina(p):
    m = re.search('(.+)</H3><PRE>(.+)</PRE>(.+)', pagina, re.DOTALL);
    if m == None:
        return None
    else:
        return m.group(2);
    
    
url = getURL('2015', '10', '16', 'MROC');
pagina = urllib2.urlopen(url).read();



print limpiarPagina(pagina);



