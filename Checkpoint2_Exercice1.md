Q1.1 
![alt text](image.png)
le serveur est en 172.16.10.10/24 alors que le client est en 172.16.100.50/24
si il ne comunique paas c'est qu'il ne sont pas sur la meme plage d'adresse IP car le 3eme octet est different.

j'ai modifier l'adresse IP de la machine client en 172.16.10.50 comme ca il sont sur la meme plage d'adresse IP
![](image-1.png)

Q1.2

![](image-2.png)
quand je ping avec le nom de la machine j'ai une reponse ok avec de l'IPV6

Q1.3

![alt text](image-3.png)

une fois l'IPV6 desactiver j'ai une reponse en IPV4
il suffit juste de reactiver l'IPV6
![alt text](image-4.png)
![alt text](image-5.png)

Q1.4
modification sur le client:
![alt text](image-6.png)

faire un ipconfig /release et un ipconfig /renew et notre client a une adresse IP attribuer par le DHCP
![alt text](image-7.png)

Q1.5
![alt text](image-8.png)
il y a une plage d'adresse IP qui prend de 172.16.10.1 a 172.16.10.19 donc la premiere adresse disponible est la 172.16.10.20
![alt text](image-7.png)

Q1.6

![alt text](image-9.png)
je fait une reservation d'adresse
![alt text](image-10.png)