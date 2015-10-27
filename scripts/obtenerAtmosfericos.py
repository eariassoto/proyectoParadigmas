import re;
import urllib.request;
import datetime;
from datetime import timedelta;

indexes = {'Showalter index': 3,
           'Lifted index': 4,
           'LIFT computed using virtual temperature': 5,
           'SWEAT index': 6,
           'K index': 7,
           'Cross totals index': 8,
           'Vertical totals index': 9,
           'Totals totals index': 10,
           'Convective Available Potential Energy': 11,
           'CAPE using virtual temperature': 12,
           'Convective Inhibition': 13,
           'CINS using virtual temperature': 14,
           'Equilibrum Level': 15,
           'Equilibrum Level using virtual temperature': 16,
           'Level of Free Convection': 17,
           'LFCT using virtual temperature': 18,
           'Bulk Richardson Number': 19,
           'Bulk Richardson Number using CAPV': 20,
           'Temp [K] of the Lifted Condensation Level': 21,
           'Pres [hPa] of the Lifted Condensation Level': 22,
           'Mean mixed layer potential temperature': 23,
           'Mean mixed layer mixing ratio': 24,
           '1000 hPa to 500 hPa thickness': 25,
           'Precipitable water [mm] for entire sounding': 26
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
    for i in range(27):
        dayRow.append("-1");

    dayRow[0] = a;
    dayRow[1] = m;
    dayRow[2] = d;
    
    url = getURL(a, m, d, e);
    pagina = urllib.request.urlopen(url).read().decode('utf-8');
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
        

        with open("../datos/datos-limpios/datos-atmosfericos.txt", mode='a') as file:
            file.write('%s\n' % (s));

while(actual.year != 1995):
    getDay(str(actual.year), str(actual.month), str(actual.day), 'MROC');
    # condicion decremento
    actual = actual-diferencia;

print("termine");



