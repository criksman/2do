using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace matri
{
    class Program
    {
        static void Main(string[] args)
        {
            int filas = 0;
            int columnas = 0;

            int[,] matriz = new int[0, 0];

            Boolean flag = true;
            while (flag)
            {
                Console.WriteLine("1. Construir Matriz\n2. Llenar Matriz con números al azar\n3. Imprimir Matriz\n4. Imprimir matriz sin diagonales\n5. Salir");

                int opcion;

                int.TryParse(Console.ReadLine(), out opcion);

                switch (opcion)
                {
                    case 1:

                        filas = 0;
                        columnas = 0;

                        while (filas <= 0)
                        {
                            Console.Write("Ingrese la cantidad de filas: ");
                            int.TryParse(Console.ReadLine(), out filas);
                        } 

                        while (columnas <= 0)
                        {
                            Console.Write("Ingrese la cantidad de columnas: ");
                            int.TryParse(Console.ReadLine(), out columnas);
                        }

                        matriz = new int[filas, columnas];

                        break;
                    case 2:
                        System.Random random = new System.Random();
                        if (matriz != null)
                        {
                            for (int filasCount = 0; filasCount < filas; filasCount++)
                            {
                                for (int columnasCount = 0; columnasCount < columnas; columnasCount++)
                                {
                                    matriz[filasCount, columnasCount] = random.Next(10, 100);
                                }
                            }
                        }
                        else
                        {
                            Console.WriteLine("Primero debes construir la matriz.");
                        }
                        break;
                    case 3:
                        if (matriz != null)
                        {
                            for (int filasCount = 0; filasCount < filas; filasCount++)
                            {
                                for (int columnasCount = 0; columnasCount < columnas; columnasCount++)
                                {
                                    Console.Write(matriz[filasCount, columnasCount] + " ");
                                }
                                Console.WriteLine();
                            }
                        }
                        else
                        {
                            Console.WriteLine("Primero debes construir y llenar la matriz.");
                        }
                        break;
                    case 4:
                        for (int filasCount = 0; filasCount < filas; filasCount++)
                        {
                            for (int columnasCount = 0; columnasCount < columnas; columnasCount++)
                            {
                                if (columnasCount == filasCount || columnasCount + filasCount == matriz.GetLength(0) - 1)
                                {
                                    Console.ForegroundColor = ConsoleColor.Black;
                                }
                                else
                                {
                                    Console.ResetColor();
                                }
                                Console.Write(matriz[filasCount, columnasCount] + " ");

                                Console.ResetColor();
                            }
                            Console.WriteLine();
                        }
                        break;
                    case 5:
                        flag = false;
                        break;
                    default:
                        Console.WriteLine("Opción Incorrecta");
                        break;
                }
            }
        }
    }
}
