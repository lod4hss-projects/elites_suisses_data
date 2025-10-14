
 



CONSTRAINT `filiation_fils` FOREIGN KEY (`idFils`) REFERENCES `identite_versions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `filiation_parent` FOREIGN KEY (`idParent`) REFERENCES `identite_versions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE