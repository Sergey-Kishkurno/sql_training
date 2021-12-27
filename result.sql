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


-- №2
-- Вывести 10 актеров, чьи фильмы большего всего арендовали,
-- отсортировать по убыванию.




-- №3
-- Вывести категорию фильмов, на которую потратили больше всего денег.



-- №4
-- Вывести названия фильмов, которых нет в inventory.
-- Написать запрос без использования оператора IN.



-- №5
-- вывести топ 3 актеров, которые больше всего появлялись в фильмах
-- в категории “Children”.
-- Если у нескольких актеров одинаковое кол-во фильмов, вывести всех.





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



