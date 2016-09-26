INSERT INTO account (username, sha_pass_hash, gmlevel, last_login)
VALUE ('GM', SHA1(CONCAT(UPPER('gm'), ':', UPPER('password1234'))),3, "2006-04-25")