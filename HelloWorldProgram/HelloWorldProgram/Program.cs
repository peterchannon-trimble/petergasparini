using System;
using System.Threading;

namespace HelloWorldProgram
{
	class Program
	{
		static void Main(string[] args)
		{
			while (true)
			{
				Console.WriteLine("Hello World! PartyPete!");
				int milliseconds = 2000;
				Thread.Sleep(milliseconds);
			}
			
		}
	}
}
