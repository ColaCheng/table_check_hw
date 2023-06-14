## Order APIs

### Count customers by restaurant name

**Request**:

```
GET /v1/orders/restaurants/{restaurant_name}/customers/count
```

*restaurant_name* - Restaurant name want to check.

**Response**:

```
HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

result:
10
```

### Get revenue by restaurant name

**Request**:

```
GET /v1/orders/restaurants/{restaurant_name}/revenue
```

*restaurant_name* - Restaurant name want to check.

**Response**:

```
HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

result:
1000.1
```

### Get the most popular dish at restaurant

**Request**:

```
GET /v1/orders/restaurants/dishes/top
```

**Response**:

```
HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

result:
[
  {
    "restaurant_name": "the-restaurant-at-the-end-of-the-universe",
    "food_name": "chips",
    "count": 500
  },...
]
```

### Get the most profitable dish at each restaurant

**Request**:

```
GET /v1/orders/restaurants/dishes/profit/top
```

**Response**:

```
HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

result:
[
  {
    "restaurant_name": "johnnys-cashew-stand",
    "food_name": "juice",
    "sum": 5989.0
  },...
]
```

### Get the top customer at each restaurant

**Request**:

```
GET /v1/orders/restaurants/customers/top
```

**Response**:

```
HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

result:
[
  {
    "first_name": "Michael",
    "restaurant_name": "the-ice-cream-parlor",
    "visit_count": 915
  },...
]
```

### Get the top customer

**Request**:

```
GET /v1/orders/customers/top
```

**Response**:

```
HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

result:
{
  "first_name": "Michael",
  "visit_count": 3462
}
```
