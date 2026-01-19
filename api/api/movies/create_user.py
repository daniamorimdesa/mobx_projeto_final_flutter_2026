from movies.models import SessionLocal, Base, engine, UserDB

# garante que a tabela existe
Base.metadata.create_all(bind=engine)

def create_user(username: str, password: str):
    db = SessionLocal()
    try:
        # verificar se já existe
        existing = db.query(UserDB).filter(UserDB.username == username).first()
        if existing:
            print(f"❌ Usuário '{username}' já existe.")
            return

        # criar novo
        new_user = UserDB(username=username, password=password)
        db.add(new_user)
        db.commit()
        print(f"✅ Usuário '{username}' criado com sucesso!")
    finally:
        db.close()

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 3:
        print("Uso: python create_user.py <username> <password>")
    else:
        _, username, password = sys.argv
        create_user(username, password)
