CREATE TABLE public.Image (
    ID uuid PRIMARY KEY,
    PathString Varchar(255),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.AdvertisementImage (
    AdvertisingID uuid,
    ImageID uuid,
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp,
    PRIMARY KEY(AdvertisingID, ImageID)
);
CREATE TABLE public.User (
    ID uuid PRIMARY KEY,
    Username Varchar(50),
    Password Varchar(50),
    Name Varchar(30),
    Surname Varchar(30),
    Email Varchar(50),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Rating (
    ID uuid PRIMARY KEY,
    AdvertisementID uuid,
    BuyerID uuid,
    SellerID uuid,
    BuyerRating int,
    SellerRating int,
    BuyerComments Varchar(255),
    SellerComments Varchar(255),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.AdvertisementType (
    Code Varchar(3),
    Name Varchar(3),
    Description Varchar(255),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Notes (
    ModuleCode Varchar(50),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Textbook (
    ID uuid PRIMARY KEY,
    CONSTRAINT textbookmodulefkey FOREIGN KEY (ID)
        REFERENCES Module (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    Name Varchar(255),
    Edition Varchar(30),
    Quality Varchar(255),
    Author Varchar(255),
    CreatedDateTime timestamp,
    IsDeleted Boolean,
    ModifiedDateTime timestamp
);
CREATE TABLE public.Institution (
    ID uuid PRIMARY KEY,
    Name Varchar(50),
    CreatedDateTime timestamp,
    IsDeleted Boolean,
    ModifiedDateTime timestamp
);
CREATE TABLE public.Faculty (
    ID uuid PRIMARY KEY,
    CONSTRAINT facultyinstitutionfkey FOREIGN KEY (ID)
        REFERENCES Institution (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    Name Varchar(50),
    CreatedDateTime timestamp,
    IsDeleted Boolean,
    ModifiedDateTime timestamp
);
CREATE TABLE public.Module (
    ID uuid PRIMARY KEY,
    CONSTRAINT modulefacultyfkey FOREIGN KEY (ID)
        REFERENCES Faculty (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    Name Varchar(50),
    ModuleCode Varchar(50),
    CreatedDateTime timestamp,
    IsDeleted Boolean,
    ModifiedDateTime timestamp
);
CREATE TABLE public.Tutor (
    ID uuid PRIMARY KEY,
    Subject Varchar(50),
    YearCompleted Varchar(4),
    ModuleCode Varchar(50),
    Venue Varchar(100),
    NotesIncluded Boolean,
    Terms Varchar(20),
    CreatedDateTime timestamp,
    IsDeleted Boolean,
    ModifiedDateTime timestamp
);
CREATE TABLE public.Advertisement (
    ID uuid PRIMARY KEY,
    CONSTRAINT adertisementuserfkey FOREIGN KEY (ID)
        REFERENCES User (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    AdvertisementType Varchar(3),
    EntityID uuid,
    Price Decimal,
    Description Varchar(255),
    CreatedDateTime timestamp,
    IsDeleted Boolean,
    ModifiedDateTime timestamp
);
CREATE TABLE public.AccomodationType (
    Code varchar(3) PRIMARY KEY,
    Description Varchar(255),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Accomodation (
    ID uuid PRIMARY KEY,
    CONSTRAINT accomodationaccomodationtypefkey FOREIGN KEY (ID)
        REFERENCES AccomodationType (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,

    CONSTRAINT accomodationinstitutionfkey FOREIGN KEY (ID)
        REFERENCES Institution (ID) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    Location Varchar(255),
    DistanceToCampus Varchar(20),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Feature (
    ID uuid PRIMARY KEY,
    Name Varchar(100),
    Description Varchar(255),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.AccomodationFeature (
    AccomodationID uuid,
    FeatureID uuid,
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp,
    PRIMARY KEY(AccomodationID, FeatureID)
);
CREATE TABLE public.EntityCode (
    Code Varchar(3) PRIMARY KEY,
    Name Varchar(25),
    Description Varchar(255),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.EventCode (
    Code Varchar(3) PRIMARY KEY,
    Name Varchar(25),
    Description Varchar(255),
    CreatedDateTime timestamp,
    IsDeleted Boolean DEFAULT(0),
    ModifiedDateTime timestamp
);
CREATE TABLE public.Event (
    ID uuid PRIMARY KEY,
    EventCode Varchar(3),
    EntityCode Varchar(3),
    EntityID uuid,
    CreatedDateTime timestamp,
    IsDeleted Boolean,
    ModifiedDateTime timestamp
);