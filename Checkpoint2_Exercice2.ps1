Write-Host "--- Début du script ---"

#il faut modifier la variable $lenght = 6 par $lenght = 12 pour que l'on puisse aavoir un mot de passe de 12 caractere
Function Random-Password ($length = 12)
{
    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122

    $password = get-random -count $length -input ($punc + $digits + $letters) |`
        ForEach -begin { $aa = $null } -process {$aa += [char]$_} -end {$aa}
    Return $password.ToString()
}
#cette fonction sert a remplacer toutes les lettre avec accent par des lettres sans accents et met tout en miniscule(par exemple Anaïs Bourgeois devient anais bourgeois)
Function ManageAccentsAndCapitalLetters
{
    param ([String]$String)
    
    $StringWithoutAccent = $String -replace '[éèêë]', 'e' -replace '[àâä]', 'a' -replace '[îï]', 'i' -replace '[ôö]', 'o' -replace '[ùûü]', 'u'
    $StringWithoutAccentAndCapitalLetters = $StringWithoutAccent.ToLower()
    $StringWithoutAccentAndCapitalLetters
}

$Path = "\\172.16.10.10\Scripts"
$CsvFile = "$Path\Users.csv"
$LogFile = "$Path\Log.log"
# il faut remplacer le -skip 2 par un -skip 1 pour qu'il ne  prenne juste pas en compte la premiere ligne 
#des champs sont inutile donc je vais supprimer les champs société, fonction,service,mail,mobile,scriptpath,telephoneNumber
$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","description" -Encoding UTF8  | Select-Object -Skip 1

foreach ($User in $Users)
{
    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom
    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
    $Name = "$Prenom.$Nom"
    If (-not(Get-LocalUser -Name "$Prenom.$Nom" -ErrorAction SilentlyContinue))
    {
        $Pass = Random-Password
        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
        $Description = "$($user.description) - $($User.fonction)"
        $UserInfo = @{
            Name                 = "$Name"
            FullName             = "$Name"
            Password             = $Password
            AccountNeverExpires  = $true
            #on change le parametre PasswordNeverExpires de $false a $true pour que le mot de passe expire 
            PasswordNeverExpires = $true
            #ajout de la ligne pour ajouter la description au profil
            Description          = "$Description"
        }
        
        New-LocalUser @UserInfo
        #il manque le "s"a la fin de utilisateur voila pourquoi il ne trouver pas le groupe
        Add-LocalGroupMember -Group "Utilisateurs" -Member "$Name"
        #ajout de la phrase avec le mot de passe creer en clair
        Write-Host -ForegroundColor Green "L'utilisateur $Nom a été crée avec le mot de passe $Password"
        }
        else{
        
            #ajout du message d'erreur si l'utilisateur existe deja
            write-host -ForegroundColor Red "le compte $Name existe deja"
        }
         


}