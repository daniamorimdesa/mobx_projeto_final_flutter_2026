from sqlalchemy import Column, Integer, String, Float, LargeBinary, ForeignKey, DateTime, Boolean
from sqlalchemy.orm import declarative_base, sessionmaker, relationship
from sqlalchemy import create_engine
from datetime import datetime

DATABASE_URL = "sqlite:///./movies.db"

Base = declarative_base()
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False)

class UserDB(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True, nullable=False)
    password = Column(String, nullable=False)

    rentals = relationship("RentalDB", back_populates="user")  # <-- precisa existir!

class MovieDB(Base):
    __tablename__ = "movies"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    cover = Column(LargeBinary, nullable=True)   # bytes (imagem)
    value = Column(Float, nullable=False)
    sinopse = Column(String, nullable=False)
    year = Column(String, nullable=False)
    director = Column(String, nullable=False)

    rentals = relationship("RentalDB", back_populates="movie")  # <-- precisa existir!

class RentalDB(Base):
    __tablename__ = "rentals_v2"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    movie_id = Column(Integer, ForeignKey("movies.id"), nullable=False)
    rented_at = Column(DateTime, default=datetime.utcnow)
    is_active = Column(Boolean, default=False, nullable=False)

    user = relationship("UserDB", back_populates="rentals")
    movie = relationship("MovieDB", back_populates="rentals")
