USE [master]
GO
/****** Object:  Database [cihancelenBlog]    Script Date: 10.07.2018 23:22:58 ******/
CREATE DATABASE [cihancelenBlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cihancelenBlog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\cihancelenBlog.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'cihancelenBlog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\cihancelenBlog_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [cihancelenBlog] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cihancelenBlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [cihancelenBlog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cihancelenBlog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cihancelenBlog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cihancelenBlog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cihancelenBlog] SET ARITHABORT OFF 
GO
ALTER DATABASE [cihancelenBlog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cihancelenBlog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cihancelenBlog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cihancelenBlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cihancelenBlog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cihancelenBlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cihancelenBlog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cihancelenBlog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cihancelenBlog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cihancelenBlog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cihancelenBlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cihancelenBlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cihancelenBlog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [cihancelenBlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [cihancelenBlog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cihancelenBlog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [cihancelenBlog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [cihancelenBlog] SET RECOVERY FULL 
GO
ALTER DATABASE [cihancelenBlog] SET  MULTI_USER 
GO
ALTER DATABASE [cihancelenBlog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [cihancelenBlog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [cihancelenBlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [cihancelenBlog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [cihancelenBlog] SET DELAYED_DURABILITY = DISABLED 
GO
USE [cihancelenBlog]
GO
/****** Object:  Table [dbo].[tblEtiket]    Script Date: 10.07.2018 23:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEtiket](
	[EtiketId] [int] IDENTITY(1,1) NOT NULL,
	[Etiket] [varchar](100) NULL,
 CONSTRAINT [PK_tblEtiket] PRIMARY KEY CLUSTERED 
(
	[EtiketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblKategoriler]    Script Date: 10.07.2018 23:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKategoriler](
	[KategoriId] [int] IDENTITY(1,1) NOT NULL,
	[Kategori] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblKategoriler] PRIMARY KEY CLUSTERED 
(
	[KategoriId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLike]    Script Date: 10.07.2018 23:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLike](
	[LikeId] [int] IDENTITY(1,1) NOT NULL,
	[LikeDurum] [int] NOT NULL,
	[YazarId] [int] NULL,
	[PostId] [int] NULL,
 CONSTRAINT [PK_tblLike] PRIMARY KEY CLUSTERED 
(
	[LikeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPostEtiket]    Script Date: 10.07.2018 23:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPostEtiket](
	[PostId] [int] NOT NULL,
	[EtiketId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPosts]    Script Date: 10.07.2018 23:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPosts](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[Baslik] [nvarchar](300) NULL,
	[Aciklama] [nvarchar](500) NULL,
	[Icerik] [nvarchar](max) NULL,
	[Views] [int] NOT NULL CONSTRAINT [DF_tblPosts_Views]  DEFAULT ((0)),
	[EklenmeTarihi] [datetime] NULL CONSTRAINT [DF_tblPosts_EklenmeTarihi]  DEFAULT (getdate()),
	[YazarId] [int] NULL,
	[KategoriId] [int] NULL,
	[PostResimUrl] [nvarchar](500) NULL,
 CONSTRAINT [PK_tblPosts] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRutbe]    Script Date: 10.07.2018 23:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRutbe](
	[RutbeId] [int] IDENTITY(1,1) NOT NULL,
	[Rutbe] [nvarchar](50) NULL,
	[RutbeResim] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblRutbe] PRIMARY KEY CLUSTERED 
(
	[RutbeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblYazarlar]    Script Date: 10.07.2018 23:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblYazarlar](
	[YazarId] [int] IDENTITY(1,1) NOT NULL,
	[Ad] [nvarchar](100) NULL,
	[Soyad] [nvarchar](100) NULL,
	[DogumTarihi] [date] NOT NULL,
	[KullaniciAdi] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
	[Parola] [nvarchar](50) NULL,
	[Cinsiyet] [nchar](10) NULL,
	[RutbeId] [int] NULL,
	[KayitTarihi] [datetime] NULL CONSTRAINT [DF_tblYazarlar_KayitTarihi]  DEFAULT (getdate()),
	[AvatarResim] [nvarchar](max) NULL,
	[YazarOnay] [bit] NULL CONSTRAINT [DF_tblYazarlar_YazarOnay]  DEFAULT ((0)),
	[AktivasyonKodu] [nvarchar](200) NULL,
 CONSTRAINT [PK_tblYazarlar] PRIMARY KEY CLUSTERED 
(
	[YazarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblYorumlar]    Script Date: 10.07.2018 23:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblYorumlar](
	[YorumId] [int] IDENTITY(1,1) NOT NULL,
	[Yorum] [nvarchar](500) NULL,
	[YorumETarihi] [datetime] NULL CONSTRAINT [DF_tblYorumlar_YorumETarihi]  DEFAULT (getdate()),
	[PostId] [int] NULL,
	[YazarId] [int] NULL,
 CONSTRAINT [PK_tblYorumlar] PRIMARY KEY CLUSTERED 
(
	[YorumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblEtiket] ON 

INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (1, N'#Haber')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (2, N'#ucak')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (3, N'#araba')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (4, N'#fashion')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (13, N'#vscode')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (14, N'#visualstudio')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (18, N'#pandas')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (19, N'#python')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (20, N'#flask')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (21, N'#aykutkocaman')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (22, N'#fenerbahce')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (23, N'#istifa')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (26, N'#typescript')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (27, N'#angular')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (28, N'#can')
INSERT [dbo].[tblEtiket] ([EtiketId], [Etiket]) VALUES (29, N'#health')
SET IDENTITY_INSERT [dbo].[tblEtiket] OFF
SET IDENTITY_INSERT [dbo].[tblKategoriler] ON 

INSERT [dbo].[tblKategoriler] ([KategoriId], [Kategori]) VALUES (1, N'Sanat')
INSERT [dbo].[tblKategoriler] ([KategoriId], [Kategori]) VALUES (2, N'Futbol')
INSERT [dbo].[tblKategoriler] ([KategoriId], [Kategori]) VALUES (3, N'Spor')
INSERT [dbo].[tblKategoriler] ([KategoriId], [Kategori]) VALUES (4, N'Teknoloji')
INSERT [dbo].[tblKategoriler] ([KategoriId], [Kategori]) VALUES (5, N'Web')
SET IDENTITY_INSERT [dbo].[tblKategoriler] OFF
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (1, 1)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (1, 2)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (2, 2)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (2, 3)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (12, 13)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (12, 14)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (16, 19)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (16, 20)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (15, 18)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (19, 26)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (19, 27)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (20, 28)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (20, 29)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (17, 21)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (17, 22)
INSERT [dbo].[tblPostEtiket] ([PostId], [EtiketId]) VALUES (17, 23)
SET IDENTITY_INSERT [dbo].[tblPosts] ON 

INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (1, N'Bu ilk post başlığı', NULL, N'Bu icerik ilk postun içeriğidir. Çünkü bu ilk postumuz.', 2, CAST(N'2018-05-03 20:48:51.530' AS DateTime), 1, 1, N'/Uploads/PostImages/ring.jpg')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (2, N'Mvc ile web yazılımı nasıl geliştirilir.', NULL, N'Mvc ile yazılım geliştirmek istiyorsanız 0 dan başlamanızı öneririm. İyi bir temel yaptıktan sonra gerisi çorap söküğü gibi geliyor açıkçası...', 4, CAST(N'2018-05-03 20:56:06.967' AS DateTime), 1, 2, N'/Uploads/PostImages/Content-Security-Policy-CSP-for-ASP.NET-MVC.png')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (3, N'ASP.NET hala kulllanılıyormu?', NULL, N'ASP.NET hala kullanılan bir teknoloji fakat çokta revaşta değil.', 20, CAST(N'2018-05-03 20:57:07.440' AS DateTime), 2, 1, N'/Uploads/PostImages/ring.jpg')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (4, N'AngularJS ile nasıl sepet yapılır', NULL, N'Bu konuya daha sonra değinmek istiyordum fakat mesajlardan dolayı çekmenin oldukça doğru bir karar olduğunu düşündüm.', 26, CAST(N'2018-05-03 20:58:19.880' AS DateTime), 1, 3, N'/Uploads/PostImages/Angular2.png')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (5, N'Bu admin controllerda yazdığım ilk post başlığı', N'Buda açıklaması', N'Ee tabi buda&nbsp;<strong>İ&ccedil;eriği<br />
nasıl ama<em>&nbsp;sss</em></strong>', 1, CAST(N'2018-05-18 00:00:00.000' AS DateTime), 5, 1, N'/Uploads/PostImages/technology.jpg')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (6, N'ReactJS ile post islemleri', N'REACTJS', N'<p>ReactJS yi umarım duymuşsunuzdur. &Ccedil;&uuml;nk&uuml; bu k&uuml;t&uuml;phane m&uuml;kemmel &ouml;tesi yazılımıs asla ve asla &uuml;cretli olmayan&nbsp;<strong>free software&nbsp;</strong>bir framework(k&uuml;t&uuml;phanedir).</p>
', 26, CAST(N'2018-05-19 22:59:52.023' AS DateTime), 1, 5, N'/Uploads/PostImages/react.png')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (12, N'Visual Studio Code nasıl kurulur?', N'VSCODE', N'Merhabalar ben Cihan<br />
Bug&uuml;n sizlere vs code nasıl kurulur onu anlatacağım.<br />
&Ouml;ncelikle sitesinden indiriyoruz.<br />
Daha sonra setup calistiriyoruz ve kurulum tamamlanmıstır.', 11, CAST(N'2018-05-20 19:04:07.123' AS DateTime), 1, 1, N'/Uploads/PostImages/ring.jpg')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (15, N'Pandalar nasıl yaşar?', N'Pandalar', N'Pandalar<strong>&nbsp;bambu&nbsp;</strong>yiyerek hayatlarını s&uuml;rd&uuml;r&uuml;rler.', 5, CAST(N'2018-05-21 00:23:08.787' AS DateTime), 2, 1, N'/Uploads/PostImages/5f1c44a6-72f5-4acf-9bd3-d476563934e0.jpeg')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (16, N'Python nasıl bir dildir?', N'Python ile yapabileceklerinizin sınırının olmadığını biliyor muydunuz?', N'Evet arkadaşlar bug&uuml;n sizlere python hakkında birka&ccedil; bilgi paylaşacağım.<br />
Python o kadar g&uuml;zel bir nimet ki &ouml;ğrendikten sonra diğer dilleri hi&ccedil;e sayabileceğiniz bir dildir.<br />
<strong>OOP&nbsp;</strong>dillerden en basit yazımı olan ve &ccedil;ok g&uuml;&ccedil;l&uuml; bir programlama dilidir.<br />
Web i&ccedil;in Flask idealdir.', 35, CAST(N'2018-05-21 00:34:23.897' AS DateTime), 1, 5, N'/Uploads/PostImages/7a5a71cc-b008-4642-952a-ed81b2a6643a.png')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (17, N'Fenerbahçe', N'Aziz Yıldırım', N'<strong>Aykut Kocaman</strong> istifa verdi.', 21, CAST(N'2018-05-21 01:59:57.967' AS DateTime), 1, 3, N'/Uploads/PostImages/b676917a-dd1a-48ce-b092-0ff6a32aa6a2.png')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (19, N'Typescript nedir', N'Typescript', N'<blockquote>
<p>Son zamanlarda&nbsp;<strong>AngularJS 2.0</strong>&rsquo;ın TypeScript ile olan birlikte &ccedil;alışması haberlerine&nbsp;istinaden bug&uuml;nk&uuml; makaleyi yazmaya&nbsp;karar verdim. TypeScript dosyaları .ts uzantılıdır. Bunu halen TrabzonSpor olarak d&uuml;ş&uuml;nen arkadaşlar olunca makalenin başlığı da şekillenmiş oldu:) Şimdi gelin isterseniz &nbsp;Microsoft tarafından geliştirilen&nbsp;son&nbsp;stable s&uuml;r&uuml;m&uuml;n&uuml;n (1.4) 16 Ocak 2015&rsquo;de &ccedil;ıkarılan bu javascript framework&rsquo;&uuml;n&uuml; hep beraber inceleyelim.<br />
<strong>BORA KAŞMER</strong></p>
</blockquote>

<p>&nbsp;</p>
', 2, CAST(N'2018-05-28 05:51:44.877' AS DateTime), 1, 5, N'/Uploads/PostImages/b866c268-43bc-42de-9b77-4654860f6139.png')
INSERT [dbo].[tblPosts] ([PostId], [Baslik], [Aciklama], [Icerik], [Views], [EklenmeTarihi], [YazarId], [KategoriId], [PostResimUrl]) VALUES (20, N'Can baya kıllı', N'Kıllı jojuk', N'can <strong>Can </strong>can<br />
bu arada k&uuml;&ccedil;&uuml;kken y&uuml;zmeye gitmisti', 4, CAST(N'2018-06-07 22:49:29.383' AS DateTime), 16, 3, N'/Uploads/PostImages/b899b8d9-c79c-4eb1-a999-9d971dad2a11.jpg')
SET IDENTITY_INSERT [dbo].[tblPosts] OFF
SET IDENTITY_INSERT [dbo].[tblRutbe] ON 

INSERT [dbo].[tblRutbe] ([RutbeId], [Rutbe], [RutbeResim]) VALUES (1, N'admin', NULL)
INSERT [dbo].[tblRutbe] ([RutbeId], [Rutbe], [RutbeResim]) VALUES (3, N'yazar', NULL)
INSERT [dbo].[tblRutbe] ([RutbeId], [Rutbe], [RutbeResim]) VALUES (4, N'üye', NULL)
SET IDENTITY_INSERT [dbo].[tblRutbe] OFF
SET IDENTITY_INSERT [dbo].[tblYazarlar] ON 

INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (1, N'Cihan', N'Çelen', CAST(N'2001-05-14' AS Date), N'pearlq', N'cihan.celen37@hotmail.com', N'827CCB0EEA8A706C4C34A16891F84E7B', N'erkek     ', 3, CAST(N'2018-05-07 16:07:51.083' AS DateTime), N'/Uploads/images/f572fecc-3d5c-49d4-84e5-d9d8e7efeae9.jpg', 1, N'')
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (2, N'Adem Samet', N'Eşsiz', CAST(N'2001-06-07' AS Date), N'blo4dyface', N'essizsamet@gmail.com', N'827CCB0EEA8A706C4C34A16891F84E7B', N'erkek     ', 3, CAST(N'2018-05-10 16:07:51.083' AS DateTime), N'/Uploads/images/c7f80d0a-de01-4d35-8e0c-67f4618f5a86.jpg', 1, NULL)
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (5, N'Can', N'Bağcı', CAST(N'2000-06-10' AS Date), N'canomi', N'canbagci@gmail.com', N'827CCB0EEA8A706C4C34A16891F84E7B', N'erkek     ', 1, CAST(N'2018-05-19 16:07:51.083' AS DateTime), N'/Uploads/images/4adafbfb-bb66-47d3-9bdf-0536c89f6501.jpg', 0, NULL)
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (6, N'Sakin', N'Elçiçek', CAST(N'1981-04-20' AS Date), N'muamma', N'sakin27@gmail.com', N'12345', N'erkek     ', 1, CAST(N'2018-05-19 16:12:28.130' AS DateTime), N'/Uploads/images/default.png', 0, NULL)
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (7, N'İlayda', N'Demirtaş', CAST(N'2001-04-10' AS Date), N'ilaydos', N'ilayda@gmail.com', N'827CCB0EEA8A706C4C34A16891F84E7B', N'kadın     ', 1, CAST(N'2018-05-19 16:18:21.677' AS DateTime), N'/Uploads/images/default.png', 0, NULL)
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (9, N'Sema', N'Yıldız', CAST(N'2001-11-02' AS Date), N'semaa', N'semaa@gmail.com', N'202CB962AC59075B964B07152D234B70', N'kadın     ', 4, CAST(N'2018-05-19 16:37:23.453' AS DateTime), N'/Uploads/images/default.png', 0, NULL)
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (10, N'Yusuf', N'İlme', CAST(N'1979-08-04' AS Date), N'ilmeyusuf', N'ilmeyusuf@ilme.net', N'827CCB0EEA8A706C4C34A16891F84E7B', N'erkek     ', 4, CAST(N'2018-05-19 16:56:58.490' AS DateTime), N'/Uploads/images/default.png', 1, NULL)
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (12, N'Ali', N'Işık', CAST(N'2001-03-30' AS Date), N'blackDevil', N'isikali@hotmail.com', N'25D55AD283AA400AF464C76D713C07AD', N'erkek     ', 1, CAST(N'2018-06-06 20:48:33.200' AS DateTime), N'/Uploads/images/default.png', 0, N'25D08D353CD5C49417409FF37CB22E37')
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (13, N'Kübra', N'Kor', CAST(N'2000-11-12' AS Date), N'kubraa', N'kubraa@gmail.com', N'25F9E794323B453885F5181F1B624D0B', N'erkek     ', 1, CAST(N'2018-06-06 22:38:11.123' AS DateTime), N'/Uploads/images/default.png', 0, N'08571327DCD6228960F2EB39982A0775')
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (15, N'Roddy', N'Awase', CAST(N'2000-12-20' AS Date), N'roddy', N'rodway.14@gmail.com', N'25F9E794323B453885F5181F1B624D0B', N'erkek     ', 1, CAST(N'2018-06-06 22:41:58.227' AS DateTime), N'/Uploads/images/default.png', 0, N'F0B28A600ABBE3F0314034201290235D')
INSERT [dbo].[tblYazarlar] ([YazarId], [Ad], [Soyad], [DogumTarihi], [KullaniciAdi], [Email], [Parola], [Cinsiyet], [RutbeId], [KayitTarihi], [AvatarResim], [YazarOnay], [AktivasyonKodu]) VALUES (16, N'Can', N'Koç', CAST(N'2004-02-20' AS Date), N'can_koc', N'cankoc@gmail.com', N'25F9E794323B453885F5181F1B624D0B', N'erkek     ', 3, CAST(N'2018-06-07 20:59:14.547' AS DateTime), N'/Uploads/images/2ad7756a-96b1-43da-a495-d27e706d36fc.jpg', 0, N'E9E0F0FEE7349E63451CB0CD6C0AD454')
SET IDENTITY_INSERT [dbo].[tblYazarlar] OFF
SET IDENTITY_INSERT [dbo].[tblYorumlar] ON 

INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (1, N'kjl', CAST(N'2018-05-20 17:29:20.927' AS DateTime), 4, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (2, N'Merhaba ben adem', CAST(N'2018-05-20 17:36:23.163' AS DateTime), 4, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (3, N'Merhaba', CAST(N'2018-05-20 17:39:38.073' AS DateTime), 3, 5)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (4, N'heyy', CAST(N'2018-05-20 17:40:30.370' AS DateTime), 3, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (5, N'Merhaba', CAST(N'2018-05-20 17:46:00.563' AS DateTime), 1, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (6, N'Ben cihannn', CAST(N'2018-05-20 17:46:10.513' AS DateTime), 1, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (7, N'Çok güzel bir blog olmuş !', CAST(N'2018-05-20 22:00:50.227' AS DateTime), 12, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (8, N'', CAST(N'2018-05-20 22:00:59.933' AS DateTime), 12, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (10, N'Merhaba ben adem nasılsınız', CAST(N'2018-05-20 22:13:38.057' AS DateTime), 12, 2)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (11, N'Merhabalar ben can,
bu yazınızı oldukça beğendim.', CAST(N'2018-05-21 00:44:27.550' AS DateTime), 16, 5)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (12, N'Teşekkür ederim Can. Bu yazıda python''ın nasıl bir nimet olduğunu belirtmek istedim.', CAST(N'2018-05-21 00:58:30.637' AS DateTime), 16, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (13, N'Merhaba pandalar konusunda oldukça bilgi sahibisiniz sanırım.', CAST(N'2018-05-21 01:57:18.417' AS DateTime), 15, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (14, N'huuhuhuhu!', CAST(N'2018-05-21 02:00:21.737' AS DateTime), 17, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (15, N'hahhahahaa!', CAST(N'2018-05-21 02:00:41.083' AS DateTime), 17, 2)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (16, N'Nasılsınız gençler', CAST(N'2018-05-28 04:23:13.910' AS DateTime), 4, 5)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (17, N'kerem napıon', CAST(N'2018-05-29 00:06:20.050' AS DateTime), 6, 1)
INSERT [dbo].[tblYorumlar] ([YorumId], [Yorum], [YorumETarihi], [PostId], [YazarId]) VALUES (18, N'hayır yanlış yazdım', CAST(N'2018-06-07 22:49:49.163' AS DateTime), 20, 16)
SET IDENTITY_INSERT [dbo].[tblYorumlar] OFF
ALTER TABLE [dbo].[tblLike]  WITH CHECK ADD  CONSTRAINT [FK_tblLike_tblPosts] FOREIGN KEY([PostId])
REFERENCES [dbo].[tblPosts] ([PostId])
GO
ALTER TABLE [dbo].[tblLike] CHECK CONSTRAINT [FK_tblLike_tblPosts]
GO
ALTER TABLE [dbo].[tblLike]  WITH CHECK ADD  CONSTRAINT [FK_tblLike_tblYazarlar] FOREIGN KEY([YazarId])
REFERENCES [dbo].[tblYazarlar] ([YazarId])
GO
ALTER TABLE [dbo].[tblLike] CHECK CONSTRAINT [FK_tblLike_tblYazarlar]
GO
ALTER TABLE [dbo].[tblPostEtiket]  WITH CHECK ADD  CONSTRAINT [FK_tblPostEtiket_tblEtiket] FOREIGN KEY([EtiketId])
REFERENCES [dbo].[tblEtiket] ([EtiketId])
GO
ALTER TABLE [dbo].[tblPostEtiket] CHECK CONSTRAINT [FK_tblPostEtiket_tblEtiket]
GO
ALTER TABLE [dbo].[tblPostEtiket]  WITH CHECK ADD  CONSTRAINT [FK_tblPostEtiket_tblPosts] FOREIGN KEY([PostId])
REFERENCES [dbo].[tblPosts] ([PostId])
GO
ALTER TABLE [dbo].[tblPostEtiket] CHECK CONSTRAINT [FK_tblPostEtiket_tblPosts]
GO
ALTER TABLE [dbo].[tblPosts]  WITH CHECK ADD  CONSTRAINT [FK_tblPosts_tblKategoriler] FOREIGN KEY([KategoriId])
REFERENCES [dbo].[tblKategoriler] ([KategoriId])
GO
ALTER TABLE [dbo].[tblPosts] CHECK CONSTRAINT [FK_tblPosts_tblKategoriler]
GO
ALTER TABLE [dbo].[tblPosts]  WITH CHECK ADD  CONSTRAINT [FK_tblPosts_tblYazarlar] FOREIGN KEY([YazarId])
REFERENCES [dbo].[tblYazarlar] ([YazarId])
GO
ALTER TABLE [dbo].[tblPosts] CHECK CONSTRAINT [FK_tblPosts_tblYazarlar]
GO
ALTER TABLE [dbo].[tblYorumlar]  WITH CHECK ADD  CONSTRAINT [FK_tblYorumlar_tblPosts] FOREIGN KEY([PostId])
REFERENCES [dbo].[tblPosts] ([PostId])
GO
ALTER TABLE [dbo].[tblYorumlar] CHECK CONSTRAINT [FK_tblYorumlar_tblPosts]
GO
ALTER TABLE [dbo].[tblYorumlar]  WITH CHECK ADD  CONSTRAINT [FK_tblYorumlar_tblYazarlar] FOREIGN KEY([YazarId])
REFERENCES [dbo].[tblYazarlar] ([YazarId])
GO
ALTER TABLE [dbo].[tblYorumlar] CHECK CONSTRAINT [FK_tblYorumlar_tblYazarlar]
GO
USE [master]
GO
ALTER DATABASE [cihancelenBlog] SET  READ_WRITE 
GO
