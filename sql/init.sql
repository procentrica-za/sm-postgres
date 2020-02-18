/* ---- Creating Extension needed for uuid datatypes and uuid operations ---- */
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

/* ---- Initializing all tables ---- */

CREATE TABLE public.Image (
    ID uuid PRIMARY KEY NOT NULL,
    PathString Varchar(255) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);
CREATE TABLE public.AdvertisementImage (
    AdvertisingID uuid NOT NULL,
    ImageID uuid NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp,
    PRIMARY KEY(AdvertisingID, ImageID)
);
CREATE TABLE public.User (
    ID uuid PRIMARY KEY NOT NULL,
    Username Varchar(50) NOT NULL,
    Password Varchar(50) NOT NULL,
    Name Varchar(64) NOT NULL,
    Surname Varchar(64) NOT NULL,
    Email Varchar(50) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);

CREATE TABLE public.Advertisement (
    ID uuid PRIMARY KEY NOT NULL,
    UserID uuid NOT NULL,
    IsSelling Boolean DEFAULT(true),
    CONSTRAINT adertisementuserfkey FOREIGN KEY (UserID)
        REFERENCES public.User (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    AdvertisementType Varchar(3) NOT NULL,
    EntityID uuid NOT NULL,
    Price DEC(15,2) NOT NULL,
    Description Varchar(255) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);

CREATE TABLE public.Rating (
    ID uuid PRIMARY KEY NOT NULL,
    AdvertisementID uuid NOT NULL,
    SellerID uuid NOT NULL,
    BuyerID uuid NOT NULL,
    CONSTRAINT ratingsellerfkey FOREIGN KEY (SellerID)
        REFERENCES public.User (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT ratingbuyerfkey FOREIGN KEY (BuyerID)
        REFERENCES public.User (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT ratingadvertisementfkey FOREIGN KEY (AdvertisementID)
        REFERENCES public.Advertisement (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    BuyerRating int,
    SellerRating int,
    BuyerComments Varchar(255),
    SellerComments Varchar(255),
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);
CREATE TABLE public.AdvertisementType (
    Code Varchar(3) NOT NULL,
    Name Varchar(350) NOT NULL,
    Description Varchar(255) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);

CREATE TABLE public.Institution (
    ID uuid PRIMARY KEY NOT NULL,
    Name Varchar(50) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);


CREATE TABLE public.Faculty (
    ID uuid PRIMARY KEY NOT NULL,
    InstitutionID uuid NOT NULL,
    CONSTRAINT facultyinstitutionfkey FOREIGN KEY (InstitutionID)
        REFERENCES public.Institution (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    Name Varchar(50) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Module (
    ID uuid PRIMARY KEY NOT NULL,
    FacultyID uuid NOT NULL,
    CONSTRAINT modulefacultyfkey FOREIGN KEY (FacultyID)
        REFERENCES public.Faculty (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    Name Varchar(50) NOT NULL,
    ModuleCode Varchar(50) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Notes (
    ID uuid PRIMARY KEY NOT NULL,
    ModuleID uuid NOT NULL,
    CONSTRAINT notesmodulefkey FOREIGN KEY (ModuleID)
        REFERENCES public.Module (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Textbook (
    ID uuid PRIMARY KEY NOT NULL,
    ModuleID uuid NOT NULL,
    CONSTRAINT textbookmodulefkey FOREIGN KEY (ModuleID)
        REFERENCES public.Module (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    Name Varchar(255) NOT NULL,
    Edition Varchar(30),
    Quality Varchar(255) NOT NULL,
    Author Varchar(255) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);

CREATE TABLE public.Tutor (
    ID uuid PRIMARY KEY NOT NULL,
    Subject Varchar(50) NOT NULL,
    YearCompleted Varchar(4) NOT NULL,
    ModuleID uuid NOT NULL,
    CONSTRAINT tutormodulefkey FOREIGN KEY (ModuleID)
        REFERENCES public.Module (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    Venue Varchar(100) NOT NULL,
    NotesIncluded Boolean NOT NULL,
    Terms Varchar(20) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);

CREATE TABLE public.AccomodationType (
    Code Varchar(3) PRIMARY KEY NOT NULL,
    Name Varchar(50) NOT NULL,
    Description Varchar(255) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);

CREATE TABLE public.Accomodation (
    ID uuid PRIMARY KEY NOT NULL,
    AccomodationTypeCode varchar(3) NOT NULL,
    CONSTRAINT accomodationaccomodationtypefkey FOREIGN KEY (AccomodationTypeCode)
        REFERENCES public.AccomodationType (Code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    InstitutionID uuid NOT NULL,
    CONSTRAINT accomodationinstitutionfkey FOREIGN KEY (InstitutionID)
        REFERENCES public.Institution (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    Location Varchar(255) NOT NULL,
    DistanceToCampus Varchar(20) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Feature (
    Code VARCHAR(3) PRIMARY KEY NOT NULL,
    Name Varchar(100) NOT NULL,
    Description Varchar(255) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);

CREATE TABLE public.AccomodationFeature (
    AccomodationID uuid NOT NULL,
    FeatureID uuid NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp,
    PRIMARY KEY(AccomodationID, FeatureID)
);
CREATE TABLE public.EntityCode (
    Code Varchar(3) PRIMARY KEY NOT NULL,
    Name Varchar(25) NOT NULL,
    Description Varchar(255) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);
CREATE TABLE public.EventCode (
    Code Varchar(3) PRIMARY KEY NOT NULL,
    Name Varchar(25) NOT NULL,
    Description Varchar(255) NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Event (
    ID uuid PRIMARY KEY NOT NULL,
    EventCode varchar(3) NOT NULL,
    EntityCode varchar(3) NOT NULL,
    CONSTRAINT eventeventcodefkey FOREIGN KEY (EventCode)
        REFERENCES public.EventCode (Code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT evententitycodefkey FOREIGN KEY (EntityCode)
        REFERENCES public.EntityCode (Code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,    
    EntityID uuid NOT NULL,
    CreatedDateTime timestamp NOT NULL,
    IsDeleted Boolean DEFAULT(false),
    ModifiedDateTime timestamp
);

/* ---- Creating all functions needed for CRUD functions to be used by the CRUD service ---- */


/* ---- Register User Function ---- */
CREATE OR REPLACE FUNCTION public.registeruser(
	var_username character varying,
	var_password character varying,
	var_name character varying,
	var_surname character varying,
	var_email character varying,
	OUT res_created boolean,
	OUT ret_username character varying,
	OUT ret_user_id uuid,
	OUT ret_error character varying)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
    userid uuid := uuid_generate_v4();
BEGIN
	IF EXISTS (SELECT 1 FROM public.user u WHERE u.username = var_username) THEN
		res_created := false;
		ret_username := '';
		ret_user_id := '00000000-0000-0000-0000-000000000000';
		ret_error := 'This Username Already Exists!';
			ELSE IF EXISTS (SELECT 1 FROM public.user u WHERE u.email = var_email) THEN
				res_created := false;
				ret_username := '';
				ret_user_id := '00000000-0000-0000-0000-000000000000';
				ret_error := 'This Email Already Exists!';
					ELSE
						INSERT INTO public.User(ID, Username, Password, Name, Surname, Email, CreatedDateTime, IsDeleted, ModifiedDateTime)
    					VALUES (userid, var_username, var_password, var_name, var_surname, var_email, CURRENT_TIMESTAMP , 'false', CURRENT_TIMESTAMP);
    					res_created := true;
    					ret_username := var_username;
    					ret_user_id := userid;
						ret_error := 'User Successfully Created!';
    				END IF;
			END IF;
END;
$BODY$;

/* ---- Get user on ID Function ---- */

CREATE OR REPLACE FUNCTION public.getuser(
	var_userid uuid,
OUT ret_varid uuid,
OUT ret_username varchar(50),
OUT ret_name varchar (50),
OUT ret_surname varchar (50),
OUT ret_email varchar (50),
OUT ret_successget boolean)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
AS $BODY$
BEGIN
IF EXISTS (SELECT 1 FROM public.User u WHERE u.id = var_userid AND u.isdeleted = false) THEN
	SELECT u.id, u.username, u.name, u.surname, u.email
	INTO ret_varid, ret_username, ret_name, ret_surname, ret_email
    FROM public.User u
    WHERE var_userid = u.id AND isdeleted = false;
	ret_successget = true;
	ELSE
        ret_varid = '00000000-0000-0000-0000-000000000000';
        ret_username = 'none';
		ret_name = 'none';
		ret_surname = 'none';
		ret_email = 'none';
        ret_successget = false; 
    END IF;
END;
$BODY$;

/* ---- Update User details Function ---- */

CREATE OR REPLACE FUNCTION public.updateuser(
	var_userid uuid,
	var_username character varying,
	var_password character varying,
	var_name character varying,
	var_surname character varying,
	var_email character varying,
	OUT res_updated boolean,
	OUT res_error character varying)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
BEGIN
IF EXISTS (SELECT 1 FROM public.user u WHERE u.username = var_username AND u.id != var_userid) THEN
	res_updated := false;
	res_error := 'This Username Already Exists!';
		ELSE IF (SELECT 1 FROM public.user u WHERE u.email = var_email AND u.id != var_userid) THEN
			res_updated := false;
			res_error := 'This Email Already Exists!';
                ELSE IF (SELECT 1 FROM public.user u WHERE u.isdeleted = true AND u.id = var_userid) THEN
			    res_updated := false;
			    res_error := 'This User is deleted!';
				    ELSE
    				    UPDATE public.User
   				 	    SET username = var_username, password = var_password, name = var_name, surname = var_surname, email = var_email, modifieddatetime = CURRENT_TIMESTAMP 
    				    WHERE var_userid = id;
    				    res_updated := true;
					    res_error := 'User Successfully Updated';
				    END IF;
                END IF;
		END IF;
END;
$BODY$;

/* ---- Delete User on ID Function ---- */

CREATE OR REPLACE FUNCTION public.deleteuser(
	var_userid uuid,
	OUT res_deleted boolean)
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
BEGIN
    IF EXISTS (SELECT 1 FROM public.User u WHERE u.id = var_userid) THEN
        UPDATE public.User
        SET isdeleted = true 
        WHERE var_userid = id;
        res_deleted := true;
    ELSE
        res_deleted := false;
    END IF;
    
END;
$BODY$;

/* ---- Login User Function ---- */

CREATE OR REPLACE FUNCTION public.loginuser(
	var_username varchar(50),
	var_password varchar(50),
    OUT ret_userid uuid,
    OUT ret_username varchar(50),
    OUT ret_successlogin boolean
)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
AS $BODY$
BEGIN
IF EXISTS (SELECT 1 FROM public.User u WHERE u.username = var_username AND u.password = var_password) THEN
    SELECT u.id, u.username
    INTO ret_userid, ret_username 
    FROM public.User u 
    WHERE  u.username = var_username AND u.password = var_password; 
    ret_successlogin = true;
    ELSE
        ret_userid = '00000000-0000-0000-0000-000000000000';
        ret_username = var_username;
        ret_successlogin = false; 
    END IF;
END;
$BODY$;

/* ---- Add new Advertisement Function ---- */

CREATE OR REPLACE FUNCTION public.addadvertisement(
	var_userid uuid,
    var_isselling boolean,
	var_advertisementtype character varying,
	var_entityid uuid,
	var_price float,
	var_description character varying,
	OUT res_advertisementposted boolean,
	OUT ret_id uuid,
	OUT ret_error character varying)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
    id uuid := uuid_generate_v4();
BEGIN
	INSERT INTO public.Advertisement(ID, UserID, IsSelling, AdvertisementType, EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
    VALUES (id, var_userid,var_isselling, var_advertisementtype, var_entityid, var_price, var_description, CURRENT_TIMESTAMP , 'false', CURRENT_TIMESTAMP);
    res_advertisementposted := true;
    ret_id := id;
	ret_error := 'Advert Successfully Created!';
END;
$BODY$;

/* ---- Add Textbook Function ---- */
/* TODO: Error handling for duplicates */
CREATE OR REPLACE FUNCTION public.addtextbook(
	var_moduleid uuid,
	var_name character varying,
	var_edition character varying,
	var_quality character varying,
	var_author character varying,
	OUT ret_success bool,
	OUT ret_textbookid uuid)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	id uuid := uuid_generate_v4();
BEGIN
INSERT INTO public.Textbook(ID, ModuleID, Name, Edition, Quality, Author, CreatedDateTime, IsDeleted, ModifiedDateTime)
    VALUES (id, var_moduleid, var_name, var_edition, var_quality, var_author, CURRENT_TIMESTAMP , 'false', CURRENT_TIMESTAMP);
	ret_success = true;
	ret_textbookid = id;
END;
$BODY$;

/* ---- Add Tutor Function ---- */
/* TODO: Error handling for duplicates */
CREATE OR REPLACE FUNCTION public.addtutor(
	var_moduleid uuid,
	var_subject character varying,
	var_yearcompleted character varying,
	var_venue character varying,
	var_notesincluded bool,
    var_terms character varying,
	OUT ret_success bool,
	OUT ret_tutorid uuid)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	id uuid := uuid_generate_v4();
BEGIN
INSERT INTO public.Tutor(ID, Subject, YearCompleted, ModuleID, Venue, NotesIncluded, Terms, CreatedDateTime, IsDeleted, ModifiedDateTime)
    VALUES (id, var_subject, var_yearcompleted, var_moduleid, var_venue, var_notesincluded, var_terms, CURRENT_TIMESTAMP , 'false', CURRENT_TIMESTAMP);
	ret_success = true;
	ret_tutorid = id;
END;
$BODY$;

/* ---- Add Accomodation Function ---- */
/* TODO: Error handling for duplicates */
CREATE OR REPLACE FUNCTION public.addaccomodation(
	var_accomodationTypeCode character varying,
	var_institutionid uuid,
	var_location character varying,
    var_distanceToCampus character varying,
	OUT ret_success bool,
	OUT ret_accomodationid uuid)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	id uuid := uuid_generate_v4();
BEGIN
INSERT INTO public.Accomodation(ID, AccomodationTypeCode, InstitutionID, Location, DistanceToCampus, CreatedDateTime, IsDeleted, ModifiedDateTime)
    VALUES (id, var_accomodationTypeCode, var_institutionid, var_location, var_distanceToCampus, CURRENT_TIMESTAMP , 'false', CURRENT_TIMESTAMP);
	ret_success = true;
	ret_accomodationid = id;
END;
$BODY$;

/* ---- Add Notes Function ---- */
/* TODO: Error handling for duplicates */
CREATE OR REPLACE FUNCTION public.addnotes(
	var_moduleid uuid,
	OUT ret_success bool,
	OUT ret_noteid uuid)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	id uuid := uuid_generate_v4();
BEGIN
INSERT INTO public.Notes(ID, ModuleID, CreatedDateTime, IsDeleted, ModifiedDateTime)
    VALUES (id, var_moduleid, CURRENT_TIMESTAMP , 'false', CURRENT_TIMESTAMP);
	ret_success = true;
	ret_noteid = id;
END;
$BODY$;



/* ---- Get advertisement on ID Function ---- */
CREATE OR REPLACE FUNCTION public.getadvertisement(
	var_advertisementid uuid,
    OUT ret_varid uuid,
    OUT ret_userid uuid,
    OUT ret_isselling boolean,
    OUT ret_advertisementtype character varying,
    OUT ret_entityid uuid,
    OUT ret_price float,
    OUT ret_description character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
AS $BODY$
BEGIN
IF EXISTS (SELECT 1 FROM public.Advertisement u WHERE u.id = var_advertisementid AND u.isdeleted = false) THEN
	SELECT u.id, u.userid, u.isselling, u.advertisementtype, u.entityid, u.price, u.description
    INTO ret_varid, ret_userid,ret_isselling, ret_advertisementtype, ret_entityid, ret_price, ret_description
    FROM public.Advertisement u
    WHERE var_advertisementid = u.id AND isdeleted = false;
    ELSE
        ret_varid = '00000000-0000-0000-0000-000000000000';
        ret_userid = '00000000-0000-0000-0000-000000000000';
        ret_isselling = false;
		ret_advertisementtype = 'none';
		ret_entityid = '00000000-0000-0000-0000-000000000000';
		ret_price = 0;
        ret_description = 'none'; 
    END IF;
END;
$BODY$;

/* ---- Update Advertisement Function ---- */

CREATE OR REPLACE FUNCTION public.updateadvertisement(
	var_advertisementid uuid,
	var_userid uuid,
    var_isselling boolean,
	var_advertisementtype character varying,
	var_entityid uuid,
	var_price float,
	var_description character varying,
	OUT res_updated boolean,
	OUT res_error character varying)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
BEGIN
IF EXISTS (SELECT 1 FROM public.advertisement u WHERE u.isdeleted = true AND u.id = var_advertisementid) THEN
	res_updated := false;
	res_error := 'This Advertisement is deleted!';
    ELSE
        UPDATE public.Advertisement
   	    SET id = var_advertisementid, isselling = var_isselling, advertisementtype = var_advertisementtype, entityid = var_entityid, price = var_price, description = var_description, modifieddatetime = CURRENT_TIMESTAMP 
        WHERE var_advertisementid = id AND isdeleted = false;
        res_updated := true;
	    res_error := 'Advert Successfully Updated';
    END IF;
END;
$BODY$;


/* ---- Delete Advertisement on ID Function ---- */

CREATE OR REPLACE FUNCTION public.deleteadvertisement(
	var_advertisementid uuid,
	OUT res_deleted boolean)
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
BEGIN
    IF EXISTS (SELECT 1 FROM public.Advertisement u WHERE u.id = var_advertisementid) THEN
        UPDATE public.Advertisement
        SET isdeleted = true 
        WHERE var_advertisementid = id;
        res_deleted := true;
    ELSE
        res_deleted := false;
    END IF;
    
END;
$BODY$;

/* ---- Delete Advertisements pertaining to Users Function ---- */

CREATE OR REPLACE FUNCTION public.deleteuseradvertisements(
	var_userid uuid,
	OUT res_deleted boolean)
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
BEGIN
    IF EXISTS (SELECT * FROM public.Advertisement u WHERE u.userid = var_userid) THEN
        UPDATE public.Advertisement
        SET isdeleted = true 
        WHERE var_userid = userid;
        res_deleted := true;
    ELSE
        res_deleted := false;
    END IF;
    
END;
$BODY$;

/* ---- Get Advertisements by ad type Function ---- */

CREATE OR REPLACE FUNCTION public.getadvertisementbytype(
	var_advertisementtype character varying)
    RETURNS TABLE(advertisementid uuid, userid uuid, isselling boolean, advertisementtype character varying, entityid uuid, price numeric, description character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
    ROWS 1000
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT u.id, u.userid, u.isselling, u.advertisementtype, u.entityid, u.price, u.description
    FROM public.Advertisement u
    WHERE var_advertisementtype  = u.advertisementtype AND isdeleted = false;
END;
$BODY$;

/* ---- Get Advertisement by User ID Function ---- */

CREATE OR REPLACE FUNCTION public.getadvertisementbyuserid(
	var_userid uuid)
    RETURNS TABLE(advertisementid uuid, isselling boolean, advertisementtype character varying, entityid uuid, price numeric, description character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
    ROWS 1000
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT u.id, u.isselling, u.advertisementtype, u.entityid, u.price, u.description
    FROM public.Advertisement u
    WHERE var_userid  = u.userid AND isdeleted = false;
END;
$BODY$;

/* ---- Get all advertisements Function ---- */

CREATE OR REPLACE FUNCTION public.getalladvertisements()
    RETURNS TABLE(advertisementid uuid, userid uuid, isselling boolean, advertisementtype character varying, entityid uuid, price numeric, description character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
    ROWS 1000
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT u.id, u.userid, u.isselling, u.advertisementtype, u.entityid, u.price, u.description
    FROM public.Advertisement u
    WHERE isdeleted = false;
END;
$BODY$;

/* ---- Get Textbooks by Filter Function ---- */
CREATE OR REPLACE FUNCTION public.gettextbookbyfilter(
	var_modulecode character varying,
	var_name character varying,
	var_edition character varying,
	var_quality character varying,
	var_author character varying)
    RETURNS TABLE(modulecode character varying, id uuid, name character varying, edition character varying, quality character varying, author character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT m.modulecode, t.id, t.name, t.edition, t.quality, t.author
    FROM public.Textbook t
	INNER JOIN public.Module m  
	ON m.id = t.moduleid AND m.isdeleted = false
    WHERE t.name LIKE var_name AND t.edition LIKE var_edition AND t.quality LIKE var_quality AND t.author LIKE var_author AND m.ModuleCode LIKE var_modulecode AND t.IsDeleted = false;
END;
$BODY$;

/* ---- Get Tutors by Filter Function ---- */
CREATE OR REPLACE FUNCTION public.gettutorbyfilter(
	var_modulecode character varying,
	var_subject character varying,
	var_yearcompleted character varying,
	var_venue character varying,
	var_notesincluded character varying,
	var_terms character varying)
    RETURNS TABLE(modulecode character varying, id uuid, subject character varying, yearcompleted character varying, venue character varying, notesincluded boolean, terms character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT m.modulecode, t.id, t.subject, t.yearcompleted, t.venue, t.notesincluded, t.terms
    FROM public.Tutor t
	INNER JOIN public.Module m  
	ON m.id = t.moduleid AND m.isdeleted = false
    WHERE t.subject LIKE var_subject AND t.yearcompleted LIKE var_yearCompleted AND t.venue LIKE var_venue AND CAST(t.notesincluded AS character varying) LIKE var_notesIncluded AND t.terms LIKE var_terms AND m.ModuleCode LIKE var_modulecode AND t.IsDeleted = false;
END;
$BODY$;

/* ---- Get Accomodation by Filter Function ---- */
CREATE OR REPLACE FUNCTION public.getaccomodationbyfilter(
	var_accomodationcode character varying,
    var_institutionname character varying,
    var_location character varying,
    var_distancetocampus character varying)
    RETURNS TABLE(institution character varying, accomodationtypecode character varying, location character varying, distancetocampus character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT i.name, a.accomodationtypecode, a.location, a.distancetocampus
    FROM public.Accomodation a
	INNER JOIN public.Institution i  
	ON i.id = a.institutionid AND i.isdeleted = false
    WHERE i.name LIKE var_institutionname AND a.accomodationtypecode LIKE var_accomodationcode AND a.location LIKE var_location AND a.distancetocampus LIKE var_distancetocampus AND a.isdeleted = false;
END;
$BODY$;

/* ---- Get Notes by Filter Function ---- */
CREATE OR REPLACE FUNCTION public.getnotesbyfilter(
	var_modulecode character varying)
    RETURNS TABLE(modulecode character varying, id uuid) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT m.modulecode, n.id
    FROM public.Notes n
	INNER JOIN public.Module m  
	ON m.id = n.moduleid AND m.isdeleted = false
    WHERE m.ModuleCode LIKE var_modulecode AND n.isdeleted = false;
END;
$BODY$;

/* ---- Get Advertisements by Selling or Looking for Function ---- */

CREATE OR REPLACE FUNCTION public.getadvertisementbyposttype(
	var_isselling boolean)
    RETURNS TABLE(advertisementid uuid, userid uuid, isselling boolean, advertisementtype character varying, entityid uuid, price numeric, description character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
    ROWS 1000
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT u.id, u.userid, u.isselling, u.advertisementtype, u.entityid, u.price, u.description
    FROM public.Advertisement u
    WHERE var_isselling  = u.isselling AND isdeleted = false;
END;
$BODY$;



/* ---- Populating user table with default users. ---- */
SELECT public.registeruser('Peter65', '123Piet!@#', 'Peter', 'Schmeical', 'peter65.s@gmail.com');
SELECT public.registeruser('John12', 'D0main!', 'John', 'Smith', 'John@live.co.za');
SELECT public.registeruser('Blairzee', '!Blairzee', 'Blaire', 'Baldwin', 'Blaire24@gmail.com');

/* ---- Populating lookup tables with default values. ---- */

/* ---- ACCOMODATION TYPES ---- */
INSERT INTO public.AccomodationType(Code,Name,Description,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('COM', 'Commune', 'A group of people living together and sharing kitchen, bathrooms with their own seperate bedrooms.', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.AccomodationType(Code,Name,Description,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('APT', 'Appartement', 'A self-contained housing unit (a type of residential real estate) that occupies only part of a building, generally on a single storey.', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.AccomodationType(Code,Name,Description,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('HSE', 'House', 'A building for human habitation, especially one that consists of a ground floor and one or more upper storeys.', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.AccomodationType(Code,Name,Description,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('GDC', 'Garden Cottage', 'A small house in the garden of a generally larger house.', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
/* ---- ADVERTISEMENT TYPES ---- */
INSERT INTO public.AdvertisementType (Code,Name,Description,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('TXB','Textbook', 'A book used for the study of a subject. People use a textbook to learn facts and methods about a certain subject.', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.AdvertisementType (Code,Name,Description,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('NTS','Notes', 'Notes taken on class lectures about key points or discussions that may serve as study aids.', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.AdvertisementType (Code,Name,Description,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('TUT','Tutor', 'Tutors are responsible for helping students to understand different subjects. They assess, assist and encourage the students in the learning processes.', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.AdvertisementType (Code,Name,Description,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('ACD','Accomodation', 'Living quaters provided by privately for public use.', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
/* ---- INSTITUTIONS ---- */
INSERT INTO public.Institution(ID,Name,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('9d68ff9f-01a0-476e-ac3a-fc6463127ff4', 'University of Pretoria', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Institution(ID,Name,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('fb901315-d971-4347-880b-bc8c6292386f', 'University of Johannesburg', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
/* ---- FACULTIES ---- */
INSERT INTO public.Faculty(ID,InstitutionID,Name,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('ec7e55ab-da81-48b1-87df-51d75296297e', '9d68ff9f-01a0-476e-ac3a-fc6463127ff4', 'EMS', CURRENT_TIMESTAMP, false , CURRENT_TIMESTAMP);
INSERT INTO public.Faculty(ID,InstitutionID,Name,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('79c43f4d-7aff-49bc-bd7d-5b4c630ab7f5', '9d68ff9f-01a0-476e-ac3a-fc6463127ff4', 'ENG', CURRENT_TIMESTAMP, false , CURRENT_TIMESTAMP);
INSERT INTO public.Faculty(ID,InstitutionID,Name,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('6382b19c-dc86-43d1-8113-b0f765c91e6f', '9d68ff9f-01a0-476e-ac3a-fc6463127ff4', 'LAW', CURRENT_TIMESTAMP, false , CURRENT_TIMESTAMP);
INSERT INTO public.Faculty(ID,InstitutionID,Name,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('8acca7e9-fdba-4a0f-88f3-1a4cc0c0f32f', 'fb901315-d971-4347-880b-bc8c6292386f', 'EMS', CURRENT_TIMESTAMP, false , CURRENT_TIMESTAMP);
INSERT INTO public.Faculty(ID,InstitutionID,Name,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('060d4547-65c5-495e-a381-b42107fb632f', 'fb901315-d971-4347-880b-bc8c6292386f', 'ENG', CURRENT_TIMESTAMP, false , CURRENT_TIMESTAMP);
INSERT INTO public.Faculty(ID,InstitutionID,Name,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('65f21344-e49e-4f29-bccd-a7e39056d3f9', 'fb901315-d971-4347-880b-bc8c6292386f', 'LAW', CURRENT_TIMESTAMP, false , CURRENT_TIMESTAMP);
/* ---- MODULES ---- */
INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('2e901148-ae96-4158-a92a-3c6f371d1ea1', 'ec7e55ab-da81-48b1-87df-51d75296297e', 'Business Management Basics', 'OBS110', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('e47aa688-d18b-4c88-a93f-ecc5836a88f0', 'ec7e55ab-da81-48b1-87df-51d75296297e', 'Business Management Advanced', 'OBS120', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);

INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('433ce13a-22ce-4f53-8a75-c7b8e190f15f', '79c43f4d-7aff-49bc-bd7d-5b4c630ab7f5', 'Electrical Engineering Basics', 'ENG111', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('69ba5241-2059-40b0-b02a-7d983d01b6e5', '79c43f4d-7aff-49bc-bd7d-5b4c630ab7f5', 'Electrical Engineering Advanced', 'ENG122', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);

INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('6168c0d4-a541-450c-9de2-bea7e5be1b00', '6382b19c-dc86-43d1-8113-b0f765c91e6f', 'Family Law Basics', 'LLB120', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('edf58c02-1a51-4188-b21b-f05f82677da8', '6382b19c-dc86-43d1-8113-b0f765c91e6f', 'Family Law Advanced', 'LLB140', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);

INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('b83a1751-f6bc-466c-b20e-3d837cc22fda', '8acca7e9-fdba-4a0f-88f3-1a4cc0c0f32f', 'Economics Basics', 'EKN110', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('9b137496-d030-4e4d-b85b-2ea334e0179d', '8acca7e9-fdba-4a0f-88f3-1a4cc0c0f32f', 'Economics Advanced', 'EKN122', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);

INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('d53a2759-0df7-41a4-a8d1-dbbcca3f4f47', '060d4547-65c5-495e-a381-b42107fb632f', 'Chemical Engineering Basics', 'CHE156', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('7c0bc68a-b123-46ca-8d04-d91d7a1c0768', '060d4547-65c5-495e-a381-b42107fb632f', 'Chemical Engineering Advanced', 'CHE186', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);

INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('15f5d63c-01cf-480c-aadc-335672da87a2', '65f21344-e49e-4f29-bccd-a7e39056d3f9', 'Industrial Law Basics', 'ILB111', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Module(ID,FacultyID,Name,ModuleCode,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('888b571a-1819-48c8-a8f1-27686b55eb3b', '65f21344-e49e-4f29-bccd-a7e39056d3f9', 'Industrial Law Advanced', 'ILB122', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);

/* ---- TEXTBOOKS ---- */
SELECT public.addtextbook('2e901148-ae96-4158-a92a-3c6f371d1ea1', 'Business Strategy Principles', '1', 'Used', 'Franklin James');
SELECT public.addtextbook('2e901148-ae96-4158-a92a-3c6f371d1ea1', 'Business Strategy Principles', '1', 'New', 'Franklin James');
SELECT public.addtextbook('2e901148-ae96-4158-a92a-3c6f371d1ea1', 'Business Logistics Principles', '3', 'Used', 'Franklin James');
SELECT public.addtextbook('2e901148-ae96-4158-a92a-3c6f371d1ea1', 'Business Logistics Principles', '2', 'Used', 'Franklin James');

SELECT public.addtextbook('433ce13a-22ce-4f53-8a75-c7b8e190f15f', 'Engineer Structures Principles', '1', 'New', 'Thomas Edison');
SELECT public.addtextbook('433ce13a-22ce-4f53-8a75-c7b8e190f15f', 'Engineer Structures Advanced', '1', 'New', 'Thomas Edison');
SELECT public.addtextbook('433ce13a-22ce-4f53-8a75-c7b8e190f15f', 'Engineer Structures Principles', '1', 'New', 'Roberto Edgar L');
SELECT public.addtextbook('433ce13a-22ce-4f53-8a75-c7b8e190f15f', 'Business Structures Advanced', '1', 'New', 'Roberto Edgar L');


/* ---- TUTORS ---- */ 
SELECT public.addtutor('2e901148-ae96-4158-a92a-3c6f371d1ea1','Business Management','2018','Campus',false,'Per Lesson');
SELECT public.addtutor('2e901148-ae96-4158-a92a-3c6f371d1ea1','Business Management','2019','Both',true,'Per Lesson');
SELECT public.addtutor('2e901148-ae96-4158-a92a-3c6f371d1ea1','Business Logistics','2019','Both',true,'Minimum 5 Lessons');

SELECT public.addtutor('433ce13a-22ce-4f53-8a75-c7b8e190f15f','Engineering','2018','Campus',true,'Per Lesson');
SELECT public.addtutor('433ce13a-22ce-4f53-8a75-c7b8e190f15f','Engineering Structures','2018','At Home',false,'Minimum 10 Lessons');
SELECT public.addtutor('433ce13a-22ce-4f53-8a75-c7b8e190f15f','Engineering','2019','Campus',false,'Per Lesson');


/* ---- ACCOMODATION ---- */
SELECT public.addaccomodation('APT', '9d68ff9f-01a0-476e-ac3a-fc6463127ff4', 'Hatfield', '1.2Km');
SELECT public.addaccomodation('COM', '9d68ff9f-01a0-476e-ac3a-fc6463127ff4', 'Brooklyn', '2.8Km');
SELECT public.addaccomodation('HSE', '9d68ff9f-01a0-476e-ac3a-fc6463127ff4', 'Brooklyn', '4.8Km');
SELECT public.addaccomodation('GDC', '9d68ff9f-01a0-476e-ac3a-fc6463127ff4', 'Pretoria CBD', '8.5Km');

SELECT public.addaccomodation('APT', 'fb901315-d971-4347-880b-bc8c6292386f', 'Johannesburg CBD', '5.4Km');
SELECT public.addaccomodation('COM', 'fb901315-d971-4347-880b-bc8c6292386f', 'Main Campus', '0.5Km');
SELECT public.addaccomodation('HSE', 'fb901315-d971-4347-880b-bc8c6292386f', 'Johannesburg CBD', '8.9Km');
SELECT public.addaccomodation('GDC', 'fb901315-d971-4347-880b-bc8c6292386f', 'Auckland Park', '1.7Km');

/* ---- NOTES ---- */
SELECT public.addnotes('2e901148-ae96-4158-a92a-3c6f371d1ea1');
SELECT public.addnotes('e47aa688-d18b-4c88-a93f-ecc5836a88f0');
SELECT public.addnotes('e47aa688-d18b-4c88-a93f-ecc5836a88f0');
SELECT public.addnotes('433ce13a-22ce-4f53-8a75-c7b8e190f15f');
SELECT public.addnotes('433ce13a-22ce-4f53-8a75-c7b8e190f15f');
SELECT public.addnotes('433ce13a-22ce-4f53-8a75-c7b8e190f15f');
SELECT public.addnotes('7c0bc68a-b123-46ca-8d04-d91d7a1c0768');
SELECT public.addnotes('7c0bc68a-b123-46ca-8d04-d91d7a1c0768');
SELECT public.addnotes('9b137496-d030-4e4d-b85b-2ea334e0179d');

/* ---- FEATURES ---- */
INSERT INTO public.Feature (Code, Name, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('FBR','Fibre', 'The property is fibre ready.', CURRENT_TIMESTAMP,false,CURRENT_TIMESTAMP);
INSERT INTO public.Feature (Code, Name, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('PAR','Parking', 'The Property has parking.', CURRENT_TIMESTAMP,false,CURRENT_TIMESTAMP);
INSERT INTO public.Feature (Code, Name, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('PPE','Prepaid Electricity', 'The property works on perpaid electricity.', CURRENT_TIMESTAMP,false,CURRENT_TIMESTAMP);
/* ---- DEFAULT USER FOR ADVERTISEMENTS ---- */
INSERT INTO public.User(ID,Username,Password,Name,Surname,Email,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES ('56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7','Gerard','1234','Gerard','Botes','Gerard.Botes@gmail.com', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
/* ---- ADVERTISEMENTS ---- */
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('d17e784f-f5f7-4bc8-ad34-3170bc735fc7', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TXB', '07643974-4bad-45a2-9431-a10308c66c5d', '450','Default Textbook Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('1bd5e0d6-bc54-4806-afe2-8253ceb931d4', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TXB', '07643974-4bad-45a2-9431-a10308c66c5d', '600','Default Textbook Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('4eafce73-791d-46c4-9c24-9c99f9352459', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TXB', '07643974-4bad-45a2-9431-a10308c66c5d', '760','Default Textbook Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('0f3f0188-2130-4369-af37-fc50242a39db', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TXB', '07643974-4bad-45a2-9431-a10308c66c5d', '180','Default Textbook Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('8964f09f-27ca-4132-9a8a-25bdb9d00737', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TXB', '07643974-4bad-45a2-9431-a10308c66c5d', '900','Default Textbook Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);

INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('06abf31a-3165-48ad-87b3-75ff2a6c0225', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TUT', 'a019c7ad-9bc4-4eb0-ab08-40fecd36a1d5', '450','Default Tutoring Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('957f82e0-6b08-4632-bc12-300b5f817e6e', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TUT', 'a019c7ad-9bc4-4eb0-ab08-40fecd36a1d5', '600','Default Tutoring Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('b9367c75-83b8-4a87-acb6-04468e72b61d', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TUT', 'a019c7ad-9bc4-4eb0-ab08-40fecd36a1d5', '760','Default Tutoring Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('fdcef41c-740d-43c4-8535-876a18c6ed8d', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TUT', 'a019c7ad-9bc4-4eb0-ab08-40fecd36a1d5', '180','Default Tutoring Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('c42460df-7aa0-484e-902c-29a21f79527f', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'TUT', 'a019c7ad-9bc4-4eb0-ab08-40fecd36a1d5', '900','Default Tutoring Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);

INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('81dc2379-aeb9-4279-865b-bdb46edc5db5', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'ACD', 'bd263485-64bc-4589-bf83-73dc6d5b1338', '450','Default Accomodation Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('b1177d3e-43bd-4614-b512-2c6f3a2436a1', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'ACD', 'bd263485-64bc-4589-bf83-73dc6d5b1338', '600','Default Accomodation Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('53d9ab8c-d572-4315-b0e2-6ed1785d444e', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'ACD', 'bd263485-64bc-4589-bf83-73dc6d5b1338', '760','Default Accomodation Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('a9c2abd0-be84-49c7-99a0-063dcb85f7eb', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'ACD', 'bd263485-64bc-4589-bf83-73dc6d5b1338', '180','Default Accomodation Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('7b803d28-19fb-4d20-a8d9-9a1a9f2207ec', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'ACD', 'bd263485-64bc-4589-bf83-73dc6d5b1338', '900','Default Accomodation Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);

INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('76151522-5437-4fe7-86b9-3dfa11d43cb6', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'NTS', 'dce1c0bf-63ef-4d06-a9c4-7e4cce806823', '450','Default Notes Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('3c3741b9-f71a-410a-b170-23c07abeb327', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'NTS', 'dce1c0bf-63ef-4d06-a9c4-7e4cce806823', '600','Default Notes Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('9ed48cfb-7e49-4d6c-9e01-68ff5fed5d51', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'NTS', 'dce1c0bf-63ef-4d06-a9c4-7e4cce806823', '760','Default Notes Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('c2de2f67-ec44-4998-91ac-0a7f4f117350', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'NTS', 'dce1c0bf-63ef-4d06-a9c4-7e4cce806823', '180','Default Notes Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Advertisement (ID, UserID, IsSelling, AdvertisementType,EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('00dfc25a-cb4c-4be5-9bdc-347db41dd68e', '56c27ab0-eed7-4aa5-8b0a-e4082c83c3b7', true,'NTS', 'dce1c0bf-63ef-4d06-a9c4-7e4cce806823', '900','Default Notes Advertisement', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);





