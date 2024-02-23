# imports
import requests
from bs4 import BeautifulSoup
import csv

# web scrapping page url
url='https://pokemondb.net/pokedex/all'

# HTTP request
response =requests.get(url)

# BeautifulSoup object
soup= BeautifulSoup(response.text,'html.parser')

# CSV FILE
csv_file=open('./WebScrapping/pokemons.csv','w',newline='',encoding='utf-8')
csv_writter=csv.writer(csv_file)
csv_writter.writerow(['pokedex_number','name','types','total','hp','attack','defense',
                      'special_attack','special_defense',"speed"])

# find all pokemons
pokemons_table=soup.find('table',class_='data-table sticky-header block-wide')
pokemons=pokemons_table.find_all('tr')
# Travel around rows
for pokemon in pokemons:
  #obtain all columns of each row
  cells=pokemon.find_all('td')
  if cells:
    pokedex_number=cells[0].find('span',class_='infocard-cell-data').text
    name=cells[1].find('a',class_='ent-name').text
    types=[a.text for a in cells[2].find_all('a',class_='type-icon type-grass')]
    total=cells[3].text
    hp=cells[4].text
    attack=cells[5].text
    defense=cells[6].text
    special_attack=cells[7].text
    special_defense=cells[8].text
    speed=cells[9].text

    # Print pokemon data
    print("Pokedex number:",pokedex_number)
    print("Name:",name)
    # Write pokemon data on csv file
    csv_writter.writerow([
      pokedex_number,name,types,total,hp,attack,defense,special_attack,special_defense,speed
    ])
    
  





