/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include "vpi_user.h"
#define MAX_BUFFER 1024

/*
 *  This is the structure for keeping track of a single open VCD file
 *   (the code is written to allow multiple open files at one time)
 */
struct file
{
    char*        name;
    FILE*        file;
    long         line;
    long         mods;
    long         sigs;
    long         uniq;
    char         buff[ MAX_BUFFER ];
};

/***
 *** Low-level file reading/parsing
 ***/

static char* get_line( struct file* file )
{
    char* retval = fgets( file->buff, ( MAX_BUFFER - 1 ), file->file );

    if ( retval == ( char* )0 ) *( file->buff ) = 0x00; /* clear buffer */

    if ( file->buff[ strlen( file->buff ) - 1 ] == '\n' )
    {
        file->buff[ strlen( file->buff ) - 1 ] = 0x00; ++( file->line );
    }
    return( retval );
}

static char* gettoken( struct file* file )
{
    char* tok = ( char* )0; char* delim = " \t\n";

    if ( ( tok = strtok( ( char* )0, delim ) ) != ( char* )0 ) return( tok );

    while ( get_line( file ) )
    {
        if ( ( tok = strtok( file->buff, delim ) ) != ( char* )0 ) return( tok );
    }
    return( ( char* )0 );
}

static void getend( struct file* file )
{
    if ( strcmp( gettoken( file ), "$end" ) != 0 )
    {
        fprintf( stderr, "Something funny at line %d of %s\n", file->line, file->name ); exit( 1 );
    }
}

/***
 ***  VCD file heirarchy parser
 ***/

static void readwire( struct file* file )
{
    char* type = strdup( gettoken( file ) );
    long  size =   atol( gettoken( file ) );
    char* mark = strdup( gettoken( file ) );
    char* name = strdup( gettoken( file ) );

    /*
     *  One optional field may be read and tacked onto the end of the name
     */
    char* temp = gettoken( file );

    if ( strcmp( temp, "$end" ) != 0 )
    {
        char* both = ( char* )malloc( strlen( name ) + strlen( temp ) + 1 );

        strcpy( both, name ); strcat( both, temp );

        /*
         *  Replace the current name with the concated name
         */
        free( name ); name = both; getend( file );
    }
    foundSignal( name, type, size, mark ); ++( file->sigs );
}

static void readscope( struct file* file, char* parent )
{
    char* tokn = ( char* )0;

    char* type = strdup( gettoken( file ) );
    char* name = strdup( gettoken( file ) );

    char* path = name; getend( file ); /* by default... */

    if ( parent ) /* ...unless we need to concatenate */
    {
        path = malloc( strlen( parent ) + strlen( name ) + 2 );

        sprintf( path, "%s.%s", parent, name );
    }
    foundScope( name, type, path ); ++( file->mods );

    while ( ( tokn = gettoken( file ) ) != ( char* )0 )
    {
        if ( strcmp( tokn, "$var" ) == 0 )
        {
            readwire( file );
        }
        else if ( strcmp( tokn, "$scope" ) == 0 )
        {
            readscope( file, path );
        }
        else if ( strcmp( tokn, "$upscope" ) == 0 )
        {
            getend( file ); break;
        }
    }
}

void* readVcdHeader( char* name )
{
    char* tokn = ( char* )0;

    struct file* file = ( struct file* )malloc( sizeof( struct file ) );

    file->file = fopen( ( file->name = strdup( name ) ), "r" );

    if ( file->file == ( FILE* )0 )
    {
        tf_error( "Cannot open %s for reading\n", file->name ); return( ( void* )0 );
    }
    file->mods = file->sigs = file->uniq = 0; file->line = 1;

    io_printf( "Reading file %s...\n", file->name );

    while (strtok(NULL, " \t\n"));

    while ( ( tokn = gettoken( file ) ) != ( char* )0 )
    {
        if ( strcmp( tokn, "$date" ) == 0 )
        {
            while ( strcmp( gettoken( file ), "$end" ) != 0 ); /* toss it */
        }
        else if ( strcmp( tokn, "$version" ) == 0 )
        {
            while ( strcmp( gettoken( file ), "$end" ) != 0 ); /* toss it */
        }
        else if ( strcmp( tokn, "$timescale" ) == 0 )
        {
            while ( strcmp( gettoken( file ), "$end" ) != 0 ); /* toss it */
        }
        else if ( strcmp( tokn, "$comment" ) == 0 )
        {
            while ( strcmp( gettoken( file ), "$end" ) != 0 ); /* toss it */
        }
        else if ( strcmp( tokn, "$scope" ) == 0 )
        {
            readscope( file, ( char* )0 );
        }
        else if ( strcmp( tokn, "$enddefinitions" ) == 0 )
        {
            getend( file ); break; /* done with heirarchy section of file */
        }
        else if ( strcmp( tokn, "$upscope" ) == 0 )
        {
            fprintf( stderr, "Unexpected end-of-scope in %s\n", file->name ); exit( 1 );
        }
        else
        {
            fprintf( stderr, "Unrecognized keyword %s in %s\n", tokn, file->name ); exit( 1 );
        }
    }
    return( ( void* )file );
}

char* readVcdLine( void* ptr )
{
    struct file* file = ( struct file* )ptr;

    while ( get_line( file ) )
    {
        if ( strlen( file->buff ) ) return( file->buff );
    }
    return( ( char* )0 );
}

void register_vcdReader(){
    s_vpi_systf_data tf_data;
    tf_data.type=vpiSysTask;
    tf_data.tfname="$vcdReader";
    tf_data.calltf=NULL;
    tf_data.compiletf=NULL;
    tf_data.sizetf=0;
    tf_data.user_data=0;
    vpi_register_systf(&tf_data);
}

//extern void register_vcdReader();
//
//void (*vlog_startup_routines[])() = 
//{
//    /*** add user entries here ***/
//  register_vcdReader,
//  NULL /*** final entry must be 0 ***/
//};
