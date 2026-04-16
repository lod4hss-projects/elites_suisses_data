from typing import Dict, List, Optional, Tuple


from sqlalchemy import (
    Float,
    ForeignKey,
    Integer,
    String,
)

import sqlalchemy
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from sqlalchemy.dialects.sqlite import insert

from database_creation import *


"""
This file simply defines a set of sqlite classes
which get mapped onto a set of database tables later
"""


# define tables for sqlite table
class Base(DeclarativeBase):
    pass


class Person(Base):
    __tablename__ = "person"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    nom: Mapped[Optional[str]] = mapped_column(String)
    pre_nom: Mapped[Optional[str]] = mapped_column(String)
    naissance: Mapped[Optional[str]] = mapped_column(String)
    nationalite: Mapped[Optional[str]] = mapped_column(String)
    gradeMilitaireMax: Mapped[str] = mapped_column(String)
    rank_id: Mapped[int] = mapped_column(
        ForeignKey("rank.id"), primary_key=True
    )
    birth_place_id: Mapped[int] = mapped_column(
        ForeignKey("rank.id"), primary_key=True
    )

class Rank(Base):
    __tablename__ = "rank"

    id: Mapped[int]  = mapped_column(Integer, primary_key=True)
    german_name: Mapped[Optional[str]] = mapped_column(String)
    french_name: Mapped[Optional[str]] = mapped_column(String)
    note: Mapped[Optional[str]] = mapped_column(String)
    year_of_birth: Mapped[Optional[str]] = mapped_column(Integer)
    definition: Mapped[Optional[str]] = mapped_column(String)


class BirthPlace(Base):
    __tablename__ = "birth_place"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    name: Mapped[Optional[str]] = mapped_column(String)
    canton: Mapped[Optional[str]] = mapped_column(String)


class Citizenship(Base):
    __tablename__ = "citizenship"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String)

class CitizenShipRelationPerson(Base):
    __tablename__ = "citizenship_relation_person"
    citizenship_id: Mapped[int] = mapped_column(
        ForeignKey("citizenship.id"), primary_key=True
    )
    person_id: Mapped[int] = mapped_column(
        ForeignKey("person.id"), primary_key=True
    )






