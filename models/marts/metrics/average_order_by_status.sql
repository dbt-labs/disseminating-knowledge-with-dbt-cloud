select * 
from {{ metrics.calculate(
    metric('average_order_amount_by_status'),
    grain='week',
    dimensions=['status']
) }}
order by date_week, status