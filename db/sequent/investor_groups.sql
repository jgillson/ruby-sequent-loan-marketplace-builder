CREATE TABLE investor_groups (
    aggregate_id uuid,
    name character varying,
    description character varying,
    marketplace_aggregate_id uuid,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    PRIMARY KEY(aggregate_id),
        CONSTRAINT fk_marketplace
            FOREIGN KEY(marketplace_aggregate_id)
                REFERENCES marketplaces(aggregate_id)
);