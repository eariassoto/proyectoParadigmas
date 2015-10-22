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
    
def getIndiceMatriz(s):
    return None;


url = getURL('2015', '02', '10', 'MROC');
pagina = urllib.request.urlopen(url).read().decode('utf-8');
datos = limpiarPagina(pagina);

a = [];
for i in range(24):
    a.append("-1");
print(a);

if(datos != None):
    datos = datos.splitlines();
    datos.pop(0);

    for linea in datos:
        d = linea.strip().split(":");
        print(d);
else:
    print(None);

