INSERT INTO account (username,sha_pass_hash,gmlevel)
VALUE ('GM', SHA1(CONCAT(UPPER('gm'), ':', UPPER('password1234'))),3)