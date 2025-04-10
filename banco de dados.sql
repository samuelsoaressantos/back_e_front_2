create database sabor_brasil;

use sabor_brasil;


CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `logo` text,
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `publicacao` (
  `id_publicacao` int NOT NULL AUTO_INCREMENT,
  `foto` text,
  `nome_pet` varchar(100) NOT NULL,
  `local` varchar(100) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `usuarioid` int NOT NULL,
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_publicacao`),
  KEY `publicacao_ibfk_1` (`usuarioid`),
  CONSTRAINT `publicacao_ibfk_1` FOREIGN KEY (`usuarioid`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `comentario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuarioid` int NOT NULL,
  `publicacaoid` int NOT NULL,
  `texto` text NOT NULL,
  `data_comentario` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `usuarioid` (`usuarioid`),
  KEY `publicacaoid` (`publicacaoid`),
  CONSTRAINT `comentario_ibfk_1` FOREIGN KEY (`usuarioid`) REFERENCES `usuario` (`id`),
  CONSTRAINT `comentario_ibfk_2` FOREIGN KEY (`publicacaoid`) REFERENCES `publicacao` (`id_publicacao`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `curtida` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuarioid` int NOT NULL,
  `publicacaoid` int NOT NULL,
  `tipo_interacao` enum('like','deslike','none') NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_publicacao_unique` (`usuarioid`,`publicacaoid`),
  KEY `usuarioid` (`usuarioid`),
  KEY `publicacaoid` (`publicacaoid`),
  CONSTRAINT `curtida_ibfk_1` FOREIGN KEY (`usuarioid`) REFERENCES `usuario` (`id`),
  CONSTRAINT `curtida_ibfk_2` FOREIGN KEY (`publicacaoid`) REFERENCES `publicacao` (`id_publicacao`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
