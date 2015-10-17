import datetime;
from datetime import timedelta;

actual = datetime.datetime.now();
diferencia = datetime.timedelta(days=1);


while(actual.year != 2014):
    print actual.year, actual.month, actual.day;


    # condicion decremento
    actual = actual-diferencia; 

