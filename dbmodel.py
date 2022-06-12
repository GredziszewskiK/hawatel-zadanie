import logging
import peewee as pw

import config

logger = logging.getLogger('dbmodel')
mysql_db = pw.MySQLDatabase(None)

class Product(pw.Model):
    ProductID = pw.CharField(primary_key=True, max_length=8)
    DepartmentID = pw.CharField(max_length=8)
    Category = pw.CharField(max_length=45)
    IDSKU = pw.CharField(max_length=8)
    ProductName = pw.CharField(max_length=45)
    Quantity = pw.IntegerField()
    UnitPrice = pw.DecimalField(max_digits=10, decimal_places=0)
    Ranking = pw.IntegerField()
    ProductDesc = pw.TextField()
    UnitsInStock = pw.IntegerField()
    UnitsInOrder = pw.IntegerField()
    Picture = pw.BigBitField()
    UnitPriceUSD = pw.DecimalField(max_digits=10, decimal_places=0)
    UnitPriceEuro = pw.DecimalField(max_digits=10, decimal_places=0)

    class Meta:
        database = mysql_db

def init_db() -> None:
    try:
        mysql_db.init(
            database = config.DATABASE,
            user = config.DBUSER,
            password = config.DBPASSWORD,
            host = config.DBHOST
        )
    except pw.PeeweeException as e:
        logger.error(e)

def update_usd_price(usd_rate: float) -> None:
    logger.info(f'Aktualizacja cen w dolarach. Kurs dolara: {usd_rate}')
    try:
        Product.update(UnitPriceUSD = Product.UnitPrice / usd_rate).execute()
    except pw.PeeweeException as e:
        logger.error(e)

def update_euro_price(euro_rate: float) -> None:
    logger.info(f'Aktualizacja cen w euro. Kurs euro: {euro_rate}')
    try:
        Product.update(UnitPriceEuro = Product.UnitPrice / euro_rate).execute()
    except pw.PeeweeException as e:
        logger.error(e)
        
def get_product_for_export() -> list[dict]:
    logger.info('Pobieranie produktow do raportu')
    try:
        products = Product.select(
            Product.ProductID
            ,Product.DepartmentID
            ,Product.Category
            ,Product.IDSKU
            ,Product.ProductName
            ,Product.Quantity
            ,Product.UnitPrice
            ,Product.UnitPriceUSD
            ,Product.UnitPriceEuro
            ,Product.Ranking
            ,Product.ProductDesc
            ,Product.UnitsInStock
            ,Product.UnitsInOrder
        ).dicts()
        return products
    except pw.PeeweeException as e:
        logger.error(e)