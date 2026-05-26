//import reusable data types from commons.cds
using { ul.commons } from './commons';
using { cuid, managed, temporal } from '@sap/cds/common';

//to unique identification
namespace sana.team1;

//use for reusability of data types
//type Guid : String(32);   commenting this as we have already defined in commons.cds and we are importing it here

//context use for grouping purpose of entities
context master{
    entity student: commons.address{
        key id : commons.Guid;
        name : String(100);
        gender : String(2);
        rollno : Integer;
        //foreign key
        class: Association to one Departments
    }

    entity Departments{
        key id : commons.Guid;
        deptName : String(120);
        specialization : String(120);
        hod : String(120);
    };

    entity Books{
        key id : commons.Guid;
        bookName : localized String(120);
        author : String(120);
        stock : Int16;
    }
}

context transactional{
    entity Subs: cuid, managed, temporal{
        book : Association to one master.Books;
        student : Association to one master.student;
    }
}