from pyproj import Proj, transform

inProj = Proj(init='epsg:3857')
outProj = Proj(init='epsg:4326')
x1,y1 = -7860687.599064509,-3949917.2460160106
x2,y2 = transform(inProj,outProj,x1,y1)
print x2,y2
