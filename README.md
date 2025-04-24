# Aththatu

A versatile mobile application that offers various features for users and sellers.

## How to Run the Server

1. Open a terminal and navigate to the backend directory:
    ```bash
    cd backend/Aththatu
    ```

2. Run the server with the following command:
    ```bash
    python3 manage.py runserver
    ```

3. Now, the server should be running at http://localhost:8000.

## API Endpoints

### 1. Fetch User Profile by Username

- **Endpoint**: `GET /users/profile/{username}`
- **Description**: Retrieve a user's profile information by providing their username.
- **Example**:
  ```
  GET http://localhost:8000/users/profile/gunathilaka
  ```

### 2. Create a New User

- **Endpoint**: `POST /users/createprofile/`
- **Description**: Create a new user by sending a POST request with JSON body.
- **Example**:
  ```bash
  curl -X POST http://localhost:8000/users/createprofile/ \
     -H "Content-Type: application/json" \
     -d '{"username":"gunathilaka", "email":"test@gmail.com", "passwordhash":"123"}'
  ```

### 3. Get the Closest Seller to a Given Location

- **Endpoint**: `GET /filter/closet/seller`
- **Description**: Find the closest seller based on the user's geographical location.
- **Parameters**: Latitude, longitude, and an optional limit parameter (defaults to 5).
- **Example**:
  ```bash
  curl -X POST http://localhost:8000/filter/closet/seller \
     -H "Content-Type: application/json" \
     -d '{"latitude": 34.0522, "longitude": -118.2437, "limit": 5}'
  ```