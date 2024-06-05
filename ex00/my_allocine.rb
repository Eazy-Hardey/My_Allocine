requests = {}

# Display all actors
requests['Display all actors'] = "SELECT * FROM actors;"

# Display all genres
requests['Display all genres'] = "SELECT * FROM genres;"

# Display the name and year of the movies
requests['Display the name and year of the movies'] = "SELECT mov_title, mov_year FROM movies;"

# Display reviewer name from the reviews table
requests['Display reviewer name from the reviews table'] = "SELECT rev_name FROM reviews;"

# Find the year when the movie American Beauty released
requests["Find the year when the movie American Beauty released"] = "SELECT mov_year FROM movies WHERE mov_title = 'American Beauty';"

# Find the movie which was released in the year 1999
requests["Find the movie which was released in the year 1999"] = "SELECT mov_title FROM movies WHERE mov_year = 1999;"

# Find the movie which was released before 1998
requests["Find the movie which was released before 1998"] = "SELECT mov_title FROM movies WHERE mov_year < 1998;"

# Find the name of all reviewers who have rated 7 or more stars to their rating order by reviews rev_name (it might have duplicated names :-))
requests["Find the name of all reviewers who have rated 7 or more stars to their rating order by reviews rev_name (it might have duplicated names :-))"] = "SELECT reviews.rev_name FROM movies_ratings_reviews INNER JOIN reviews ON movies_ratings_reviews.rev_id = reviews.id WHERE movies_ratings_reviews.rev_stars >= 7 ORDER BY reviews.rev_name;"

# Find the titles of the movies with ID 905, 907, 917
requests["Find the titles of the movies with ID 905, 907, 917"] = "SELECT mov_title FROM movies WHERE id IN (905, 907, 917);"

# Find the list of those movies with year and ID which include the words Boogie Nights
requests["Find the list of those movies with year and ID which include the words Boogie Nights"] = "SELECT id, mov_title, mov_year FROM movies WHERE mov_title LIKE '%Boogie Nights%';"

# Find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'
requests["Find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'"] = "SELECT id FROM actors WHERE act_fname = 'Woody' AND act_lname = 'Allen';"

# Find the actors with all information who played a role in the movies 'Annie Hall'
requests["Find the actors with all information who played a role in the movies 'Annie Hall'"] = "SELECT actors.* FROM actors INNER JOIN movies_actors ON actors.id = movies_actors.act_id INNER JOIN movies ON movies.id = movies_actors.mov_id WHERE movies.mov_title = 'Annie Hall';"

# Find the first and last names of all the actors who were cast in the movies 'Annie Hall', and the roles they played in that production
requests["Find the first and last names of all the actors who were cast in the movies 'Annie Hall', and the roles they played in that production"] = "SELECT actors.act_fname, actors.act_lname, movies_actors.role FROM actors INNER JOIN movies_actors ON actors.id = movies_actors.act_id INNER JOIN movies ON movies.id = movies_actors.mov_id WHERE movies.mov_title = 'Annie Hall';"

# Find the name of movie and director who directed a movies that casted a role as Sean Maguire
requests["Find the name of movie and director who directed a movies that casted a role as Sean Maguire"] = "SELECT directors.dir_fname, directors.dir_lname, movies.mov_title FROM movies INNER JOIN directors_movies ON movies.id = directors_movies.mov_id INNER JOIN directors ON directors_movies.dir_id = directors.id INNER JOIN movies_actors ON movies.id = movies_actors.mov_id WHERE movies_actors.role = 'Sean Maguire';"


requests["Find all the actors who have not acted in any movie between 1990 and 2000 (select only actor first name, last name, movie title and release year)"] = "SELECT actors.act_fname, actors.act_lname, movies.mov_title,CAST (strftime('%Y',movies.mov_dt_rel) AS INTEGER)
FROM actors
LEFT JOIN movies_actors ON actors.id = movies_actors.act_id
LEFT JOIN movies ON movies_actors.mov_id = movies.id
WHERE actors.id NOT IN 
( 
    SELECT movies_actors.act_id 
    FROM movies_actors 
    WHERE movies_actors.mov_id IN
( 
    SELECT movies.id FROM movies
WHERE (CAST(strftime('%Y', movies.mov_dt_rel) AS INTEGER) BETWEEN 1990 AND 2000) 
) 
) AND movies.mov_title IS NOT NULL
ORDER BY actors.id;"