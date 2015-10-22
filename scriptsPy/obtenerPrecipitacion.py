with open("datos-ejemplo.txt") as f:
    datoG = "";
    for line in f:
        line.strip();
        words = line.split()
        help = words[2];
        year = help[0:4]
        month = help[4:6]
        day = help[6:8]
        datoF = year + " " + month + " " + day;
        
        
        if (words[19] == '99.99'):
            st1 = words[19] 
            st1 = '-1';
            datoF += " " + st1;
            
        else:
            st = words[19].strip(); 
            st = st[:-1]
            datoF += " " + st;

        datoG += datoF + "\n";
    print(datoG);