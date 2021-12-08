# teste data engineer roxy
Esta é minha solução para resolver este teste técnico

### Programas utilizados:
* [AWS RDS](https://aws.amazon.com/pt/rds/?nc2=type_a)
* [Postgresql](https://www.postgresql.org/)
* [Pgadmin](https://www.pgadmin.org)
* [Pentaho Data Integration](https://help.hitachivantara.com/Documentation/Pentaho/9.2)
* [Dbvear](https://dbeaver.io/download/)

### Criação do rds
* Meu primeiro passo foi crirar um banco em uma nuvem [☁](#-cloud-) , e para isso eu utilizei o [AWS RDS](https://aws.amazon.com/pt/rds/?nc2=type_a)  indo em: serviços > RDS > Criar banco de dados.
![1](https://user-images.githubusercontent.com/63296032/145125161-144f2d7b-1f60-4587-b99d-7fc92a1e358d.png)
* A próxima etapa é configurar o banco, e eu vou deixar a criação padrão > selecionar o mecanismo postgreSQL > e utilizar a versão 12.8-R1 para poder utilizar em uso de nível gratuito.
![2](https://user-images.githubusercontent.com/63296032/145126375-33ac1f9b-4b63-419d-a364-e20eb7758b05.png)
* Outra etapa importante é configurar o nome do banco, um usuário e a senha para posteriormente fazer a conexão:
![3](https://user-images.githubusercontent.com/63296032/145127276-f3d4149f-a8d4-4f88-aba0-b507597fe1e0.png)
* A última etapa da configuração do banco é a configuração da VPC e dos grupos de sub-redes, para evitar cobranças eu deixei o padrão da AWS, e defini o acesso como público, outro ajuste que tenho que fazer para conseguir acessar o banco de um ip externo ao da aws.
![4](https://user-images.githubusercontent.com/63296032/145129195-6a3c8eea-e8e5-454d-ac00-5868f72ee9ae.png)
* Após essas configurações o banco pode ser criado.
* Uma última configuração para conceder acesso externo é configurar uma regra de entrada para isso devo ir em: EC2 > Grupos de segurança > clicar no nome do grupo criado por padrão > editar regras de entrada > definir uma regra para todo o tráfego e todos os ips:
![5](https://user-images.githubusercontent.com/63296032/145130903-93915b76-befa-451b-9cb5-42b86fa0ffd7.png)
* O banco já está criado e já pode ser utilizado.
* Para checar se está tudo certo eu vou utilizar o [Pgadmin](https://www.pgadmin.org) para conectar ao banco criado, eu preciso utilizar o Endpoint, a porta, o usuário e a senha que eu defini.
* Com a conexão criada eu vou criar manualmente um schema para poder fazer a criação das tabelas.
![6](https://user-images.githubusercontent.com/63296032/145133638-00d55ce8-ebe5-438b-95d7-5f9f90dc133a.png)
### Criando tabela e importando arquivos CSV
* Para isso vou utilizar o [Pentaho Data Integration](https://help.hitachivantara.com/Documentation/Pentaho/9.2), com ele aberto eu crio uma conexão com a pasta que estão meus arquivos csv
![pdi](https://user-images.githubusercontent.com/63296032/145195101-a684f117-2896-4053-8cdb-60b0f2f980cc.gif)
* Com a conexão criada eu crio uma trasnformação e seleciono os meus inputs e outputs, como eu quero de um arquivo csv para uma tabela vou utilizar esses que o próprio pentaho disponibiliza
![pdi2](https://user-images.githubusercontent.com/63296032/145196486-087c6594-6fb0-4e24-875f-41b402d4a0e0.gif)
* Agora é só selecionar o arquivo csv e definir como o pentaho enxerga os parametros dele e eu posso dar um preview pra validar se está tudo correto
![pdi3](https://user-images.githubusercontent.com/63296032/145198480-d038cec1-0c74-43ba-b8ab-154d0ecdca45.gif)
* Dentro do output da tabela tenho que colocar a conexão, e é aqui que eu coloco os dados do RDS
![pdi4](https://user-images.githubusercontent.com/63296032/145199761-45563566-ae40-4498-b103-e8e1b9f12838.gif)
* Agora o pentaho me disponibiliza um step importante. se não houver uma tabela com o nome que eu defini no banco ele me da uma SQL de criação que eu posso executar pelo próprio pentaho.
![pdi6](https://user-images.githubusercontent.com/63296032/145200551-111ecd4a-5d86-4405-a575-50912268ff0f.gif)
* É só repitir isso para todas as tabelas e depois, para inserir o dado dentro delas eu executo a trasnformação.
![pdi7](https://user-images.githubusercontent.com/63296032/145202956-4be769ea-86be-4955-8d07-d56c04209b76.gif)
* Para validar os dados eu vou utilizar o [Dbvear](https://dbeaver.io/download/), dentro da interface eu faço a conexão com o RDS e valido seas tabelas estão criadas e se todas elas estão populadas.
![7](https://user-images.githubusercontent.com/63296032/145203311-23af3f72-cbed-41f4-982b-dfd8bfbc8d3c.png)
## Análise de dados
1.	Escreva uma query que retorna a quantidade de linhas na tabela Sales.SalesOrderDetail pelo campo SalesOrderID, desde que tenham pelo menos três linhas de detalhes.
```sql
with recursive cte1 as(
SELECT 
sod.salesorderid,
count(salesorderid) as QTD
FROM roxy.sales_order_detail sod 
group by 1
)
select *
from 
cte1
where qtd >=3
```
2.	Escreva uma query que ligue as tabelas Sales.SalesOrderDetail, Sales.SpecialOfferProduct e Production.Product e retorne os 3 produtos (Name) mais vendidos (pela soma de OrderQty), agrupados pelo número de dias para manufatura (DaysToManufacture).
```sql
select
p.name_product,
sum (orderqty),
p.daystomanufacture
from roxy.sales_order_detail sod
join roxy.product p on p.productid = sod.productid
join roxy.special_offer_product sop on sod.productid = sop.productid
group by 3,1
order by 2 desc
limit 3
```
3. Escreva uma query ligando as tabelas Person.Person, Sales.Customer e Sales.SalesOrderHeader de forma a obter uma lista de nomes de clientes e uma contagem de pedidos efetuados.
* Essa eu fiz duas SQL por questão de entendimento sobre como se comportavam os campos de nome na coleta, mas ambas funcionam da mesma forma.
```sql
with recursive cte1 as(
select
customerid,
count (salesorderid) as qtd
from roxy.sales_order_harder
group by 1
order by 2 desc
) 
,
cte2 as(
select
p.firstname ||' '|| p.middlename ||' '|| p.lastname as nome,
c.customerid 
from roxy.person p
join roxy.customer c on c.customerid = p.businessentityid
)
select 
nome,
qtd
from cte1
join cte2 on cte1.customerid = cte2.customerid
order by 2 desc
```
OU
```sql
select
p.firstname ||' '|| p.middlename ||' '|| p.lastname as nome,
count(salesorderid)
from roxy.person p 
join roxy.customer cus on cus.customerid = p.businessentityid
join roxy.sales_order_harder soh on p.businessentityid = soh.customerid
group by 1
order by 2 desc
```
4.	Escreva uma query usando as tabelas Sales.SalesOrderHeader, Sales.SalesOrderDetail e Production.Product, de forma a obter a soma total de produtos (OrderQty) por ProductID e OrderDate.
```sql
select
p.productid,
p.name_product,
soh.orderdate,
sum (sod.orderqty)
from roxy.sales_order_harder soh
join roxy.sales_order_detail sod on sod.salesorderid = soh.salesorderid
join roxy.product p on sod.productid = p.productid
group by 1,2,3
order by 4 desc
```
5.	Escreva uma query mostrando os campos SalesOrderID, OrderDate e TotalDue da tabela Sales.SalesOrderHeader. Obtenha apenas as linhas onde a ordem tenha sido feita durante o mês de setembro/2011 e o total devido esteja acima de 1.000. Ordene pelo total devido decrescente.
```sql
SELECT 
salesorderid,
orderdate,
totaldue 
FROM roxy.sales_order_harder soh 
where 
totaldue >= '1000'
and 
extract(year from orderdate::timestamp) = 2011
and
extract(month from orderdate::timestamp) = 11
order by totaldue desc 
```

