


update person set birth_place_id = birth_place_id + 1;

update birth_place set new_id = id + 1;




SELECT p.id, p.uncleaned_birth_place_name, bp.new_id,  bp.name, bp.birth_canton, bp.long, bp.lat
FROM person p left join birth_place bp on bp.new_id = p.birth_place_id 
where bp.new_id is not null
order by bp.new_id desc ;

--create view v_person_place as
SELECT p.id, bp.new_id
FROM person p left join birth_place bp on bp.new_id = p.birth_place_id 
where bp.new_id is not null;
order by bp.new_id desc ;

select *
from v_person_place ;