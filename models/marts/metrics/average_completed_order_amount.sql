select * 
from {{ metrics.calculate(
    metric('average_completed_order_amount'),
    grain='month'
) }}
;