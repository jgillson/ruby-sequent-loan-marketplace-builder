CREATE TABLE borrowers (
    aggregate_id uuid,
    name character varying,
    description text,
    requested_amount float,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    PRIMARY KEY(aggregate_id)
);