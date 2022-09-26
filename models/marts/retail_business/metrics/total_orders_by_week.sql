select * 
from {{ metrics.calculate(
    metric('total_order_total_by_status'),
    grain='week',
    
) }}

