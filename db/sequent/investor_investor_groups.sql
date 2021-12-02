CREATE TABLE investor_investor_groups (
    id SERIAL PRIMARY KEY,
    investor_group_aggregate_id uuid NOT NULL,
    investor_aggregate_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT fk_investor_group
        FOREIGN KEY(investor_group_aggregate_id)
            REFERENCES investor_groups(aggregate_id),
    CONSTRAINT fk_investor
        FOREIGN KEY(investor_aggregate_id)
            REFERENCES investors(aggregate_id)
);