// Actors nodes creation
CREATE 
(brad:PACTOR{name:"Brad Pitt", age: 58, height: 1.80}),
(leo:PACTOR{name:"Leonardo DiCaprio", age: 48, height: 1.83}),
(angelina:PACTOR{name:"Angelina Jolie", age: 46, height: 1.69}),
(margot:PACTOR{name:"Margot Robbie", age: 32, height: 1.68}),
(jennifer:PACTOR{name:"Jennifer Lawrence", age: 33, height: 1.75}),
(johnny:PACTOR{name:"Johnny Depp", age: 59, height: 1.78}),
(emma:PACTOR{name:"Emma Stone", age: 35, height: 1.68}),
(ryan:PACTOR{name:"Ryan Gosling", age: 42, height: 1.84}),

// Directors nodes creation
(christopher:DIRECTOR{name: "Christopher Nolan"}),
(quentin:DIRECTOR{name: "Quentin Tarantino"}),
(steven:DIRECTOR{name: "Steven Spielberg"}),
(james:DIRECTOR{name: "James Cameron"}),
(martin:DIRECTOR{name: "Martin Scorsese"}),
(alfonso:DIRECTOR{name: "Alfonso Cuarón"}),

// Genres nodes creation
(scienceFiction:GENRE{name: "Science Fiction"}),
(drama:GENRE{name: "Drama"}),
(action:GENRE{name: "Action"}),
(biography:GENRE{name: "Biography"}),
(romance:GENRE{name: "Romance"}),
(adventure:GENRE{name: "Adventure"}),
(musical:GENRE{name: "Musical"}),
(thriller:GENRE{name: "Thriller"}),

// Movies nodes creation
(inception:MOVIE{name:"Inception", year: 2010, rating: 8.8, box_office: 830000000}),
(once_upon_a_time:MOVIE{name:"Once Upon a Time in Hollywood", year: 2019, rating: 7.6, box_office: 385000000}),
(mr_and_mrs_smith:MOVIE{name:"Mr. & Mrs. Smith", year: 2005, rating: 6.5, box_office: 487000000}),
(wolf_of_wall_street:MOVIE{name:"The Wolf of Wall Street", year: 2013, rating: 8.2, box_office: 392000000}),
(silver_linings_playbook:MOVIE{name:"Silver Linings Playbook", year: 2012, rating: 7.7, box_office: 236000000}),
(pirates_of_caribbean:MOVIE{name:"Pirates of the Caribbean", year: 2003, rating: 8.0, box_office: 654000000}),
(la_la_land:MOVIE{name:"La La Land", year: 2016, rating: 8.0, box_office: 446000000}),
(black_swan:MOVIE{name:"Black Swan", year: 2010, rating: 8.0, box_office: 329000000}),
(titanic:MOVIE{name:"Titanic", year: 1997, rating: 7.8, box_office: 2208000000}),
(the_revenant:MOVIE{name:"The Revenant", year: 2015, rating: 8.0, box_office: 533000000}),


// Relation Director -> movie
(christopher)-[:DIRECTED]->(inception),
(quentin)-[:DIRECTED]->(once_upon_a_time),
(james)-[:DIRECTED]->(titanic),
(martin)-[:DIRECTED]->(wolf_of_wall_street),
(alfonso)-[:DIRECTED]->(the_revenant),


// Relation Actor -> movie
(brad)-[:ACTED_IN]->(inception),
(leo)-[:ACTED_IN]->(inception),
(leo)-[:ACTED_IN]->(once_upon_a_time),
(brad)-[:ACTED_IN]->(once_upon_a_time),
(angelina)-[:ACTED_IN]->(mr_and_mrs_smith),
(brad)-[:ACTED_IN]->(mr_and_mrs_smith),
(jennifer)-[:ACTED_IN]->(silver_linings_playbook),
(brad)-[:ACTED_IN]->(silver_linings_playbook),
(johnny)-[:ACTED_IN]->(pirates_of_caribbean),
(margot)-[:ACTED_IN]->(pirates_of_caribbean),
(emma)-[:ACTED_IN]->(la_la_land),
(ryan)-[:ACTED_IN]->(la_la_land),
(jennifer)-[:ACTED_IN]->(black_swan),
(angelina)-[:ACTED_IN]->(black_swan),
(leo)-[:ACTED_IN]->(the_revenant),
(brad)-[:ACTED_IN]->(the_revenant),



(inception)-[:BELONGS_TO]->(scienceFiction),
(once_upon_a_time)-[:BELONGS_TO]->(drama),
(mr_and_mrs_smith)-[:BELONGS_TO]->(action),
(wolf_of_wall_street)-[:BELONGS_TO]->(biography),
(silver_linings_playbook)-[:BELONGS_TO]->(romance),
(pirates_of_caribbean)-[:BELONGS_TO]->(adventure),
(la_la_land)-[:BELONGS_TO]->(musical),
(black_swan)-[:BELONGS_TO]->(thriller),
(titanic)-[:BELONGS_TO]->(romance),
(the_revenant)-[:BELONGS_TO]->(adeventure);
