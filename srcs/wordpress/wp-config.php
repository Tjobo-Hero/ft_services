<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'mysql' );

/** MySQL database password */
define( 'DB_PASSWORD', 'mysql' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '@;bjRHNq=:B+;GPR`0%majD79nUzUXC{(G@x1fz@poY2qgi6 ;R]@pZ8.a78DG;#' );
define( 'SECURE_AUTH_KEY',   'W@|&&AH[fc;&LJ!vMMz6DiRui0UjF.BZy~)OX^;MU)a-3z,YYwWPW3/-x-VnE[Id' );
define( 'LOGGED_IN_KEY',     '>B)Az{/>jQXcMd#lG#SYR=pu>wBTgZx|s?;>Fu?XYLa$kA$t;r/jAgOGd@H|Nj5n' );
define( 'NONCE_KEY',         'a,jlK~Hnw#G5eG$sh90ZNXX,FFU?Kj1Q9|O~/CGVUu=M5ASgn.6+$pp7?wn>aHLU' );
define( 'AUTH_SALT',         'b1)XXhEM!8ka-B6R~etf7#|T/v>k/3#,5nJE&.f_yN9zK,kT-Dt:w&F#{Z@DZ_=+' );
define( 'SECURE_AUTH_SALT',  '#xfqGeP5eP9kfz]Rzl3:S:B}sA?IQ#)U$`oz8<n95ov2GZq(qI%DD}ih9b,rv*o`' );
define( 'LOGGED_IN_SALT',    'Gebd?9RbQa>,?jW>1ODk~@I}!ji6z5c+#*8a9F0/,Wf}a]w]i ss?5h=_V%7@; $' );
define( 'NONCE_SALT',        'Vdz>ZzLP4^vQ5pC7^MpU_ra`!srd#%I |3`VU[rE>;)).~&e!m9v+4Y244uV2M77' );
define( 'WP_CACHE_KEY_SALT', 'RUu2k!t[HD;jE]#n`gf S$ZA-LH!ZmpT15x*3(TN#}KIO%2<0F?c}A,Oc!!-Yt %' );

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';




/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
