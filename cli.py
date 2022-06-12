import logging
import logging.config

import click
from peewee import PeeweeException

import config
import dbmodel
from export import ExportToXLS
from nbp import NBPApiReader


logging.config.fileConfig('logging.conf')
logger = logging.getLogger('cli')

@click.group()
def cli():    
    pass

@cli.command(name='update-prices')
@click.option('--usd/--no-usd', default=True, help='Aktualizacja cen w USD', show_default=True)
@click.option('--euro/--no-euro', default=True, help='Aktualizacja cen w Euro', show_default=True)
def update_prices(usd, euro):
    """Aktualizacja cen produktów w USD/Euro w oparciu o aktualy kurs z NBP"""
    logger.info('Aktualizacja cen')  
    dbmodel.init_db()
    nbp_api_reader = NBPApiReader(url=config.APIURL)
    if euro:
        euro_rate = nbp_api_reader.get_current_exchangerate('eur')
        if euro_rate is not None:
            dbmodel.update_euro_price(euro_rate)
    if usd:
        usd_rate = nbp_api_reader.get_current_exchangerate('usd')
        if usd_rate is not None:
            dbmodel.update_usd_price(usd_rate)
    logger.info('Zakonczono aktualizacje cen')

@click.option('-f', '--file-name', help='Nazwa pliku')
@click.option('-s', '--sheet-name', default='Arkusz 1', help='Nazwa arkusza', show_default=True)
@click.option('--header/--no-header', default=True, help='Dodaj naglowek pliku', show_default=True) 
@cli.command(name='export-products')
def export_products(file_name, header, sheet_name):
    """Export tabeli produktow do pliku xls"""
    logger.info(f'Eksport produktow do pliku {file_name}')
    dbmodel.init_db()
    products = dbmodel.get_product_for_export()
    export = ExportToXLS(file_name = file_name, data = products, header = header, sheet_name = sheet_name)
    export.export()
    logger.info(f'Zakonczono eksport produktow do pliku {file_name}')

if __name__ == '__main__':
    cli()
