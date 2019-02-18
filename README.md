### Sentry on Dev

Projeto criado para utilização do Sentry Localmente, script feito para ser o mais pronto para o uso possível.

Para iniciar tendo o docker instalado, efetue o clone do projeto:

```
$ git clone https://github.com/sergsoares/sentry-on-dev.git
```

Após isso inicie com o comando:

```
$ make init
```

O processo vai executar: 
- Download dos containers docker
- Configuração do Banco do Sentry 
- Obter DSN interna para uso 
- Enviará um evento de teste 

Após a conclusão uma mensagem semelhante a essa será mostrada:


