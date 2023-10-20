--1 y 2 Se genera un error porque recibe muchas files ya que muchos empleados pueden estar asociados al mismo supervior.

SET SERVEROUTPUT ON;
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
end;

--3

SET SERVEROUTPUT ON;
DECLARE
    v_nomemp empleado.nom_emp%type;
BEGIN
    select nom_emp into v_nomemp from empleado where cod_supervisor = 7368;
EXCEPTION
    when NO_DATA_FOUND then
        dbms_output.put_line('No se encontraron empleados');
END;



--4

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



--5

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




--6

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


--7
DECLARE
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
end;


--8
DECLARE
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
END;


--9
SET SERVEROUTPUT ON;

DECLARE 
    CURSOR c_depto (p_ubica CHAR) is select * from depto where ubicacion =  p_ubica;
    
    reg_depto c_depto%ROWTYPE;
    v_ubica depto.ubicacion%type := 'Valpo';
BEGIN
    OPEN c_depto(v_ubica);
        fetch c_depto into reg_depto;
        DBMS_OUTPUT.PUT_LINE(reg_depto.cod_depto || ' ' || reg_depto.nom_depto || reg_depto.ubicacion);
    close c_depto;
END;


--10
set serveroutput on;
set verify off;
DECLARE
    mayor EXCEPTION;
    nulo EXCEPTION;
    
    v_fecha date := '&fecha';
BEGIN
    if v_fecha is null then
        raise nulo;
    elsif SYSDATE < v_fecha then
        raise mayor;
    end if;
EXCEPTION
    when mayor then
        DBMS_OUTPUT.PUT_LINE('LA FECHA INGRESADA ES MAYOR A LA FECHA ACTUAL');
    when nulo then
        DBMS_OUTPUT.PUT_LINE('LA FECHA INGRESA ES NULA');
END;


--11 Se gatilla la excepcion DUP_VAL_ON_INDEX cuando se inresa un cod_depto que ya se encuentra en la tabla.
set serveroutput on;
set verify off;
declare
  v_coddepto depto.cod_depto%type := &codigo;
  v_nomdepto depto.nom_depto%type := '&nombre';
  v_ubicacion depto.ubicacion%type := '&ubicacion';
begin
  insert into depto values(v_coddepto, v_nomdepto,v_ubicacion);
  dbms_output.put_line('inserción realizada');
exception
  when dup_val_on_index then
    dbms_output.put_line('código duplicado');
end;

--12 PRAGMA EXCEPTION_UNIT PERMITE declarar una excepción personalizada asociada un código de error específico.
set serveroutput on;
set verify off;
DECLARE
  v_fecha date;
  e_fecha_invalida01   EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_fecha_invalida01 , -01858);
  e_fecha_invalida02   EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_fecha_invalida02 , -01843); 
  e_fecha_invalida03   EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_fecha_invalida03 , -01847); 
  e_fecha_invalida04   EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_fecha_invalida04 , -01840);

  BEGIN
  v_fecha := '&fecha';
  DBMS_OUTPUT.PUT_LINE(v_fecha);

EXCEPTION
  
  WHEN e_fecha_invalida01 THEN DBMS_OUTPUT.PUT_LINE('Se ingresó una letra o un símbolo');
  WHEN e_fecha_invalida02 THEN DBMS_OUTPUT.PUT_LINE('Mes no válido');
  WHEN e_fecha_invalida03 THEN DBMS_OUTPUT.PUT_LINE('Día no válido');
  WHEN e_fecha_invalida04 THEN DBMS_OUTPUT.PUT_LINE('Se ingresó un número');
END;

--13
set serveroutput on;
set verify off;
DECLARE
    e_codigo_invalido01 EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_codigo_invalido01, -06502);
    
    e_salario_invalido01 EXCEPTION;
    
    v_codigo_emp empleado.cod_emp%type;
    v_salario_semanal empleado.salario_sem%type;
BEGIN
    v_codigo_emp := '&codigo';
    select cod_emp, salario_sem into v_codigo_emp, v_salario_semanal 
    from empleado where cod_emp = v_codigo_emp;
    
    if v_salario_semanal < 10000 then
        RAISE e_salario_invalido01;
    else
        DBMS_OUTPUT.PUT_LINE('Salario semanal: '|| v_salario_semanal);
    end if;
        
EXCEPTION
    when e_codigo_invalido01 then DBMS_OUTPUT.PUT_LINE('El código ingresado no es válido');
    when e_salario_invalido01 THEN DBMS_OUTPUT.PUT_LINE('El SALARIO SEMANAL ES MENOR A 1000');
    when no_data_found THEN DBMS_OUTPUT.PUT_LINE('El código ingresado no existe');
END;

--14
SET SERVEROUTPUT ON;
DECLARE 
CURSOR c_sueldo
 IS
 SELECT *
 FROM sueldo;

Reg_sueldo  sueldo%ROWTYPE;
 
BEGIN
   DBMS_OUTPUT.PUT_LINE(  'CODIGO' || ' ' || 'MINIMO' || '       ' || 'MAXIMO');
    OPEN c_sueldo;
        LOOP
            FETCH c_sueldo INTO reg_sueldo;
            EXIT when c_sueldo%notfound;
            DBMS_OUTPUT.PUT_LINE(  reg_sueldo.grado || '      ' || reg_sueldo.sueldo_minimo || '         ' || reg_sueldo.sueldo_maximo);
        END LOOP;
    CLOSE c_sueldo;
EXCEPTION
WHEN invalid_cursor THEN
    DBMS_OUTPUT.PUT_LINE( 'CURSOR INVÁLIDO');
END;


--15
DECLARE
    type r_empleado is record(
        v_nom_emp empleado.nom_emp%type,
        v_salario_sem empleado.salario_sem%type
    );
    type t_empleados is table of r_empleado index by binary_integer;
    v_empleado t_empleados;
    i number := 1;
BEGIN
    for c_reg in(select nom_emp, salario_sem from empleado order by salario_sem DESC)
    loop
        v_empleado(i).v_nom_emp := c_reg.nom_emp;
        v_empleado(i).v_salario_sem := c_reg.salario_sem;
        i := i + 1;
    end loop;
    
    
    for i in 1..3
    loop
        DBMS_OUTPUT.PUT_LINE('NOMBRE: ' || v_empleado(i).v_nom_emp || ' SALARIO SEMANAL: ' || v_empleado(i).v_salario_sem);
    end loop;
END;



    
        