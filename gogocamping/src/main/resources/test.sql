-- 전체 상품 리스트 조회 페이징(main)
select rnum, product_name, price, product_img
from (select p.*, row_number() over(order by product_name) as rnum from product p)
where rnum between 1 and 12

-- 대분류
select product_name, price, product_img, c.category_no, c.category_name
from product p, category c
where p.category_no = c.category_no
and c.category_name = '텐트/타프'
-- 페이징
select rnum, p.product_name, p.price, p.product_img, p.category_name, p.detail_category_name
from (
   select p.*, row_number() over(order by product_name) as rnum, c.category_name, c.detail_category_name
   from product p, category c where p.category_no=c.category_no and c.category_name='텐트/타프'
) p
where rnum between (2-1*12) and (2*12)

-- 대분류/소분류
select product_name, price, product_img, c.category_name, c.detail_category_name
from product p, category c
where p.category_no = c.category_no
and c.category_name = '텐트/타프'
and c.detail_category_name = '텐트'
-- 페이징
select rnum, p.product_name, p.price, p.product_img, p.category_name, p.detail_category_name
from (
   select p.*, row_number() over(order by product_name) as rnum, c.category_name, c.detail_category_name
   from product p, category c where p.category_no=c.category_no and c.category_name='텐트/타프' and c.detail_category_name = '텐트'
) p
where rnum between 1 and 12

-- 검색 페이징
select rnum, p.product_id p.product_name, p.price, p.product_img
from (
   select p.*, row_number() over(order by product_name) as rnum, c.category_name, c.detail_category_name
   from product p, category c where p.category_no=c.category_no and REPLACE(p.product_name, ' ', '') like '%루텐트%'
) p
where rnum between 1 and 12
-- 검색된 상품수
select count(*) from product
where REPLACE(product_name, ' ', '') like '%루텐트%'

-- 검색된 상품 정렬(높은가격순)
select rnum, p.product_name, p.price, p.product_img
from (
   select p.*, row_number() over(order by price desc) as rnum, c.category_name, c.detail_category_name
   from product p, category c where p.category_no=c.category_no and REPLACE(p.product_name, ' ', '') like '%텐트%'
) p

select * from seller;

-- 브랜드 리스트
select seller_id, brand from seller;
-- 브랜드별 상품수
select count(*) from seller where brand = '지프 JEEP'

-- 브랜드별 상품리스트 조회(높은 가격순)
select p.*, s.seller_id, s.seller_email, s.brand, s.seller_tel, c.*
from product p, seller s, category c
where p.seller_id = s.seller_id and p.category_no = c.category_no
and s.brand = '지프(JEEP)'
order by price desc

-- 브랜드별 카테고리 조회 (중복 제거)
select distinct c.category_name, s.brand
from product p, seller s, category c
where p.seller_id = s.seller_id and p.category_no = c.category_no
and s.brand = '지프(JEEP)'
order by c.category_name desc

-- 브랜드별 카테고리별 상품 조회
select s.brand, p.*, c.*
from product p, seller s, category c
where p.seller_id = s.seller_id and p.category_no = c.category_no
and s.brand = '지프(JEEP)' and c.category_name = '침낭/매트/해먹'
order by p.price

-- 브랜드별 카테고리별 상품수
select count(*)
from product p, seller s, category c
where p.seller_id = s.seller_id and p.category_no = c.category_no
and s.brand = '지프(JEEP)' and c.category_name = '침낭/매트/해먹'


-- 1220
-- 카테고리 조회 (헤더)
select category_no, category_name, detail_category_name from category

-- 카테고리 조회 (헤더 클릭 후 나타나는 소분류)
select *
from category
where category_name = '텐트/타프'

-- 카테고리별(대분류) 상품 리스트 조회 (페이징 포함)
select rnum, pc.category_no, pc.product_id, pc.product_name, pc.price, pc.product_img, pc.category_name, pc.detail_category_name
from (
   select p.*, c.category_name, c.detail_category_name, row_number() over(order by product_name) as rnum
   from product p, category c where p.category_no=c.category_no and c.category_name='침낭/매트/해먹'
) pc
where rnum between 1 and 12

-- 카테고리별(대분류) 상품수
select count(*)
from product p, seller s, category c
where p.seller_id = s.seller_id and p.category_no = c.category_no
and c.category_name = '침낭/매트/해먹'

-- 카테고리별(소분류) 상품 리스트 조회
select c.detail_category_name
from product p, category c
where p.category_no = c.category_no
and c.category_name = '텐트/타프'
and c.detail_category_name = '텐트'
order by price desc

-- 2차구현
-- 장바구니 추가
insert into cart(cart_no,product_count,customer_id,product_id)
values(cart_seq.nextval,1,'customer',1);

-- 장바구니에 같은 상품이 있을 경우
update cart set product_count = product_count+1 where customer_id = 'customer' and product_id = 1

-- 장바구니 확인 (최신순)
select c.*, p.* from cart c, product p 
where c.product_id = p.product_id
and c.customer_id = 'customer' and p.product_id = 1
order by c.cart_no desc

-- 장바구니 상품 수량 변경
update cart set product_count = 5 where customer_id = 'customer' and product_id = 1

-- 장바구니에서 상품 삭제
delete from cart where customer_id = 'customer' and product_id = 1


-- 좋아요 하기
insert into likes(likes_no,customer_id,product_id)
values(likes_seq.nextval,'java',1);

select * from likes

-- 좋아요 취소
delete from likes where customer_id = 'customer' and product_id = 1

-- 좋아요 확인 (최신순)
select l.likes_no, l.customer_id, p.product_id,p.product_name,p.price,p.product_img
from likes l, product p 
where l.product_id=p.product_id 
and l.customer_id = 'customer'
order by l.likes_no desc

select l.likes_no, l.customer_id, p.product_id,p.product_name,p.price,p.product_img
	from likes l, product p 
	where l.product_id=p.product_id 
	and l.customer_id = 'customer'
	order by l.likes_no desc
-- 주문 

-- 주문내역 확인

-- 주문 취소


-- 브랜드별 구매 후기 리스트 출력
select r.review_no, r.grade, r.review_content, to_char(r.review_regdate, 'YYYY-MM-DD HH24:MI:SS') as review_regdate, r.customer_id, r.product_id, s.seller_id
from review r, product p, seller s
where r.product_id=p.product_id
and s.seller_id=p.seller_id
and s.seller_id='campis'


select * from review where review_no=21
select * from seller

-- 리뷰 상세 출력
select r.review_no, r.grade, r.review_content, to_char(r.review_regdate, 'YYYY-MM-DD HH24:MI:SS') as review_regdate, r.customer_id, r.product_id, p.product_name
from review r, product p
where r.product_id=p.product_id and r.review_no=21

delete from review where review_no=22

-- 전체 판매 내역
select oi.order_no, od.order_detail_no, p.product_name, od.order_count, to_char(oi.order_date, 'YYYY-MM-DD') as order_date, od.order_price, od.delivery_status, p.seller_id
from order_info oi, order_detail od, product p
where oi.order_no = od.order_no
and od.product_id=p.product_id
and od.delivery_status = '배송완료'
and p.seller_id='snowpeak'
order by order_date desc;

select seller_id, seller_name from seller where seller_id='snowpeak'

-- 날짜별 판매 내역
select oi.order_no, od.order_detail_no, p.product_name, od.order_count, to_char(oi.order_date, 'YYYY-MM-DD') as order_date, od.order_price, od.delivery_status, p.seller_id
from order_info oi, order_detail od, product p
where oi.order_no = od.order_no
and od.product_id=p.product_id
and od.delivery_status = '배송완료'
and p.seller_id='snowpeak'
and oi.order_date between to_date('2021-12-01', 'YYYY-MM-DD') 
and to_date('2021-12-22', 'YYYY-MM-DD')+1
order by order_date desc

--주문개수 조회
select count(*) 
from (select TO_CHAR(o.order_date, 'yyyy/mm/dd'), o.order_count, o.order_price, o.delivery_status, o.refund_check, p.product_name, p.product_img
from (select i.order_date, i.customer_id, d.order_count, d.order_price, d.delivery_status, d.refund_check, d.product_id
from order_info i , order_detail d
where i.order_no = d.order_no) o, product p
where o.product_id = p.product_id
and o.customer_id='test2')

--주문조회
select TO_CHAR(o.order_date, 'yyyy/mm/dd'), o.order_count, o.order_price, o.delivery_status, o.refund_check, p.product_name, p.product_img
from (select i.order_date, i.customer_id, d.order_count, d.order_price, d.delivery_status, d.refund_check, d.product_id
from order_info i , order_detail d
where i.order_no = d.order_no) o, product p
where o.product_id = p.product_id
and o.customer_id='test2'


-- 인기순 정렬
-- 전체 상품 인기순 정렬 (페이징 포함)
select rnum, product_id, product_name, price, product_img, product_img_stored, c from (
select * from (
	select p.*, row_number() over(order by (select count(*) from order_detail where product_id = p.product_id group by p.product_id)) as rnum,
	nvl((select count(*) from order_detail where product_id = p.product_id group by p.product_id), 0) as c
	from product p
) order by c desc) where rnum between 1 and 7

-- 카테고리(대분류) 상품 인기순 정렬 (페이징 포함)
select rnum, product_id, product_name, price, product_img, category_name, detail_category_name, c from (
select * from (
   select p.*, row_number() over(order by (select count(*) from order_detail where product_id = p.product_id group by p.product_id) desc) as rnum, c.category_name, c.detail_category_name,
   nvl((select count(*) from order_detail where product_id = p.product_id group by p.product_id), 0) as c
   from product p, category c where p.category_no=c.category_no and c.category_name='의자/테이블/침대'
) order by c desc )
where rnum between 1 and 3

-- 카테고리(소분류) 상품 인기순 정렬
select p.*, c.*, nvl((select count(*) from order_detail where product_id = p.product_id group by p.product_id), 0) as c
from product p, category c
where p.category_no = c.category_no
and c.category_name = '침낭/매트/해먹' and c.detail_category_name = '베개/쿠션'
order by c desc

-- 검색 상품 인기순 정렬
select p.*, c.*, nvl((select count(*) from order_detail where product_id = p.product_id group by p.product_id), 0) as c
from product p, category c where p.category_no=c.category_no and REPLACE(p.product_name, ' ', '') like '%이%'
order by c desc

-- 브랜드별 인기순 정렬
select s.brand, p.*, nvl((select count(*) from order_detail where product_id = p.product_id group by p.product_id), 0) as c
from product p, seller s
where p.seller_id = s.seller_id
and s.brand = '스노우피크(Snowpeak)' order by c desc

-- 브랜드 카테고리별 인기순 정렬
select s.brand, p.*, c.*, nvl((select count(*) from order_detail where product_id = p.product_id group by p.product_id), 0) as c
from product p, seller s, category c
where p.seller_id = s.seller_id and p.category_no = c.category_no
and s.brand = '지프(JEEP)' and c.category_name = '침낭/매트/해먹' order by c desc

 select category_name 
 from (select category_name from category group by category_name order by category_no) 
 
select category_name
from category group by category_name order by min(category_no)

