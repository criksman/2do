--1
SET SERVEROUTPUT ON;
set verify off;

DECLARE
  v_cod_depto depto.cod_depto%type;
  v_cantidad number := 0;
BEGIN
  v_cod_depto := &codigo;
  if v_cod_depto = 10 or v_cod_depto = 20  then
    select count(DISTINCT cod_supervisor) into v_cantidad from empleado where cod_depto = v_cod_depto;
     dbms_output.put_line('La cantidad de supervisores con cod_depto ' || v_cod_depto || ' es: ' || v_cantidad);
  elsif v_cod_depto = 30 or v_cod_depto = 40 then
    select count(DISTINCT cod_supervisor) into v_cantidad from empleado where cod_depto = v_cod_depto;
     dbms_output.put_line('La cantidad de supervisores con cod_depto ' || v_cod_depto || ' es: ' || v_cantidad);
  else
    dbms_output.put_line('No existe el codigo de depto');
  end if;
  
END;

--2
DECLARE
  v_cod_emp empleado.cod_emp%type := &cod;
  v_cod_supervisor empleado.cod_supervisor%type;
BEGIN
  select cod_supervisor into v_cod_supervisor from empleado where cod_emp = v_cod_emp;
  
  update empleado
  set cod_supervisor = v_cod_supervisor
  where cod_supervisor = v_cod_emp;
  
  delete from empleado
  where cod_emp = v_cod_emp;
  
EXCEPTION
  when no_data_found then
    dbms_output.put_line('No existe');
END;

--3
DECLARE
  v_cod_depto depto.cod_depto%type := '&codigo';
  v_nom_depto depto.nom_depto%type := '&nom';
  v_ubicacion depto.ubicacion%type;
  
  nom_repetido EXCEPTION;
  v_cantidad Number;
BEGIN
  select count(nom_depto, cod_depto) into v_cantidad from depto where nom_depto = v_nom_depto;
  if v_cantidad > 0 then
    dbms_output.put_line('Departamento ya existe');
  else
    v_ubicacion := '&ubicacion';
    insert into depto(cod_depto, nom_depto, ubicacion)
      values(v_cod_depto, v_nom_depto, v_ubicacion);
  end if;
-- falta los exceptions
END;
  