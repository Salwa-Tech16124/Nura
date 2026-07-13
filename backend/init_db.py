from app.database.connection import engine, Base
from app.database import models

print("Creating tables...")
Base.metadata.create_all(bind=engine)
print("Tables created successfully!")