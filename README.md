

```markdown
# 🧊 FromFridge API

A Spring Boot RESTful API that helps users reduce food waste by managing fridge ingredients and discovering matching recipes based on available items.

---

## 🛠️ Tech Stack

- Java 17+
- Spring Boot 3.x
- Spring Web + Validation
- Spring Data JPA + PostgreSQL
- Lombok
- Springdoc OpenAPI 3 (Swagger UI)
- JUnit + Mockito (for testing)

---

## 📦 Features

### ✅ Fridge Management
- Add ingredient to fridge (`POST`)
- Remove specific ingredient from fridge (`DELETE`)
- Clear all fridge ingredients (`DELETE`)
- Get all ingredients currently in fridge (`GET`)

### ✅ Recipe Search & Details
- Search recipes by ingredient names (limit: 5)
- Get number of matched ingredients per recipe
- View full recipe detail including ingredients and which ones you already have

---

## 📚 REST API Endpoints

### 🔍 Search Recipes
```

GET /api/v1/from-fridge/recipes/search?ingredientNames=egg,tomato

````

Response:
```json
[
  {
    "title": "Tomato Egg Stir Fry",
    "imageUrl": "...",
    "matchedCount": 2,
    "matchedIngredients": ["Egg", "Tomato"]
  }
]
````

### 📋 Get Recipe Detail

```
GET /api/v1/from-fridge/recipes/{id}/detail?matchedIngredients=Egg,Tomato
```

Response:

```json
{
  "title": "Tomato Egg Stir Fry",
  "matchedCount": 2,
  "ingredients": [
    {"name": "Egg", "owned": true},
    {"name": "Tomato", "owned": true},
    {"name": "Salt", "owned": false}
  ]
}
```

### 🧊 Fridge Endpoints

* `GET /api/v1/from-fridge/fridge/ingredients` – Get all items in fridge
* `POST /api/v1/from-fridge/fridge/ingredient?ingredient=Egg` – Add item
* `DELETE /api/v1/from-fridge/fridge/ingredient/{id}` – Remove item by ID
* `DELETE /api/v1/from-fridge/fridge/ingredients` – Clear all

---

## 🧪 Running Locally

1. Clone the repo:

   ```bash
   git clone https://github.com/your-username/from-fridge-api.git
   cd from-fridge-api
   ```

2. Update DB config in `application.properties`:

   ```properties
   spring.datasource.url=jdbc:postgresql://localhost:5432/fridge_db
   spring.datasource.username=your_db_user
   spring.datasource.password=your_db_pass
   ```

3. Run the app:

   ```bash
   ./mvnw spring-boot:run
   ```

4. Access API:

   * Swagger UI: [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)
   * OpenAPI Spec: [http://localhost:8080/api-docs](http://localhost:8080/api-docs)


---

## ✨ Credits

Built for the Open University TM470 project on food waste reduction.

