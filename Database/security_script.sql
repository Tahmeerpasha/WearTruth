use ecommerce;
CREATE TABLE `users` (
 `username` varchar(50) NOT NULL,
 `password` varchar(68) NOT NULL,
 `enabled` tinyint NOT NULL,
 PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `authorities` (
 `username` varchar(50) NOT NULL,
 `authority` varchar(50) NOT NULL,
 UNIQUE KEY `authorities_idx_1` (`username`,`authority`),
 CONSTRAINT `authorities_ibfk_1` 
 FOREIGN KEY (`username`) 
 REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `users` 
VALUES
('Tahmeer','{bcrypt}$2a$10$wXvgS/Y5BTIkRzTmj6ODSub6FFmJc0kGWW67cCblMEygebgDMMkYK',1),
('Maxson','{bcrypt}$2a$10$hwKcdMGHu3sRRYf9HtnZeuwIk.2EEYBzYnaRzGxdwefq/7QSRmVWO',1),
('Sarkheel','{bcrypt}$2a$10$KUjUpEkUO3zSlFcxZ2OSxuALEtwHglx71czSYSnwfkatS.EwVJnvy',1),
('Umar','{bcrypt}$2a$10$QuGXBeWBDJwMVdcZvK5Da.00wQLp6mUPBEHoDtMar12OCKzuLGtlO',1);


INSERT INTO `authorities` 
VALUES
('Tahmeer','ROLE_USER'),
('Tahmeer','ROLE_ADMIN'),
('Maxson','ROLE_USER'),
('Maxson','ROLE_ADMIN'),
('Sarkheel','ROLE_USER'),
('Umar','ROLE_USER');
