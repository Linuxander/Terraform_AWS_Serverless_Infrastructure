import mysql.connector
from mysql.connector import Error
import json
import os

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USERNAME']
db_password = os.environ['DB_PASSWORD']
db_databasename = os.environ['DB_NAME']

connection = ""
cursor = ""

table_data = []
json_data = {}
result = {'result': 'fail', 'message': ''}


def db_connect():
    global connection, cursor
    try:
        connection = mysql.connector.connect(host=db_host,
                                             user=db_username,
                                             password=db_password,
                                             database=db_databasename,
                                             connect_timeout=10)
        cursor = connection.cursor()  # If succeedes, error won't be thrown
        print("Successfully connected to the database.")
    except Error as e:
        print("Error while connecting to MySQL:", e)


def db_disconnect():
    global connection, cursor
    cursor.close()
    connection.close()


def db_query_show_available_tables():
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()  # Fetch rows from execute statement

    # If you have tables, it will print them
    if tables:
        print("Available tables in the database:")
        for table in tables:
            print(table[0])
    else:
        print("No tables found in the database.")


def db_insert_user_record(user: str, post_content: str):
    select_query = "SELECT * FROM user WHERE name = %s"
    cursor.execute(select_query, (user,))
    result = cursor.fetchone()

    if result:
        update_result_obj('fail', 'user already exists')
    else:
        insert_query = "INSERT INTO user (name, post) VALUES (%s, %s)"
        cursor.execute(insert_query, (user, post_content))
        connection.commit()
        update_result_obj('success', 'user added')


def db_show_user_table_data():
    global json_data
    select_query = "SELECT * FROM user"
    cursor.execute(select_query)
    results = cursor.fetchall()

    for row in results:
        table_data.append({
            'id': row[0],
            'name': row[1],
            'picture': row[2],
            'friends': row[3],
            'post': row[4]
        })
    json_data = json.dumps(table_data)


def update_result_obj(outcome: str, message: str):
    global result
    result["result"] = outcome
    result["message"] = message


def lambda_handler(event, context):
    global table_data
    global result

    try:
        body = json.loads(event['body'])
        user = body.get('user', 'missing')
        post_content = body.get('post_content', 'missing')

        if (user != 'missing') and (post_content != 'missing'):

            db_connect()

            db_insert_user_record(user, post_content)

            # db_show_user_table_data()

            db_disconnect()
    except KeyError:
        pass

    return {
        'statusCode': 200,
        'body': json.dumps(str(result))
    }
