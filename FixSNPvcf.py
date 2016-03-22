import re,sys,fileinput
Argument = []
Argument = sys.argv[1:] 
Filepath = Argument[0]
Strain_column = int(Argument[1])
Outpath = Argument[2]
newfile = open(str(Outpath),"w")
for line in fileinput.input([Filepath]):
        if line.startswith("#"):
                if line.startswith("##"):
                        newfile.write(str(line))
                        continue
                else:
                        header = ""
                        header = ("\t".join(line.split("\t")[0:9]))+"\t"+line.split("\t")[Strain_column]+"\n"
                        newfile.write(str(header))

        rowlist = []
        rowlist = line.split("\t")

        genotype = []
        genotype = rowlist[Strain_column].split(":")

        if genotype[-1] == "1":
                if genotype[0] == "1/1" or genotype[0] == "2/2" or genotype[0] == "3/3" or genotype[0] == "4/4" or genotype[0] == "5/5" or genotype[0] == "6/6" or genotype[0] == "7/7":
                        newline = ""
                        newline = "chr"+("\t".join(rowlist[0:9]))+"\t"+rowlist[Strain_column]+"\n"
                        newfile.write(str(newline))

newfile.close()