#!/usr/bin/python2.7

import re
import random
import sys

def loadFile(file):
    with open(file, 'r') as f:
        return f.read()

def extraerPreguntas(str):
    r = re.compile('::T(.*)\}')
    return r.findall(str)

def formatearPregunta(pregunta):
    r_enunciado = re.compile('::(.*?)\{')
    r_respuestas = re.compile('~(.*?)~(.*?)~(.*?)=(.*?)\.|\}')
    return [r_enunciado.findall(pregunta), r_respuestas.findall(pregunta)]

def formularPregunta(pregunta):
    try:
        print pregunta[0][0]
        respuestas_desorganizadas = list(pregunta[1][0])
    except IndexError:
        print "Index error! " + str(pregunta)
        return False
    random.seed()
    random.shuffle(respuestas_desorganizadas)
    i = 0
    for respuesta in respuestas_desorganizadas:
        i += 1
        print str(i) + ': ' + respuesta
    try:
        respuesta_proporcionada = respuestas_desorganizadas[int(raw_input())-1]
    except ValueError:
        print "Entrada incorrecta! Respuesta correcta: " + pregunta[1][0][3]
        return None
    except IndexError:
        print "Numeros de 1 a 4, muchacho! Respuesta correcta: " + pregunta[1][0][3]
    if respuesta_proporcionada == pregunta[1][0][3]:
        print "YEAH"
        return True
    else:
        print "NOPE. Correcta: " + pregunta[1][0][3]
        return False
    
def main():
    
    file = sys.argv[1]
    rawtxt = loadFile(file)
    preguntas = extraerPreguntas(rawtxt)
    preguntas_formateadas = []
    for pregunta in preguntas:
        preguntas_formateadas.append(formatearPregunta(pregunta))

    n_correctas = 0
    n_incorrectas = 0
    
    while(True):
        try:
            respuesta_correcta = formularPregunta(random.choice(preguntas_formateadas))
            if respuesta_correcta:
                n_correctas += 1
            elif not respuesta_correcta:
                n_incorrectas += 1
    
        except KeyboardInterrupt:
            print "Preguntas acertadas: " + str(n_correctas) + "/" + str(n_correctas + n_incorrectas) + " (" + str(n_correctas*100./(n_correctas+n_incorrectas)) + "%)"
            print "Hasta lueguito!"
            break
    
if __name__ == '__main__':
    main()
