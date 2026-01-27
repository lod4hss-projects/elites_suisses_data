
/statements

INSERT DATA {
  <http://ciccio.org> <http://my_property.org> <http://bombo.org> .
}

works... !!!

INSERT DATA {
  <http://ciccio.org/2> <http://my_property.org> <http://bombo.org/2> .
}


INSERT DATA {
  <http://ciccio.org/3> <http://my_property.org> <http://bombo.org/3> .
}

INSERT DATA {
  <http://ciccio.org/4> <http://my_property.org> <http://bombo.org/4> .
}

SELECT *
WHERE {
  <http://ciccio.org> ?p ?o .
}


