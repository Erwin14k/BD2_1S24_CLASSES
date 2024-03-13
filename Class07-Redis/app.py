# Install dependencies

# FLASK ->  pip install flask
# Redis -> pip install redis

# Imports
from flask import Flask, request, jsonify
import redis


# Flask instance
app = Flask(__name__)

db = redis.StrictRedis(host='localhost', port=6379, db=0)


# MOVIE STRUCTURE
  # -ID  (KEY)
  # - NAME
  # - YEAR
  # - GENRE


@app.route('/new-key',methods=['POST'])
def new_key():
  data= request.get_json()
  key=data.get('key')
  value= data.get('value')

  if key is None or value is None:
    return jsonify({
      'Error':'Key and value must be provided'
    })

  db.set(key,value)
  return jsonify({
      'Message':'Key inserted succesfully :)'
  })

@app.route('/get/<key>',methods=['GET'])
def get_key(key):
  value=db.get(key)

  if value is None :
    return jsonify({
      'Error':'Key not found'
    })
  return jsonify({
      key: value.decode()
  }),200


@app.route('/new-movie',methods=['POST'])
def add_movie():
  data=request.get_json()
  movie_id=data.get('id')
  movie_name=data.get('name')
  movie_year=data.get('year')
  movie_genre=data.get('genre')

  if movie_id is None or movie_name is None or movie_genre is None or movie_year is None:
    return jsonify({'Error':'Id, name, year and genre must be provided for the movie'}),400
  
  movie_data={
    'name':movie_name,
    'genre':movie_genre,
    'year':movie_year
  }

  db.hmset(movie_id,movie_data)
  return jsonify({'Message':'Movie added successfully :)'}),200


@app.route('/movies',methods=['GET'])
def get_movies():
  movies={}

  keys= db.keys('*')

  for key in keys:
    # Verify if the key is a hash or not
    if db.type(key)== b'hash':
      movie_data=db.hgetall(key)
      movies[key.decode()]={ k.decode(): v.decode() for k,v in movie_data.items()}
  return jsonify(movies),200

@app.route('/delete-movie/<movie_id>',methods=['DELETE'])
def delete_movie(movie_id):
  movie_id_str=str(movie_id)
  if movie_id_str.encode() not in db.keys('*'):
    return jsonify({"Error": "Movie Id not found"}),404
  db.delete(movie_id)
  return jsonify({'message':'Movie deleted succesfully:)'}),200


@app.route('/update-movie/<movie_id>',methods=['PUT'])
def update_movie(movie_id):
  data = request.get_json()
  movie_name=data.get('name')
  movie_genre=data.get('genre')
  movie_year=data.get('year')

  if movie_name is None and movie_genre is None and movie_year is None:
    return jsonify({'Error': 'Name, year or genre must be provided to update the movie'}),400
  
  movie_id_str=str(movie_id)
  if movie_id_str.encode() not in db.keys('*'):
    return jsonify({'Error': 'Movie ID not found'}),404
  
  # Update data
  if movie_name:
    db.hset(movie_id,'name',movie_name)
  if movie_genre:
    db.hset(movie_id,'genre',movie_genre)
  if movie_year:
    db.hset(movie_id,'year',movie_year)
  return jsonify({'Message': 'Movie updated'}),200



if __name__=='__main__':
  app.run(debug=True)

