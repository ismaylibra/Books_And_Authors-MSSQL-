create database BooksOfAuthors

use BooksOfAuthors
create table Books(
   Id int primary key identity,
   [Name] nvarchar(100) check (len([Name])>2),
   AuthorId  int foreign key references Author(Id),
   [PageCount] int check ([PageCount]>10)

)
create table Author(
Id int primary key identity,
[Name] nvarchar(30) not null,
Surname nvarchar(30)

)

 create  view vw_AllofBooks
 as
 select * from
(
select b.Id,b.[Name],b.[PageCount], a.[Name] + ' ' + a.Surname as Fullname from Books as b
join Author as a
on b.AuthorId = a.Id
) as AuthorOfBook  
select * from vw_AllofBooks

create procedure usp_BookSearching
@Name nvarchar(30)
as 
select b.Id,b.[Name], b.[PageCount],a.[Name] +' '+ a.Surname as Fullname from Books as b
join Author as a
on b.AuthorId= a.Id
where a.[Name] = @Name
 
 insert into Books([Name],[PageCount])
 values('Adventures of Tom Sawyer', 274),
 ('Mein Kampf',720),
 ('Utopia', 304),
 ('Anna Karenina',864)
 exec usp_BookSearching 'Adolf'

 create procedure usp_UpdateAuthor
 @Id int,
 @Name nvarchar(30)
 as
 update Author
 set Name = @Name where Id= @Id

 exec usp_UpdateAuthor 1, 'Mark'
 
 create procedure usp_AddAuthor
 @Name nvarchar(30),
 @Surname nvarchar(30)
 as 
 insert into Author ([Name],[Surname])
 values(@Name,@Surname)

 exec usp_AddAuthor 'Karl', 'Marx'

 create procedure usp_AddBook
 @Name nvarchar(30),
 @PageCount int
 as 
 insert into Books([Name],[PageCount])
 values(@Name,@PageCount)

 exec usp_AddBook 'Das Kapital',1134

create procedure usp_DeleteAuthor
@Id int
as 
delete from Author where Id = @Id

exec usp_AddAuthor 'Elxan', 'Elatli'

exec usp_DeleteAuthor 6

exec usp_BookSearching 'karl'


create table BooksAndAuthors(
Id int primary key identity,
Book_Id int foreign key references Books(Id),
Author_Id int foreign key references Author(Id)

)
insert into Author([Name],[Surname])
values('Meghan','Markle')
insert into Books([Name],[PageCount])
values('The Bench',40)


create view vw_AuthorInfo
as
select * from(select a.Id, a.Name+ ' ' + a.Surname as Fullname,b.Name as BookName, b.PageCount,b.AuthorId from BooksAndAuthors as ba
right join Books as b
on ba.Book_Id  = b.Id
left join Author as a
on ba.Author_Id = a.Id)
as AboutAuthor

select * from vw_AuthorInfo


