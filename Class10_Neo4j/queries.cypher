// ======================= Obtain all nodes =======================
MATCH (n) RETURN n

// ======================= Obtain all actors =======================
MATCH (n:PACTOR) return n

// ======================= Obtain all directors =======================
MATCH (n:DIRECTOR) return n

// ======================= Obtain all movies =======================
MATCH (n:MOVIE) return n

// ======================= Obtain all genres =======================
MATCH (n:MOVIE) return n

// ======================= Obtain properties of a node =======================
MATCH (n:PACTOR) RETURN n.name

// ======================= Obtain properties of a node with alias =======================
MATCH (n:PACTOR) RETURN n.name AS NAME , n.age AS AGE

// ======================= Obtain a node with a property match condition using where =======================
MATCH (actor:PACTOR)
WHERE actor.name = "Jennifer Lawrence"
RETURN actor
// ======================= Obtain a node with a property match condition using json format =======================
MATCH (actor:PACTOR {name: "Jennifer Lawrence"})
RETURN actor


// ======================= Get the nodes that satisfy all conditions =======================
// Using <>
MATCH (actor:PACTOR)
WHERE actor.name <> "Jennifer Lawrence"
RETURN actor
// Using >=
MATCH (actor:PACTOR)
WHERE actor.height>=1.83
RETURN actor
// Using <=
MATCH (actor:PACTOR)
WHERE actor.height <=1.82
RETURN actor
// Using multiple conditons (AND)
MATCH (actor:PACTOR)
WHERE actor.age>=50
AND actor.height <=1.82
RETURN actor
// Using multiple conditons (OR)
MATCH (actor:PACTOR)
WHERE actor.age>=50
OR actor.height <=1.82
RETURN actor
// Using multiple conditons (NOT)
MATCH (actor:PACTOR)
WHERE NOT actor.age>=50
OR NOT actor.height <=1.82
RETURN actor


// Using limit on results
MATCH (actor:PACTOR)
WHERE actor.age>=50
OR actor.height <=1.82
RETURN actor
LIMIT 3
// Using limit and skip
MATCH (actor:PACTOR)
WHERE actor.age>=50
OR actor.height <=1.82
RETURN actor
SKIP 3
LIMIT 3

// Using order by (DESC)
MATCH (actor:PACTOR)
RETURN  actor
ORDER BY actor.height DESC

// Using order by (ASC)
MATCH (actor:PACTOR)
RETURN  actor
ORDER BY actor.height DESC

// ======================= Queries on relations and entities =======================
// Get all nodes of 2 entities
MATCH (actor:PACTOR), (director:DIRECTOR)
RETURN actor, director
//
MATCH (actor:PACTOR), (movie:MOVIE)
RETURN actor, movie
// Get all nodes of 3 entities
MATCH (actor:PACTOR), (movie:MOVIE), (director:DIRECTOR)
RETURN actor, movie,director

// ><
// "ACTED_IN": Get all actors of an specific movie
MATCH (actor:PACTOR) -[:ACTED_IN] -> (movie:MOVIE)
WHERE movie.name = "Black Swan"
RETURN actor


// Complex Queries
// Query #1 Find all the films directed by Quentin Tarantino along with actors who participated in them
MATCH (quentin:DIRECTOR{name:"Quentin Tarantino"})-[:DIRECTED]->(movie:MOVIE)<-[:ACTED_IN]-(actor:PACTOR)
RETURN movie, quentin,actor

