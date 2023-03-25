select condition_bins, avg(selling_price) avg_price
from condition_bins
where condition_bins is not null
group by condition_bins
order by condition_bins