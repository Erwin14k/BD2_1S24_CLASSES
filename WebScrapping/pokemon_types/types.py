# imports
import requests
from bs4 import BeautifulSoup

# web scrapping page url
url='https://pokemondb.net/type'

# HTTP request
response =requests.get(url)

# BeautifulSoup object
soup= BeautifulSoup(response.text,'html.parser')

div_element= soup.find('div',class_='grid-col span-md-4')
# Find all "a" tags with not empty class
a_elements=div_element.find_all(lambda tag: tag.name=='a' and tag.get('class') and len(tag.get('class'))>0)
type_names=[a_element.text for a_element in a_elements]

# Print all type names
for name in type_names:
  print("Type name:",name)