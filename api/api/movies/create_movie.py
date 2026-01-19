from movies.models import SessionLocal, Base, engine, MovieDB

Base.metadata.create_all(bind=engine)

def create_movie(title: str, value: float, cover_path, year, director, sinopse):
    db = SessionLocal()
    try:
        cover_bytes = None
        if cover_path:
            with open(cover_path, "rb") as f:
                cover_bytes = f.read()

        new_movie = MovieDB(title=title, value=value, cover=cover_bytes, year=year, director=director, sinopse=sinopse)
        db.add(new_movie)
        db.commit()
        db.refresh(new_movie)

        print(f"✅ Filme '{title}' criado com id={new_movie.id}")
    finally:
        db.close()

if __name__ == "__main__":
    import sys
    if len(sys.argv) < 3:
        print("Uso: python create_movie.py <title> <value> [<cover_path>]")
    else:
        title = sys.argv[1]
        value = float(sys.argv[2])
        cover_path = sys.argv[3]
        year = sys.argv[4]
        director = sys.argv[5]
        sinopse = sys.argv[6]
        create_movie(title, value, cover_path, year, director, sinopse)
