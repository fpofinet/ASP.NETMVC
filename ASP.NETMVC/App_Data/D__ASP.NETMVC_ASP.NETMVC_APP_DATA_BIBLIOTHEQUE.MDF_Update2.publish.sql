/*
Script de déploiement pour D:\ASP.NETMVC\ASP.NETMVC\APP_DATA\BIBLIOTHEQUE.MDF

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "D:\ASP.NETMVC\ASP.NETMVC\APP_DATA\BIBLIOTHEQUE.MDF"
:setvar DefaultFilePrefix "D_\ASP.NETMVC\ASP.NETMVC\APP_DATA\BIBLIOTHEQUE.MDF_"
:setvar DefaultDataPath "C:\Users\fika\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\fika\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Création de Utilisateur [connexion_biblio]...';


GO
CREATE USER [connexion_biblio] FOR LOGIN [connexion_biblio];


GO
PRINT N'Création de Appartenance au rôle <Sans nom>...';


GO
EXECUTE sp_addrolemember @rolename = N'db_accessadmin', @membername = N'connexion_biblio';


GO
PRINT N'Création de Appartenance au rôle <Sans nom>...';


GO
EXECUTE sp_addrolemember @rolename = N'db_datareader', @membername = N'connexion_biblio';


GO
PRINT N'Création de Appartenance au rôle <Sans nom>...';


GO
EXECUTE sp_addrolemember @rolename = N'db_datawriter', @membername = N'connexion_biblio';


GO
PRINT N'Création de Table [dbo].[AUTEURS]...';


GO
CREATE TABLE [dbo].[AUTEURS] (
    [ID_AUTEUR]  INT            IDENTITY (1, 1) NOT NULL,
    [NOM_AUTEUR] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_AUTEURS] PRIMARY KEY CLUSTERED ([ID_AUTEUR] ASC)
);


GO
PRINT N'Création de Table [dbo].[COURANTS]...';


GO
CREATE TABLE [dbo].[COURANTS] (
    [ID_COURANT]      INT            IDENTITY (1, 1) NOT NULL,
    [ID_GENRE]        INT            NULL,
    [LIBELLE_COURANT] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_COURANTS] PRIMARY KEY CLUSTERED ([ID_COURANT] ASC)
);


GO
PRINT N'Création de Table [dbo].[GENRES]...';


GO
CREATE TABLE [dbo].[GENRES] (
    [ID_GENRE]      INT            IDENTITY (1, 1) NOT NULL,
    [LIBELLE_GENRE] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_GENRES] PRIMARY KEY CLUSTERED ([ID_GENRE] ASC)
);


GO
PRINT N'Création de Table [dbo].[LIVRES]...';


GO
CREATE TABLE [dbo].[LIVRES] (
    [ID_LIVRE]      INT            IDENTITY (1, 1) NOT NULL,
    [ISBN]          NUMERIC (18)   NULL,
    [TITRE]         NVARCHAR (MAX) NULL,
    [EDITEUR]       NVARCHAR (MAX) NULL,
    [ANNEE_EDITION] DATE           NULL,
    [ID_AUTEUR]     INT            NULL,
    [ID_GENRE]      INT            NULL,
    [LIVRE]         NVARCHAR (MAX) NULL,
    [URL_LIVRE]     NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_LIVRES] PRIMARY KEY CLUSTERED ([ID_LIVRE] ASC)
);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_COURANTS_GENRES]...';


GO
ALTER TABLE [dbo].[COURANTS] WITH NOCHECK
    ADD CONSTRAINT [FK_COURANTS_GENRES] FOREIGN KEY ([ID_GENRE]) REFERENCES [dbo].[GENRES] ([ID_GENRE]) ON UPDATE CASCADE;


GO
PRINT N'Création de Clé étrangère [dbo].[FK_LIVRES_AUTEURS]...'; 


GO
ALTER TABLE [dbo].[LIVRES] WITH NOCHECK
    ADD CONSTRAINT [FK_LIVRES_AUTEURS] FOREIGN KEY ([ID_AUTEUR]) REFERENCES [dbo].[AUTEURS] ([ID_AUTEUR]) ON UPDATE CASCADE;
        

GO
PRINT N'Création de Clé étrangère [dbo].[FK_LIVRES_GENRES]...';


GO
ALTER TABLE [dbo].[LIVRES] WITH NOCHECK
    ADD CONSTRAINT [FK_LIVRES_GENRES] FOREIGN KEY ([ID_GENRE]) REFERENCES [dbo].[GENRES] ([ID_GENRE]) ON UPDATE CASCADE;


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[COURANTS] WITH CHECK CHECK CONSTRAINT [FK_COURANTS_GENRES];

ALTER TABLE [dbo].[LIVRES] WITH CHECK CHECK CONSTRAINT [FK_LIVRES_AUTEURS];

ALTER TABLE [dbo].[LIVRES] WITH CHECK CHECK CONSTRAINT [FK_LIVRES_GENRES];


GO
PRINT N'Mise à jour terminée.';


GO
