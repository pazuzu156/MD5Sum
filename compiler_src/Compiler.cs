using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;

namespace compiler
{
    public class Compiler
    {
        private Dictionary<String, String> EnVars;
        private List<String> Libs;

        public Compiler()
        {
            getEnVars();
            configure();
        }

        private void getEnVars()
        {
            Console.WriteLine("Setting up environment for build\n");
            Vars v = new Vars("compiler.ini");
            v.process();

            EnVars = v.EnVars;
            Libs = v.Libs;
        }

        private void configure()
        {
            Console.WriteLine("Configuring project for compiling..\n");
            ProcessStartInfo i = new ProcessStartInfo();
            i.FileName = EnVars["QBIN"] + "qmake.exe";
            i.Arguments = "" + EnVars["CURDIR"] + "src\\MD5Sum.pro";
            i.UseShellExecute = false;
            Process p = Process.Start(i);
            p.WaitForExit();
            compile();
        }

        private void compile()
        {
            Console.WriteLine("Compiling project..\n");
            ProcessStartInfo i = new ProcessStartInfo();
            i.FileName = ((EnVars.ContainsKey("MKBIN")) ? EnVars["MKBIN"] : EnVars["CURDIR"]) + "make.exe";
            i.UseShellExecute = false;
            Process p = Process.Start(i);
            p.WaitForExit();

            Console.WriteLine("Copying exe to destination..\n");
            File.Copy(
                EnVars["CURDIR"] + "release\\MD5Sum.exe",
                EnVars["MBIN"] + "MD5Sum.exe",
                true
            );

            getlibs();
        }

        private void getlibs()
        {
            Console.WriteLine("Obtaining Qt libraries...");
            for(int i = 0; i < Libs.Count; i++)
            {
                if(Libs[i].Contains("\\") || Libs[i].Contains("/"))
                {
                    Console.WriteLine("Copying library: " + Libs[i]);
                    File.Copy(
                        EnVars["QBIN"] + "..\\plugins\\" + Libs[i],
                        EnVars["MBIN"] + Libs[i],
                        true
                    );
                }
                else
                {
                    Console.WriteLine("Copying library: " + Libs[i]);
                    File.Copy(
                        EnVars["QBIN"] + Libs[i],
                        EnVars["MBIN"] + Libs[i],
                        true
                    );
                }
            }
            Console.WriteLine();
            createInstaller();
        }

        private void createInstaller()
        {
            Console.WriteLine("Creating installer..\n");
            ProcessStartInfo i = new ProcessStartInfo();
            i.FileName = EnVars["ISS"] + "iscc.exe";
            i.Arguments = "/qp /o" + EnVars["MROOT"] + "release " + EnVars["MROOT"] + "md5sum_setup.iss";
            i.UseShellExecute = false;
            Process p = Process.Start(i);
            p.WaitForExit();
            cleanup();
        }

        private void cleanup()
        {
            Console.WriteLine("Cleaning up..\n");

            ProcessStartInfo i = new ProcessStartInfo();
            i.FileName = ((EnVars.ContainsKey("MKBIN")) ? EnVars["MKBIN"] : EnVars["CURDIR"]) + "make.exe";
            i.Arguments = "clean";
            i.UseShellExecute = false;
            Process p = Process.Start(i);
            p.WaitForExit();

            Console.WriteLine("Cleaning up residual files...\n");
            string[] files = Directory.GetFiles(EnVars["CURDIR"]);
            foreach(string file in files)
            {
                if (file.Contains("Makefile") || file.Contains("object_script"))
                {
                    Console.WriteLine("Deleting file: " + EnVars["CURDIR"] + file);
                    File.Delete(Path.Combine(EnVars["CURDIR"], file));
                }
            }

            Console.WriteLine("Deleting file: " + EnVars["MBIN"] + "MD5Sum.exe");
            File.Delete(EnVars["MBIN"] + "MD5Sum.exe");

            Directory.Delete(EnVars["CURDIR"] + "release", true);
            Directory.Delete(EnVars["CURDIR"] + "debug", true);

            Console.WriteLine("\nBuild 100% Successfull!");
            Console.WriteLine("Setup file can be found at: " + EnVars["MROOT"] + "release\n");
            Console.WriteLine("Press <RETURN> to close");
            Console.Read();
        }
    }
}
