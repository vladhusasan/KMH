import json
from flask import Flask, request
import queries as query

application = Flask(__name__)
app = application
application.config.update(dict(
    DATABASE="Datc",
    USERNAME="andrei",
    HOST="date.ccfx9begeize.eu-central-1.rds.amazonaws.com",
    PASSWORD="andreicm12"
))


@application.route("/")
def index():
    return application.send_static_file("index.html")

def add_locatie(data):
    return json.dumps({'success': 'success', 'results': query.add_locatie(data)})

def delete_locatie(data):
    return json.dumps({'success': 'success', 'results': query.delete_locatie(data)})

def update_locatie_voturi(data):
    return json.dumps({'success': 'success', 'results': query.update_Locatie_Voturi(data)})

def update_locatie_poz(data):
    return json.dumps({'success': 'success', 'results': query.update_locatie_poz(data)})

def get_Alerte(data):
    return json.dumps({'success': 'success', 'results': query.get_Alerte()})

#LOCATII
@application.route("/locatie", methods=["POST","GET","PATCH","DELETE","PUT"])
def locatie():
    data=request.json
    if request.method == "POST":
        return add_locatie(data)
    elif request.method == "PATCH":
        return update_locatie_voturi(data)
    elif request.method == "DELETE":
        return delete_locatie(data)
    elif request.method == "GET":
        return get_Alerte(data)
    elif request.method == "PUT":
        return update_locatie_poz(data)
    else:
        return json.dumps({'success': 'success', 'results': 'mai incearca :)'})
 
 #USERS
#PUT-update sau creeaza. POST adauga ,PATHC UPDATE resursa:https://nordicapis.com/crud-vs-rest-whats-the-difference/

def add_user(data):
    return json.dumps({'results': query.add_user(data['nume'],data['parola'])})

def update_user(data):
    query.update_User(data)
    user=query.login_user(data['nume'])
    if user.getParola()==data['parola']:
        return json.dumps({'result': 'success'})
    else:
        return json.dumps({'result':'error'})

def get_users():
    return json.dumps({'results': query.get_users()})

def delete_user(data):
    return json.dumps({'results': "succes" if query.delete_user(data['nume'])== "null" else "error"})

@application.route("/user",methods=["POST","PATCH","DELETE","GET"])
def pag():
    data=request.json
    if request.method == "POST":#adauga user
        return add_user(data)
    elif request.method == "PATCH":#update parola
        return update_user(data)
    elif request.method == "DELETE":#sterge cont
        return delete_user(data)
    elif request.method == "GET":#vezi toata baza de date
        return get_users()
    else:
        return json.dumps({'success': 'success', 'results': 'mai incearca :)'})

@application.route("/login", methods=["POST"])
def login_user():
    data=request.json
    #print(data['nume'])
    user=query.login_user(data['nume'])
    if user.getParola()==data['parola']:
        return json.dumps({'nume':data['nume'],'parola':data['parola'],'errorCode':''})
    else:
        return json.dumps({'nume':data['nume'],'parola':data['parola'],'errorCode':'parola'})
if __name__ == "__main__":
    application.run(host="0.0.0.0", port=1997)
