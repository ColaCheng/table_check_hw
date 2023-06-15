## APIs

### Health

**Request**:

```
GET /health
```

**Response**:

```
HTTP/1.1 204 No Content
```

### Metrics

The endpoint for Prometheus to scrape the metrics.

**Request**:

```
GET /metrics
```

**Response**:

```
HTTP/1.1 200 OK

result:
# HELP table_check_hw_http_requests
# TYPE table_check_hw_http_requests histogram
table_check_hw_http_requests_bucket{env="unknown",method="GET",route="/metrics",service="table_check_hw",status="200",le="10207.234282"} 1
table_check_hw_http_requests_bucket{env="unknown",method="GET",route="/metrics",service="table_check_hw",status="200",le="+Inf"} 1
table_check_hw_http_requests_sum{env="unknown",method="GET",route="/metrics",service="table_check_hw",status="200"} 9851
table_check_hw_http_requests_count{env="unknown",method="GET",route="/metrics",service="table_check_hw",status="200"} 1
```

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
