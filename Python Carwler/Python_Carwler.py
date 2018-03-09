#-----------------------------------------------------------------------------------------

#Se importan las librerias

#pip install request
#pip install lxml

#-----------------------------------------------------------------------------------------

from datetime import datetime
from datetime import timedelta

#Para tranformar el número a formato de la máquina en la que se corre el código
import locale

# Set to users preferred locale:
locale.setlocale(locale.LC_ALL, '')

#Para usar try 
import sys

#Web Crawler
import urllib
from html.parser import HTMLParser
from urllib.request import urlopen
from urllib.request import urlretrieve

from lxml.html import parse
import json

from lxml import html

#gzip
import gzip

#xlm
from xml.dom import minidom

#import regular expresions
import re

#import request
import requests



#-----------------------------------------------------------------------------------------

#Se Generan las Clases

#-----------------------------------------------------------------------------------------



#*****************************************************************************************
#************* Clase que permite descargar una página WEB y buscar la información en el HTML
#*****************************************************************************************

class Parser_PI(HTMLParser):
    doc=""
    strParsed="a"

    def __init__(self, url):
        
        temp_file="temp.html"
        urllib.request.urlretrieve(url, temp_file)
        
        with open(temp_file, 'r') as myfile:
            data=myfile.read().replace('\n', '')
            
        parsed = parse(temp_file)
        self.doc = parsed.getroot()
        self.strParsed="" +data

    def getData(self,tag,key,value,nstop=1):
##        Parser.getData(url,"p","class","price")
        txt="error"
        counter=1
        datas=self.doc.findall('.//'+tag)
##        txt=str(datas[1].text_content())
        for d in datas:
            if d.get(key)==value:
                counter+=1
                txt=str(d.text_content())
                if counter>nstop:
                    break
        return txt

    def getScriptData(self,firstVar,secondVarA,secondVarB):
        found=""
        JsonVar = re.compile(firstVar+'({.*?});', re.DOTALL)
        matches = JsonVar.search(self.strParsed)
        str1=matches.group(1)        
        m = re.search(secondVarA+'(.+?)'+secondVarB, str1)        
        if m:
            found = m.group(1)
        return found

    def getJsonData(self):
        data = json.loads(self.strParsed)
        return data

#*****************************************************************************************
#************* Clase controla el SiteMAp
#*****************************************************************************************

class SiteMapManager:
    lista_Links=list()
    #self.lista_XML=list()
    
    def __init__(self, urlSiteMap,fileSiteMap):
        self.urlSiteMap = urlSiteMap
        self.fileSiteMap = fileSiteMap
        self.downloadSiteMap()
        self.processSiteMap()

    def downloadSiteMap(self):
        urllib.request.urlretrieve(self.urlSiteMap, self.fileSiteMap)
        xmldocSiteMap = minidom.parse(self.fileSiteMap)
        self.SystemsList = xmldocSiteMap.getElementsByTagName('sitemap')
        print("Total Sistemas: " +str (len(self.SystemsList)))

    def processSiteMap(self):
        self.lista_Links.append('http://www.portalinmobiliario.com/sitemaps/sitemappropiedades.xml.gz')
        self.lista_Links.append('http://www.portalinmobiliario.com/sitemaps/sitemappropiedades1.xml.gz')
        self.lista_Links.append('http://www.portalinmobiliario.com/sitemaps/sitemappropiedades2.xml.gz')
        self.lista_Links.append('http://www.portalinmobiliario.com/sitemaps/sitemappropiedades3.xml.gz')
        self.lista_Links.append('http://www.portalinmobiliario.com/sitemaps/sitemappropiedades4.xml.gz')
        self.lista_Links.append('http://www.portalinmobiliario.com/sitemaps/sitemappropiedades5.xml.gz')
        self.lista_Links.append('http://www.portalinmobiliario.com/sitemaps/sitemappropiedades6.xml.gz')
##        for s in self.SystemsList:
##            loc=s.getElementsByTagName('loc')[0].childNodes[0].data
##            if "sitemappropiedades" in loc:
##                self.lista_Links.append(loc)

    def getlista_Links(self):
        return self.lista_Links
    
#*****************************************************************************************
#************* Clase que descomprime un .zip a .txt
#*****************************************************************************************

class GZipManager:
    def unzip(self,gZip_in,txtFile_out):

        f_in=gzip.open(gZip_in, 'rb')
        f_out=open(txtFile_out, 'wb')
        f_out.write(f_in.read())
        f_out.close()

#*****************************************************************************************
#************* Clase que define el objeto Propiedad. Se necesita la URL y la última modificación.
#*****************************************************************************************

class oPropiedad:
    propCount = 0
    formatoFecha='%Y-%m-%d'
    col_div="\t"
    valouUF=26646
    
    #Se inicializa la instancia (info de URL y XML)
    def __init__(self, loc,lastmod):
        #datos xml
        self.loc = loc
        self.lastmod = lastmod

        #datos básicos desde URL
        self.codigo0=re.findall(r'\d+|$',loc)[0]
        detalleURL=re.findall(r'(?<=\/)(.*)(?<=\/)',loc)[0].split("/")
        self.operacion=detalleURL[2]
        self.tipopropiedad=detalleURL[3]

        #datos ubicación desde URL
        self.sector=detalleURL[4]
        self.getComunaRegion(self.sector)

        oPropiedad.propCount += 1

    #Retorna la cantidad de propiedades creadas
    def displayCount(self):
        return "Total Propiedades %d" % oPropiedad.propCount

    def getComunaRegion(self,strSector):
        regiones=['-metropolitana','-valparaiso','-biobio','-magallanes-y-antartica-chilena','-bernardo-ohiggins','-antofagasta','-la-araucania','-coquimbo','-de-los-rios','-arica-y-parinacota','-maule','-aysen','-los-lagos','-tarapaca','-atacama']
        self.comuna=""
        self.region=""
        try:
            contained = [x for x in regiones if x in strSector]
            self.region=contained[0]
            self.comuna=strSector.replace(self.region,"")      
        except:
            #print (self.loc)
            pass

    #Descarga la información adicional del html desde PI
    def downloadDatosBasicos(self, Parser):   
        self.codigo=Parser.getData("p","class","operation-internal-code").replace("Código: ", "")
        self.publicacion=Parser.getData("p","class","operation-internal-code",2).replace("Publicada: ", "")
        self.precio=re.sub(r'[^0-9]',"",Parser.getData("p","class","price"))

    #Descarga la información adicional del html desde PI
    def downloadDatosUbicacion(self, Parser):
        self.direccion=re.sub(r'\s+',' ',re.sub(r'\n', " " ,Parser.getData("div","class","data-sheet-column data-sheet-column-address"))).replace(" Dirección ", "")

    #Descarga la información adicional del html desde PI
    def downloadDatosPropiedad(self, Parser):

        self.programa=re.sub(r'\s+',' ',re.sub(r'\n', " " ,Parser.getData("div","class","data-sheet-column data-sheet-column-programm"))).replace(" Programa ", "").replace("&nbsp"," ")
        self.superficie=re.sub(r'\s+',' ',re.sub(r'\n', " " ,Parser.getData("div","class","data-sheet-column data-sheet-column-area"))).replace(" Superficie ", "").replace("&nbsp"," ")
        self.descripcion=re.sub(r'\"',"",re.sub(r'\s+',' ',re.sub(r'\n', " " ,Parser.getData("div","class","propiedad-descr"))).replace("&nbsp"," "))

        # Datos para casa
        #Superficie Construida
        #Superficie Terreno
        detalleSup=re.findall(r'[-+]?\d*\.\d+|\d+',self.superficie)

        self.detalleSupConstruida="0"
        self.detalleSupTerreno="0"

        try:
            self.detalleSupConstruida=re.sub(r'[^0-9]',"",detalleSup[0])
            self.detalleSupTerreno=re.sub(r'[^0-9]',"",detalleSup[1])
        except:
            pass
    def downloadDatosScrip(self, Parser):

        self.lat=Parser.getScriptData('var PageOpts = ','lat:',',')
        self.lng=Parser.getScriptData('var PageOpts = ','lng:','}')
        self.nombreVendedor=Parser.getScriptData('var datosContacto = ','nombreVendedor :',',').replace("\"","")
        #self.telefonosVendedor=Parser.getScriptData('var datosContacto = ','telefonosVendedor:',',')
        self.emailVendedor=Parser.getScriptData('var datosContacto = ','emailVendedor :','}').replace("\"","")
        
        
#datos Crawler
#datos básicos
#Detalle propiedad
#Equipamiento
#Ubicación
#Contacto

    #Retorna la información básica de la propiedad (info de URL y XML)
    def displayDatosCrawler(self):
        col_div=self.col_div
        return self.loc + col_div + self.lastmod.strftime(formatoFecha) + col_div
        #loc;lastmod;
    
    def displayDatosSector(self):
        return self.sector + col_div + self.comuna + col_div + self.region
        
    def displayDatosBasicos(self):
        col_div=self.col_div
        return self.codigo0 + col_div + self.codigo + col_div + self.publicacion + col_div + self.tipopropiedad + col_div + self.operacion + col_div + self.precio + col_div
        #codigo0;codigo;publicacion;Tipo_Propiedad;Operacion;precio;

    def displayDatosUbicacion(self):
        col_div=self.col_div
        return self.sector + col_div + self.direccion+ col_div
        #sector;direccion

    def displayPropiedad(self):
        col_div=self.col_div
        precioUF=float(self.precio)/float(self.valouUF)
        try:
            valorM2UFTerreno=locale.format('%.2f',(precioUF)/float(self.detalleSupTerreno))
        except:        
            valorM2UFTerreno='0'
            pass
        return self.displayDatosCrawler() + self.displayDatosBasicos() + self.displayDatosUbicacion() + self.programa + col_div + self.superficie + col_div + self.descripcion + col_div + self.detalleSupConstruida + col_div + self.detalleSupTerreno + col_div + locale.format('%.0f',(precioUF)) + col_div + valorM2UFTerreno + col_div + self.displayDatosScript()
        #programa;superficie;descripcion

    def displayDatosScript(self):        
        return locale.format('%.2f',float(self.lat)) + col_div + locale.format('%.2f',float(self.lng)) + col_div + self.nombreVendedor + col_div + self.emailVendedor + col_div

    def displayPostData(self):
        payload = {'url': self.loc, 'codigo': self.codigo0, 'operacion': self.operacion,
                   'tipo': self.tipopropiedad,'publicacion':self.publicacion, 'precio':self.precio,
                   'sector':self.sector,'comuna':self.comuna,'region':self.region, 'direccion':self.direccion, 'programa':self.programa, 'superficie':self.superficie,
                   'descripcion':self.descripcion, 'sup_construida':self.detalleSupConstruida, 'sup_terreno':self.detalleSupTerreno,
                   'lat':self.lat, 'lng':self.lng, 'contacto':self.nombreVendedor, 'correo':self.emailVendedor}
        return payload
#-----------------------------------------------------------------------------------------

#SCRIP PROGRAMA

#-----------------------------------------------------------------------------------------

print("Se inicia el programa")

# Flujo:
# 1_ http://www.portalinmobiliario.com/robots.txt
# 2_ ver el site map -->Sitemap http://www.portalinmobiliario.com/sitemaps/sitemapindex.xml
# 3_ descargar todos los xml (Sistema de propiedades)
# 4_ descomprimir el gzip
# 5_ Recorrer toda la lista de propiedades
# 6_ Recolectar la información de cada propiedad
# 7_ Guardar la información en la base de datos

#-----------------------------------------------------------------------------------------

# VARIABLES GENERALES

#-----------------------------------------------------------------------------------------


#exit()

#Parametros______________
formatoFecha='%Y-%m-%d'
dias_crawler=100
col_div="\t"
n=0
p=0


tempFolder="TEMP\\"
urlSiteMap="http://www.portalinmobiliario.com/sitemaps/sitemapindex.xml"
fileSiteMap=tempFolder+"sitemapindex.xml"
outFile2="final.txt"
api_url_base='http://localhost:3000'
#api_url_base = 'http://www.hushas.cl'
api_url_new = api_url_base+'/api/new_pi'
api_url_find = api_url_base+'/api/buscarcodigo?codigo='

#Objetos______________
gz=GZipManager()
lista_propiedades=list()
lista_LinksProp=list()

#se escriben los headers______________
f_out=open(outFile2, 'w')
f_out.write("loc"+col_div+"lastmod"+col_div)
f_out.write("codigo0"+col_div+"codigo"+col_div+"publicacion"+col_div+"Tipo_Propiedad"+col_div+"Operacion"+col_div+"precio"+col_div)
f_out.write("sector"+col_div+"direccion"+col_div)
f_out.write("programa"+col_div+"superficie"+col_div+"descripcion"+col_div+"detalleSupConstruida"+col_div+"detalleSupTerreno"+col_div)
f_out.write("precioUF"+col_div+"UFxM2"+col_div)
f_out.write('lat'+col_div+ 'lng'+col_div+'nombreVendedor'+col_div+'emailVendedor'+col_div)
f_out.write("\n")

# 1_ABRIR ROBOT __________________________________________________________________________

# 2_ABRIR SITEMAP ________________________________________________________________________

siteMapManager=SiteMapManager(urlSiteMap,fileSiteMap)
lista_LinksProp=siteMapManager.getlista_Links()[0:2] # COMENTAR para que baje más

#***************************************************************** LOOP *****************************************************************************************
for sSystem in lista_LinksProp:
    sTempLink=tempFolder+sSystem.rsplit('/', 1)[-1]
    sTempFile=tempFolder+sSystem.rsplit('/', 1)[-1].rsplit('.gz', 1)[0]
    
    # 3_DESCARGAR LOS ARCHIVOS NECESARIOS ____________________________________________________
    urllib.request.urlretrieve(sSystem, sTempLink)

    # 4_DESCOMPRIMIR EL GZIP _________________________________________________________________
    gz.unzip(sTempLink,sTempFile)

    # 5_RECORRER LA LISTA DE PROPIEDADES _____________________________________________________
    xmldoc = minidom.parse(sTempFile)
    propertieslist = xmldoc.getElementsByTagName('url')[0:1000] #COMENTAR [0:5] SI SE QUIERE RECORRER TODO
    print("Total Propiedades: " +str (len(propertieslist)))
    for s in propertieslist:
        lastmod=s.getElementsByTagName('lastmod')[0].childNodes[0].data
        dLastmod=datetime.strptime(lastmod, formatoFecha)
        if (dLastmod>(datetime.now()- timedelta(days=dias_crawler))  ):
            loc=s.getElementsByTagName('loc')[0].childNodes[0].data
            lista_propiedades.append(oPropiedad(loc,dLastmod))

#***************************************************************** END LOOP *****************************************************************************************


# 6_RECOLECTAR INFORMACIÓN DE CADA PROPIEDAD______________________________________________

for i in lista_propiedades:

    if (i.tipopropiedad=="casa"):       
        #Se descarga la información de la página WEB
        try:
            
            ParserLcl=Parser_PI(api_url_find+i.codigo0)
            if (ParserLcl.getJsonData()["status"]=="False"):
                Parser=Parser_PI(i.loc)
                i.downloadDatosBasicos(Parser)
                if (i.codigo!="error"):
                    i.downloadDatosUbicacion(Parser)
                    i.downloadDatosPropiedad(Parser)
                    i.downloadDatosScrip(Parser)
                    n+=1
                    print("Propiedad N° : " +str (n) + " x Descargar Casa")                
                    #f_out.write(i.displayDatosSector() +"\n")
                    #f_out.write(i.displayPropiedad() +"\n")
                    
                    r = requests.post(api_url_new, data=i.displayPostData())
                    print (r.text)
            else:
                print("Propiedad N° : " +str (n) + " x Ta se encuentra guardada") 
            p+=1
        except:
            pass
    #else if(i.tipopropiedad="casa"):

#    else:

#Matamos el programa
#exit()

print("Total Propiedades Guardadas: " +str (n))
f_out.close()

# 7_GUARDAR LOS DATOS EN LA BASE DE DATOS_________________________________________________







