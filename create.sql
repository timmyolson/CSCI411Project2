
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
  fee varchar2(100) default NULL,
  PRIMARY KEY (sid)
);

CREATE TABLE Users (
  user_id varchar2(20) default NULL,
  uname varchar2(255) default NULL,
  PRIMARY KEY (user_id)
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

CREATE TABLE Journal (
  jid varchar2(255),
  jtitle varchar2(255),
  jvol number,
  content varchar2(255),
  catid varchar2(255) NOT NULL references Catalog_item(catid),
  PRIMARY KEY (jid, catid) );

CREATE TABLE Magazine (
  mid varchar2(255),
  mtitle varchar2(255),
  jvol number,
  content varchar2(255),
  catid varchar2(255) NOT NULL references Catalog_item(catid),
  PRIMARY KEY (mid, catid) );

CREATE TABLE Book (
  bid varchar2(255),
  btitle varchar2(255),
  edition number,
  content varchar2(255),
  catid varchar2(255) NOT NULL references Catalog_item(catid),
  PRIMARY KEY (bid, catid) );

CREATE TABLE Conference_proceedings (
  cid varchar2(255),
  cptitle varchar2(255),
  content varchar2(255),
  catid varchar2(255) NOT NULL references Catalog_item(catid),
  PRIMARY KEY (cid, catid) );


CREATE TABLE Reference (
  catid varchar2(255),
  cite_id varchar2(255),
  PRIMARY KEY (catid, cite_id),
  FOREIGN KEY (catid) references Catalog_item );

CREATE TABLE creates (
  vid  number,
  sid  varchar2(255) NOT NULL,
  user_id  varchar2(255) NOT NULL,
  PRIMARY KEY (vid, sid, user_id),
  FOREIGN KEY (vid) references Viewer,
  FOREIGN KEY (sid) references Subscription,
  FOREIGN KEY (user_id) references Users );

CREATE TABLE Search (
  vid number NOT NULL,
  catid varchar2(255),
  PRIMARY KEY (vid, catid),
  FOREIGN KEY (vid) references Viewer,
  FOREIGN KEY (catid) references Catalog_item );

CREATE TABLE Retrieve (
  user_id varchar2(255),
  catid varchar2(255),
  PRIMARY KEY (user_id, catid),
  FOREIGN KEY (user_id) references Users,
  FOREIGN KEY (catid) references Catalog_item );

CREATE TABLE Writes (
  catid varchar2(255) NOT NULL,
  pid number NOT NULL,
  PRIMARY KEY (catid, pid),
  FOREIGN KEY (catid) references Catalog_item,
  FOREIGN KEY (pid) references Author );

CREATE TABLE Edits (
  catid varchar2(255) NOT NULL,
  pid number NOT NULL,
  PRIMARY KEY (catid, pid),
  FOREIGN KEY (catid) references Catalog_item,
  FOREIGN KEY (pid) references Editor );

CREATE TABLE Publishes (
  catid varchar2(255) NOT NULL,
  pcid number NOT NULL,
  year number,
  PRIMARY KEY (catid, pcid),
  FOREIGN KEY (catid) references Catalog_item,
  FOREIGN KEY (pcid) references Publishing_Company );

CREATE TABLE Located_at (
  pcid number NOT NULL,
  street varchar2(255),
  city varchar(255),
  state varchar(255),
  PRIMARY KEY (pcid, street, city, state),
  FOREIGN KEY (pcid) references Publishing_Company,
  FOREIGN KEY (street, city, state) references Address );

CREATE TABLE Lives_At (
  pid number NOT NULL,
  street varchar2(255),
  city varchar2(255),
  state varchar2(255),
  PRIMARY KEY (pid, street, city, state),
  FOREIGN KEY (pid) references Person,
  FOREIGN KEY (street, city, state) references Address );
