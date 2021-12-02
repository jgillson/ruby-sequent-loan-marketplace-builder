CREATE TABLE loans (
    aggregate_id uuid PRIMARY KEY,
    borrower_aggregate_id uuid NOT NULL,
    investor_aggregate_id uuid NOT NULL,
    name character varying,
    amount float,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);