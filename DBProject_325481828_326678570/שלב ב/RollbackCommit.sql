##ROLLBACK:
UPDATE foodbasket
SET kind = 'change'
WHERE foodbasket_id = 1;

select * from foodbasket 
ORDER BY foodbasket_id ASC;

ROLLBACK;

select * from foodbasket 
ORDER BY foodbasket_id ASC;


##COMMIT
UPDATE foodbasket
SET kind = 'family'
WHERE foodbasket_id = 1;

select * from foodbasket 
ORDER BY foodbasket_id ASC;
COMMIT;


select * from foodbasket 
ORDER BY foodbasket_id ASC;
