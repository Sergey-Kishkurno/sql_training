-- №1
-- Вывести количество фильмов в каждой категории, отсортировать по убыванию.
select result.category_id, name, result.count
from
    (select fc.category_id, count(*)
    from film_category as fc
    join category as c on fc.category_id=c.category_id
    group by fc.category_id
    ) as result, category
where result.category_id=category.category_id
order by result.count desc
;


-- №2
-- Вывести 10 актеров, чьи фильмы большего всего арендовали,
-- отсортировать по убыванию.
select fa.actor_id, a.last_name, a.first_name, fa.film_id, f.title, f.rental_duration
from film_actor fa
join film f on fa.film_id = f.film_id
join actor a on fa.actor_id = a.actor_id
group by fa.actor_id, a.last_name, a.first_name, fa.film_id, f.title, f.rental_duration
order by rental_duration desc
limit 10
;


-- №3
-- Вывести категорию фильмов, на которую потратили больше всего денег.
select c.name, res.sum from category c
join
    (select fc.category_id, sum(amount)
    from payment p
    join rental r on p.rental_id = r.rental_id
    join inventory i on r.inventory_id =i.inventory_id
    join film_category fc on fc.film_id = i.film_id
    group by fc.category_id
    order by sum desc
    limit 1
    ) as res on c.category_id = res.category_id
;


-- №4
-- Вывести названия фильмов, которых нет в inventory.
-- Написать запрос без использования оператора IN.
select title from film f
left join inventory i on f.film_id = i.film_id
where i.film_id is null
;



-- №5
-- вывести топ 3 актеров, которые больше всего появлялись в фильмах
-- в категории “Children”.
-- Если у нескольких актеров одинаковое кол-во фильмов, вывести всех.
select array_agg(actor_id), films_count
from
  (
  select actor_id, count(actor_id) as films_count
  from film_actor fa
  left join film_category fc on fa.film_id = fc.film_id
  where fc.category_id = 3
  group by actor_id
  order by films_count desc
  ) as t1
group by films_count
order by films_count DESC
limit 3
;
-- Примечание: Обычно приложения работают по ID, потому использовано fc.category_id = 3


-- №6
-- Вывести города с количеством активных и неактивных клиентов (активный — customer.active = 1).
-- Отсортировать по количеству неактивных клиентов по убыванию.
select  c2.city , c.active, count(c.customer_id )
from address a
right join customer c on a.address_id = c.address_id
left join city c2 on c2.city_id = a.city_id
group by a.city_id, c.active, c2.city
order by c.active
;


-- №7
-- Вывести категорию фильмов, у которой самое большое кол-во часов суммарной аренды в городах
-- (customer.address_id в этом city), и которые начинаются на букву “a”.
-- То же самое сделать для городов в которых есть символ “-”.
-- Написать все в одном запросе.

-- Неоконченный запрос:
select
	justify_interval(sum(r.return_date - r.rental_date))
	, r.inventory_id
	, r.return_date as end_time
	, r.rental_date as start_time
	, ct.city as city_name
	--, justify_interval(sum(r.return_date - r.rental_date)) as duration
from rental r
join customer c on r.customer_id = c.customer_id
join address a on c.address_id = a.address_id
join city ct on a.address_id = c.address_id
group by r.inventory_id
	, r.return_date
	, r.rental_date
	, ct.city
where ct.city ilike '%-%' or ct.city ilike 'a%'
;


