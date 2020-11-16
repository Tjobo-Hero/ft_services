<?php

declare(strict_types=1);

$cfg['blowfish_secret'] = 'wVxb8fw:sBxR/B:}yYGsS{OlONOs=6S0';

$i = 1;

/* Authentication type */
$cfg['Servers'][$i]['auth_type'] = 'cookie';
/* Server parameters */
$cfg['Servers'][$i]['host'] = 'mysql';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = true;

$cfg['Servers'][$i]['port'] = '3306';
// $cfg['Servers'][$i]['user'] = 'mysql';
//$cfg['Servers'][$i]['password'] = 'mysql';

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

$cfg['TempDir'] = '/tmp';

$cfg['PmaAbsoluteUri'] = '/';
