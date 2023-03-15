import pyodbc
from sqlalchemy.engine import create_engine, URL

class SQLConnection:
    def __init__(self, driver, server, db, user, pwd):
        self.driver = driver
        self.server = server
        self.db = db
        self.user = user
        self.pwd = pwd

    def get_conn_string(self):
        return f"Driver={self.driver};Server={self.server};Database={self.db};Authentication=SqlPassword;Encrypt=yes;TrustServerCertificate=Yes;UID={self.user};PWD={self.pwd}"
    
    def get_sql_engine(self):
        conn_string = self.get_conn_string()
        conn_url = URL.create("mssql+pyodbc", query={"odbc_connect": conn_string})
        engine = create_engine(conn_url)
        return engine
    
    def get_conn_odbc(self):
        try:
            conn = pyodbc.connect(self.get_conn_string())
            return conn
        except pyodbc.Error as e:
            print("Connection Error:")
            print(e.args[1])

    def select_records(self, query):
        cnxn = self.get_conn_odbc()
        try:
            cursor = cnxn.cursor()
            cursor.execute(query)
            rows = cursor.fetchall()
            cnxn.commit()
            return rows
        except Exception as e:
            cnxn.rollback()
            print(e.args[1])
        finally:
            cursor.close()
            cnxn.close()

    def insert_records(self, query, params):
        cnxn = self.get_conn_odbc()
        try:
            cursor = cnxn.cursor()
            cursor.fast_executemany = True
            cursor.executemany(query, params)
            cnxn.commit()
        except Exception as e:
            cnxn.rollback()
            print(e.args[1])
        finally:
            cursor.close()
            cnxn.close()

    def execute_ddl_dml(self, query):
        cnxn = self.get_conn_odbc()
        try: 
            cursor = cnxn.cursor()
            cursor.execute(query)
            cnxn.commit()
        except Exception as e:
            cnxn.rollback()
            print(e.args[1])
        finally:
            cursor.close()
            cnxn.close()


# function to read file contents
def read_contents(path):
    with open(path, "r") as file:
        contents = file.read()
    return contents