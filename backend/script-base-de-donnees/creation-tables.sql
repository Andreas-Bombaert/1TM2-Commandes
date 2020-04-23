CREATE TABLE tbVilles (
    vilId CHAR(4) NOT NULL,
    vilNom VARCHAR(20) NOT NULL,
    CONSTRAINT pk__Villes PRIMARY KEY (vilId)
);


CREATE TABLE tbBrasseurs(
    brasseurId CHAR(3) NOT NULL,
    brasseurNom VARCHAR(20) NOT NULL,
    vilId CHAR(4) NOT NULL,
    CONSTRAINT pk__Brasseurs PRIMARY KEY (brasseurId),
    CONSTRAINT fk__Brasseurs FOREIGN KEY (vilId) REFERENCES tbVilles (vilId)
    on update CASCADE
    on delete restrict
);

CREATE TABLE tbBieres(
    biereId CHAR(4) NOT NULL,
    biereNom VARCHAR(30) NOT NULL,
    biereCouleur VARCHAR(15) NOT NULL, 
    biereAlcool DECIMAL NULL,
    biereVolume NUMERIC NOT NULL, 
    bierePrix DECIMAL NOT NULL,
    brasseurId char(3) NOT NULL,
    CONSTRAINT pk_tbBieres PRIMARY KEY (biereId),
    CONSTRAINT fk_tbBieres FOREIGN KEY ( brasseurId ) REFERENCES tbBrasseurs ( brasseurId )
    on update cascade
    on delete restrict
);
  
CREATE TABLE tbClients(
    clientId char(4) NOT NULL,
    clientNom VARCHAR(20) NOT NULL,
    clientPrenom VARCHAR(20) NOT NULL,
    clientAdresse VARCHAR(50) NOT NULL,
    clientMail VARCHAR(50) NOT NULL,
    CONSTRAINT pk__Clients PRIMARY KEY (clientId)
);

CREATE TABLE tbHistoriques (
    commId char(5) NOT NULL,
    clientId char(4) NOT NULL,
    prixTot decimal(6,2) NOT NULL,
    quantTot INTEGER NOT NULL,
    "date" "datetime" NOT NULL DEFAULT getDate(),
    CONSTRAINT pk__tbHistoriques PRIMARY KEY (commId)
    CONSTRAINT fk__tbHistoriques PRIMARY KEY (clientId) REFERENCES tbClients (clientId)
    on update CASCADE
    on delete restrict
);

CREATE TABLE tbVentes (
    commId char(5) NOT NULL,
    ligneNo INTEGER NOT NULL,
    biereId char(4) NOT NULL,
    prodQuant INTEGER NOT NULL,
    CONSTRAINT fk__tbVentes__tbHistoriques FOREIGN KEY (commId) REFERENCES tbHistoriques (commId)
    on update CASCADE
    on delete restrict,
    CONSTRAINT fk__tbVentes__tbBieres FOREIGN KEY (biereId) REFERENCES tbBieres (biereId)
    on update CASCADE
    on delete restrict
);