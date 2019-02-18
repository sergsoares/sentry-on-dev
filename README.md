### Sentry on Dev

Projeto criado para utilização do Sentry Localmente, script feito para ser o mais pronto para o uso possível.

Para iniciar tendo o docker instalado, efetue o clone do projeto:

```
$ git clone https://github.com/sergsoares/sentry-on-dev.git
```

Após isso inicie com o comando (Esse processo demora um tempo):

```
$ make init
```

O processo vai executar: 
- Download dos containers docker
- Configuração do Banco do Sentry 
- Obter DSN interna para uso 
- Enviará um evento de teste 

Após a conclusão uma mensagem semelhante a essa será mostrada:

```
This is your Internal Sentry DSN (Development Purpose): 
http://96c6eeec37834fcd97a11b7f5cc08d37@sentry:9000/1

To use in laravel for example, put in your .env
SENTRY_DSN=http://96c6eeec37834fcd97a11b7f5cc08d37@sentry:9000/1

To access your events
http://localhost:7000/sentry/internal/
```
