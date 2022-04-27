# Air France Business Case

Air France has the ambition to expand its international presence and competitivity, particularly in the U.S. In order to do it, the company wants to be fully aware of 
the advantages that mediators and publishers have on its business. 
The analysis was focused on these requests, considering specific metrics that could predict the impact of publishers and forecast the success of Air France's business
with and without them.

# Project Description

The analysis of the dataset provided was entirely conducted on R. 
The dataset presented unlabeled variables and some of them resulted useless. In order to conduct the project properly all variables were renominated and some of them dropped. After having solved typos, variables useful for the analysis were converted into numbers to finally arrive to a logistic regression.
1) Conversion of variables in integers
2) Reduction to dummies of target variable
3) Normalization of variables composing the model

# Principal Findings

1 - The value related to Publishers like Google, Yahoo, etc. is reduced when the customers buy directly from Air france. For every customers who buys tickets directly  
    from Air France the value related to Search Engine is reduced by 67%.
2 - If the customers buy directly from Air France, the odds for business success related to Average Cost per Click is reduced by 94%.
    This means that if Air France increases the number of customers who buy tickets from their own channels, the expense for every single
    research in the search engines is drastically reduced.
3 - Differently from the previous results, the Engine Click Thru maintains stability in relation to the odds of business success.
    In fact, even if the company augments the amount of customers who decides to buy tickets without intermediates the value related to the
    exposition in the search engines is reduced only by 1%.
    A similar thing happens when we consider the bidding strategy in the search engines. The odds of business success are reduced only by 5%.
    
    In conclusion, the total volume of bookings. This is the most interesting finding in the analysis. In fact, for every additional customer that Air France is able to     attract to its channels, the odds for more bookings increase only by 1%. What does this means? It means that in this moment Air France is stuck with a certain number     of customers. Consequently, if the strategy changes, shifting from search engines to its own website, Air France will probably not increase the amount of customers.     Probably, the company will reduce some costs, especially those related to the clicks and the bid strategy, but it will remain bound to the fidelity of its customers.     If the company wants to move from here, it has to maximize the more independence given by this new strategy to invest in new solutions to increase the number of         customers.
