SET FOREIGN_KEY_CHECKS=0 ;
set sqlblanklines ON;

drop table Distribution_Shift CASCADE CONSTRAINTS;
drop table Collection_Shift CASCADE CONSTRAINTS;
drop table Item_Collects CASCADE CONSTRAINTS;
drop table Mon_Collects CASCADE CONSTRAINTS;
drop table GroupE CASCADE CONSTRAINTS;
drop table expirationDate CASCADE CONSTRAINTS;
drop table Item CASCADE CONSTRAINTS;
drop table Item_Distributes CASCADE CONSTRAINTS;
drop table Administrator CASCADE CONSTRAINTS;
drop table Volunteer_Add CASCADE CONSTRAINTS;

drop table Adds CASCADE CONSTRAINTS;
drop table Purchase_Makes CASCADE CONSTRAINTS;
drop table Shift_LogDelete CASCADE CONSTRAINTS;
drop table Works CASCADE CONSTRAINTS;

--Shift stuff

CREATE TABLE Distribution_Shift(
	startTime DECIMAL(5,2),
	Length DECIMAL(5,2),
	letter CHAR(1),
	PRIMARY KEY (startTime, length, letter)
);

CREATE TABLE Collection_Shift(
	startTime DECIMAL(5,2),
	Length DECIMAL(5,2),
	letter CHAR(1),
	PRIMARY KEY (startTime, length, letter)
);

--Collection things
 
CREATE TABLE Item_Collects (
	did INTEGER,
	name VARCHAR(20),
	phone CHAR(10),
	dateI INTEGER, 
	startTime DECIMAL(5,2) NOT NULL,
	length DECIMAL(5,2) NOT NULL,
	letter CHAR(1) NOT NULL,
	PRIMARY KEY(did),
	FOREIGN KEY(startTime, length, letter) REFERENCES Collection_Shift (startTime, length, letter)
		ON DELETE CASCADE /*added this to match above also got rid of on update cascade*/
);

CREATE TABLE Mon_Collects(
	did INTEGER,
	name VARCHAR(20),
	phone CHAR(10),
	dateM INTEGER,
	startTime DECIMAL(5,2) NOT NULL,
	length DECIMAL(5,2) NOT NULL,
	letter CHAR(1) NOT NULL,
	amount DECIMAL(5,2),
	medium VARCHAR(6),
	PRIMARY KEY(did),
	FOREIGN KEY (startTime, length, letter) REFERENCES Collection_Shift (startTime, length, letter)
		ON DELETE CASCADE,
		
		CONSTRAINT check_amount
		  CHECK (amount >=0)

);


---------------

CREATE TABLE expirationDate( 
		dateE VARCHAR(12),
		PRIMARY KEY (dateE)
);
	


--Item things	
	
CREATE TABLE GroupE( /*changed from Group*/ --Like a list of carbs, or whatever.
	value VARCHAR(255) PRIMARY KEY	
);

--Kinda got rid of expiration date
--FOREIGN KEY (dateE) REFERENCES expirationDate (dateE)
--dateE VARCHAR(255),
CREATE TABLE Item(
	did INTEGER,
	String VARCHAR(20), --no primary key?
	category VARCHAR(20),
	location VARCHAR(10),
	PRIMARY KEY (did, category),--New
	FOREIGN KEY (category) REFERENCES GroupE (value),
	FOREIGN KEY (did) REFERENCES item_collects (did)
);


--Distribution Entity
--It had Is connect this and item collection before
CREATE TABLE Item_Distributes(
	String VARCHAR(255), 
	category VARCHAR(255),
	location VARCHAR(255),
	startTime DECIMAL(5,2),
	length DECIMAL(5,2),
	letter CHAR(1),
	PRIMARY KEY (String),
	FOREIGN KEY(startTime, length,letter) REFERENCES Distribution_Shift (startTime, length,letter)
		ON DELETE CASCADE
);




--Employee, volunteer, administrator. It seems that It follows a different structure than the other
--isA heiarchys

--Decided to get rid of employee table to use a different isa heiarchy

CREATE TABLE Administrator(
	phone CHAR(10),
	name VARCHAR(15),
	password VARCHAR(15),
	A_userName VARCHAR(15),
	PRIMARY KEY (A_userName)
);



CREATE TABLE Volunteer_Add(
	userName VARCHAR(15),
	A_userName VARCHAR(15),
	phone CHAR(10),
	name VARCHAR(15),
	password VARCHAR(15),
	PRIMARY KEY (userName),
	FOREIGN KEY (A_userName) references Administrator (A_userName)
		ON DELETE CASCADE
);





--Tables for purchase requests

CREATE TABLE Purchase_Makes (
purchaseID INTEGER PRIMARY KEY,
amount DECIMAL(10,2),
A_userName VARCHAR(16) ,
Item VARCHAR(16),
FOREIGN KEY (A_userName) REFERENCES Administrator (A_userName)
);


CREATE TABLE Adds(
String VARCHAR(12),
purchaseID INTEGER,
PRIMARY KEY (purchaseID),
FOREIGN KEY (purchaseID) REFERENCES Purchase_Makes(purchaseID)
);



CREATE TABLE Shift_LogDelete (
A_userName VARCHAR(255) NOT NULL,
startTime DECIMAL(5,2),
length DECIMAL(5,2),
letter CHAR(1),
PRIMARY KEY (startTime, length, letter),
FOREIGN KEY (A_userName) REFERENCES Administrator (A_userName)
ON DELETE CASCADE
);

CREATE TABLE Works(
	startTime DECIMAL(5,2),
	length DECIMAL(5,2),
	userName VARCHAR(255),
	letter CHAR(1),
	PRIMARY KEY (startTime, length, letter, userName),
	FOREIGN KEY (startTime, length, letter) REFERENCES Distribution_Shift (startTime, length, letter),
	FOREIGN KEY (userName) REFERENCES Volunteer_add (userName)
);




insert into GroupE
values('carbohydrate');

insert into GroupE
values('protein');

insert into GroupE
values('fat');

insert into Collection_Shift
values('8.05', '1.1', 'A');

insert into Mon_Collects
values('0', 'donor0', '6041231001', '22096', '8.05', '1.1', 'A', '990', 'cash');

insert into Collection_Shift
values('8.1', '1.15', 'A');

insert into Mon_Collects
values('1', 'donor1', '6041231002', '22097', '8.1', '1.15', 'A', '850', 'credit');

insert into Collection_Shift
values('8.15', '1.2', 'A');

insert into Mon_Collects
values('2', 'donor2', '6041231003', '22098', '8.15', '1.2', 'A', '145', 'cash');

insert into Collection_Shift
values('8.2', '1.25', 'A');

insert into Mon_Collects
values('3', 'donor3', '6041231004', '22099', '8.2', '1.25', 'A', '229', 'credit');

insert into Collection_Shift
values('8.25', '1.3', 'A');

insert into Mon_Collects
values('4', 'donor4', '6041231005', '22100', '8.25', '1.3', 'A', '217', 'cash');

insert into Collection_Shift
values('8.3', '1.35', 'A');

insert into Mon_Collects
values('5', 'donor5', '6041231006', '22101', '8.3', '1.35', 'A', '504', 'credit');

insert into Collection_Shift
values('8.35', '1.4', 'A');

insert into Mon_Collects
values('6', 'donor6', '6041231007', '22102', '8.35', '1.4', 'A', '462', 'cash');

insert into Collection_Shift
values('8.4', '1.45', 'A');

insert into Mon_Collects
values('7', 'donor7', '6041231008', '22103', '8.4', '1.45', 'A', '402', 'credit');

insert into Collection_Shift
values('8.45', '1.5', 'A');

insert into Mon_Collects
values('8', 'donor8', '6041231009', '22104', '8.45', '1.5', 'A', '698', 'cash');

insert into Collection_Shift
values('8.5', '1.55', 'A');

insert into Mon_Collects
values('9', 'donor9', '6041231010', '22105', '8.5', '1.55', 'A', '308', 'credit');

insert into Collection_Shift
values('8.55', '1.6', 'A');

insert into Mon_Collects
values('10', 'donor10', '6041231011', '22106', '8.55', '1.6', 'A', '824', 'cash');

insert into Collection_Shift
values('8.6', '1.65', 'A');

insert into Mon_Collects
values('11', 'donor11', '6041231012', '22107', '8.6', '1.65', 'A', '458', 'credit');

insert into Collection_Shift
values('8.65', '1.7', 'A');

insert into Mon_Collects
values('12', 'donor12', '6041231013', '22108', '8.65', '1.7', 'A', '653', 'cash');

insert into Collection_Shift
values('8.7', '1.75', 'A');

insert into Mon_Collects
values('13', 'donor13', '6041231014', '22109', '8.7', '1.75', 'A', '131', 'credit');

insert into Collection_Shift
values('8.75', '1.8', 'A');

insert into Mon_Collects
values('14', 'donor14', '6041231015', '22110', '8.75', '1.8', 'A', '130', 'cash');

insert into Collection_Shift
values('8.8', '1.85', 'A');

insert into Mon_Collects
values('15', 'donor15', '6041231016', '22111', '8.8', '1.85', 'A', '867', 'credit');

insert into Collection_Shift
values('8.85', '1.9', 'A');

insert into Mon_Collects
values('16', 'donor16', '6041231017', '22112', '8.85', '1.9', 'A', '785', 'cash');

insert into Collection_Shift
values('8.9', '1.95', 'A');

insert into Mon_Collects
values('17', 'donor17', '6041231018', '22113', '8.9', '1.95', 'A', '663', 'credit');

insert into Collection_Shift
values('8.95', '1.05', 'A');

insert into Mon_Collects
values('18', 'donor18', '6041231019', '22114', '8.95', '1.05', 'A', '749', 'cash');

insert into Collection_Shift
values('9.0', '1.1', 'A');

insert into Mon_Collects
values('19', 'donor19', '6041231020', '22115', '9.0', '1.1', 'A', '617', 'credit');

insert into Collection_Shift
values('9.05', '1.15', 'A');

insert into Mon_Collects
values('20', 'donor20', '6041231021', '22116', '9.05', '1.15', 'A', '823', 'cash');

insert into Collection_Shift
values('9.1', '1.2', 'A');

insert into Mon_Collects
values('21', 'donor21', '6041231022', '22117', '9.1', '1.2', 'A', '906', 'credit');

insert into Collection_Shift
values('9.15', '1.25', 'A');

insert into Mon_Collects
values('22', 'donor22', '6041231023', '22118', '9.15', '1.25', 'A', '958', 'cash');

insert into Collection_Shift
values('9.2', '1.3', 'A');

insert into Mon_Collects
values('23', 'donor23', '6041231024', '22119', '9.2', '1.3', 'A', '357', 'credit');

insert into Collection_Shift
values('9.25', '1.35', 'A');

insert into Mon_Collects
values('24', 'donor24', '6041231025', '22120', '9.25', '1.35', 'A', '112', 'cash');

insert into Collection_Shift
values('9.3', '1.4', 'A');

insert into Mon_Collects
values('25', 'donor25', '6041231026', '22121', '9.3', '1.4', 'A', '275', 'credit');

insert into Collection_Shift
values('9.35', '1.45', 'A');

insert into Mon_Collects
values('26', 'donor26', '6041231027', '22122', '9.35', '1.45', 'A', '741', 'cash');

insert into Collection_Shift
values('9.4', '1.5', 'A');

insert into Mon_Collects
values('27', 'donor27', '6041231028', '22123', '9.4', '1.5', 'A', '464', 'credit');

insert into Collection_Shift
values('9.45', '1.55', 'A');

insert into Mon_Collects
values('28', 'donor28', '6041231029', '22124', '9.45', '1.55', 'A', '912', 'cash');

insert into Collection_Shift
values('9.5', '1.6', 'A');

insert into Mon_Collects
values('29', 'donor29', '6041231030', '22125', '9.5', '1.6', 'A', '895', 'credit');

insert into Collection_Shift
values('9.55', '1.65', 'A');

insert into Mon_Collects
values('30', 'donor30', '6041231031', '22126', '9.55', '1.65', 'A', '459', 'cash');

insert into Collection_Shift
values('9.6', '1.7', 'A');

insert into Mon_Collects
values('31', 'donor31', '6041231032', '22127', '9.6', '1.7', 'A', '592', 'credit');

insert into Collection_Shift
values('9.65', '1.75', 'A');

insert into Mon_Collects
values('32', 'donor32', '6041231033', '22128', '9.65', '1.75', 'A', '119', 'cash');

insert into Collection_Shift
values('9.7', '1.8', 'A');

insert into Mon_Collects
values('33', 'donor33', '6041231034', '22129', '9.7', '1.8', 'A', '163', 'credit');

insert into Collection_Shift
values('9.75', '1.85', 'A');

insert into Mon_Collects
values('34', 'donor34', '6041231035', '22130', '9.75', '1.85', 'A', '75', 'cash');

insert into Collection_Shift
values('9.8', '1.9', 'A');

insert into Mon_Collects
values('35', 'donor35', '6041231036', '22131', '9.8', '1.9', 'A', '641', 'credit');

insert into Collection_Shift
values('9.85', '1.95', 'A');

insert into Mon_Collects
values('36', 'donor36', '6041231037', '22132', '9.85', '1.95', 'A', '869', 'cash');

insert into Collection_Shift
values('9.9', '1.05', 'A');

insert into Mon_Collects
values('37', 'donor37', '6041231038', '22133', '9.9', '1.05', 'A', '260', 'credit');

insert into Collection_Shift
values('9.95', '1.1', 'A');

insert into Mon_Collects
values('38', 'donor38', '6041231039', '22134', '9.95', '1.1', 'A', '159', 'cash');

insert into Collection_Shift
values('10.0', '1.15', 'A');

insert into Mon_Collects
values('39', 'donor39', '6041231040', '22135', '10.0', '1.15', 'A', '587', 'credit');

insert into Collection_Shift
values('10.05', '1.2', 'A');

insert into Mon_Collects
values('40', 'donor40', '6041231041', '22136', '10.05', '1.2', 'A', '895', 'cash');

insert into Collection_Shift
values('10.1', '1.25', 'A');

insert into Mon_Collects
values('41', 'donor41', '6041231042', '22137', '10.1', '1.25', 'A', '201', 'credit');

insert into Collection_Shift
values('10.15', '1.3', 'A');

insert into Mon_Collects
values('42', 'donor42', '6041231043', '22138', '10.15', '1.3', 'A', '423', 'cash');

insert into Collection_Shift
values('10.2', '1.35', 'A');

insert into Mon_Collects
values('43', 'donor43', '6041231044', '22139', '10.2', '1.35', 'A', '123', 'credit');

insert into Collection_Shift
values('10.25', '1.4', 'A');

insert into Mon_Collects
values('44', 'donor44', '6041231045', '22140', '10.25', '1.4', 'A', '790', 'cash');

insert into Collection_Shift
values('10.3', '1.45', 'A');

insert into Mon_Collects
values('45', 'donor45', '6041231046', '22141', '10.3', '1.45', 'A', '207', 'credit');

insert into Collection_Shift
values('10.35', '1.5', 'A');

insert into Mon_Collects
values('46', 'donor46', '6041231047', '22142', '10.35', '1.5', 'A', '752', 'cash');

insert into Collection_Shift
values('10.4', '1.55', 'A');

insert into Mon_Collects
values('47', 'donor47', '6041231048', '22143', '10.4', '1.55', 'A', '915', 'credit');

insert into Collection_Shift
values('10.45', '1.6', 'A');

insert into Mon_Collects
values('48', 'donor48', '6041231049', '22144', '10.45', '1.6', 'A', '150', 'cash');

insert into Collection_Shift
values('10.5', '1.65', 'A');

insert into Mon_Collects
values('49', 'donor49', '6041231050', '22145', '10.5', '1.65', 'A', '873', 'credit');

insert into Collection_Shift
values('10.55', '1.7', 'A');

insert into Mon_Collects
values('50', 'donor50', '6041231051', '22146', '10.55', '1.7', 'A', '629', 'cash');

insert into Collection_Shift
values('10.6', '1.75', 'A');

insert into Mon_Collects
values('51', 'donor51', '6041231052', '22147', '10.6', '1.75', 'A', '89', 'credit');

insert into Collection_Shift
values('10.65', '1.8', 'A');

insert into Mon_Collects
values('52', 'donor52', '6041231053', '22148', '10.65', '1.8', 'A', '986', 'cash');

insert into Collection_Shift
values('10.7', '1.85', 'A');

insert into Mon_Collects
values('53', 'donor53', '6041231054', '22149', '10.7', '1.85', 'A', '760', 'credit');

insert into Collection_Shift
values('10.75', '1.9', 'A');

insert into Mon_Collects
values('54', 'donor54', '6041231055', '22150', '10.75', '1.9', 'A', '787', 'cash');

insert into Collection_Shift
values('10.8', '1.95', 'A');

insert into Mon_Collects
values('55', 'donor55', '6041231056', '22151', '10.8', '1.95', 'A', '777', 'credit');

insert into Collection_Shift
values('10.85', '1.05', 'A');

insert into Mon_Collects
values('56', 'donor56', '6041231057', '22152', '10.85', '1.05', 'A', '936', 'cash');

insert into Collection_Shift
values('10.9', '1.1', 'A');

insert into Mon_Collects
values('57', 'donor57', '6041231058', '22153', '10.9', '1.1', 'A', '767', 'credit');

insert into Collection_Shift
values('10.95', '1.15', 'A');

insert into Mon_Collects
values('58', 'donor58', '6041231059', '22154', '10.95', '1.15', 'A', '887', 'cash');

insert into Collection_Shift
values('11.0', '1.2', 'A');

insert into Mon_Collects
values('59', 'donor59', '6041231060', '22155', '11.0', '1.2', 'A', '840', 'credit');

insert into Collection_Shift
values('11.05', '1.25', 'A');

insert into Mon_Collects
values('60', 'donor60', '6041231061', '22156', '11.05', '1.25', 'A', '100', 'cash');

insert into Collection_Shift
values('11.1', '1.3', 'A');

insert into Mon_Collects
values('61', 'donor61', '6041231062', '22157', '11.1', '1.3', 'A', '535', 'credit');

insert into Collection_Shift
values('11.15', '1.35', 'A');

insert into Mon_Collects
values('62', 'donor62', '6041231063', '22158', '11.15', '1.35', 'A', '988', 'cash');

insert into Collection_Shift
values('11.2', '1.4', 'A');

insert into Mon_Collects
values('63', 'donor63', '6041231064', '22159', '11.2', '1.4', 'A', '117', 'credit');

insert into Collection_Shift
values('11.25', '1.45', 'A');

insert into Mon_Collects
values('64', 'donor64', '6041231065', '22160', '11.25', '1.45', 'A', '589', 'cash');

insert into Collection_Shift
values('11.3', '1.5', 'A');

insert into Mon_Collects
values('65', 'donor65', '6041231066', '22161', '11.3', '1.5', 'A', '578', 'credit');

insert into Collection_Shift
values('11.35', '1.55', 'A');

insert into Mon_Collects
values('66', 'donor66', '6041231067', '22162', '11.35', '1.55', 'A', '707', 'cash');

insert into Collection_Shift
values('11.4', '1.6', 'A');

insert into Mon_Collects
values('67', 'donor67', '6041231068', '22163', '11.4', '1.6', 'A', '784', 'credit');

insert into Collection_Shift
values('11.45', '1.65', 'A');

insert into Mon_Collects
values('68', 'donor68', '6041231069', '22164', '11.45', '1.65', 'A', '386', 'cash');

insert into Collection_Shift
values('11.5', '1.7', 'A');

insert into Mon_Collects
values('69', 'donor69', '6041231070', '22165', '11.5', '1.7', 'A', '803', 'credit');

insert into Collection_Shift
values('11.55', '1.75', 'A');

insert into Mon_Collects
values('70', 'donor70', '6041231071', '22166', '11.55', '1.75', 'A', '666', 'cash');

insert into Collection_Shift
values('11.6', '1.8', 'A');

insert into Mon_Collects
values('71', 'donor71', '6041231072', '22167', '11.6', '1.8', 'A', '986', 'credit');

insert into Collection_Shift
values('11.65', '1.85', 'A');

insert into Mon_Collects
values('72', 'donor72', '6041231073', '22168', '11.65', '1.85', 'A', '970', 'cash');

insert into Collection_Shift
values('11.7', '1.9', 'A');

insert into Mon_Collects
values('73', 'donor73', '6041231074', '22169', '11.7', '1.9', 'A', '636', 'credit');

insert into Collection_Shift
values('11.75', '1.95', 'A');

insert into Mon_Collects
values('74', 'donor74', '6041231075', '22170', '11.75', '1.95', 'A', '295', 'cash');

insert into Collection_Shift
values('11.8', '1.05', 'A');

insert into Mon_Collects
values('75', 'donor75', '6041231076', '22171', '11.8', '1.05', 'A', '561', 'credit');

insert into Collection_Shift
values('11.85', '1.1', 'A');

insert into Mon_Collects
values('76', 'donor76', '6041231077', '22172', '11.85', '1.1', 'A', '403', 'cash');

insert into Collection_Shift
values('11.9', '1.15', 'A');

insert into Mon_Collects
values('77', 'donor77', '6041231078', '22173', '11.9', '1.15', 'A', '40', 'credit');

insert into Collection_Shift
values('11.95', '1.2', 'A');

insert into Mon_Collects
values('78', 'donor78', '6041231079', '22174', '11.95', '1.2', 'A', '929', 'cash');

insert into Collection_Shift
values('12.0', '1.25', 'A');

insert into Mon_Collects
values('79', 'donor79', '6041231080', '22175', '12.0', '1.25', 'A', '109', 'credit');

insert into Collection_Shift
values('12.05', '1.3', 'A');

insert into Mon_Collects
values('80', 'donor80', '6041231081', '22176', '12.05', '1.3', 'A', '389', 'cash');

insert into Collection_Shift
values('12.1', '1.35', 'A');

insert into Mon_Collects
values('81', 'donor81', '6041231082', '22177', '12.1', '1.35', 'A', '971', 'credit');

insert into Collection_Shift
values('12.15', '1.4', 'A');

insert into Mon_Collects
values('82', 'donor82', '6041231083', '22178', '12.15', '1.4', 'A', '854', 'cash');

insert into Collection_Shift
values('12.2', '1.45', 'A');

insert into Mon_Collects
values('83', 'donor83', '6041231084', '22179', '12.2', '1.45', 'A', '247', 'credit');

insert into Collection_Shift
values('12.25', '1.5', 'A');

insert into Mon_Collects
values('84', 'donor84', '6041231085', '22180', '12.25', '1.5', 'A', '845', 'cash');

insert into Collection_Shift
values('12.3', '1.55', 'A');

insert into Mon_Collects
values('85', 'donor85', '6041231086', '22181', '12.3', '1.55', 'A', '722', 'credit');

insert into Collection_Shift
values('12.35', '1.6', 'A');

insert into Mon_Collects
values('86', 'donor86', '6041231087', '22182', '12.35', '1.6', 'A', '802', 'cash');

insert into Collection_Shift
values('12.4', '1.65', 'A');

insert into Mon_Collects
values('87', 'donor87', '6041231088', '22183', '12.4', '1.65', 'A', '677', 'credit');

insert into Collection_Shift
values('12.45', '1.7', 'A');

insert into Mon_Collects
values('88', 'donor88', '6041231089', '22184', '12.45', '1.7', 'A', '12', 'cash');

insert into Collection_Shift
values('12.5', '1.75', 'A');

insert into Mon_Collects
values('89', 'donor89', '6041231090', '22185', '12.5', '1.75', 'A', '448', 'credit');

insert into Collection_Shift
values('12.55', '1.8', 'A');

insert into Mon_Collects
values('90', 'donor90', '6041231091', '22186', '12.55', '1.8', 'A', '715', 'cash');

insert into Collection_Shift
values('12.6', '1.85', 'A');

insert into Mon_Collects
values('91', 'donor91', '6041231092', '22187', '12.6', '1.85', 'A', '356', 'credit');

insert into Collection_Shift
values('12.65', '1.9', 'A');

insert into Mon_Collects
values('92', 'donor92', '6041231093', '22188', '12.65', '1.9', 'A', '236', 'cash');

insert into Collection_Shift
values('12.7', '1.95', 'A');

insert into Mon_Collects
values('93', 'donor93', '6041231094', '22189', '12.7', '1.95', 'A', '975', 'credit');

insert into Collection_Shift
values('12.75', '1.05', 'A');

insert into Mon_Collects
values('94', 'donor94', '6041231095', '22190', '12.75', '1.05', 'A', '376', 'cash');

insert into Collection_Shift
values('12.8', '1.1', 'A');

insert into Mon_Collects
values('95', 'donor95', '6041231096', '22191', '12.8', '1.1', 'A', '369', 'credit');

insert into Collection_Shift
values('12.85', '1.15', 'A');

insert into Mon_Collects
values('96', 'donor96', '6041231097', '22192', '12.85', '1.15', 'A', '672', 'cash');

insert into Collection_Shift
values('12.9', '1.2', 'A');

insert into Mon_Collects
values('97', 'donor97', '6041231098', '22193', '12.9', '1.2', 'A', '608', 'credit');

insert into Collection_Shift
values('12.95', '1.25', 'A');

insert into Mon_Collects
values('98', 'donor98', '6041231099', '22194', '12.95', '1.25', 'A', '43', 'cash');

insert into Collection_Shift
values('13.0', '1.3', 'A');

insert into Mon_Collects
values('99', 'donor99', '6041231100', '22195', '13.0', '1.3', 'A', '869', 'credit');

insert into Collection_Shift
values('13.05', '1.35', 'A');

insert into Item_Collects
values('100', 'donor100', '6041231101', '22196', '13.05', '1.35', 'A');

insert into Item
values('100', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22196');

insert into distribution_Shift
values('13.05', '1.35', 'B');

insert into Collection_Shift
values('13.1', '1.4', 'A');

insert into Item_Collects
values('101', 'donor101', '6041231102', '22197', '13.1', '1.4', 'A');

insert into Item
values('101', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22197');

insert into distribution_Shift
values('13.1', '1.4', 'B');

insert into Collection_Shift
values('13.15', '1.45', 'A');

insert into Item_Collects
values('102', 'donor102', '6041231103', '22198', '13.15', '1.45', 'A');

insert into Item
values('102', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22198');

insert into distribution_Shift
values('13.15', '1.45', 'B');

insert into Collection_Shift
values('13.2', '1.5', 'A');

insert into Item_Collects
values('103', 'donor103', '6041231104', '22199', '13.2', '1.5', 'A');

insert into Item
values('103', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22199');

insert into distribution_Shift
values('13.2', '1.5', 'B');

insert into Collection_Shift
values('13.25', '1.55', 'A');

insert into Item_Collects
values('104', 'donor104', '6041231105', '22200', '13.25', '1.55', 'A');

insert into Item
values('104', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22200');

insert into distribution_Shift
values('13.25', '1.55', 'B');

insert into Collection_Shift
values('13.3', '1.6', 'A');

insert into Item_Collects
values('105', 'donor105', '6041231106', '22201', '13.3', '1.6', 'A');

insert into Item
values('105', 'olive oil', 'fat', 'PantryA');

insert into expirationDate
values('22201');

insert into distribution_Shift
values('13.3', '1.6', 'B');

insert into Collection_Shift
values('13.35', '1.65', 'A');

insert into Item_Collects
values('106', 'donor106', '6041231107', '22202', '13.35', '1.65', 'A');

insert into Item
values('106', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22202');

insert into distribution_Shift
values('13.35', '1.65', 'B');

insert into Collection_Shift
values('13.4', '1.7', 'A');

insert into Item_Collects
values('107', 'donor107', '6041231108', '22203', '13.4', '1.7', 'A');

insert into Item
values('107', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22203');

insert into distribution_Shift
values('13.4', '1.7', 'B');

insert into Collection_Shift
values('13.45', '1.75', 'A');

insert into Item_Collects
values('108', 'donor108', '6041231109', '22204', '13.45', '1.75', 'A');

insert into Item
values('108', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22204');

insert into distribution_Shift
values('13.45', '1.75', 'B');

insert into Collection_Shift
values('13.5', '1.8', 'A');

insert into Item_Collects
values('109', 'donor109', '6041231110', '22205', '13.5', '1.8', 'A');

insert into Item
values('109', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22205');

insert into distribution_Shift
values('13.5', '1.8', 'B');

insert into Collection_Shift
values('13.55', '1.85', 'A');

insert into Item_Collects
values('110', 'donor110', '6041231111', '22206', '13.55', '1.85', 'A');

insert into Item
values('110', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22206');

insert into distribution_Shift
values('13.55', '1.85', 'B');

insert into Collection_Shift
values('13.6', '1.9', 'A');

insert into Item_Collects
values('111', 'donor111', '6041231112', '22207', '13.6', '1.9', 'A');

insert into Item
values('111', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22207');

insert into distribution_Shift
values('13.6', '1.9', 'B');

insert into Collection_Shift
values('13.65', '1.95', 'A');

insert into Item_Collects
values('112', 'donor112', '6041231113', '22208', '13.65', '1.95', 'A');

insert into Item
values('112', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22208');

insert into distribution_Shift
values('13.65', '1.95', 'B');

insert into Collection_Shift
values('13.7', '1.05', 'A');

insert into Item_Collects
values('113', 'donor113', '6041231114', '22209', '13.7', '1.05', 'A');

insert into Item
values('113', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22209');

insert into distribution_Shift
values('13.7', '1.05', 'B');

insert into Collection_Shift
values('13.75', '1.1', 'A');

insert into Item_Collects
values('114', 'donor114', '6041231115', '22210', '13.75', '1.1', 'A');

insert into Item
values('114', 'olive oil', 'fat', 'PantryA');

insert into expirationDate
values('22210');

insert into distribution_Shift
values('13.75', '1.1', 'B');

insert into Collection_Shift
values('13.8', '1.15', 'A');

insert into Item_Collects
values('115', 'donor115', '6041231116', '22211', '13.8', '1.15', 'A');

insert into Item
values('115', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22211');

insert into distribution_Shift
values('13.8', '1.15', 'B');

insert into Collection_Shift
values('13.85', '1.2', 'A');

insert into Item_Collects
values('116', 'donor116', '6041231117', '22212', '13.85', '1.2', 'A');

insert into Item
values('116', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22212');

insert into distribution_Shift
values('13.85', '1.2', 'B');

insert into Collection_Shift
values('13.9', '1.25', 'A');

insert into Item_Collects
values('117', 'donor117', '6041231118', '22213', '13.9', '1.25', 'A');

insert into Item
values('117', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22213');

insert into distribution_Shift
values('13.9', '1.25', 'B');

insert into Collection_Shift
values('13.95', '1.3', 'A');

insert into Item_Collects
values('118', 'donor118', '6041231119', '22214', '13.95', '1.3', 'A');

insert into Item
values('118', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22214');

insert into distribution_Shift
values('13.95', '1.3', 'B');

insert into Collection_Shift
values('14.0', '1.35', 'A');

insert into Item_Collects
values('119', 'donor119', '6041231120', '22215', '14.0', '1.35', 'A');

insert into Item
values('119', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22215');

insert into distribution_Shift
values('14.0', '1.35', 'B');

insert into Collection_Shift
values('14.05', '1.4', 'A');

insert into Item_Collects
values('120', 'donor120', '6041231121', '22216', '14.05', '1.4', 'A');

insert into Item
values('120', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22216');

insert into distribution_Shift
values('14.05', '1.4', 'B');

insert into Collection_Shift
values('14.1', '1.45', 'A');

insert into Item_Collects
values('121', 'donor121', '6041231122', '22217', '14.1', '1.45', 'A');

insert into Item
values('121', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22217');

insert into distribution_Shift
values('14.1', '1.45', 'B');

insert into Collection_Shift
values('14.15', '1.5', 'A');

insert into Item_Collects
values('122', 'donor122', '6041231123', '22218', '14.15', '1.5', 'A');

insert into Item
values('122', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22218');

insert into distribution_Shift
values('14.15', '1.5', 'B');

insert into Collection_Shift
values('14.2', '1.55', 'A');

insert into Item_Collects
values('123', 'donor123', '6041231124', '22219', '14.2', '1.55', 'A');

insert into Item
values('123', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22219');

insert into distribution_Shift
values('14.2', '1.55', 'B');

insert into Collection_Shift
values('14.25', '1.6', 'A');

insert into Item_Collects
values('124', 'donor124', '6041231125', '22220', '14.25', '1.6', 'A');

insert into Item
values('124', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22220');

insert into distribution_Shift
values('14.25', '1.6', 'B');

insert into Collection_Shift
values('14.3', '1.65', 'A');

insert into Item_Collects
values('125', 'donor125', '6041231126', '22221', '14.3', '1.65', 'A');

insert into Item
values('125', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22221');

insert into distribution_Shift
values('14.3', '1.65', 'B');

insert into Collection_Shift
values('14.35', '1.7', 'A');

insert into Item_Collects
values('126', 'donor126', '6041231127', '22222', '14.35', '1.7', 'A');

insert into Item
values('126', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22222');

insert into distribution_Shift
values('14.35', '1.7', 'B');

insert into Collection_Shift
values('14.4', '1.75', 'A');

insert into Item_Collects
values('127', 'donor127', '6041231128', '22223', '14.4', '1.75', 'A');

insert into Item
values('127', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22223');

insert into distribution_Shift
values('14.4', '1.75', 'B');

insert into Collection_Shift
values('14.45', '1.8', 'A');

insert into Item_Collects
values('128', 'donor128', '6041231129', '22224', '14.45', '1.8', 'A');

insert into Item
values('128', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22224');

insert into distribution_Shift
values('14.45', '1.8', 'B');

insert into Collection_Shift
values('14.5', '1.85', 'A');

insert into Item_Collects
values('129', 'donor129', '6041231130', '22225', '14.5', '1.85', 'A');

insert into Item
values('129', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22225');

insert into distribution_Shift
values('14.5', '1.85', 'B');

insert into Collection_Shift
values('14.55', '1.9', 'A');

insert into Item_Collects
values('130', 'donor130', '6041231131', '22226', '14.55', '1.9', 'A');

insert into Item
values('130', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22226');

insert into distribution_Shift
values('14.55', '1.9', 'B');

insert into Collection_Shift
values('14.6', '1.95', 'A');

insert into Item_Collects
values('131', 'donor131', '6041231132', '22227', '14.6', '1.95', 'A');

insert into Item
values('131', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22227');

insert into distribution_Shift
values('14.6', '1.95', 'B');

insert into Collection_Shift
values('14.65', '1.05', 'A');

insert into Item_Collects
values('132', 'donor132', '6041231133', '22228', '14.65', '1.05', 'A');

insert into Item
values('132', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22228');

insert into distribution_Shift
values('14.65', '1.05', 'B');

insert into Collection_Shift
values('14.7', '1.1', 'A');

insert into Item_Collects
values('133', 'donor133', '6041231134', '22229', '14.7', '1.1', 'A');

insert into Item
values('133', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22229');

insert into distribution_Shift
values('14.7', '1.1', 'B');

insert into Collection_Shift
values('14.75', '1.15', 'A');

insert into Item_Collects
values('134', 'donor134', '6041231135', '22230', '14.75', '1.15', 'A');

insert into Item
values('134', 'olive oil', 'fat', 'PantryA');

insert into expirationDate
values('22230');

insert into distribution_Shift
values('14.75', '1.15', 'B');

insert into Collection_Shift
values('14.8', '1.2', 'A');

insert into Item_Collects
values('135', 'donor135', '6041231136', '22231', '14.8', '1.2', 'A');

insert into Item
values('135', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22231');

insert into distribution_Shift
values('14.8', '1.2', 'B');

insert into Collection_Shift
values('14.85', '1.25', 'A');

insert into Item_Collects
values('136', 'donor136', '6041231137', '22232', '14.85', '1.25', 'A');

insert into Item
values('136', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22232');

insert into distribution_Shift
values('14.85', '1.25', 'B');

insert into Collection_Shift
values('14.9', '1.3', 'A');

insert into Item_Collects
values('137', 'donor137', '6041231138', '22233', '14.9', '1.3', 'A');

insert into Item
values('137', 'olive oil', 'fat', 'PantryA');

insert into expirationDate
values('22233');

insert into distribution_Shift
values('14.9', '1.3', 'B');

insert into Collection_Shift
values('14.95', '1.35', 'A');

insert into Item_Collects
values('138', 'donor138', '6041231139', '22234', '14.95', '1.35', 'A');

insert into Item
values('138', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22234');

insert into distribution_Shift
values('14.95', '1.35', 'B');

insert into Collection_Shift
values('15.0', '1.4', 'A');

insert into Item_Collects
values('139', 'donor139', '6041231140', '22235', '15.0', '1.4', 'A');

insert into Item
values('139', 'olive oil', 'fat', 'PantryA');

insert into expirationDate
values('22235');

insert into distribution_Shift
values('15.0', '1.4', 'B');

insert into Collection_Shift
values('15.05', '1.45', 'A');

insert into Item_Collects
values('140', 'donor140', '6041231141', '22236', '15.05', '1.45', 'A');

insert into Item
values('140', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22236');

insert into distribution_Shift
values('15.05', '1.45', 'B');

insert into Collection_Shift
values('15.1', '1.5', 'A');

insert into Item_Collects
values('141', 'donor141', '6041231142', '22237', '15.1', '1.5', 'A');

insert into Item
values('141', 'olive oil', 'fat', 'PantryA');

insert into expirationDate
values('22237');

insert into distribution_Shift
values('15.1', '1.5', 'B');

insert into Collection_Shift
values('15.15', '1.55', 'A');

insert into Item_Collects
values('142', 'donor142', '6041231143', '22238', '15.15', '1.55', 'A');

insert into Item
values('142', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22238');

insert into distribution_Shift
values('15.15', '1.55', 'B');

insert into Collection_Shift
values('15.2', '1.6', 'A');

insert into Item_Collects
values('143', 'donor143', '6041231144', '22239', '15.2', '1.6', 'A');

insert into Item
values('143', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22239');

insert into distribution_Shift
values('15.2', '1.6', 'B');

insert into Collection_Shift
values('15.25', '1.65', 'A');

insert into Item_Collects
values('144', 'donor144', '6041231145', '22240', '15.25', '1.65', 'A');

insert into Item
values('144', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22240');

insert into distribution_Shift
values('15.25', '1.65', 'B');

insert into Collection_Shift
values('15.3', '1.7', 'A');

insert into Item_Collects
values('145', 'donor145', '6041231146', '22241', '15.3', '1.7', 'A');

insert into Item
values('145', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22241');

insert into distribution_Shift
values('15.3', '1.7', 'B');

insert into Collection_Shift
values('15.35', '1.75', 'A');

insert into Item_Collects
values('146', 'donor146', '6041231147', '22242', '15.35', '1.75', 'A');

insert into Item
values('146', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22242');

insert into distribution_Shift
values('15.35', '1.75', 'B');

insert into Collection_Shift
values('15.4', '1.8', 'A');

insert into Item_Collects
values('147', 'donor147', '6041231148', '22243', '15.4', '1.8', 'A');

insert into Item
values('147', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22243');

insert into distribution_Shift
values('15.4', '1.8', 'B');

insert into Collection_Shift
values('15.45', '1.85', 'A');

insert into Item_Collects
values('148', 'donor148', '6041231149', '22244', '15.45', '1.85', 'A');

insert into Item
values('148', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22244');

insert into distribution_Shift
values('15.45', '1.85', 'B');

insert into Collection_Shift
values('15.5', '1.9', 'A');

insert into Item_Collects
values('149', 'donor149', '6041231150', '22245', '15.5', '1.9', 'A');

insert into Item
values('149', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22245');

insert into distribution_Shift
values('15.5', '1.9', 'B');

insert into Collection_Shift
values('15.55', '1.95', 'A');

insert into Item_Collects
values('150', 'donor150', '6041231151', '22246', '15.55', '1.95', 'A');

insert into Item
values('150', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22246');

insert into distribution_Shift
values('15.55', '1.95', 'B');

insert into Collection_Shift
values('15.6', '1.05', 'A');

insert into Item_Collects
values('151', 'donor151', '6041231152', '22247', '15.6', '1.05', 'A');

insert into Item
values('151', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22247');

insert into distribution_Shift
values('15.6', '1.05', 'B');

insert into Collection_Shift
values('15.65', '1.1', 'A');

insert into Item_Collects
values('152', 'donor152', '6041231153', '22248', '15.65', '1.1', 'A');

insert into Item
values('152', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22248');

insert into distribution_Shift
values('15.65', '1.1', 'B');

insert into Collection_Shift
values('15.7', '1.15', 'A');

insert into Item_Collects
values('153', 'donor153', '6041231154', '22249', '15.7', '1.15', 'A');

insert into Item
values('153', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22249');

insert into distribution_Shift
values('15.7', '1.15', 'B');

insert into Collection_Shift
values('15.75', '1.2', 'A');

insert into Item_Collects
values('154', 'donor154', '6041231155', '22250', '15.75', '1.2', 'A');

insert into Item
values('154', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22250');

insert into distribution_Shift
values('15.75', '1.2', 'B');

insert into Collection_Shift
values('15.8', '1.25', 'A');

insert into Item_Collects
values('155', 'donor155', '6041231156', '22251', '15.8', '1.25', 'A');

insert into Item
values('155', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22251');

insert into distribution_Shift
values('15.8', '1.25', 'B');

insert into Collection_Shift
values('15.85', '1.3', 'A');

insert into Item_Collects
values('156', 'donor156', '6041231157', '22252', '15.85', '1.3', 'A');

insert into Item
values('156', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22252');

insert into distribution_Shift
values('15.85', '1.3', 'B');

insert into Collection_Shift
values('15.9', '1.35', 'A');

insert into Item_Collects
values('157', 'donor157', '6041231158', '22253', '15.9', '1.35', 'A');

insert into Item
values('157', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22253');

insert into distribution_Shift
values('15.9', '1.35', 'B');

insert into Collection_Shift
values('15.95', '1.4', 'A');

insert into Item_Collects
values('158', 'donor158', '6041231159', '22254', '15.95', '1.4', 'A');

insert into Item
values('158', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22254');

insert into distribution_Shift
values('15.95', '1.4', 'B');

insert into Collection_Shift
values('16.0', '1.45', 'A');

insert into Item_Collects
values('159', 'donor159', '6041231160', '22255', '16.0', '1.45', 'A');

insert into Item
values('159', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22255');

insert into distribution_Shift
values('16.0', '1.45', 'B');

insert into Collection_Shift
values('16.05', '1.5', 'A');

insert into Item_Collects
values('160', 'donor160', '6041231161', '22256', '16.05', '1.5', 'A');

insert into Item
values('160', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22256');

insert into distribution_Shift
values('16.05', '1.5', 'B');

insert into Collection_Shift
values('16.1', '1.55', 'A');

insert into Item_Collects
values('161', 'donor161', '6041231162', '22257', '16.1', '1.55', 'A');

insert into Item
values('161', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22257');

insert into distribution_Shift
values('16.1', '1.55', 'B');

insert into Collection_Shift
values('16.15', '1.6', 'A');

insert into Item_Collects
values('162', 'donor162', '6041231163', '22258', '16.15', '1.6', 'A');

insert into Item
values('162', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22258');

insert into distribution_Shift
values('16.15', '1.6', 'B');

insert into Collection_Shift
values('16.2', '1.65', 'A');

insert into Item_Collects
values('163', 'donor163', '6041231164', '22259', '16.2', '1.65', 'A');

insert into Item
values('163', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22259');

insert into distribution_Shift
values('16.2', '1.65', 'B');

insert into Collection_Shift
values('16.25', '1.7', 'A');

insert into Item_Collects
values('164', 'donor164', '6041231165', '22260', '16.25', '1.7', 'A');

insert into Item
values('164', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22260');

insert into distribution_Shift
values('16.25', '1.7', 'B');

insert into Collection_Shift
values('16.3', '1.75', 'A');

insert into Item_Collects
values('165', 'donor165', '6041231166', '22261', '16.3', '1.75', 'A');

insert into Item
values('165', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22261');

insert into distribution_Shift
values('16.3', '1.75', 'B');

insert into Collection_Shift
values('16.35', '1.8', 'A');

insert into Item_Collects
values('166', 'donor166', '6041231167', '22262', '16.35', '1.8', 'A');

insert into Item
values('166', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22262');

insert into distribution_Shift
values('16.35', '1.8', 'B');

insert into Collection_Shift
values('16.4', '1.85', 'A');

insert into Item_Collects
values('167', 'donor167', '6041231168', '22263', '16.4', '1.85', 'A');

insert into Item
values('167', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22263');

insert into distribution_Shift
values('16.4', '1.85', 'B');

insert into Collection_Shift
values('16.45', '1.9', 'A');

insert into Item_Collects
values('168', 'donor168', '6041231169', '22264', '16.45', '1.9', 'A');

insert into Item
values('168', 'olive oil', 'fat', 'PantryA');

insert into expirationDate
values('22264');

insert into distribution_Shift
values('16.45', '1.9', 'B');

insert into Collection_Shift
values('16.5', '1.95', 'A');

insert into Item_Collects
values('169', 'donor169', '6041231170', '22265', '16.5', '1.95', 'A');

insert into Item
values('169', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22265');

insert into distribution_Shift
values('16.5', '1.95', 'B');

insert into Collection_Shift
values('16.55', '1.05', 'A');

insert into Item_Collects
values('170', 'donor170', '6041231171', '22266', '16.55', '1.05', 'A');

insert into Item
values('170', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22266');

insert into distribution_Shift
values('16.55', '1.05', 'B');

insert into Collection_Shift
values('16.6', '1.1', 'A');

insert into Item_Collects
values('171', 'donor171', '6041231172', '22267', '16.6', '1.1', 'A');

insert into Item
values('171', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22267');

insert into distribution_Shift
values('16.6', '1.1', 'B');

insert into Collection_Shift
values('16.65', '1.15', 'A');

insert into Item_Collects
values('172', 'donor172', '6041231173', '22268', '16.65', '1.15', 'A');

insert into Item
values('172', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22268');

insert into distribution_Shift
values('16.65', '1.15', 'B');

insert into Collection_Shift
values('16.7', '1.2', 'A');

insert into Item_Collects
values('173', 'donor173', '6041231174', '22269', '16.7', '1.2', 'A');

insert into Item
values('173', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22269');

insert into distribution_Shift
values('16.7', '1.2', 'B');

insert into Collection_Shift
values('16.75', '1.25', 'A');

insert into Item_Collects
values('174', 'donor174', '6041231175', '22270', '16.75', '1.25', 'A');

insert into Item
values('174', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22270');

insert into distribution_Shift
values('16.75', '1.25', 'B');

insert into Collection_Shift
values('16.8', '1.3', 'A');

insert into Item_Collects
values('175', 'donor175', '6041231176', '22271', '16.8', '1.3', 'A');

insert into Item
values('175', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22271');

insert into distribution_Shift
values('16.8', '1.3', 'B');

insert into Collection_Shift
values('16.85', '1.35', 'A');

insert into Item_Collects
values('176', 'donor176', '6041231177', '22272', '16.85', '1.35', 'A');

insert into Item
values('176', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22272');

insert into distribution_Shift
values('16.85', '1.35', 'B');

insert into Collection_Shift
values('16.9', '1.4', 'A');

insert into Item_Collects
values('177', 'donor177', '6041231178', '22273', '16.9', '1.4', 'A');

insert into Item
values('177', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22273');

insert into distribution_Shift
values('16.9', '1.4', 'B');

insert into Collection_Shift
values('16.95', '1.45', 'A');

insert into Item_Collects
values('178', 'donor178', '6041231179', '22274', '16.95', '1.45', 'A');

insert into Item
values('178', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22274');

insert into distribution_Shift
values('16.95', '1.45', 'B');

insert into Collection_Shift
values('8.0', '1.5', 'A');

insert into Item_Collects
values('179', 'donor179', '6041231180', '22275', '8.0', '1.5', 'A');

insert into Item
values('179', 'beans', 'protein', 'PantryA');

insert into expirationDate
values('22275');

insert into distribution_Shift
values('8.0', '1.5', 'B');

insert into Collection_Shift
values('8.05', '1.55', 'A');

insert into Item_Collects
values('180', 'donor180', '6041231181', '22276', '8.05', '1.55', 'A');

insert into Item
values('180', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22276');

insert into distribution_Shift
values('8.05', '1.55', 'B');

insert into Collection_Shift
values('8.1', '1.6', 'A');

insert into Item_Collects
values('181', 'donor181', '6041231182', '22277', '8.1', '1.6', 'A');

insert into Item
values('181', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22277');

insert into distribution_Shift
values('8.1', '1.6', 'B');

insert into Collection_Shift
values('8.15', '1.65', 'A');

insert into Item_Collects
values('182', 'donor182', '6041231183', '22278', '8.15', '1.65', 'A');

insert into Item
values('182', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22278');

insert into distribution_Shift
values('8.15', '1.65', 'B');

insert into Collection_Shift
values('8.2', '1.7', 'A');

insert into Item_Collects
values('183', 'donor183', '6041231184', '22279', '8.2', '1.7', 'A');

insert into Item
values('183', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22279');

insert into distribution_Shift
values('8.2', '1.7', 'B');

insert into Collection_Shift
values('8.25', '1.75', 'A');

insert into Item_Collects
values('184', 'donor184', '6041231185', '22280', '8.25', '1.75', 'A');

insert into Item
values('184', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22280');

insert into distribution_Shift
values('8.25', '1.75', 'B');

insert into Collection_Shift
values('8.3', '1.8', 'A');

insert into Item_Collects
values('185', 'donor185', '6041231186', '22281', '8.3', '1.8', 'A');

insert into Item
values('185', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22281');

insert into distribution_Shift
values('8.3', '1.8', 'B');

insert into Collection_Shift
values('8.35', '1.85', 'A');

insert into Item_Collects
values('186', 'donor186', '6041231187', '22282', '8.35', '1.85', 'A');

insert into Item
values('186', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22282');

insert into distribution_Shift
values('8.35', '1.85', 'B');

insert into Collection_Shift
values('8.4', '1.9', 'A');

insert into Item_Collects
values('187', 'donor187', '6041231188', '22283', '8.4', '1.9', 'A');

insert into Item
values('187', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22283');

insert into distribution_Shift
values('8.4', '1.9', 'B');

insert into Collection_Shift
values('8.45', '1.95', 'A');

insert into Item_Collects
values('188', 'donor188', '6041231189', '22284', '8.45', '1.95', 'A');

insert into Item
values('188', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22284');

insert into distribution_Shift
values('8.45', '1.95', 'B');

insert into Collection_Shift
values('8.5', '1.05', 'A');

insert into Item_Collects
values('189', 'donor189', '6041231190', '22285', '8.5', '1.05', 'A');

insert into Item
values('189', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22285');

insert into distribution_Shift
values('8.5', '1.05', 'B');

insert into Collection_Shift
values('8.55', '1.1', 'A');

insert into Item_Collects
values('190', 'donor190', '6041231191', '22286', '8.55', '1.1', 'A');

insert into Item
values('190', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22286');

insert into distribution_Shift
values('8.55', '1.1', 'B');

insert into Collection_Shift
values('8.6', '1.15', 'A');

insert into Item_Collects
values('191', 'donor191', '6041231192', '22287', '8.6', '1.15', 'A');

insert into Item
values('191', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22287');

insert into distribution_Shift
values('8.6', '1.15', 'B');

insert into Collection_Shift
values('8.65', '1.2', 'A');

insert into Item_Collects
values('192', 'donor192', '6041231193', '22288', '8.65', '1.2', 'A');

insert into Item
values('192', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22288');

insert into distribution_Shift
values('8.65', '1.2', 'B');

insert into Collection_Shift
values('8.7', '1.25', 'A');

insert into Item_Collects
values('193', 'donor193', '6041231194', '22289', '8.7', '1.25', 'A');

insert into Item
values('193', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22289');

insert into distribution_Shift
values('8.7', '1.25', 'B');

insert into Collection_Shift
values('8.75', '1.3', 'A');

insert into Item_Collects
values('194', 'donor194', '6041231195', '22290', '8.75', '1.3', 'A');

insert into Item
values('194', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22290');

insert into distribution_Shift
values('8.75', '1.3', 'B');

insert into Collection_Shift
values('8.8', '1.35', 'A');

insert into Item_Collects
values('195', 'donor195', '6041231196', '22291', '8.8', '1.35', 'A');

insert into Item
values('195', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22291');

insert into distribution_Shift
values('8.8', '1.35', 'B');

insert into Collection_Shift
values('8.85', '1.4', 'A');

insert into Item_Collects
values('196', 'donor196', '6041231197', '22292', '8.85', '1.4', 'A');

insert into Item
values('196', 'rice', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22292');

insert into distribution_Shift
values('8.85', '1.4', 'B');

insert into Collection_Shift
values('8.9', '1.45', 'A');

insert into Item_Collects
values('197', 'donor197', '6041231198', '22293', '8.9', '1.45', 'A');

insert into Item
values('197', 'peanut butter', 'protein', 'PantryA');

insert into expirationDate
values('22293');

insert into distribution_Shift
values('8.9', '1.45', 'B');

insert into Collection_Shift
values('8.95', '1.5', 'A');

insert into Item_Collects
values('198', 'donor198', '6041231199', '22294', '8.95', '1.5', 'A');

insert into Item
values('198', 'bread', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22294');

insert into distribution_Shift
values('8.95', '1.5', 'B');

insert into Collection_Shift
values('9.0', '1.55', 'A');

insert into Item_Collects
values('199', 'donor199', '6041231200', '22295', '9.0', '1.55', 'A');

insert into Item
values('199', 'canned vegetables', 'carbohydrate', 'PantryA');

insert into expirationDate
values('22295');

insert into distribution_Shift
values('9.0', '1.55', 'B');

insert into Administrator
values('6041231200', 'boss0', 'bosspass', 'topboss');

insert into Administrator
values('6041231201', 'boss1', 'bosspass', 'anothertopboss');

insert into volunteer_add
values('genericUser0', 'topboss', '6041231202', 'genericName0', 'genericPass0');

insert into volunteer_add
values('genericUser1', 'topboss', '6041231203', 'genericName1', 'genericPass1');

insert into volunteer_add
values('genericUser2', 'topboss', '6041231204', 'genericName2', 'genericPass2');

insert into volunteer_add
values('genericUser3', 'topboss', '6041231205', 'genericName3', 'genericPass3');

insert into volunteer_add
values('genericUser4', 'topboss', '6041231206', 'genericName4', 'genericPass4');

insert into volunteer_add
values('genericUser5', 'topboss', '6041231207', 'genericName5', 'genericPass5');

insert into volunteer_add
values('genericUser6', 'topboss', '6041231208', 'genericName6', 'genericPass6');

insert into volunteer_add
values('genericUser7', 'topboss', '6041231209', 'genericName7', 'genericPass7');

insert into volunteer_add
values('genericUser8', 'topboss', '6041231210', 'genericName8', 'genericPass8');

insert into volunteer_add
values('genericUser9', 'topboss', '6041231211', 'genericName9', 'genericPass9');

insert into volunteer_add
values('genericUser10', 'topboss', '6041231212', 'genericName10', 'genericPass10');

insert into volunteer_add
values('genericUser11', 'topboss', '6041231213', 'genericName11', 'genericPass11');

insert into volunteer_add
values('genericUser12', 'topboss', '6041231214', 'genericName12', 'genericPass12');

insert into volunteer_add
values('genericUser13', 'topboss', '6041231215', 'genericName13', 'genericPass13');

insert into volunteer_add
values('genericUser14', 'topboss', '6041231216', 'genericName14', 'genericPass14');

insert into volunteer_add
values('genericUser15', 'topboss', '6041231217', 'genericName15', 'genericPass15');

insert into volunteer_add
values('genericUser16', 'topboss', '6041231218', 'genericName16', 'genericPass16');

insert into volunteer_add
values('genericUser17', 'topboss', '6041231219', 'genericName17', 'genericPass17');

insert into volunteer_add
values('genericUser18', 'topboss', '6041231220', 'genericName18', 'genericPass18');

insert into volunteer_add
values('genericUser19', 'topboss', '6041231221', 'genericName19', 'genericPass19');

insert into volunteer_add
values('genericUser20', 'topboss', '6041231222', 'genericName20', 'genericPass20');

insert into volunteer_add
values('genericUser21', 'topboss', '6041231223', 'genericName21', 'genericPass21');

insert into volunteer_add
values('genericUser22', 'topboss', '6041231224', 'genericName22', 'genericPass22');

insert into volunteer_add
values('genericUser23', 'topboss', '6041231225', 'genericName23', 'genericPass23');

insert into volunteer_add
values('genericUser24', 'topboss', '6041231226', 'genericName24', 'genericPass24');

insert into volunteer_add
values('genericUser25', 'topboss', '6041231227', 'genericName25', 'genericPass25');

insert into volunteer_add
values('genericUser26', 'topboss', '6041231228', 'genericName26', 'genericPass26');

insert into volunteer_add
values('genericUser27', 'topboss', '6041231229', 'genericName27', 'genericPass27');

insert into volunteer_add
values('genericUser28', 'topboss', '6041231230', 'genericName28', 'genericPass28');

insert into volunteer_add
values('genericUser29', 'topboss', '6041231231', 'genericName29', 'genericPass29');

insert into volunteer_add
values('genericUser30', 'topboss', '6041231232', 'genericName30', 'genericPass30');

insert into volunteer_add
values('genericUser31', 'topboss', '6041231233', 'genericName31', 'genericPass31');

insert into volunteer_add
values('genericUser32', 'topboss', '6041231234', 'genericName32', 'genericPass32');

insert into volunteer_add
values('genericUser33', 'topboss', '6041231235', 'genericName33', 'genericPass33');

insert into volunteer_add
values('genericUser34', 'topboss', '6041231236', 'genericName34', 'genericPass34');

insert into volunteer_add
values('genericUser35', 'topboss', '6041231237', 'genericName35', 'genericPass35');

insert into volunteer_add
values('genericUser36', 'topboss', '6041231238', 'genericName36', 'genericPass36');

insert into volunteer_add
values('genericUser37', 'topboss', '6041231239', 'genericName37', 'genericPass37');

insert into volunteer_add
values('genericUser38', 'topboss', '6041231240', 'genericName38', 'genericPass38');

insert into volunteer_add
values('genericUser39', 'topboss', '6041231241', 'genericName39', 'genericPass39');

insert into volunteer_add
values('genericUser40', 'topboss', '6041231242', 'genericName40', 'genericPass40');

insert into volunteer_add
values('genericUser41', 'topboss', '6041231243', 'genericName41', 'genericPass41');

insert into volunteer_add
values('genericUser42', 'topboss', '6041231244', 'genericName42', 'genericPass42');

insert into volunteer_add
values('genericUser43', 'topboss', '6041231245', 'genericName43', 'genericPass43');

insert into volunteer_add
values('genericUser44', 'topboss', '6041231246', 'genericName44', 'genericPass44');

insert into volunteer_add
values('genericUser45', 'topboss', '6041231247', 'genericName45', 'genericPass45');

insert into volunteer_add
values('genericUser46', 'topboss', '6041231248', 'genericName46', 'genericPass46');

insert into volunteer_add
values('genericUser47', 'topboss', '6041231249', 'genericName47', 'genericPass47');

insert into volunteer_add
values('genericUser48', 'topboss', '6041231250', 'genericName48', 'genericPass48');

insert into volunteer_add
values('genericUser49', 'topboss', '6041231251', 'genericName49', 'genericPass49');

insert into volunteer_add
values('genericUser50', 'topboss', '6041231252', 'genericName50', 'genericPass50');

insert into volunteer_add
values('genericUser51', 'topboss', '6041231253', 'genericName51', 'genericPass51');

insert into volunteer_add
values('genericUser52', 'topboss', '6041231254', 'genericName52', 'genericPass52');

insert into volunteer_add
values('genericUser53', 'topboss', '6041231255', 'genericName53', 'genericPass53');

insert into volunteer_add
values('genericUser54', 'topboss', '6041231256', 'genericName54', 'genericPass54');

insert into volunteer_add
values('genericUser55', 'topboss', '6041231257', 'genericName55', 'genericPass55');

insert into volunteer_add
values('genericUser56', 'topboss', '6041231258', 'genericName56', 'genericPass56');

insert into volunteer_add
values('genericUser57', 'topboss', '6041231259', 'genericName57', 'genericPass57');

insert into volunteer_add
values('genericUser58', 'topboss', '6041231260', 'genericName58', 'genericPass58');

insert into volunteer_add
values('genericUser59', 'topboss', '6041231261', 'genericName59', 'genericPass59');

insert into volunteer_add
values('genericUser60', 'topboss', '6041231262', 'genericName60', 'genericPass60');

insert into volunteer_add
values('genericUser61', 'topboss', '6041231263', 'genericName61', 'genericPass61');

insert into volunteer_add
values('genericUser62', 'topboss', '6041231264', 'genericName62', 'genericPass62');

insert into volunteer_add
values('genericUser63', 'topboss', '6041231265', 'genericName63', 'genericPass63');

insert into volunteer_add
values('genericUser64', 'topboss', '6041231266', 'genericName64', 'genericPass64');

insert into volunteer_add
values('genericUser65', 'topboss', '6041231267', 'genericName65', 'genericPass65');

insert into volunteer_add
values('genericUser66', 'topboss', '6041231268', 'genericName66', 'genericPass66');

insert into volunteer_add
values('genericUser67', 'topboss', '6041231269', 'genericName67', 'genericPass67');

insert into volunteer_add
values('genericUser68', 'topboss', '6041231270', 'genericName68', 'genericPass68');

insert into volunteer_add
values('genericUser69', 'topboss', '6041231271', 'genericName69', 'genericPass69');

insert into volunteer_add
values('genericUser70', 'topboss', '6041231272', 'genericName70', 'genericPass70');

insert into volunteer_add
values('genericUser71', 'topboss', '6041231273', 'genericName71', 'genericPass71');

insert into volunteer_add
values('genericUser72', 'topboss', '6041231274', 'genericName72', 'genericPass72');

insert into volunteer_add
values('genericUser73', 'topboss', '6041231275', 'genericName73', 'genericPass73');

insert into volunteer_add
values('genericUser74', 'topboss', '6041231276', 'genericName74', 'genericPass74');

insert into volunteer_add
values('genericUser75', 'topboss', '6041231277', 'genericName75', 'genericPass75');

insert into volunteer_add
values('genericUser76', 'topboss', '6041231278', 'genericName76', 'genericPass76');

insert into volunteer_add
values('genericUser77', 'topboss', '6041231279', 'genericName77', 'genericPass77');

insert into volunteer_add
values('genericUser78', 'topboss', '6041231280', 'genericName78', 'genericPass78');

insert into volunteer_add
values('genericUser79', 'topboss', '6041231281', 'genericName79', 'genericPass79');

insert into volunteer_add
values('genericUser80', 'topboss', '6041231282', 'genericName80', 'genericPass80');

insert into volunteer_add
values('genericUser81', 'topboss', '6041231283', 'genericName81', 'genericPass81');

insert into volunteer_add
values('genericUser82', 'topboss', '6041231284', 'genericName82', 'genericPass82');

insert into volunteer_add
values('genericUser83', 'topboss', '6041231285', 'genericName83', 'genericPass83');

insert into volunteer_add
values('genericUser84', 'topboss', '6041231286', 'genericName84', 'genericPass84');

insert into volunteer_add
values('genericUser85', 'topboss', '6041231287', 'genericName85', 'genericPass85');

insert into volunteer_add
values('genericUser86', 'topboss', '6041231288', 'genericName86', 'genericPass86');

insert into volunteer_add
values('genericUser87', 'topboss', '6041231289', 'genericName87', 'genericPass87');

insert into volunteer_add
values('genericUser88', 'topboss', '6041231290', 'genericName88', 'genericPass88');

insert into volunteer_add
values('genericUser89', 'topboss', '6041231291', 'genericName89', 'genericPass89');

insert into volunteer_add
values('genericUser90', 'topboss', '6041231292', 'genericName90', 'genericPass90');

insert into volunteer_add
values('genericUser91', 'topboss', '6041231293', 'genericName91', 'genericPass91');

insert into volunteer_add
values('genericUser92', 'topboss', '6041231294', 'genericName92', 'genericPass92');

insert into volunteer_add
values('genericUser93', 'topboss', '6041231295', 'genericName93', 'genericPass93');

insert into volunteer_add
values('genericUser94', 'topboss', '6041231296', 'genericName94', 'genericPass94');

insert into volunteer_add
values('genericUser95', 'topboss', '6041231297', 'genericName95', 'genericPass95');

insert into volunteer_add
values('genericUser96', 'topboss', '6041231298', 'genericName96', 'genericPass96');

insert into volunteer_add
values('genericUser97', 'topboss', '6041231299', 'genericName97', 'genericPass97');

insert into volunteer_add
values('genericUser98', 'topboss', '6041231300', 'genericName98', 'genericPass98');

insert into volunteer_add
values('genericUser99', 'topboss', '6041231301', 'genericName99', 'genericPass99');

