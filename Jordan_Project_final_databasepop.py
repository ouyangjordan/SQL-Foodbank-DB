import random

date = 053117
phone = 6041231000
starttime = 8.00
length = 1.05


#Food in our database
food = {'bread':'carbohydrate', 'beans':'protein', 'canned vegetables':'carbohydrate',
'olive oil':'fat', 'rice':'carbohydrate','peanut butter':'protein'} 


f = open("foodbankdata.sql","w+")

#Setting up our groups

f.write("insert into GroupE\n")
f.write("values('carbohydrate');\n\n")

f.write("insert into GroupE\n")
f.write("values('protein');\n\n")

f.write("insert into GroupE\n")
f.write("values('fat');\n\n")

for i in range(100):
    
    date = date + 1
    phone = phone + 1
    starttime = starttime + .05
    
    if(starttime > 17.00):
        starttime = 8.00
    
    length = length + .05
    
    if(length > 2):
        length = 1.05
       
       
    if (i % 2 == 0):
        medium = "cash"
    else:
        medium = "credit"
  
    #Collection_shift 
    f.write("insert into Collection_Shift\n")
    f.write("values('" + str(starttime) + "', '" + str(length) + "', 'A');\n\n") #should the letter change?
    
    #Money_collects
    f.write("insert into Mon_Collects\n")
    f.write("values('" + str(i) + "', '" + "donor" + str(i) + "', '" + str(phone) + "', '" + str(date) + "', '" )
    f.write(str(starttime) + "', '" + str(length) + "', 'A', '" + str(random.randint(1,999)) + "', '" + medium)
    f.write("');\n\n")
    
for i in range(100):
    
    date = date + 1
    phone = phone + 1
    starttime = starttime + .05
    
    if(starttime > 17.00):
        starttime = 8.00
    
    length = length + .05
    
    if(length > 2):
        length = 1.05

    #DID IS i + 100 !!!
    #Im pretty sure you could have done for i in range (100,200):
    
    f.write("insert into Collection_Shift\n")
    f.write("values('" + str(starttime) + "', '" + str(length) + "', 'A');\n\n") #should the letter change?
    
    f.write("insert into Item_Collects\n") 
    f.write("values('" + str(i + 100) + "', '" + "donor" + str(i + 100) + "', '" + str(phone) + "', '" + str(date) + "', '" )
    f.write(str(starttime) + "', '" + str(length) + "', 'A');\n\n")
    
    
    key, value = random.choice(list(food.items()))
    
    f.write("insert into Item\n")
    f.write("values('" + str(i + 100) + "', '" + key + "', '" + value + "', 'PantryA');\n\n")
    

#This will now populate the admins and the volunteers



f.write("insert into Administrator\n")
f.write("values('" + str(phone) + "', '" + "boss0', 'bosspass', 'topboss');\n\n")

phone = phone + 1

f.write("insert into Administrator\n")
f.write("values('" + str(phone) + "', '" + "boss1', 'bosspass', 'anothertopboss');\n\n")

phone = phone + 1

#all 100 volunteers will be connected to boss0 with the key topboss

for i in range(100):
    
    f.write("insert into volunteer_add\n")
    f.write("values('genericUser" + str(i) + "', 'topboss', '" + str(phone) + "', 'genericName" + str(i) + "', 'genericPass" + str(i) + "');\n\n")
    
    phone = phone + 1
    





     
     
     
f.close()