--5
/*SET SERVEROUTPUT ON

declare
    v_sueldo number :=&v_num;
begin
    case
        when v_sueldo < 0 then
            dbms_output.put_line('menor a 0');
        when v_sueldo <= 13000 then
            dbms_output.put_line('Sueldo Nivel C');
        when v_sueldo <= 29999 then
            dbms_output.put_line('Sueldo Nivel B');
        when v_sueldo >= 30000 then
            dbms_output.put_line('Sueldo Nivel A');
    end case;
end;*/


--6
/*begin
    for num in 1..10 LOOP
        dbms_output.put_line('Valor: ' || num);
    end LOOP;
end;*/


--7
/*declare
    v_num NUMBER := &numero;
begin
    LOOP
        v_num := v_num + 1;
        dbms_output.put_line('Valor: ' || v_num);
        EXIT WHEN v_num = 100;
    END LOOP;
end;*/


--8
/*declare
    v_num NUMBER := &numero;
begin
    WHILE v_num <= 100 LOOP
        dbms_output.put_line('Valor: ' || v_num);
        v_num := v_num + 1;
    END LOOP;
end;*/


--9
/*declare
    grado SUELDO.grado%type;
    sueldo SUELDO.sueldo_minimo%type;*/