# Write your sql queries in this file in the appropriate method like the example below:
#
# def select_category_from_projects
# "SELECT category FROM projects;"
# end

# Make sure each ruby method returns a string containing a valid SQL statement.

# SELECT - extracts data from a database
# UPDATE - updates data in a database
# DELETE - deletes data from a database
# INSERT INTO - inserts new data into a database
# CREATE DATABASE - creates a new database
# ALTER DATABASE - modifies a database
# CREATE TABLE - creates a new table
# ALTER TABLE - modifies a table
# DROP TABLE - deletes a table
# CREATE INDEX - creates an index (search key)
# DROP INDEX - deletes an index

def selects_the_titles_of_all_projects_and_their_pledge_amounts
 <<-SQL
  SELECT projects.title , sum(pledges.amount)
  FROM projects
  INNER JOIN pledges
  ON projects.id = pledges.project_id
  GROUP BY pledges.project_id
  ORDER BY projects.title
 SQL
end

def selects_the_user_name_age_and_pledge_amount_for_all_pledges
  <<-SQL
    SELECT users.name, users.age, SUM(pledges.amount)
    FROM users
    JOIN pledges
    ON pledges.user_id = users.id
    GROUP BY users.name
  SQL
end

def selects_the_titles_and_amount_over_goal_of_all_projects_that_have_met_their_funding_goal
<<-SQL
    SELECT projects.title,
    SUM(pledges.amount)- projects.funding_goal
    AS extra
    FROM projects
    JOIN pledges
    ON projects.id = pledges.project_id
    GROUP BY projects.title
    HAVING extra >= 0
  SQL
end

def selects_user_names_and_amounts_of_all_pledges_grouped_by_name_then_orders_them_by_the_amount
  <<-SQL
    SELECT users.name, SUM(pledges.amount) AS total
    FROM users
    JOIN pledges
    ON users.id = pledges.user_id -- links user_id of user with user_id of the donor that pledged
    GROUP BY users.name
    ORDER BY total
  SQL
end

def selects_the_category_names_and_pledge_amounts_of_all_pledges_in_the_music_category
  <<-SQL
    SELECT projects.category, pledges.amount
    FROM projects
    JOIN pledges
    ON projects.id = pledges.project_id
    WHERE projects.category = 'music'
  SQL
end

def selects_the_category_name_and_the_sum_total_of_the_all_its_pledges_for_the_book_category
  <<-SQL
    SELECT projects.category,
    SUM(pledges.amount) as total
    FROM projects
    JOIN pledges
    ON projects.id = pledges.project_id
    WHERE projects.category = 'books'
  SQL
end
