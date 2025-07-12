-- name: CreateFeedFollow :one
WITH inserted_feed_follows AS (
    INSERT INTO feed_follows (id, created_at, updated_at, feed_id, user_id)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING *
)
SELECT 
    inserted_feed_follows.*,
    feeds.name AS feed_name,
    users.name AS user_name
FROM inserted_feed_follows
JOIN feeds ON inserted_feed_follows.feed_id = feeds.id
JOIN users ON inserted_feed_follows.user_id = users.id; 
--

-- name: GetFeedFollowsForUser :many
SELECT feed_follows.*, feeds.name AS feed_name, users.name AS user_name
FROM feed_follows
INNER JOIN feeds ON feed_follows.feed_id = feeds.id
INNER JOIN users ON feed_follows.user_id = users.id
WHERE feed_follows.user_id = $1;
--

-- name: DeleteFeedFollow :exec
DELETE FROM feed_follows
WHERE feed_id = $1 AND user_id = $2;
--