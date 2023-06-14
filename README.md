### Car Sales

#### Client ask

- We need an outside analysis on auto procurement for our fleet of service vehicles
- We lease trucks to contractors and other businesses, but a recent spike in demand has meant we are unable to get cars from our traditional suppliers
- We want to see an overview of automotive auction industry so we can use that information to get F150s at the most affordable price from the market
- car_prices.csv dataset has been emailed to you

#### Delivery

- Technologies used
    - Python
    - Pandas
    - Numpy
    - Matplotlib
    - Seaborn
    - SQL Server (Data Definitions and Transformations)

#### Replication Steps (Needs SQL Server on your Local Machine)

- Clone the repository
- Create .env file under root directory with the following key-value pairs
    - SQL_SERVER=YOUR_SERVER_NAME
    - SQL_DB=YOUR_DATABASE_NAME
    - SQL_USER=YOUR_USERNAME
    - SQL_PWD=YOUR_PASSWORD
- Create a virtual environment and activate it
- Install dependencies
    - pandas
    - numpy
    - matplotlib
    - seaborn
    - pyodbc
- Run notebook.ipynb in Jupyter Notebook
- Data definition and transformation scripts are under /sql folder as follows:
![Alt text](/images/queries.png "SQL Scripts")