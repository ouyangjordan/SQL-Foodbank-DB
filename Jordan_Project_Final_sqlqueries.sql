--Selection and Projection Query

--See total money in foodbank from donation

SELECT SUM(amount) FROM mon_collects;

--See how many protein items are in the foodbank

SELECT COUNT(category) 
from item
where item.category = 'protein';

--Join Query

--Join the volunteers to their administrators

select Administrator.name, volunteer_add.name
from administrator
INNER JOIN volunteer_add ON administrator.A_userName= volunteer_add.A_userName;

--Join the donors name, date, and their item they donated.

select item_collects.name, item_collects.dateI, item.string
from item_collects
INNER JOIN item ON item_collects.did = item.did;


--Division Query and relational algebra

--See which administrators are connected to
--all the volunteers. Only the boss0 is.

select distinct name
from administrator

minus

select name
from (
	
	select administrator.name, volunteer_add.A_userName
	from
	administrator
	cross join
	volunteer_add
	
	minus
	
	select name, a_username
	from administrator
) names;

--This will not affect the result because it is still linked to boss0

insert into volunteer_add
values('genericUser143', 'topboss', '6041232927', 'genericName12', 'genericPass35');

--Rerun query again

select distinct name
from administrator

minus

select name
from (
	
	select administrator.name, volunteer_add.A_userName
	from
	administrator
	cross join
	volunteer_add
	
	minus
	
	select name, a_username
	from administrator
) names;


--This will make it so that its linked to another boss (boss1)

insert into volunteer_add
values('genericUser144', 'anothertopboss', '6041231297', 'genericName95', 'genericPass95');

--Rerun the query here and see that theres no total divison relation

select distinct name
from administrator

minus

select name
from (
	
	select administrator.name, volunteer_add.A_userName
	from
	administrator
	cross join
	volunteer_add
	
	minus
	
	select name, a_username
	from administrator
) names;



--aggregation query

--Max amount of money donated

SELECT MAX(amount) "Maximum amount donated" FROM mon_collects;

--average amount of money donated

SELECT AVG(amount) "Average amount donated" FROM mon_collects;

--nested aggregation with group by

--Find the max average from cash or credit
	
	SELECT MAX(amountDonated.avg)
	FROM (SELECT AVG(amount) as avg, medium FROM mon_collects group by medium)amountDonated;
	
	
	--Sorts the average by descending order whichever medium had higher donation
	
	select amountDonated.avg as averagedonation , amountDonated.medium as MEDIUM
	FROM (SELECT AVG(amount) as avg, medium FROM mon_collects group by medium)amountDonated
	order by amountDonated.avg desc;
	
	--Ascending order now
	
	SELECT MIN(amountDonated.avg)
	FROM (SELECT AVG(amount) as avg, medium FROM mon_collects group by medium)amountDonated;
	
	
	--Sorts the average by descending order whichever medium had higher donation
	
	select amountDonated.avg as averagedonation , amountDonated.medium as MEDIUM
	FROM (SELECT AVG(amount) as avg, medium FROM mon_collects group by medium)amountDonated
	order by amountDonated.avg;
	
	

/*deletion operation with cascade*/
	
--Once the administrator deletes itself then it must cascade through
	
DELETE FROM administrator
WHERE A_username = 'topboss';
	
--It is because once the admin is deleted from the system all the associated
--accounts must apply for permission from other admins.

--this is to see the resulting tables

select * from volunteer_add;
select * from administrator;




/*give an example of cascade without.

	--If you delete the item you don't want to delete the record
	--of the donation of course

	/*
	select * from item_collects;
	
	select * from item
	where did = 199;
	
	delete from item_collects 
	where did = 199;*/

/*use check statement for an update thing*/

	--This is a fine insert
insert into Mon_Collects
values('2345', 'donor112', '6041231002', '22097', '8.1', '1.15', 'A', '102.0', 'credit');

--This is not because of the negative amount
insert into Mon_Collects
values('4343', 'donor143', '6041231002', '22097', '8.1', '1.15', 'A', '-5', 'credit'); 