select * 
from {{ metrics.calculate(
    metric('order_total_by_time'),
    grain='week',
) }}
order by date_week

