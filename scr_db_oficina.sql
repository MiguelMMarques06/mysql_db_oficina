-- drop database oficina;
create database oficina;
use oficina;

create table Clients(
	idClient int auto_increment primary key,
	Cname varchar(45) not null,
    cpf varchar(12) unique,
    phonenumber varchar(13),
    address varchar(50)
);

create table Vehicle(
	idVehicle int auto_increment primary key,
    idVClient int,
    license_plate varchar(7) unique,
	model varchar (45),
    manufacturer varchar (45),
    Vyear int,
    constraint fk_idVClient foreign key Vehicle(idVClient) references Clients(idClient)
);

create table Mechanic(
	idMechanic int auto_increment primary key,
	Mname varchar(45) not null,
    address varchar(50),
	specialty varchar(45)
);

create table Parts(
	 idParts int auto_increment primary key,
     Pdescription varchar(45),
     cost int
);

create table SO_status(
	idSO_status int auto_increment primary key,
    StatusDescription varchar(80)
);

create table Service_order(
	idService_order int auto_increment primary key,
    idSOVehicle int,
    idSOClient int,
    idSOStatus int,
    emission_date date,
    total_costs float,
    conclusion_date date,
    constraint fk_idSOVehicle foreign key Service_order(idSOVehicle) references Vehicle(idVehicle),
    constraint fk_idSOClient foreign key Service_order(idSOClient) references Clients(idClient),
    constraint fk_idSOStatus foreign key Service_order(idSOStatus) references SO_status(idSO_status)
);

create table SO_parts(
	idSOPService_order int,
    idSOPParts int,
    constraint fk_idSOPService_order foreign key SO_parts(idSOPService_order) references Service_order(idService_order),
    constraint fk_iidSOPParts foreign key SO_parts(idSOPParts) references Parts(idParts)
);

create table Service(
	idService int auto_increment primary key,
    Sdescription varchar(100),
    labor_cost int
);


create table Mechanic_service(
	idSMechanic int,
    idMService int,
    constraint fk_idSMechanic foreign key Mechanic_service(idSMechanic) references Mechanic(idMechanic),
    constraint fk_idMService foreign key Mechanic_service(idMService) references Service(idService)
);

create table Mechanic_SO(
	idSOMechanic int,
    idMSO int,
    constraint fk_idSOMechanic foreign key Mechanic_SO(idSOMechanic) references Mechanic(idMechanic),
    constraint fk_idMSO foreign key Mechanic_SO(idMSO) references Service_order(idService_order)
);

create table SO_service(
	idSService_Order int,
    idSOService int,
    constraint fk_idSService_Order foreign key SO_service(idSService_Order) references Service_order(idService_order),
    constraint fk_idSOService foreign key SO_service(idSOService) references Service(idService)
);


show tables;

-- Populando Clients
INSERT INTO Clients (Cname, cpf, phonenumber, address) VALUES
('Carlos Silva', '12345678901', '11987654321', 'Rua A, 100'),
('Mariana Costa', '98765432100', '11976543210', 'Rua B, 200'),
('Pedro Oliveira', '45612378902', '11965432198', 'Rua C, 300'),
('Fernanda Souza', '32198765401', '11954321087', 'Rua D, 400'),
('João Mendes', '74185296300', '11943210976', 'Rua E, 500');


-- Populando Vehicles
INSERT INTO Vehicle (idVClient, license_plate, model, manufacturer, Vyear) VALUES
(1, 'ABC1234', 'Civic', 'Honda', 2020),
(2, 'XYZ5678', 'Corolla', 'Toyota', 2022),
(3, 'LMN2468', 'Gol', 'Volkswagen', 2018),
(4, 'QWE1357', 'Fiesta', 'Ford', 2019),
(5, 'RTY8520', 'Cruze', 'Chevrolet', 2021);

-- Populando Mechanics
INSERT INTO Mechanic (Mname, address, specialty) VALUES
('José Ferreira', 'Rua F, 600', 'Motores'),
('Ana Santos', 'Rua G, 700', 'Suspensão'),
('Carlos Nogueira', 'Rua H, 800', 'Freios'),
('Maria Souza', 'Rua I, 900', 'Elétrica'),
('Ricardo Lima', 'Rua J, 1000', 'Pintura');

-- Populando Parts
INSERT INTO Parts (Pdescription, cost) VALUES
('Filtro de Óleo', 50),
('Pastilha de Freio', 120),
('Bateria 60Ah', 300),
('Correia Dentada', 180),
('Pneu Aro 16', 400);

-- Populando SO_status
INSERT INTO SO_status (StatusDescription) VALUES
('Aberto'), ('Em andamento'), ('Finalizado'), ('Cancelado');

-- Populando Service_order
INSERT INTO Service_order (idSOVehicle, idSOClient, idSOStatus, emission_date, total_costs, conclusion_date) VALUES
(1, 1, 1, '2025-03-01', 500, NULL),
(2, 2, 2, '2025-03-05', 1200, NULL),
(3, 3, 3, '2025-02-20', 800, '2025-02-25'),
(4, 4, 3, '2025-02-10', 350, '2025-02-15'),
(5, 5, 4, '2025-01-15', 0, NULL);

-- Populando SO_parts
INSERT INTO SO_parts (idSOPService_order, idSOPParts) VALUES
(1, 1), (1, 3), (2, 2), (3, 4), (4, 5);

-- Populando Service
INSERT INTO Service (Sdescription, labor_cost) VALUES
('Troca de óleo', 100),
('Revisão completa', 500),
('Alinhamento e balanceamento', 200),
('Troca de bateria', 150),
('Pintura externa', 800);

-- Populando Mechanic_service
INSERT INTO Mechanic_service (idSMechanic, idMService) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Populando Mechanic_SO
INSERT INTO Mechanic_SO (idSOMechanic, idMSO) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Populando SO_service
INSERT INTO SO_service (idSService_Order, idSOService) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

--  Liste o nome e telefone de todos os clientes cadastrados.
select
	c.Cname AS Cliente,
    c.phonenumber AS Telefone
from
	Clients c;

-- Quais veículos são fabricados pela "Toyota"?
select
	CONCAT(v.manufacturer, ' ' , v.model) AS Carro, v.Vyear AS Ano
from 
	Vehicle v
where
	v.manufacturer = 'Toyota';
    
-- Mostre o nome e a especialidade de todos os mecânicos
select
	m.Mname AS NomeMecânico,
    m.specialty AS Especialidade
from
	Mechanic m;
    
-- Quais são as peças que custam mais de R$150?
select
	p.Pdescription AS Peça,
    p.cost AS Preço
from
	Parts p
having
	p.cost >150;
    
-- Liste todas as ordens de serviço concluídas.
select
	so.idService_order AS IdOrdemDeServiço
from
	Service_order so
inner join 
	SO_Status sos ON so.idSOStatus = sos.idSO_status
where
	sos.StatusDescription = 'Finalizado';

-- Liste todas as ordens de seriço ordenadas por preço.
select
	so.idService_order AS IdOrdemDeServiço,
    so.total_costs AS CustoTotal
from
	Service_order so
order by
    total_costs;
    
-- Liste quantidade de carros fabricados após e anteriormente a década de 2020.
select
	count(v.model)
from
	Vehicle v
group by
	v.Vyear >= 2020, 
    v.Vyear <2020;

-- Liste a idade dos veículos.
select
	CONCAT(v.manufacturer,' ',v.model) AS Carro,
    YEAR(CURDATE()) - v.VYear AS IdadeCarro
from
	Vehicle v
order by
	IdadeCarro desc;