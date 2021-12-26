-- №1
-- Вывести количество фильмов в каждой категории, отсортировать по убыванию.
select result.category_id, name, result.count
from
(select fc.category_id, count(*)
from film_category as fc
join category as c on fc.category_id=c.category_id
group by fc.category_id) as result,
category
where result.category_id=category.category_id
order by result.count desc
;


