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
	{ "message":"Authentication token required" }

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

- `username` - must be unique
- `password`

###Editing a user

PATCH: `/api/v1/users/:id`

Allowed fields:

- `username` - must be unique
- `password`

---

#Sessions

###Creating a new session / signing in

POST: `/api/v1/sessions`

Required fields:

- `username`
- `password`

Success response:

	Status: 200
	Body:
	{ "auth_token":"" }

Failure response:

	Status: 401
	Body:
	{ "message":"Incorrect username or password" }

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
		id: 1,
		name: 'Bobby',
		dob: '14-05-2005',
		insurance_id: '123456',
		nurse_phone: '555-867-5309'
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

Success response:

	Status: 201
	Body:
	{
		id: 1,
		name: 'Bobby',
		dob: '14-05-2005',
		insurance_id: '123456',
		nurse_phone: '555-867-5309'
	}

###Editing a kid

PATCH: `/api/v1/kids/:id`

Allowed fields:

- `name`
- `dob`
- `insurance_id`
- `nurse_phone`

Success response:

	Status: 201
	Body:
	{
		id: 1,
		name: 'Bobby',
		dob: '14-05-2005',
		insurance_id: '123456',
		nurse_phone: '555-867-5309'
	}

###Deleting a kid

DELETE: `/api/v1/kids/:id`

Success response:

	Status: 204

---

#Event

Events have four possible types, and certain fields will only apply to a specific event type.

**Medicine**: `medicine`

- `name`
- `amount`

**Temperature**: `temperature`

- `temperature`

**Height / Weight**: `heightweight`

- `height`
- `weight`

**Symptom**: `symptom`

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
			"type":"medicine",
			"name":"Advil",
			"amount":"2 pills"
		},
		{
			"id":"2",
			"datetime":"20-04-2015T12:45:00",
			"type":"temperature",
			"temperature":"100.3"
		},
		{
			"id":"3",
			"datetime":"20-04-2015T12:55:00",
			"type":"heightweight",
			"height":"5'11",
			"weight":"80lb"
		},
		{
			"id":"4",
			"datetime":"20-04-2015T13:00:00",
			"type":"symptom",
			"description":"bumps on arm"
		}
	]
	
###Creating an event

POST `/api/v1/kids/:kid_id/events`

Required fields:

- `type`
- `name` - required for type `medicine`
- `temperature` - required for type `temperature`, must be decimal number
- `height` or `weight` - at least one required for type `heightweight`
- `description` - associated with type `symptom`

Allowed fields:

- `type`
- `datetime` - formatted as `dd-mm-yyyyThh:mm:ss`
- `name` - associated with type `medicine`
- `amount` - associated with type `medicine`
- `temperature` - associated with type `temperature`
- `height` - associated with type `heightweight`
- `weight` - associated with type `heightweight`
- `description` - associated with type `symptom`

Success response:

	Status: 201
	Body:
	{
		"id":"1",
		"datetime":"20-04-2015T12:20:00",
		"type":"medicine",
		"name":"Advil",
		"amount":"2 pills"
	}

###Editing an event

PATCH `/api/v1/kids/:kid_id/events/:event_id`

Allowed fields:

- `type`
- `datetime` - formatted as `dd-mm-yyyyThh:mm:ss`
- `name` - associated with type `medicine`
- `amount` - associated with type `medicine`
- `temperature` - associated with type `temperature`
- `height` - associated with type `heightweight`
- `weight` - associated with type `heightweight`
- `description` - associated with type `symptom`

Success response:

	Status: 200
	Body:
	{
		"id":"1",
		"datetime":"20-04-2015T12:20:00",
		"type":"medicine",
		"name":"Advil",
		"amount":"2 pills"
	}

###Deleting an event

DELETE `/api/v1/kids/:kid_id/events/:event_id`

Success response:

	Status: 204