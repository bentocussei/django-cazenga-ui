"""
Configurações do pytest para Django Cazenga UI
"""
import django
from django.conf import settings
from django.test.utils import get_runner

def pytest_configure():
    """Configura Django para testes"""
    import os
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'tests.test_settings')
    django.setup()


def pytest_sessionstart(session):
    """Chamado após configuração dos plugins e antes da coleta de testes"""
    from django.core.management import execute_from_command_line
    # Pode ser usado para configurações adicionais se necessário
    pass 