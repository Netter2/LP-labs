vault = {}
predicat = []
count = 0
mark = 0
with open ("./Tree5.ged", "r") as text:
    l = text.readline ()
    while l:
        if (l [:4] == "0 @I"):
            Id = int (l [4:l.rfind ("@")])
            mark = 1
        if ((l [:6] == "1 NAME") and (mark == 1)):
            name =  l [7:l.find ("/") - 1] + "_" + l [l.find ("/") + 1:l.rfind ("/")]
            vault [Id] = name
            mark = 0
        if (l [:4] == "0 @F"):
            while (l [:6] != "1 HUSB") and (l [:6] != "1 WIFE"):
                l = text.readline ()
            while (1):
                if (l [:6] == "1 HUSB"):
                    father = int (l [9:l.rfind ("@")])
                if (l [:6] == "1 WIFE"):
                    mother = int (l [9:l.rfind ("@")])
                if (l [:6] == "1 CHIL"):
                    while (l [:6] == "1 CHIL"):
                        person = int (l [9:l.rfind ("@")])
                        predicat.append ("parents('" + vault [person] + "', '" + vault [father] + "', '" + vault [mother] + "').")
                        print (predicat [count])
                        count = count + 1
                        l = text.readline ()
                    break
                l = text.readline ()
        l = text.readline ()
with open ("./Out.txt", "w") as output:
    for i in range (count):
        print (predicat [i], file = output)
    