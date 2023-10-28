
--1
SET SERVEROUTPUT ON
SET VERIFY OFF

DECLARE
  v_cod_depto empleado.cod_depto%TYPE := &num;
  v_cant INTEGER := 0;
BEGIN
  IF v_cod_depto = 10 OR v_cod_depto = 20 THEN
    SELECT COUNT(DISTINCT cod_supervisor) INTO v_cant FROM empleado WHERE cod_depto = v_cod_depto;
    DBMS_OUTPUT.PUT_LINE('Cantidad de empleados con código de departamento = ' || v_cod_depto || ': ' || v_cant);
  ELSIF v_cod_depto = 30 OR v_cod_depto = 40 THEN
    SELECT COUNT(DISTINCT cod_supervisor) into v_cant FROM empleado WHERE cod_depto != v_cod_depto;
    DBMS_OUTPUT.PUT_LINE('Cantidad de empleados con código de departamento = ' || v_cod_depto || ': ' || v_cant);
  ELSE
    DBMS_OUTPUT.PUT_LINE('El código de departamento no existe.');
  END IF;
END;

--2
SET SERVEROUTPUT ON
SET VERIFY OFF

DECLARE
  v_cod_emp empleado.cod_emp%TYPE := &codigo_emp;
  v_cod_supervisor empleado.cod_supervisor%TYPE;
BEGIN
  --obtener cod_supervisor del empleado a borrar
  SELECT cod_supervisor INTO v_cod_supervisor FROM EMPLEADO WHERE cod_emp = v_cod_emp;
  
  --cambiar los empleado que dependen del empleado a borrar a su cod_supervisor
  UPDATE empleado
  SET cod_supervisor = v_cod_supervisor
  WHERE cod_supervisor = v_cod_emp;
  
  --eliminar al empleado solicitado
  DELETE FROM EMPLEADO WHERE cod_emp = v_cod_emp;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('El código de empleado no existe.');
END;
  
--3
SET serveroutput ON
SET verify OFF
DECLARE
  v_cod_depto depto.cod_depto%type:=&depto;
  v_nom_depto depto.nom_depto%type:='&nom';
  v_num NUMBER;
  v_ubic depto.ubicacion%type:='&ubicacion';
  nombre_repetido EXCEPTION;
BEGIN
  SELECT COUNT(nom_depto) INTO v_num FROM depto WHERE nom_depto = v_nom_depto;
  IF v_num = 1 THEN
    dbms_output.put_line('err. nombre de depto duplicado');
  ELSIF v_num = 0 THEN
    INSERT INTO depto VALUES(v_cod_depto, v_nom_depto, v_ubic);
      dbms_output.put_line('inserción realizada');
END IF;
EXCEPTION
  WHEN dup_val_on_index THEN
    dbms_output.put_line('err. número de depto duplicado');
END;

--4
SET SERVEROUTPUT ON
SET VERIFY OFF

DECLARE
  cursor c1 is select e.nom_emp, d.nom_depto 
  from empleado e
  inner join depto d
  on e.cod_depto = d.cod_depto
  where e.salario_sem = (select max(salario_sem) from empleado);
BEGIN
  for reg in c1
  loop
    dbms_output.put_line('Nombre = ' || reg.nom_emp || 'Nom. Depto = ' || reg.nom_depto);
  end loop;
END;

