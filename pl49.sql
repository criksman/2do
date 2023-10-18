--1 y 2 Se genera un error porque recibe muchas files ya que muchos empleados pueden estar asociados al mismo supervior.

/*SET SERVEROUTPUT ON;
DECLARE
    v_nomemp VARCHAR2(50);
    cursor c1 is SELECT nom_emp FROM empleado WHERE cod_emp = 7839;
BEGIN
    open c1;
        loop
            fetch c1 into v_nomemp;
            exit when c1%notfound;
            dbms_output.put_line('La lectura del cursor es: ' || v_nomemp);
        end loop;
    close c1;
end;*/

--3
/*
SET SERVEROUTPUT ON;
DECLARE
    v_nomemp empleado.nom_emp%type;
BEGIN
    select nom_emp into v_nomemp from empleado where cod_supervisor = 7368;
EXCEPTION
    when NO_DATA_FOUND then
        dbms_output.put_line('No se encontraron empleados');
END;
*/


--4
/*
DECLARE
    cursor c1 is select nom_depto from depto where cod_depto != 10;
    r_dep c1%rowtype;
BEGIN
    open c1;
        loop
            fetch c1 into r_dep;
            if c1%found then
                dbms_output.put_line('Nombre depto: ' || r_dep.nom_depto);
            else
                exit;
            end if;
        end loop;
    close c1;
end;
*/


--5
/*
DECLARE
    cursor c1 is select e.cod_emp, e.nom_emp, d.nom_depto from empleado e
                         inner join depto d on e.cod_depto = d.cod_depto;
    v_cod_emp empleado.cod_emp%type;
    v_nom_emp empleado.nom_emp%type;
    v_nom_depto depto.nom_depto%type;
BEGIN
    open c1;
        loop
            fetch c1 into v_cod_emp, v_nom_emp, v_nom_depto;
            exit when c1%notfound;
            dbms_output.put_line('Codigo: ' || v_cod_emp || ', Nombre: ' || v_nom_emp || ', Nom. depto: ' || v_nom_depto);
        end loop;
        dbms_output.put_line('Total de filas: ' || c1%ROWCOUNT);
    close c1;
end;

*/


--6
/*
DECLARE
    cursor c1 is select e.cod_emp, e.nom_emp, d.nom_depto from empleado e
                         inner join depto d on e.cod_depto = d.cod_depto;
    v_cod_emp empleado.cod_emp%type;
    v_nom_emp empleado.nom_emp%type;
    v_nom_depto depto.nom_depto%type;
BEGIN
    open c1;
        fetch c1 into v_cod_emp, v_nom_emp, v_nom_depto;
        while c1%found
        loop
            fetch c1 into v_cod_emp, v_nom_emp, v_nom_depto;
            dbms_output.put_line('Codigo: ' || v_cod_emp || ', Nombre: ' || v_nom_emp || ', Nom. depto: ' || v_nom_depto);
        end loop;
        dbms_output.put_line('Total de filas: ' || c1%ROWCOUNT);
    close c1;
end;
*/


--7
/*DECLARE
    cursor c1 is select e.cod_emp, e.nom_emp, d.nom_depto from empleado e
                         inner join depto d on e.cod_depto = d.cod_depto;
    cont NUMBER;                     
BEGIN
    for reg in c1
    loop
        dbms_output.put_line('Codigo: ' || reg.cod_emp || ', Nombre: ' || reg.nom_emp || ', Nom. depto: ' || reg.nom_depto);
        cont := c1%rowcount;
    end loop;
    dbms_output.put_line('Total de filas: ' || cont);
end;*/

--8
/*DECLARE
    cursor c1 is select cod_supervisor from empleado where cod_supervisor = 7566 for update;
    r_cod_supervisor c1%rowtype;
BEGIN
    open c1;
        fetch c1 into r_cod_supervisor;
        while c1%found
        loop
            update empleado
            set cod_supervisor = 7697
            where current of c1;
            fetch c1 into r_cod_supervisor;
        end loop;
    close c1;
END;*/
