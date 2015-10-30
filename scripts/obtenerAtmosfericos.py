import re;
import urllib2;
import datetime;
from datetime import timedelta;

indexes = {'Showalter index': 3,
           'Lifted index': 4,
           'SWEAT index': 5,
           'K index': 6,
           'Cross totals index': 7,
           'Vertical totals index': 8,
           'Totals totals index': 9,
           'Convective Available Potential Energy': 10,
           'Convective Inhibition': 11,
           'Bulk Richardson Number': 12,
           'Precipitable water [mm] for entire sounding': 13
           };

actual = datetime.datetime.now();
diferencia = datetime.timedelta(days=1);

def getURL(a, m, d, e):
    return "http://weather.uwyo.edu/cgi-bin/sounding?region=naconf&TYPE=TEXT%3ALIST&YEAR=" + a + "&MONTH=" + m + "&FROM=" + d + "12&TO=" + d + "12&STNM=" + e;

def limpiarPagina(p):
    m = re.search('(.+)</H3><PRE>(.+)</PRE>(.+)', p, re.DOTALL);
    if m == None:
        return None
    else:
        return m.group(2);
    
def getMatrixIndex(s):
    return indexes.get(s);

def addToRow(d, dayRow):
    i = getMatrixIndex(d[0]);
    if i != None:
        dayRow[i] = d[1];

def getDay(a, m, d, e):
    dayRow = [];
    for i in range(14):
        dayRow.append("-1");

    dayRow[0] = a;
    dayRow[1] = m;
    dayRow[2] = d;
    
    url = getURL(a, m, d, e);
    pagina = urllib2.urlopen(url).read();
    datos = limpiarPagina(pagina);

    if(datos != None):
        datos = datos.splitlines();
        datos.pop(0);

        for linea in datos:
            d = linea.strip().split(":");
            addToRow(d, dayRow);

        s = "";
        for sub in dayRow:
            s = s + sub + " ";
        

        with open("../datos/datos-atmosfericos-"+e+".txt", mode='a') as file:
            file.write('%s\n' % (s));

def getDatos(e):
    actual = datetime.datetime.now();
    while(actual.year != 1995):
        getDay(str(actual.year), str(actual.month), str(actual.day), e);
        # condicion decremento
        actual = actual-diferencia;

getDatos('722202'); # Miami 
 
print("termine");



