# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Direccion.destroy_all
Objetivo.destroy_all
Comuna.destroy_all
Region.destroy_all


region_metropolitana=Region.create(nombre: 'Región Metropolitana', nombre_PI: '-metropolitana')

comunas=Comuna.create([{nombre: 'Las Condes', PRC_link: 'http://geo.minvu.cl/arcgis/rest/services/PRC/13_PRC_Metropolitana/MapServer/18', region: region_metropolitana, nombre_PI: 'las-condes-metropolitana'},{nombre: 'Vitacura', PRC_link: 'http://geo.minvu.cl/arcgis/rest/services/PRC/13_PRC_Metropolitana/MapServer/48', region: region_metropolitana, nombre_PI: 'vitacura'}])
comuna_las_condes=comunas.first

Objetivo.create(
[{comuna:comuna_las_condes,zona_prc: 'EAa1',zona: 'EAa1',constructibilidad: 2.6,target_uf_m2: 65,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'Eaa+ca',zona: 'EAa + ca',constructibilidad: 2.6,target_uf_m2: 65,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'Eaa+cm',zona: 'EAa + cm',constructibilidad: 3.9,target_uf_m2: 97.5,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'EAa2',zona: 'EAa2',constructibilidad: 2.6,target_uf_m2: 65,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'EAa3',zona: 'EAa3',constructibilidad: 2.6,target_uf_m2: 65,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'EAa4',zona: 'EAa4',constructibilidad: 1.3,target_uf_m2: 32.5,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'EAm1',zona: 'EAm1',constructibilidad: 1.3,target_uf_m2: 32.5,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'EAm1p',zona: 'EAm1\'',constructibilidad: 3.25,target_uf_m2: 81.25,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'EAm2',zona: 'EAm2',constructibilidad: 2.08,target_uf_m2: 52,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'EAm2p',zona: 'EAm2\'',constructibilidad: 2.08,target_uf_m2: 52,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'EAm4',zona: 'EAm4',constructibilidad: 2.34,target_uf_m2: 58.5,premio_fusion: true},
  {comuna:comuna_las_condes,zona_prc: 'EAb1',zona: 'EAb1',constructibilidad: 0.6,target_uf_m2: 15,premio_fusion: false},
  {comuna:comuna_las_condes,zona_prc: 'EAb2',zona: 'EAb2',constructibilidad: 0.6,target_uf_m2: 15,premio_fusion: false},
  {comuna:comuna_las_condes,zona_prc: 'EAb3',zona: 'EAb3',constructibilidad: 0.8,target_uf_m2: 20,premio_fusion: false},
  {comuna:comuna_las_condes,zona_prc: 'EAb4',zona: 'EAb4',constructibilidad: 0.8,target_uf_m2: 20,premio_fusion: false},
  {comuna:comuna_las_condes,zona_prc: 'EAb4p',zona: 'EAb4\'',constructibilidad: 0.8,target_uf_m2: 20,premio_fusion: false}
]

)
