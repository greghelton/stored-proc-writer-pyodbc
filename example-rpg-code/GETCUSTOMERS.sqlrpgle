**free
ctl-opt dftactgrp(*no) actgrp(*caller);

// 1. File Declaration
dcl-f MYFILE usage(*input) keyed;

// 2. Data Structure Array Definition
dcl-ds ds_returnData qualified dim(50);
  emp_id   int(10);
  emp_name char(30);
  city     char(20);
  salary   packed(9:2);
end-ds;

// 3. Index/Row Counter
dcl-s idx int(10) inz(0);

// 4. Processing Loop
setll *start MYFILE;
read MYFILE;

dow not %eof(MYFILE);
  // Increment the index for the next slot
  idx += 1; 

  // Map file fields to the data structure array row
  ds_returnData(idx).emp_id   = DB_EMPID;    // (Assumes DB_xxx are fields in MYFILE)
  ds_returnData(idx).emp_name = DB_EMPNAME;
  ds_returnData(idx).city     = DB_CITY;
  ds_returnData(idx).salary   = DB_SALARY;
  
  // Array overflow check (matching the DIM of 50)
  if idx >= %elem(ds_returnData);
    leave;
  endif;

  read MYFILE;
enddo;

// 5. Return the populated data structure rows as a result set
if idx > 0;
  exec sql set result sets array :ds_returnData for :idx rows;
endif;

*inlr = *on;
return;
