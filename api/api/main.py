from fastapi import FastAPI, Request, Response, Depends, HTTPException
from sqlalchemy.orm import Session
from movies.protos.packages import User, Movies, Movie, Rental
from movies.models import Base, RentalDB, engine, SessionLocal, UserDB, MovieDB

app = FastAPI()

Base.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.post("/login")
async def login(request: Request, db=Depends(get_db)):
    message = await request.body()
    user = User()
    user.parse(message)

    user_db = db.query(UserDB).filter(UserDB.username == user.username).first()

    if user_db and user_db.password == user.password:
        user.id = user_db.id
        return Response(status_code=200, content=bytes(user)) 
    else:
        raise HTTPException(status_code=401, detail="Credenciais inválidas")


@app.get("/available-movies")
def avaialable_movies(db: Session = Depends(get_db)):
    movies = Movies()

    movies_db = db.query(MovieDB).all()

    for movie_db in movies_db:
        movie = Movie(movie_db.id, movie_db.title, movie_db.cover, movie_db.value, movie_db.year, movie_db.director, movie_db.sinopse)
        movies.movies.append(movie)

    return Response(content=bytes(movies), status_code=200)


@app.post("/movies-rental-by-user")
async def movies_rental_by_user(request: Request, db=Depends(get_db)):
    movies = Movies()

    message = await request.body()
    user = User()
    user.parse(message)

    rentals = (
        db.query(RentalDB)
        .filter(RentalDB.user_id == user.id)
        .filter(RentalDB.is_active == True)
        .all()
    )

    for rental in rentals:
        movie_db = db.query(MovieDB).filter(MovieDB.id == rental.movie_id).first()

        if movie_db:
            movie = Movie()
            movie.id = movie_db.id
            movie.title = movie_db.title
            movie.cover = movie_db.cover
            movie.year = movie_db.year
            movie.director = movie_db.director
            movie.sinopse = movie_db.sinopse
            movie.value = movie_db.value

            movies.movies.append(movie)
    
    return Response(content=bytes(movies), status_code=200)

@app.post("/rental-movie")
async def rental_movie(request: Request, db=Depends(get_db)):
    message = await request.body()
    rental = Rental()
    rental.parse(message)

    new_rental = RentalDB(user_id = rental.user_id, movie_id=rental.movie_id, is_active=True)

    db.add(new_rental)
    db.commit()

    return Response(status_code=200)

@app.post("/watch-movie")
async def watch_movie(request: Request, db=Depends(get_db)):
    message = await request.body()
    rental = Rental()
    rental.parse(message)

    rental_db = db.query(RentalDB).filter(RentalDB.user_id == rental.user_id, RentalDB.movie_id == rental.movie_id, RentalDB.is_active == True).first()
    
    if rental_db:
        rental_db.is_active = False
        db.commit()
    
    return Response(status_code=200)
    

