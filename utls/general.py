# general functions that come in handy with most appliacitons

import numpy as np
import pandas as pd



def load_query(filename):
    """Using a file in the sql folder, return the query in the form of a string."""
    with open(f"/Users/ryan/Documents/Codebase/Big_Data_Bowl/sql/{filename}.sql", 'r') as f:
        query = f.read()

    return(query)



def make_a_query(cursor, query):
    """For a given cursor and query, return a dataframe."""
    cursor.execute(query)
    colnames = [x[0] for x in cursor.description]
    df = cursor.fetchall()
    return(pd.DataFrame(df, columns = colnames))
