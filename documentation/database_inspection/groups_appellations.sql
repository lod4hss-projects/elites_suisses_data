

select *
from elites_suisses."autresNomsEntites" ane 
limit 10;

select tg.pk_group, tg.name_standard, e.nom, e.id id_entite, e."idEntite", ane."autreNom", ane.id id_autre_nom
from elites_suisses."autresNomsEntites" ane 
	left join elites_suisses.entites e on e."idEntite" = ane."idEntite" 
	left join elites_suisses.t_group tg on tg.fk_source_entity = e.id 
-- no names without group
-- where tg.pk_group is null	
where ane."autreNom" is not null and length(ane."autreNom") > 1
order by tg.pk_group 
--order by e.id
limit 100;



/*
 * Fill the new t_group_appellation table
 * 
 */

--insert into elites_suisses.t_group_appellation (appellation, fk_group, import_notes )
select ane."autreNom", tg.pk_group, '20260814_imp1_id_' || ane.id id_autre_nom
from elites_suisses."autresNomsEntites" ane 
	left join elites_suisses.entites e on e."idEntite" = ane."idEntite" 
	left join elites_suisses.t_group tg on tg.fk_source_entity = e.id 
-- no names without group
-- where tg.pk_group is null	
where ane."autreNom" is not null and length(ane."autreNom") > 1
order by tg.pk_group ;






