

DROP TABLE IF EXISTS AUDIT_ROBOT;


DROP TABLE IF EXISTS ROBOTS_HAS_SPARE_PARTS;


DROP TABLE IF EXISTS ROBOTS_FROM_FACTORY;


DROP TABLE IF EXISTS SUPPLIERS_BRING_TO_FACTORY_2;


DROP TABLE IF EXISTS SUPPLIERS_BRING_TO_FACTORY_1;


DROP TABLE IF EXISTS ROBOTS;


DROP TABLE IF EXISTS SPARE_PARTS;


DROP TABLE IF EXISTS SUPPLIERS;


DROP TABLE IF EXISTS WORKERS_FACTORY_2;


DROP TABLE IF EXISTS WORKERS_FACTORY_1;


DROP TABLE IF EXISTS FACTORIES;


CREATE TABLE FACTORIES (id INT AUTO_INCREMENT PRIMARY KEY,
                                                      main_location VARCHAR(255));


CREATE TABLE WORKERS_FACTORY_1 (id INT AUTO_INCREMENT PRIMARY KEY,
                                                              first_name VARCHAR(100),
                                                                         last_name VARCHAR(100),
                                                                                   age INT, first_day DATE, last_day DATE);


CREATE TABLE WORKERS_FACTORY_2 (worker_id INT AUTO_INCREMENT PRIMARY KEY,
                                                                     first_name VARCHAR(100),
                                                                                last_name VARCHAR(100),
                                                                                          start_date DATE, end_date DATE);


CREATE TABLE SUPPLIERS (supplier_id INT AUTO_INCREMENT PRIMARY KEY,
                                                               name VARCHAR(100));


CREATE TABLE SPARE_PARTS (id INT AUTO_INCREMENT PRIMARY KEY,
                                                        color VARCHAR(10) CHECK (color IN ('red',
                                                                                           'gray',
                                                                                           'black',
                                                                                           'blue',
                                                                                           'silver')), name VARCHAR(100));


CREATE TABLE SUPPLIERS_BRING_TO_FACTORY_1 (supplier_id INT, spare_part_id INT, delivery_date DATE, quantity INT, CONSTRAINT fk_supplier_id1
                                           FOREIGN KEY (supplier_id) REFERENCES SUPPLIERS(supplier_id),
                                                                                CONSTRAINT fk_spare_part_id1
                                           FOREIGN KEY (spare_part_id) REFERENCES SPARE_PARTS(id),
                                                                                  CONSTRAINT chk_quantity1 CHECK (quantity > 0));


CREATE TABLE SUPPLIERS_BRING_TO_FACTORY_2 (supplier_id INT NOT NULL,
                                                           spare_part_id INT NOT NULL,
                                                                             delivery_date DATE, quantity INT, recipient_worker_id INT NOT NULL,
                                                                                                                                       CONSTRAINT fk_supplier_id2
                                           FOREIGN KEY (supplier_id) REFERENCES SUPPLIERS(supplier_id),
                                                                                CONSTRAINT fk_spare_part_id2
                                           FOREIGN KEY (spare_part_id) REFERENCES SPARE_PARTS(id),
                                                                                  CONSTRAINT fk_worker_id2
                                           FOREIGN KEY (recipient_worker_id) REFERENCES WORKERS_FACTORY_2(worker_id),
                                                                                        CONSTRAINT chk_quantity2 CHECK (quantity > 0));


CREATE TABLE ROBOTS (id INT AUTO_INCREMENT PRIMARY KEY,
                                                   model VARCHAR(50));


CREATE TABLE ROBOTS_HAS_SPARE_PARTS (robot_id INT, spare_part_id INT, CONSTRAINT fk_robot_id1
                                     FOREIGN KEY (robot_id) REFERENCES ROBOTS(id),
                                                                       CONSTRAINT fk_spare_part_id3
                                     FOREIGN KEY (spare_part_id) REFERENCES SPARE_PARTS(id));


CREATE TABLE ROBOTS_FROM_FACTORY (robot_id INT, factory_id INT, CONSTRAINT fk_robot_id2
                                  FOREIGN KEY (robot_id) REFERENCES ROBOTS(id),
                                                                    CONSTRAINT fk_factory_id1
                                  FOREIGN KEY (factory_id) REFERENCES FACTORIES(id));


CREATE TABLE AUDIT_ROBOT (robot_id INT, created_at DATE, CONSTRAINT fk_robot_id3
                          FOREIGN KEY (robot_id) REFERENCES ROBOTS(id));

