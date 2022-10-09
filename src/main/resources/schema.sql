
CREATE TABLE IF NOT EXISTS users
(
    user_id   BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    user_name VARCHAR(255)                            NOT NULL,
    email     VARCHAR(512)                            NOT NULL,
    CONSTRAINT pk_user PRIMARY KEY (user_id),
    CONSTRAINT UQ_USER_EMAIL UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS requests
(
    requests_id  BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    description  VARCHAR(512)                            NOT NULL,
    requestor_id BIGINT                                  NOT NULL,
    CONSTRAINT pk_request PRIMARY KEY (requests_id),
    CONSTRAINT fk_requestor_id_requests FOREIGN KEY (requestor_id) REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS items
(
    item_id     BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    item_name   VARCHAR(255)                            NOT NULL,
    description VARCHAR(512)                            NOT NULL,
    available   BOOLEAN                                 NOT NULL,
    owner_id    BIGINT,
    request_id  BIGINT,
    CONSTRAINT pk_item PRIMARY KEY (item_id),
    CONSTRAINT fk_user_id_items FOREIGN KEY (owner_id) REFERENCES users (user_id),
    CONSTRAINT fk_request_items FOREIGN KEY (request_id) REFERENCES requests (requests_id)
);

CREATE TABLE IF NOT EXISTS bookings
(
    booking_id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    start_date TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    end_date   TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    item_id    BIGINT,
    booker_id  BIGINT,
    status     VARCHAR(15)                             NOT NULL,
    CONSTRAINT pk_booking PRIMARY KEY (booking_id),
    CONSTRAINT fk_item_id_bookings FOREIGN KEY (item_id) REFERENCES items (item_id),
    CONSTRAINT fk_booker_id_bookings FOREIGN KEY (booker_id) REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS comments
(
    comment_id   BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    comment_text VARCHAR(512)                            NOT NULL,
    item_id      BIGINT,
    author_id    BIGINT,
    created      TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    CONSTRAINT pk_comment PRIMARY KEY (comment_id),
    CONSTRAINT fk_item_id_comments FOREIGN KEY (item_id) REFERENCES items (item_id),
    CONSTRAINT fk_author_id_comments FOREIGN KEY (author_id) REFERENCES users (user_id)
);