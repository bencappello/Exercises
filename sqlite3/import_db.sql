CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body VARCHAR(255) NOT NULL,
  question_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  FOREIGN KEY(author_id) REFERENCES users(id)
  FOREIGN KEY(question_id) REFERENCES questions(id)
  FOREIGN KEY(parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Benjamin', 'Cappello'), ('Jonathan','Lee');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('wtf', 'what the f', (SELECT id FROM users WHERE lname = 'Cappello')),
  ('dsfad', 'ITS MADE OF PEOPLE', (SELECT id FROM users WHERE lname = 'Lee'));

INSERT INTO
  question_followers (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE lname = 'Lee'),(SELECT id FROM questions WHERE title = 'wtf')),
  ((SELECT id FROM users WHERE lname = 'Cappello'),(SELECT id FROM questions WHERE title = 'dsfad'));

INSERT INTO
  replies (body, question_id, author_id, parent_reply_id)
VALUES
  ('dsfiojasdf',(SELECT id FROM questions WHERE title = 'wtf'),(SELECT id FROM users WHERE lname = 'Lee'), NULL),
  ('omg',(SELECT id FROM questions WHERE title = 'wtf'),(SELECT id FROM users WHERE lname = 'Cappello'), NULL);

UPDATE replies
SET parent_reply_id = (SELECT id FROM replies WHERE body = 'dsfiojasdf')
WHERE body = 'omg';
