-- Create the database
CREATE DATABASE JamesDB;

-- Use the created database
USE JamesDB;
-- Table to store Subscription information
CREATE TABLE Subscription (
   SId INT IDENTITY(1,1) PRIMARY KEY,
    Stype NVARCHAR(50) NOT NULL,
    Price int null,
);

-- Table to store user information
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash CHAR(64) NOT NULL, -- assuming SHA-256 hash
    Email NVARCHAR(100) NOT NULL UNIQUE,
    UserRole NVARCHAR(20) CHECK (UserRole IN ('General', 'Registered', 'Admin')) DEFAULT 'General',
    SubscriptionID int default 1,
    ProfileDescription NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE() ,
	Foreign key (SubscriptionID) ReFERENCES Subscription(SId)
);

-- Table to store recipes
CREATE TABLE Recipes (
    RecipeID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    Title NVARCHAR(100) NOT NULL,
    Ingredients NVARCHAR(MAX) NOT NULL,
    CookingProcedure NVARCHAR(MAX) NOT NULL,
	RecipeImage NVARCHAR(MAX) NULL,
    IsFree BIT DEFAULT 1, -- 1 for TRUE, 0 for FALSE
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Table to store tips
CREATE TABLE Tips (
    TipID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    Title NVARCHAR(100) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    IsFree BIT DEFAULT 1, -- 1 for TRUE, 0 for FALSE
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
        
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Table to store contests
CREATE TABLE Contests (
    ContestID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
        
);

-- Table to store posts related to contests
CREATE TABLE ContestPosts (
    PostID INT IDENTITY(1,1) PRIMARY KEY,
    ContestID INT,
    UserID INT,
    Title NVARCHAR(100),
    Content NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ContestID) REFERENCES Contests(ContestID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Table to store feedback on recipes
CREATE TABLE Feedback (
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    RecipeID INT,
    UserID INT,
    FeedbackText NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (RecipeID) REFERENCES Recipes(RecipeID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Table to store announcements
CREATE TABLE Announcements (
    AnnouncementID INT IDENTITY(1,1) PRIMARY KEY,
	ContestID INT,
	UserID INT,--Winner
 
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Table to store FAQs
CREATE TABLE FAQs (
    FAQID INT IDENTITY(1,1) PRIMARY KEY,
    Question NVARCHAR(MAX) NOT NULL,
    Answer NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Table to store user payments
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(20) CHECK (PaymentMethod IN ('Credit Card', 'Bank Transfer')),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);