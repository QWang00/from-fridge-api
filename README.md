# 🧊 FromFridge API

A Spring Boot RESTful API that helps users reduce food waste by managing fridge ingredients and discovering recipes based on available items.

---

## 🛠️ Tech Stack

- Java 17+
- Spring Boot 3.x
- Spring Web (REST)
- Spring Data JPA (PostgreSQL)
- Lombok
- Springdoc OpenAPI (Swagger UI)
- JUnit 5 + Mockito (unit tests)

---

## 📦 Features

- Add or remove ingredients from a virtual fridge
- Search for recipes by up to 5 ingredient names
- Preview matched recipes with number of matched ingredients
- View recipe detail, including which ingredients you already have

---

## 🌐 REST API Endpoints

### 🧊 Fridge Endpoints

| Method | Endpoint |
|--------|----------|
| `GET`  | `/api/v1/from-fridge/fridge/ingredients` – Get all fridge ingredients |
| `POST` | `/api/v1/from-fridge/fridge/ingredient?ingredient=...` – Add an ingredient |
| `DELETE` | `/api/v1/from-fridge/fridge/ingredient/{id}` – Remove a specific ingredient |
| `DELETE` | `/api/v1/from-fridge/fridge/ingredients` – Clear all fridge ingredients |

### 🍽️ Recipe Endpoints

| Method | Endpoint |
|--------|----------|
| `GET`  | `/api/v1/from-fridge/recipes/search?ingredientNames=...` – Search recipes by up to 5 ingredients |
| `GET`  | `/api/v1/from-fridge/recipes/{id}/detail?matchedIngredients=...` – Get full recipe detail with matched ingredient flags |

---

## 🔍 API Documentation (Swagger)

- Swagger UI: [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)
- OpenAPI JSON: [http://localhost:8080/api-docs](http://localhost:8080/api-docs)

> Swagger is powered by [springdoc-openapi-starter-webmvc-ui](https://mvnrepository.com/artifact/org.springdoc/springdoc-openapi-starter-webmvc-ui)

---

## 🚀 Running the Application

### Prerequisites

- Java 17+
- Maven
- PostgreSQL database

---

## 🧪 Running Locally

1. Clone the repo:

   ```bash
   git clone https://github.com/QWang00/from-fridge-api.git
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

