from typing import Dict, List, Optional, Tuple 


from sqlalchemy import (
    Float,
    ForeignKey,
    Integer,
    String,
    Column
)

import sqlalchemy
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship 
from sqlalchemy.ext.declarative import declarative_base

from sqlalchemy.dialects import sqlite, mysql

from database_creation import *


"""
This file simply defines a set of sqlite classes
which get mapped onto a set of database tables later
"""


# define tables for sqlite table
Base = declarative_base()

class Person(Base):
    __tablename__ = "person"

    id: Mapped[int] = Column(Integer, primary_key=True)
    name: Mapped[Optional[str]] = Column(String)
    first_name: Mapped[Optional[str]] = Column(String)
    birth_date: Mapped[Optional[str]] = Column(String)
    uncleaned_birth_place_name: Mapped[str] = Column(String)
    birthplace_notes: Mapped[Optional[str]] = Column(String)
    rank_id: Mapped[int] = Column(ForeignKey("rank.id"))
    birth_place_id: Mapped[int] = Column(ForeignKey("birth_place.id"))

class Rank(Base):
    __tablename__ = "rank"

    id: Mapped[int] = Column(Integer, primary_key=True)
    orginal_rank_value : Mapped[Optional[str]] = Column(String)
    german_rank: Mapped[Optional[str]] = Column(String)
    french_rank: Mapped[Optional[str]] = Column(String)
    wikidata_uri : Mapped[Optional[str]] = Column(String)

class BirthPlace(Base):
    __tablename__ = "birth_place"

    id: Mapped[int] = Column(Integer, primary_key=True)
    name: Mapped[Optional[str]] = Column(String)
    birth_canton: Mapped[Optional[str]] = Column(String)
    lat: Mapped[Optional[float]] = Column(Float)
    long: Mapped[Optional[float]] = Column(Float)
    wikidata_uri : Mapped[Optional[str]] = Column(String)


class Citizenship(Base):
    __tablename__ = "citizenship"

    id: Mapped[int] = Column(String, primary_key=True)
    name: Mapped[str] = Column(String)
    wikidata_uri: Mapped[str] = Column(String)

class CitizenShipRelationPerson(Base):
    __tablename__ = "citizenship_relation_person"
    citizenship_id: Mapped[int] = Column(
        ForeignKey("citizenship.id"), primary_key=True
    )
    person_id: Mapped[int] = Column(
        ForeignKey("person.id"), primary_key=True
    )

