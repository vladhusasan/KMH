from logging import error
import sys
from types import SimpleNamespace
from mysql.connector.errors import Error
import database as db
import json
from clase import User
from datetime import datetime

#MERGE
"""ALERTE full"""



def add_locatie(data):
    query= "INSERT INTO locatie (`latitudine`,`longitudine`,`nume`,`timp`,`punctaj`) VALUES ('"+data['latitudine']+"','"+data['longitudine']+"','"+data['nume']+"','"+str(datetime.now())+"','0')"
    try:
        return db.query_db(query)
    except:
        return "error"

def delete_locatie(data):
    query= " DELETE FROM locatie Where latitudine='"+data['latitudine']+"' and  longitudine='"+data['longitudine']+"' and nume='"+data['nume']+"'"
    try:
        return db.query_db(query)
    except:
        return "error"

def update_Locatie_Voturi(data):
    print(int(data['voturi']))
    if int(data['voturi'])<-1:
        return delete_locatie(data)
    else:
        query = "UPDATE locatie set punctaj="+data['voturi']+" where latitudine='"+data['latitudine']+"' and  longitudine='"+data['longitudine']+"' and nume='"+data['nume']+"'"
        try:
            return db.query_db(query)
        except:
            return "error"

def update_locatie_poz(data):
    query = "UPDATE locatie set latitudine="+data['latitudine']+",longitudine="+data['longitudine']+" where latitudine='"+data['latitudine_initiala']+"' and  longitudine='"+data['longitudine_initiala']+"' and nume='"+data['nume']+"'"
    return db.query_db(query)

def get_Alerte():
    query = "SELECT * FROM locatie"
    try:
        return db.query_db(query)
    except:
        return "error"


'''USER full'''
#GET
def get_users():
    query = "SELECT * FROM User"
    try:
        return db.query_db(query)
    except:
        return "error"
#LOGIN,GET
def login_user(name):
    query= "SELECT * FROM User Where nume = '"+name+"'"
    data=db.query_db(query)
    return User(data[0])
#POST
def add_user(nume,parola):
    query= "INSERT INTO User (`nume`,`pasw`) VALUES ('"+nume+"','"+parola+"')"
    try:
        return db.query_db(query)
    except:
        return "error"
#DELETE
def delete_user(name):
    query= " DELETE FROM User WHERE nume='"+name+"'"
    try:
        db.query_db(query)
    except:
        return "error"
