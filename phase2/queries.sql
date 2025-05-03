-- Query 1: Retrieve All Media with Ratings and Average Scores
SELECT
    M.MediaID,
    M.Title,
    M.Type,
    AVG(R.Score) AS AverageScore
FROM
    Media M
LEFT JOIN
    Rating R
ON
    M.MediaID = R.MediaID
GROUP BY
    M.MediaID, M.Title, M.Type
ORDER BY
    AverageScore DESC;
--  Query 2: Find Users with Pending Subscriptions
SELECT
    U.UserID,
    U.Username,
    S.EndDate
FROM
    User U
JOIN
    Subscription S
ON
    U.UserID = S.UserID
WHERE
    S.EndDate BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days'
ORDER BY
    S.EndDate ASC;
-- Query 3: Most Popular Genres in the Media Library
SELECT
    M.Genre,
    COUNT(M.MediaID) AS TotalMedia
FROM
    Media M
GROUP BY
    M.Genre
ORDER BY
    TotalMedia DESC;
-- Query 4: Find Users Who Commented on a Specific Media
SELECT
    U.Username,
    C.Text AS Comment,
    M.Title AS MediaTitle
FROM
    Comment C
JOIN
    User U
ON
    C.UserID = U.UserID
JOIN
    Media M
ON
    C.MediaID = M.MediaID
WHERE
    M.Title = 'Inception';
-- Query 5: Watch Later List with Media Details
SELECT
    WL.UserID,
    U.Username,
    M.Title AS MediaTitle,
    M.Type AS MediaType
FROM
    WatchLater WL
JOIN
    User U
ON
    WL.UserID = U.UserID
JOIN
    Media M
ON
    WL.MediaID = M.MediaID
ORDER BY
    U.Username, M.Title;
