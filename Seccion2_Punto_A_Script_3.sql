-- Crear la tabla de empleados

DECLARE @employees TABLE (employee_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_name NVARCHAR(100),
    salary DECIMAL(10, 2))

declare @PosicionTopSalario as integer

set @PosicionTopSalario = 2

-- Insertar datos de ejemplo
INSERT INTO @employees (employee_name, salary) VALUES
('Empleado A', 1200000),
('Empleado B', 3200000),
('Empleado C', 3700000),
('Empleado D', 3700000),
('Empleado E', 4200000)
;

with  salarios_rank as (
select salary,ROW_NUMBER() OVER(ORDER BY salary desc) AS Row#
from (
select distinct salary
from @employees
)sal
)


SELECT e.employee_name, e.salary ,Row#
FROM @employees e inner join salarios_rank sr on e.salary = sr.salary		
where sr.Row# = @PosicionTopSalario