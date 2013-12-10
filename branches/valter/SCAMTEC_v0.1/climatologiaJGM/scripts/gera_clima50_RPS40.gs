'reinit'
'open climatologia50yr.dec.bin.ctl' 
'set z 1'
'set gxout fwrite'
'set fwrite climato_ETA40_dec.bin'

# Interpolando para o ETA40:Topo 
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(topo,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:lsmk 
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(lsmk,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:roug
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(roug,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:swos
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(swos,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:swrz
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(swrz,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:swdz
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(swdz,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:tmsp
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(tmsp,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:tszw
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(tszw,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:tsmw
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(tsmw,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:spmt
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(spmt,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:tast
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(tast,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:tmrh
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(tmrh,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:tmst
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(tmst,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:prec
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(prec,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:prcv
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(prcv,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:neve
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(neve,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:rnof
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(rnof,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:pwat
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(pwat,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:pitp
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(pitp,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:cssf
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(cssf,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:clsf
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(clsf,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:usst
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(usst,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:vsst
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(vsst,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:cbnv
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(cbnv,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:olis
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(olis,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:oles
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(oles,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'


# Interpolando para o ETA40:role
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(role,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:iswf
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(iswf,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'


# Interpolando para o ETA40:ocis
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(ocis,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:oces
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(oces,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'


# Interpolando para o ETA40:roce
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(roce,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:vimf
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(vimf,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'


# Interpolando para o ETA40:dlwb
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(dlwb,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:olwt
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(olwt,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'


# Interpolando para o ETA40:dswg
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(dswg,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:uswg
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(uswg,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:uswt
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(uswt,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:tdst
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(tdst,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:tgsc
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(tgsc,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:cate
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(cate,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:tcas
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(tcas,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:vpca
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(vpca,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40:bslh
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(bslh,0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'

# Interpolando para o ETA40 em niveis:uvmt
i=1
j=18
while(i<=j)
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(uvmt(z='i'),0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'
i=i+1
endwhile

# Interpolando para o ETA40 em niveis:vvmt
i=1
j=18
while(i<=j)
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(vvmt(z='i'),0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'
i=i+1
endwhile

# Interpolando para o ETA40 em niveis:fcmt
i=1
j=18
while(i<=j)
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(fcmt(z='i'),0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'
i=i+1
endwhile

# Interpolando para o ETA40 em niveis:pvmt
i=1
j=18
while(i<=j)
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(pvmt(z='i'),0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'
i=i+1
endwhile

# Interpolando para o ETA40 em niveis:ghmt
i=1
j=18
while(i<=j)
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(ghmt(z='i'),0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'
i=i+1
endwhile

# Interpolando para o ETA40 em niveis:atmt
i=1
j=18
while(i<=j)
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(atmt(z='i'),0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'
i=i+1
endwhile

# Interpolando para o ETA40 em niveis:rhmt
i=1
j=18
while(i<=j)
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(rhmt(z='i'),0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'
i=i+1
endwhile

# Interpolando para o ETA40 em niveis:ommt
i=1
j=18
while(i<=j)
'set lon -85 -26'
'set lat -51 13'
'define tmp2=regrid2(ommt(z='i'),0.4,0.4,bl_p1,-83.0,-50.2)'
'set lon -83.0 -25.8'
'set lat -50.2 12.2'
'd tmp2'
'!rm -fr udf*'
i=i+1
endwhile

# Finalizar o arquivo
'disable fwrite climato_ETA40_dec.bin'
'quit'