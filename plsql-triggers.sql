insert into empleado values (7950, 'Carmen', 'analista',7934,'17/11/2013',15000,0,40,3);

create or replace trigger auditar_mod
    before update on empleado
    for each row
declare
    v_cad_insert auditaremple.col1%type;
begin
    v_cad_insert := TO_CHAR(sysdate,'DD/MM/YY*HH24:MI*')||:OLD.COD_EMP || '* MODIFICAION *';
    
    if UPDATING ('nom_emp') then
        v_cad_insert := v_cad_insert || :old.nom_emp || '*' || :new.nom_emp;
    end if;
    
    if updating('salario_sem') then
        v_cad_insert := v_cad_isert || :old.salario_sem || '*' || :new.salario_sem;
    end if;
end;
    