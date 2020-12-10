#performing flask imports
from flask import Flask,jsonify, render_template, url_for
from flask_cors import CORS
from functools import update_wrapper
import routeros_api
 #returning key-value pair in json format

# --------------------------------


# RouterOS goes here
connection = routeros_api.RouterOsApiPool(
    "10.251.255.11",
    username="CIS-API",
    password="nXa8zqz9c4zSFvBglsT8WnGM16DwEnBu5fwfAd2BFrVr2cYzFjjksRrib8UwFate0V6ALka5U6Q7Ktepb2pCib2gDL6b0URWprYq",
    plaintext_login=True
)

# api variable. Use to get values from the router
api = connection.get_api()

# get information from the router and store in variables
# ?System_ID
system_identity = (api.get_resource('/system/identity').get()[0]['name'])

# IP SCHEME
# ip_scheme = ("IP Scheme: " + api.get_resource('ip/dhcp-server/network')
#                    .get(comment='Operations')[0]['address'])

# PUBLLIC_ADDRESS
public_addr = ("Public IP Address: " + api.get_resource('ip/cloud')
                     .get()[0]['public-address'])
# SECRET AND CREDS
ppp_user = ("VPN User: " + api.get_resource('ppp/secret')
                     .get()[2]['name'])
# SECRET AND CREDS
ppp_pass = ("VPN Pass: " + api.get_resource('ppp/secret')
                     .get()[2]['password'])
# SyStem_version
version = ("Version : " + api.get_resource('system/routerboard')
                     .get()[0]['current-firmware'])


# PAR ADDRESS
par = ("PAR: " + api.get_resource('ip/address')
                   .get(interface='PAR')[0]['address'])
par2 = par.replace('/32', '')

# ----------------------------------

app = Flask(__name__) #intance of our flask application 

#Route '/' to facilitate get request from our flutter app
CORS(app) 
@app.route('/', methods = ['GET'])

def index():
    #  //here First Variable is variable used in flutter app and second is Used in Python App
     return jsonify({'identity' : system_identity, 'public' : public_addr, 'version' : version, 'ppp_user' : ppp_user, 'ppp_pass' : ppp_pass, 'par' : par2 }) #returning key-value pair in json format    
    # return jsonify({'greetings' : 'Hi! this is pythonbn'}) #returning key-value pair in json format
    

if __name__ == "__main__":
    app.run(debug = True) #debug will allow changes without shutting down the server 

