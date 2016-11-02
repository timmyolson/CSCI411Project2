
CREATE TABLE Person (
  pid number default NULL,
  pname varchar2(30) default NULL,
  email varchar2(50) default NULL,
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
  pcname varchar2(80) default NULL,
  phone varchar2(20) default NULL,
  PRIMARY KEY (pcid)
);

CREATE TABLE Address (
  street varchar2(50) NOT NULL,
  city varchar2(30) NOT NULL,
  state varchar2(20) NOT NULL,
  PRIMARY KEY (street, city, state)
);

CREATE TABLE Subscription (
  sid varchar2(11),
  slen number,
  begin_date date,
  fee varchar2(10) default NULL,
  PRIMARY KEY (sid)
);

CREATE TABLE Users (
  pid number NOT NULL references person(pid),
  uname varchar2(30),
  PRIMARY KEY (pid)
);

CREATE TABLE Viewer (
  vid number default NULL,
  PRIMARY KEY (vid)
);

CREATE TABLE Catalog_item (
  catid varchar2(10),
  contract_term date,
  PRIMARY KEY (catid)
);

CREATE TABLE Journal (
  jid varchar2(10),
  jtitle varchar2(80),
  jvol number,
  content varchar2(80),
  PRIMARY KEY (jid),
  FOREIGN KEY (jid) references Catalog_item(catid) );

CREATE TABLE Magazine (
  mid varchar2(10),
  mtitle varchar2(80),
  jvol number,
  content varchar2(80),
  PRIMARY KEY (mid),
  FOREIGN KEY (mid) references Catalog_item(catid) );

CREATE TABLE Book (
  bid varchar2(10),
  btitle varchar2(80),
  edition number,
  content varchar2(80),
  PRIMARY KEY (bid),
  FOREIGN KEY (bid) references Catalog_item(catid) );

CREATE TABLE Conference_proceedings (
  cid varchar2(10),
  cptitle varchar2(150),
  content varchar2(80),
  PRIMARY KEY (cid),
  FOREIGN KEY (cid) references Catalog_item(catid) );


CREATE TABLE Reference (
  catid varchar2(10),
  cite_id varchar2(10),
  PRIMARY KEY (catid, cite_id),
  FOREIGN KEY (catid) references Catalog_item );

CREATE TABLE Creates (
  vid  number,
  pid  number,
  sid  varchar2(20) NOT NULL,
  PRIMARY KEY (vid, sid, pid),
  FOREIGN KEY (vid) references Viewer,
  FOREIGN KEY (sid) references Subscription,
  FOREIGN KEY (pid) references Users );

CREATE TABLE Search (
  vid number NOT NULL,
  catid varchar2(10),
  PRIMARY KEY (vid, catid),
  FOREIGN KEY (vid) references Viewer,
  FOREIGN KEY (catid) references Catalog_item );

CREATE TABLE Retrieve (
  pid number,
  catid varchar2(10),
  r_date date,
  PRIMARY KEY (pid, catid, r_date),
  FOREIGN KEY (pid) references Users,
  FOREIGN KEY (catid) references Catalog_item );

CREATE TABLE Writes (
  catid varchar2(10) NOT NULL,
  pid number NOT NULL,
  PRIMARY KEY (catid, pid),
  FOREIGN KEY (catid) references Catalog_item,
  FOREIGN KEY (pid) references Author );

CREATE TABLE Edits (
  catid varchar2(10) NOT NULL,
  pid number NOT NULL,
  PRIMARY KEY (catid, pid),
  FOREIGN KEY (catid) references Catalog_item,
  FOREIGN KEY (pid) references Editor );

CREATE TABLE Publishes (
  catid varchar2(10) NOT NULL,
  pcid number NOT NULL,
  publish_date date,
  PRIMARY KEY (catid, pcid),
  FOREIGN KEY (catid) references Catalog_item,
  FOREIGN KEY (pcid) references Publishing_Company );

CREATE TABLE Located_at (
  pcid number NOT NULL,
  street varchar2(50) NOT NULL,
  city varchar2(30) NOT NULL,
  state varchar2(20) NOT NULL,
  PRIMARY KEY (pcid, street, city, state),
  FOREIGN KEY (pcid) references Publishing_Company,
  FOREIGN KEY (street, city, state) references Address );

CREATE TABLE Lives_At (
  pid number NOT NULL,
  street varchar2(50) NOT NULL,
  city varchar2(30) NOT NULL,
  state varchar2(20) NOT NULL,
  PRIMARY KEY (pid, street, city, state),
  FOREIGN KEY (pid) references Person,
  FOREIGN KEY (street, city, state) references Address );
