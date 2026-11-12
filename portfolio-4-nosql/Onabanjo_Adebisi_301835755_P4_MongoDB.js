// Run once in mongosh against a fresh exercise database.
// These records are fictional events for the case study.
(async function () {
  db = db.getSiblingDB('portfolio_nosql');
  if ((await db.getCollectionNames()).includes("reservation_events")) {
    throw new Error('The exercise collection already exists. Use a fresh database.');
  }

  // The validator checks the stable event fields while details can vary.
  await db.createCollection("reservation_events", {
    validator: {
    "$jsonSchema": {
        "bsonType": "object",
        "required": [
            "_id",
            "schemaVersion",
            "simulation",
            "eventType",
            "occurredAt",
            "source",
            "embedded",
            "references",
            "details"
        ],
        "properties": {
            "_id": {
                "bsonType": "string",
                "minLength": 1
            },
            "schemaVersion": {
                "enum": [
                    1
                ]
            },
            "simulation": {
                "enum": [
                    true
                ]
            },
            "eventType": {
                "bsonType": "string",
                "enum": [
                    "reservation_created",
                    "reservation_confirmed"
                ]
            },
            "occurredAt": {
                "bsonType": "date"
            },
            "source": {
                "bsonType": "object",
                "required": [
                    "entity",
                    "key",
                    "snapshot"
                ],
                "properties": {
                    "entity": {
                        "enum": [
                            "reservations"
                        ]
                    },
                    "key": {
                        "bsonType": "object",
                        "required": [
                            "reservation_id"
                        ]
                    },
                    "snapshot": {
                        "bsonType": "object"
                    }
                }
            },
            "embedded": {
                "bsonType": "object"
            },
            "references": {
                "bsonType": "object"
            },
            "details": {
                "bsonType": "object"
            }
        }
    }
},
    validationLevel: 'strict', validationAction: 'error'
  });

  // Insert the four example events and show their IDs.
  printjson(await db.getCollection("reservation_events").insertMany([
    {
        "_id": "event_000001",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "reservation_created",
        "occurredAt": ISODate("2030-01-01T10:00:00Z"),
        "source": {
            "entity": "reservations",
            "key": {
                "reservation_id": 201
            },
            "snapshot": {
                "reservation_id": 201,
                "guest_id": 1,
                "room_id": 101,
                "check_in": "2026-12-01",
                "check_out": "2026-12-03",
                "status": "confirmed",
                "booked_at": "2026-10-10T09:30:00Z"
            }
        },
        "embedded": {
            "guests": [
                {
                    "key": {
                        "guest_id": 1
                    },
                    "snapshot": {
                        "guest_id": 1,
                        "email": "alex.river@example.test",
                        "full_name": "Alex River",
                        "phone": "+1-555-0101"
                    },
                    "via": [
                        "reservations.guest_id → guests"
                    ]
                }
            ],
            "rooms": [
                {
                    "key": {
                        "room_id": 101
                    },
                    "snapshot": {
                        "room_id": 101,
                        "room_number": "101",
                        "room_type": "standard",
                        "nightly_rate": 120,
                        "active": true
                    },
                    "via": [
                        "reservations.room_id → rooms"
                    ]
                }
            ]
        },
        "references": {},
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000002",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "reservation_confirmed",
        "occurredAt": ISODate("2030-01-01T10:01:00Z"),
        "source": {
            "entity": "reservations",
            "key": {
                "reservation_id": 201
            },
            "snapshot": {
                "reservation_id": 201,
                "guest_id": 1,
                "room_id": 101,
                "check_in": "2026-12-01",
                "check_out": "2026-12-03",
                "status": "confirmed",
                "booked_at": "2026-10-10T09:30:00Z"
            }
        },
        "embedded": {
            "guests": [
                {
                    "key": {
                        "guest_id": 1
                    },
                    "snapshot": {
                        "guest_id": 1,
                        "email": "alex.river@example.test",
                        "full_name": "Alex River",
                        "phone": "+1-555-0101"
                    },
                    "via": [
                        "reservations.guest_id → guests"
                    ]
                }
            ],
            "rooms": [
                {
                    "key": {
                        "room_id": 101
                    },
                    "snapshot": {
                        "room_id": 101,
                        "room_number": "101",
                        "room_type": "standard",
                        "nightly_rate": 120,
                        "active": true
                    },
                    "via": [
                        "reservations.room_id → rooms"
                    ]
                }
            ]
        },
        "references": {},
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "special_requests": "illustrative special_requests",
                "promotion_code": "illustrative promotion_code",
                "loyalty_tier": "illustrative loyalty_tier"
            }
        }
    },
    {
        "_id": "event_000003",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "reservation_created",
        "occurredAt": ISODate("2030-01-01T10:02:00Z"),
        "source": {
            "entity": "reservations",
            "key": {
                "reservation_id": 202
            },
            "snapshot": {
                "reservation_id": 202,
                "guest_id": 2,
                "room_id": 102,
                "check_in": "2026-12-05",
                "check_out": "2026-12-07",
                "status": "held",
                "booked_at": "2026-10-11T14:15:00+00:00"
            }
        },
        "embedded": {
            "guests": [
                {
                    "key": {
                        "guest_id": 2
                    },
                    "snapshot": {
                        "guest_id": 2,
                        "email": "sam.lake@example.test",
                        "full_name": "Sam Lake",
                        "phone": null
                    },
                    "via": [
                        "reservations.guest_id → guests"
                    ]
                }
            ],
            "rooms": [
                {
                    "key": {
                        "room_id": 102
                    },
                    "snapshot": {
                        "room_id": 102,
                        "room_number": "102",
                        "room_type": "deluxe",
                        "nightly_rate": 185,
                        "active": true
                    },
                    "via": [
                        "reservations.room_id → rooms"
                    ]
                }
            ]
        },
        "references": {},
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000004",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "reservation_confirmed",
        "occurredAt": ISODate("2030-01-01T10:03:00Z"),
        "source": {
            "entity": "reservations",
            "key": {
                "reservation_id": 202
            },
            "snapshot": {
                "reservation_id": 202,
                "guest_id": 2,
                "room_id": 102,
                "check_in": "2026-12-05",
                "check_out": "2026-12-07",
                "status": "held",
                "booked_at": "2026-10-11T14:15:00+00:00"
            }
        },
        "embedded": {
            "guests": [
                {
                    "key": {
                        "guest_id": 2
                    },
                    "snapshot": {
                        "guest_id": 2,
                        "email": "sam.lake@example.test",
                        "full_name": "Sam Lake",
                        "phone": null
                    },
                    "via": [
                        "reservations.guest_id → guests"
                    ]
                }
            ],
            "rooms": [
                {
                    "key": {
                        "room_id": 102
                    },
                    "snapshot": {
                        "room_id": 102,
                        "room_number": "102",
                        "room_type": "deluxe",
                        "nightly_rate": 185,
                        "active": true
                    },
                    "via": [
                        "reservations.room_id → rooms"
                    ]
                }
            ]
        },
        "references": {},
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "special_requests": "illustrative special_requests",
                "promotion_code": "illustrative promotion_code",
                "loyalty_tier": "illustrative loyalty_tier"
            }
        }
    }
]));
  await db.getCollection("reservation_events").createIndex({eventType: 1, occurredAt: -1}, {name: 'event_type_time'});

  // 1. Find the first sample event type (up to five documents).
  printjson(await db.getCollection("reservation_events").find({"eventType":"reservation_created"}).sort({_id:1}).limit(5).toArray());

  // 2. Find events for the first source record using nested key fields (up to five).
  printjson(await db.getCollection("reservation_events").find({"source.key.reservation_id":201}).sort({_id:1}).limit(5).toArray());

  // 3. Find events in the sample time range using a MongoDB Date filter (up to five).
  printjson(await db.getCollection("reservation_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray());

  // 4. Count documents for each event type.
  printjson(await db.getCollection("reservation_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray());

  // A date stored as text should be rejected by the validator.
  try {
    await db.getCollection("reservation_events").insertOne({...{
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "reservation_created",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "reservations",
        "key": {
            "reservation_id": 201
        },
        "snapshot": {
            "reservation_id": 201,
            "guest_id": 1,
            "room_id": 101,
            "check_in": "2026-12-01",
            "check_out": "2026-12-03",
            "status": "confirmed",
            "booked_at": "2026-10-10T09:30:00Z"
        }
    },
    "embedded": {
        "guests": [
            {
                "key": {
                    "guest_id": 1
                },
                "snapshot": {
                    "guest_id": 1,
                    "email": "alex.river@example.test",
                    "full_name": "Alex River",
                    "phone": "+1-555-0101"
                },
                "via": [
                    "reservations.guest_id → guests"
                ]
            }
        ],
        "rooms": [
            {
                "key": {
                    "room_id": 101
                },
                "snapshot": {
                    "room_id": 101,
                    "room_number": "101",
                    "room_type": "standard",
                    "nightly_rate": 120,
                    "active": true
                },
                "via": [
                    "reservations.room_id → rooms"
                ]
            }
        ]
    },
    "references": {},
    "details": {
        "channel": "web"
    }
}, _id: 'invalid_date_example', occurredAt: 'not-a-date'});
  } catch (error) { print('Invalid date error: ' + error.code); }

  // Reusing an event ID should be rejected by the unique _id index.
  try { await db.getCollection("reservation_events").insertOne({
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "reservation_created",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "reservations",
        "key": {
            "reservation_id": 201
        },
        "snapshot": {
            "reservation_id": 201,
            "guest_id": 1,
            "room_id": 101,
            "check_in": "2026-12-01",
            "check_out": "2026-12-03",
            "status": "confirmed",
            "booked_at": "2026-10-10T09:30:00Z"
        }
    },
    "embedded": {
        "guests": [
            {
                "key": {
                    "guest_id": 1
                },
                "snapshot": {
                    "guest_id": 1,
                    "email": "alex.river@example.test",
                    "full_name": "Alex River",
                    "phone": "+1-555-0101"
                },
                "via": [
                    "reservations.guest_id → guests"
                ]
            }
        ],
        "rooms": [
            {
                "key": {
                    "room_id": 101
                },
                "snapshot": {
                    "room_id": 101,
                    "room_number": "101",
                    "room_type": "standard",
                    "nightly_rate": 120,
                    "active": true
                },
                "via": [
                    "reservations.room_id → rooms"
                ]
            }
        ]
    },
    "references": {},
    "details": {
        "channel": "web"
    }
}); }
  catch (error) { print('Duplicate ID error: ' + error.code); }

  print('Document count: ' + await db.getCollection("reservation_events").countDocuments());
})().catch(error => { print(error.stack || String(error)); quit(1); });
