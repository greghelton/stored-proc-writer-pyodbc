A program that generates Python code that will call a given stored procedure, for example, pass the library name and stored procedure name and the name of the Python file you wish to have generated.
```bash
python3 stored_proc_writer_pyodbc.py MYLIB MYPROCEDURE MyProcedure
```

Before calling it, set the connection string
```bash
export IBM_I_ODBC_CONNECTION='DRIVER={IBM i Access ODBC Driver};SYSTEM=myhost;UID=myuser;PWD=mypassword'
```

and, if necessary, install pyodbc
```bash
python3 -m pip install pyodbc
```
