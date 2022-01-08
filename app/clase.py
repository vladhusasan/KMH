import json
class User:
    def __init__(self,user):
        self.nume=user['nume']
        self.parola=user['pasw']
    def getNume(self):
        return self.nume
    def getParola(self):
        return self.parola
class Locatie:
    def __init__(self,UserId,latitudine,longitudine,voturi,data):
        self.UserId=UserId
        self.latitudine=latitudine
        self.longitudine=longitudine
        self.voturi=voturi
        self.data=data
    def getName(self):
        return self.name
    def getLocatie(self):
        return {"latitudine" : self.latitudine,"longitudine": self.longitudine}
    def getVoturi(self):
        return self.voturi