-- +goose Up
-- +goose StatementBegin
CREATE TABLE payments (
    user_id INTEGER PRIMARY KEY,
    total_balance INTEGER NOT NULL DEFAULT 0,
    reserved_balance INTEGER NOT NULL DEFAULT 0,
    available_balance INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT check_balances CHECK (
        total_balance >= 0 AND
        reserved_balance >= 0 AND
        available_balance >= 0 AND
        total_balance >= reserved_balance AND
        available_balance = total_balance - reserved_balance
    )
);

CREATE INDEX idx_payments_user_id ON payments(user_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS payments;
-- +goose StatementEnd
