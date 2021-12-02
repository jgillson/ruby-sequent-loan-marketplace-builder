CREATE TABLE marketplaces (
    aggregate_id uuid,
    name character varying,
    loan_aggregate_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    PRIMARY KEY(aggregate_id),
        CONSTRAINT fk_loan
            FOREIGN KEY(loan_aggregate_id)
                REFERENCES loans(aggregate_id)
);