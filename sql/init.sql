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
    CONSTRAINT adertisementuserfkey FOREIGN KEY (UserID)
        REFERENCES public.User (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    AdvertisementType Varchar(3) NOT NULL,
    EntityID uuid NOT NULL,
    Price Decimal NOT NULL,
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

CREATE OR REPLACE FUNCTION public.getuser(
	var_userid uuid)
    RETURNS TABLE(userid uuid, username character varying, name character varying, surname character varying, email character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
    ROWS 1000
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT u.id, u.username, u.name, u.surname, u.email
    FROM public.User u
    WHERE var_userid = u.id;
END;
$BODY$;

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
				ELSE
    				UPDATE public.User
   				 	SET username = var_username, password = var_password, name = var_name, surname = var_surname, email = var_email, modifieddatetime = CURRENT_TIMESTAMP 
    				WHERE var_userid = id;
    				res_updated := true;
					res_error := 'User Successfully Updated';
				END IF;
		END IF;
END;
$BODY$;

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

CREATE OR REPLACE FUNCTION public.loginuser(
	var_username varchar(50),
	var_password varchar(50)
)
    RETURNS TABLE(userid uuid, username character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
    ROWS 1000
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT u.id, u.username
    FROM public.User u
    WHERE var_username = u.username AND var_password = u.password;
END;
$BODY$;

<<<<<<< HEAD
/* ---- Populating user table with default users. ----  */
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
VALUES (uuid_generate_v4(), 'University of Pretoria', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
INSERT INTO public.Institution(ID,Name,CreatedDateTime,IsDeleted,ModifiedDateTime)
VALUES (uuid_generate_v4(), 'University of Johannesburg', CURRENT_TIMESTAMP, false, CURRENT_TIMESTAMP);
/* ---- FEATURES ---- */
INSERT INTO public.Feature (Code, Name, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('FBR','Fibre', 'The property is fibre ready.', CURRENT_TIMESTAMP,false,CURRENT_TIMESTAMP);
INSERT INTO public.Feature (Code, Name, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('PAR','Parking', 'The Property has parking.', CURRENT_TIMESTAMP,false,CURRENT_TIMESTAMP);
INSERT INTO public.Feature (Code, Name, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
VALUES ('PPE','Prepaid Electricity', 'The property works on perpaid electricity.', CURRENT_TIMESTAMP,false,CURRENT_TIMESTAMP);
=======
CREATE OR REPLACE FUNCTION public.addadvertisement(
	var_userid character varying,
	var_advertisementtype character varying,
	var_entityid character varying,
	var_price character varying,
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
	INSERT INTO public.Advertisement(ID, UserID, AdvertisementType, EntityID, Price, Description, CreatedDateTime, IsDeleted, ModifiedDateTime)
    VALUES (id, var_userid, var_advertisementtype, var_entityid, var_price, var_description, CURRENT_TIMESTAMP , 'false', CURRENT_TIMESTAMP);
    res_advertisementposted := true;
    ret_id := id;
	ret_error := 'Advert Successfully Created!';
END;
$BODY$;

CREATE OR REPLACE FUNCTION public.getadvertisement(
	var_advertisementid uuid)
    RETURNS TABLE(advertisementid uuid, userid uuid, advertisementtype character varying, entityid uuid, price character varying, description character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
    ROWS 1000
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT u.id, u.userid, u.advertisementtype, u.entityid, u.price, u.description
    FROM public.Advertisement u
    WHERE var_advertisementid = u.id;
END;
$BODY$;


CREATE OR REPLACE FUNCTION public.updateadvertisement(
	var_advertisementid uuid,
	var_userid uuid,
	var_advertisementtype character varying,
	var_entityid uuid,
	var_price character varying,
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
    UPDATE public.Advertisement
   	SET advertisementid = var_advertisementid, advertisementtype = var_advertisementtype, entityid = var_entityid, price = var_price, description = var_description, modifieddatetime = CURRENT_TIMESTAMP 
    WHERE var_advertisementid = id;
    res_updated := true;
	res_error := 'Advert Successfully Updated';
END;
$BODY$;

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
>>>>>>> dab3e52c6f99166db7d439c6c455d2186e357015
