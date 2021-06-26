# AEMT
Algoritmo Evolutivo Multi-objetivo de Tabelas para Seleção de Variáveis em Calibração Multivariada

Este artigo propõe um novo algoritmo evolutivo multiobjetivo. Em particular, esse algoritmo faz uso de uma estrutura de subconjuntos armazenados em uma estrutura de dados denominada tabela na qual os melhores indivíduos de cada alvo são considerados preservados. Esta abordagem é comparada neste artigo com algoritmos evolucionários tradicionais monoobjetivos. É apresentado um caso de estudo de um problema de calibração multivariada que envolve a predição da concentração de proteínas em amostras de trigo integral a partir de ondas de medidas espectrofotométricas. Os resultados mostram que a formulação proposta apresenta um menor erro de predição em relação à formulação monoobjetivo. Adicionalmente, observou-se que os templates são obtidos a partir da formulação proposta utilizando um número menor de variáveis. Por fim, um estudo de sensibilidade ao ruído nos modelos obtidos por formulação multiobjetivo apresentou melhor resultado.

## Uso

É necessário Matlab 2014 no mínimo para utilizar esse programa.
O algoritmo é chamado através da função **aemt** passando os parâmetros que o usuário escolher.
Para fins de teste e exemplo, temos o arquivo:
```bash
dados_pronto_trigo_nir_corrigido.mat
```

como dados de entrada do algoritmo.
Para executá-lo, basta chamar o script *executa.m* no Matlab.

```bash
executa
```
## License
[MIT](https://choosealicense.com/licenses/mit/)
