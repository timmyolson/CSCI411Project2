CREATE TABLE Person (
  pid number default NULL,
  pname varchar2(255) default NULL,
  email varchar2(255) default NULL,
  PRIMARY KEY (pid)
);

CREATE TABLE Author (
  pid number NOT NULL references person(pid),
  PRIMARY KEY (pid)
);

CREATE TABLE Editor (
  pid number NOT NULL references person(pid),
  PRIMARY KEY (pid)
);

CREATE TABLE Publishing_Company (
  pcid number default NULL,
  pcname varchar2(255) default NULL,
  phone varchar2(100) default NULL,
  PRIMARY KEY (pcid)
);

CREATE TABLE Address (
  street varchar2(255) NOT NULL,
  city varchar2(255) NOT NULL,
  state varchar2(50) NOT NULL,
  PRIMARY KEY (street, city, state)
);

CREATE TABLE Subscription (
  sid varchar2(255),
  slen varchar2(50) default NULL,
  begin_date varchar2(255),
  fee varchar2(100) default NULL
  PRIMARY KEY (sid)
);

CREATE TABLE User (
  uid varchar2(20) default NULL,
  uname varchar2(255) default NULL,
  PRIMARY KEY (uid)
);

CREATE TABLE Viewer (
  vid number default NULL,
  PRIMARY KEY (vid)
);

CREATE TABLE Catalog_item (
  catid varchar2(255),
  contract_term varchar2(255),
  PRIMARY KEY (catid)
);

-- Journal
INSERT INTO Journal (jid,jtitle,jvol,content)

-- Magazine
INSERT INTO Magazine (mid,mtitle,mvol,content)

-- Book
INSERT INTO Book (bid,btitle,edition,content)

-- Journal
INSERT INTO Conference_proceedings (cpid,cptitle,content)