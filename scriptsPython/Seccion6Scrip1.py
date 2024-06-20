import mysql.connector
from mysql.connector import Error

def conectar_bd(server_name, nombre_usuario, pwd):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=server_name,
            user=nombre_usuario,
            passwd=pwd
        )
        print("Conexión a la base de datos exitosa")
    except Error as err:
        print(f"Error conectando a la base de datos: {err}")
    return connection

def close_bd(connection):
    if connection.is_connected():
        connection.close()
        print("Conexión a la base de datos cerrada")

def ejecutar_consulta(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        connection.commit()
        print("La consulta ejecutada exitosamente")
    except Error as err:
        print(f"Error hejecutando la consulta: {err}")

def conusultar_datos(connection, query):
    cursor = connection.cursor(dictionary=True)
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as err:
        print(f"Error ejecutando la consulta: {err}")
        return None


#Logica del proceso
# Parámetros de conexión
host = "localhost"
user = "root"
password = "Manuela04."


# Crear la conexión a la base de datos
connection = conectar_bd(host, user, password)

#Si la connexión fue correcta, Realiza la recuperación de la información
if connection:
    # Recupera lo datos de la tabla y los imprime en pantalla
    select_query = "SELECT * FROM sakila.customer LIMIT 10"
    rows = conusultar_datos(connection, select_query)
    if rows:
        for row in rows:
            print(row)
    

 # Realizamos Inserciones a la tabla category
    
    insert_query = "INSERT INTO sakila.category (name) VALUES('NuevaCategoria');"
    
    ejecutar_consulta(connection, insert_query)




 # Realizamos actaulizaciones a la tabla category
 
    update_query = "UPDATE sakila.category SET name = 'CategoriaNuevoNombre'  WHERE category_id = 21"
 
    ejecutar_consulta(connection, update_query)

# Cierra la conexión a ala base de datos
close_bd(connection)
