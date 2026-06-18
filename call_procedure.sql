-- call test59()

declare
    out1 int;

begin 
    DBMS_OUTPUT.put_line('---- this my second line ------');
    test59(7,out1);
    dbms_output.put_line('out return value :: '|| ' ' || out1);

end;


-- IN  => type of perameter which is used to pass a value to the precedure ( value accept karta hai)


select employee_id,first_name,salary,INCREASE_SALARY(salary) from emp100;