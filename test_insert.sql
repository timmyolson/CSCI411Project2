
INSERT INTO Person (pid,pname,email) VALUES (111,'Mr. Author','writes@example.com');
INSERT INTO Person (pid,pname,email) VALUES (112,'Mr. Editor','edits@example.com');
INSERT INTO Author (pid) VALUES (111);
INSERT INTO Editor (pid) VALUES (112);
INSERT INTO Publishing_Company (pcid,pcname,phone) VALUES (33333,'Publisher Name','(888) 888-8888');
INSERT INTO Address (street,city,state) VALUES ('street','city','state');
INSERT INTO Subscription (sid,slen,begin_date,fee) VALUES ('HTC81ARU6VV',12,'19-Nov-19','$700');
INSERT INTO User (uid,uname) VALUES ('u1000','Leonard Mckenzie');
INSERT INTO Viewer (vid) VALUES (1000);

INSERT INTO Catalog_item (catid,contract_term) VALUES ('IXUU3646','1-Jan-00');
INSERT INTO Catalog_item (catid,contract_term) VALUES ('ZLYG9928','2-Feb-01');
INSERT INTO Catalog_item (catid,contract_term) VALUES ('YZAQ6317','3-Mar-02');
INSERT INTO Catalog_item (catid,contract_term) VALUES ('KQZJ4175','4-Apr-03');

INSERT INTO Journal (jid,jtitle,jvol,content) VALUES ('IXUU3646','Title of Journal',1,'This is the content of a Journal');
INSERT INTO Magazine (mid,mtitle,jvol,content) VALUES ('ZLYG9928','Title of Magazine',1,'This is the content of a Magazine');
INSERT INTO Book (bid,btitle,edition,content) VALUES ('YZAQ6317','Title of Book',1,'This is the content of a Book');
INSERT INTO Conference_proceedings (cpid,cptitle,content) VALUES ('KQZJ4175','Title of a Conference article',1,'This is the content of a Conference article');

INSERT INTO Publishes (catid,pcid,year) VALUES ('IXUU3646',33333,2000);
INSERT INTO Publishes (catid,pcid,year) VALUES ('ZLYG9928',33333,2001);
INSERT INTO Publishes (catid,pcid,year) VALUES ('YZAQ6317',33333,2002);
INSERT INTO Publishes (catid,pcid,year) VALUES ('KQZJ4175',33333,2003);

INSERT INTO Edits (catid,pid) VALUES ('IXUU3646',112);
INSERT INTO Edits (catid,pid) VALUES ('ZLYG9928',112);
INSERT INTO Edits (catid,pid) VALUES ('YZAQ6317',112);
INSERT INTO Edits (catid,pid) VALUES ('KQZJ4175',112);

INSERT INTO Writes (catid,pid) VALUES ('IXUU3646',111);
INSERT INTO Writes (catid,pid) VALUES ('ZLYG9928',111);
INSERT INTO Writes (catid,pid) VALUES ('YZAQ6317',111);
INSERT INTO Writes (catid,pid) VALUES ('KQZJ4175',111);

INSERT INTO Reference (catid,ref_id) VALUES ('IXUU3646','ZLYG9928');
INSERT INTO Located_at (pcid,street,city,state) VALUES (33333,'street','city','state');
INSERT INTO Lives_at (pid,street,city,state) VALUES (111,'street','city','state');
INSERT INTO Lives_at (pid,street,city,state) VALUES (112,'street','city','state');
INSERT INTO Creates (vid,uid,sid) VALUES (1000,'u1000','HTC81ARU6VV',);

