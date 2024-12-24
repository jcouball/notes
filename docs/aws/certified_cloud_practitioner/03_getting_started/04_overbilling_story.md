# Overbilling Story

AWS has metered billing where billing based on numerous factors.

Generally this means that you can get services at a lower cost.

However, if you choose an expensive service or there is a mis-configuration, you
could end up with a large bill.

Things that can run the cost up:

* Choosing the wrong node type for a service
* Leaving a service running you meant to delete

The instructor showed an example of setting up an ElastiCache Redis service. In this
case the default node was over provisioned for what was needed. This ended up costing
over $150 for the month.

On your first mis-spend, Support Center can forgive the bill. Open a case with
Support Center with type = "Billing".
