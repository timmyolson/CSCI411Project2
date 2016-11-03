create or replace procedure add_data_retrive_user ( c_id varchar2,idd number ) authid definer as
    begin
      insert into retrieve (catid, pid,r_date ) values (c_id, idd, sysdate );
      end add_data_retrive_user;
