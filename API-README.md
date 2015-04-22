#Introduction

TODO

---

#Errors

There are a set number of possible errors to receive as a response, with associated HTTP status codes. These errors can apply to any endpoint. Other more specific errors are listed in the notes of the endpoint where they are applicable.

## Missing Resource
If you attempt to access a resource ID that does not exist, you will receive this error as a response.

Response:

	Status: 404
	Body:
	{ "message":"Object does not exist." }

## Missing Authentication Token
If you attempt to access an authentication-blocked resources, you will receive this error as a response.

Response:

	Status: 401 Unauthorized
	Body:
	{ "message":"Authentication token missing or invalid" }

## Invalid JSON Data
If your JSON object is incorrectly formatted, you will receive this error as a response.

Response:

	Status: 400 Bad Request
	Body:
	{ “message”:”Problems parsing JSON” }

## Invalid Object Data
If the content of your object is incorrectly formatted (sending a string where a number is required, etc), required fields are missing, or unique fields contain duplicates (unique email, etc), you will receive this error as a response.
Possible values for the "code" key of an error are:

- `missing_field`
- `unique_field`
- `incorrect_field`

Response:

	Status: 422 Unprocessable Entity
	Body:
	{
		“message”:”Validation failed”,
		"errors": [
			{
				"resource":"",
				"field":"",
				"code":""
			}
		]
	}

---

#Users

###Creating a new user

POST: `/api/v1/users`

Required fields:

- `email - must be unique`
- `password - must be 8 characters minimum`

Success response:

  Status: 201

###Editing a user

PATCH: `/api/v1/users/:id`

Allowed fields:

- `email - must be unique`
- `password - password must be 8 characters minimum`

Success response:

    Status: 200
    Body:
    {"id":#,"email":"user_email","authentication_token":"token_value"}

Failure response:
    Status: 422
---

#Sessions

###Creating a new session / signing in

POST: `/api/v1/sessions`

Required fields:

- `email`
- `password`

Success response:

    Status: 201
    Body:
    { "auth_token":" 'token_string' " }

Failure response:

    Status: 401
    Body:
    { "message":"Incorrect email or password" }

---

#Kid

All Kid endpoints require an authentication token.

###Listing kids

Returns a list of partial kid objects (`name` and `id` fields only) belonging to the user associated with the provided authentication token.

GET: `/api/v1/kids`

Success response:

	Status: 200
	Body:
	[
		{ "id":"1", "name":"Bobby" },
		{ "id":"2", "name":"Jenny" }
	]

###Getting a kid

Returns a full kid object with all fields.

GET: `/api/v1/kids/:id`

Success response:

	Status: 200
	Body:
	{
		"id": "1",
		"name": "Bobby",
		"dob": "14-05-2005",
		"insurance_id": "123456",
		"nurse_phone": "555-867-5309",
		"notes": "Allergic to peanuts"
	}

###Creating a kid

POST: `/api/v1/kids`

Required fields:

- `name`

Allowed fields:

- `name`
- `dob` - Date of birth, formatted `dd-mm-yyyy`
- `insurance_id`
- `nurse_phone`
- 'notes'

Success response:

	Status: 201
	Body:
	{
		"id": "1",
		"name": "Bobby",
		"dob": "14-05-2005",
		"insurance_id": "123456",
		"nurse_phone": "555-867-5309",
		"notes": "Allergic to peanuts"
	}

###Editing a kid

PATCH: `/api/v1/kids/:id`

Allowed fields:

- `name`
- `dob`
- `insurance_id`
- `nurse_phone`
- 'notes'

Success response:

	Status: 201
	Body:
	{
		"id": "1",
		"name": "Bobby",
		"dob": "14-05-2005",
		"insurance_id": "123456",
		"nurse_phone": "555-867-5309",
		"notes": "Allergic to peanuts"
	}

###Deleting a kid

DELETE: `/api/v1/kids/:id`

Success response:

		Status: 204

---

#Event

All Event endpoints require an authentication token.
Events have four possible types, and certain fields will only apply to a specific event type.

**Medicine**: `Medicine`

- `name`
- `amount`

**Temperature**: `Temperature`

- `temperature`

**Height / Weight**: `HeightWeight`

- `height`
- `weight`

**Symptom**: `Symptom`

- `description`

###Listing events

GET: `/api/v1/kids/:kid_id/events`

Success Response:

	Status: 200
	Body:
	[
		{
			"id":"1",
			"datetime":"20-04-2015T12:20:00",
			"type":"Medicine",
			"name":"Advil",
			"amount":"2 pills"
		},
		{
			"id":"2",
			"datetime":"20-04-2015T12:45:00",
			"type":"Temperature",
			"temperature":"100.3"
		},
		{
			"id":"3",
			"datetime":"20-04-2015T12:55:00",
			"type":"HeightWeight",
			"height":"5'11",
			"weight":"80lb"
		},
		{
			"id":"4",
			"datetime":"20-04-2015T13:00:00",
			"type":"Symptom",
			"description":"bumps on arm"
		}
	]

###Creating an event

POST `/api/v1/kids/:kid_id/events`

Required fields:

- `type`
- `name` - required for type `Medicine`
- `temperature` - required for type `Temperature`, must be decimal number
- `height` or `weight` - at least one required for type `HeightWeight`
- `description` - associated with type `Symptom`

Allowed fields:

- `type`
- `datetime` - formatted as `dd-mm-yyyyThh:mm:ss`
- `name` - associated with type `Medicine`
- `amount` - associated with type `Medicine`
- `temperature` - associated with type `Temperature`
- `height` - associated with type `HeightWeight`
- `weight` - associated with type `HeightWeight`
- `description` - associated with type `Symptom`

Success response:

	Status: 201
	Body:
	{
		"id":"1",
		"datetime":"20-04-2015T12:20:00",
		"type":"Medicine",
		"name":"Advil",
		"amount":"2 pills"
	}

###Editing an event

PATCH `/api/v1/kids/:kid_id/events/:event_id`

Allowed fields:

- `type`
- `datetime` - formatted as `dd-mm-yyyyThh:mm:ss`
- `name` - associated with type `Medicine`
- `amount` - associated with type `Medicine`
- `temperature` - associated with type `Temperature`
- `height` - associated with type `HeightWeight`
- `weight` - associated with type `HeightWeight`
- `description` - associated with type `Symptom`

Success response:

	Status: 200
	Body:
	{
		"id":"1",
		"datetime":"20-04-2015T12:20:00",
		"type":"Medicine",
		"name":"Advil",
		"amount":"2 pills"
	}

###Deleting an event

DELETE `/api/v1/kids/:kid_id/events/:event_id`

Success response:

	Status: 204
