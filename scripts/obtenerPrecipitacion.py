with open("../datos/datos-precipitacion-72451.txt") as f:
    datoG = "";
    for line in f:
        line.strip();
        words = line.split()
        help = words[2];
        year = help[0:4]
        month = help[4:6]
        day = help[6:8]
        datoF = year + " " + month + " " + day;
        
        
        if (words[25] == '99.99'):
            st1 = words[25] 
            st1 = '-1';
            datoF += " " + st1;
            
        else:
            st = words[25].strip(); 
            st = st[:-1]
            datoF += " " + st;

        datoG += datoF + "\n";
    with open("../datos/datos-limpios/datos-precipitacion-72451.txt", mode='a') as file:
        file.write('%s' % (datoG));
