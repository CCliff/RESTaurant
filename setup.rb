require 'sinatra/activerecord'
require 'pg'
require 'rainbow'


#  **** Migration ****
conn = PG::Connection.open()

conn.exec('CREATE DATABASE restaurant_db;')
conn.close


conn = PG::Connection.open(dbname: 'restaurant_db')
conn.exec('CREATE TABLE tables (id SERIAL PRIMARY KEY, number INTEGER, number_guests INTEGER, paid BOOLEAN);')
conn.exec('CREATE TABLE food_items (id SERIAL PRIMARY KEY, name VARCHAR(255), price INTEGER);')
conn.exec('CREATE TABLE orders (id SERIAL PRIMARY KEY, table_id INTEGER, food_item_id INTEGER);')
conn.close