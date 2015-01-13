--<ScriptOptions statementTerminator="@"/>

DROP TABLE "DBINPUT_CUSTOMER"@
CREATE TABLE "DBINPUT_CUSTOMER" (
		"PKEY" VARCHAR(10) NOT NULL,
		"FIRSTNAME" VARCHAR(20),
		"LASTNAME" VARCHAR(20),
		"CCODE" VARCHAR(10)
	)
	DATA CAPTURE NONE@

DROP TABLE "DBINPUT_EVENTS"@
CREATE TABLE "DBINPUT_EVENTS" (
		"EVENT_ID" INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE NO CACHE),
		"OBJECT_KEY" VARCHAR(80) NOT NULL,
		"OBJECT_VERB" VARCHAR(40) NOT NULL,
	)
	DATA CAPTURE NONE@


ALTER TABLE "DBINPUT_CUSTOMER" ADD CONSTRAINT "DBINPUTCUSTOMERPK" PRIMARY KEY
	("PKEY")@

ALTER TABLE "DBINPUT_EVENTS" ADD CONSTRAINT "DBINPUTEVENTPK" PRIMARY KEY
	("EVENT_ID")@

CREATE TRIGGER "DBIN_CUST_CREATE" 
	AFTER INSERT ON "DBINPUT_CUSTOMER"
	REFERENCING  NEW AS N
	FOR EACH ROW

INSERT INTO DBINPUT_EVENTS (OBJECT_KEY, OBJECT_VERB)
       VALUES (N.pkey, 'Create')@

CREATE TRIGGER "DBIN_CUST_DELETE" 
	AFTER DELETE ON "DBINPUT_CUSTOMER"
	REFERENCING  OLD AS O
	FOR EACH ROW

INSERT INTO DBINPUT_EVENTS (OBJECT_KEY, OBJECT_VERB)
       VALUES (O.pkey, 'Delete')@

CREATE TRIGGER "DBIN_CUST_UPDATE" 
	AFTER UPDATE ON "DBINPUT_CUSTOMER"
	REFERENCING  NEW AS N
	FOR EACH ROW

INSERT INTO DBINPUT_EVENTS (OBJECT_KEY, OBJECT_VERB)
       VALUES (N.pkey, 'Update')@

