# CepPromise

## Instalação

O pacote pode ser instalado adicionando `cep_promise` à sua lista de dependências em` mix.exs`:

```elixir
def deps do
  [
    {:cep_promise, "~> 0.0.2"}
  ]
end
```

Documentação pode ser encontrada em [https://hexdocs.pm/cep_promise](https://hexdocs.pm/cep_promise).

<p align="center">
  <img src="http://piskel-imgstore-b.appspot.com/img/d580e96e-bd8a-11e6-b157-9949cad4d609.gif">
</p>

<h1 align="center">CEP Promise</h1>
Busca por CEP integrado diretamente aos serviços BrasilAPI e ViaCEP, (logo implemento outros, como correios).

## Descrição

Essa biblioteca é uma cópia da original feita pelo <a href="https://github.com/filipedeschamps" target="_blank">Filipe Deschamps (Michel Teló)</a> que achei a premissa bastante interessante e decidi copiá-la em Elixir.

## Features

 * Sempre atualizado em tempo-real por se conectar diretamente aos serviços BrasilAPI e ViaCEP.
 * Sem limites de uso (rate limits) conhecidos.

## Como Utilizar

A utilização é bem simples:

```elixir
cep = CepPromise.get('80020100') 

/** Endereço: 
 * {:ok,
    %CepPromise.Cep{
      cep: "80020100",
      city: "Curitiba",
      neighborhood: "Centro",
      state: "PR",
      street: "Praça Tiradentes"
    }
  }
*/
```

## Deixe suas sugestões

Fique a vontade para deixar sugestões nas issues!

## Fonte

Esse pacote foi inspirado no original <a href="https://github.com/BrasilAPI/cep-promise">https://github.com/BrasilAPI/cep-promise</a>
