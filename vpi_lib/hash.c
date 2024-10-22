/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "hash.h"


#define ASSERT( c ) if ( !( c ) ) { fprintf( stderr, "Out of memory...\n" ); exit( 0 ); }

/*
** public domain code by Jerry Coffin, with improvements by HenkJan Wolthuis.
**
** Tested with Visual C 1.0 and Borland C 3.1.
** Compiles without warnings, and seems like it should be pretty portable.
*/

/*
** These are used in freeing a table. Perhaps I should code up
** something a little less grungy, but it works, so what the heck.
*/
static void (*function)(void *) = (void (*)(void *))NULL;
static hash_table *the_table = NULL;

/* Initialize the hash_table to the size asked for. Allocates space
** for the correct number of pointers and sets them to NULL. If it
** can't allocate sufficient memory, signals error by setting the size
** of the table to 0.
*/
hash_table *hashInitialize(hash_table *table, size_t size)
{
    size_t i;
    bucket **temp;
    table -> size = size;
    table -> table = (bucket * *)malloc(sizeof(bucket *) * size);
    temp = table -> table;
    if ( temp == NULL )
    {
        table -> size = 0;
        return table;
    }
    for (i=0;i<size;i++)
    temp[i] = NULL;
    return table;
}

/*
** Hashes a string to produce an unsigned short, which should be
** sufficient for most purposes.
*/
static unsigned hash(char *string)
{
    unsigned ret_val = 0;
    int i;
    while (*string)
    {
        i = *string;
        ret_val ^= i;
        ret_val <<= 1;
        string ++;
    }
    return ret_val;
}

/*
 *  Insert 'key' into hash table.
 *
 *  Returns pointer to old data associated with the key, if
 *  any, or zero if the key wasn't in the table previously.
 */
void *hashInsert( char *key, void *data, hash_table *table )
{
    bucket *ptr; unsigned val = ( hash( key ) % table->size );

    /*
     *  Zero means this bucket hasn't been used yet.
     */
    if ( ( table->table )[ val ] == 0 )
    {
        ASSERT( ptr = ( bucket* )malloc( sizeof( bucket ) ) );

        ptr->key  = strdup( key );
        ptr->data = data;
        ptr->next = 0;

        ( table->table )[ val ] = ptr; return( 0 ); /* new entry */
    }

    /*
     *  This spot in the table is already in use.
     */
    for ( ptr = ( table->table )[ val ]; ptr; ptr = ptr -> next )
    {
        if ( strcmp( key, ptr->key ) == 0 )
        {
            void *old_data = ptr->data; ptr->data = data; return( old_data );
        }
    } 
      /*  p_vdiff_node node_new =  data;
    for (ptr = (table->table)[val]; ptr; ptr = ptr->next) {
        p_vdiff_node node_old = ptr->data;
        if (strcmp(key, ptr->key) == 0) {
            fprintf(stderr, "strobe configuration error:%s and %s there are points with Equivalence\n",FullName(node_new->refn->refn),FullName(node_old->refn->refn));
            exit(1); // 终止程序并返回错误码 1
        } */

    /*
     *  This key must not be in the table yet.
     */
    ASSERT( ptr = ( bucket* )malloc( sizeof( bucket ) ) );

    ptr->key  = strdup( key );
    ptr->data = data;
    ptr->next = ( table->table )[ val ];

    ( table->table )[ val ] = ptr; return( 0 ); /* new entry */
}

/*
** Look up a key and return the associated data. Returns NULL if
** the key is not in the table.
*/
void *lookup(char *key, hash_table *table)
{
    unsigned val = hash(key) % table->size;
    bucket *ptr;
    if (NULL == (table->table)[val])
    return NULL;

    for ( ptr = (table->table)[val];NULL != ptr; ptr = ptr->next )
    {
        if (0 == strcmp(key, ptr -> key ) )
        return ptr->data;
    }
    return NULL;
}

/*
** Delete a key from the hash table and return associated
** data, or NULL if not present.
*/
void *del(char *key, hash_table *table)
{
    unsigned val = hash(key) % table->size;
    void *data;
    bucket *ptr, *last = NULL;
    if (NULL == (table->table)[val])
    return NULL;

    /*
    ** Traverse the list, keeping track of the previous node in the list.
    ** When we find the node to delete, we set the previous node's next
    ** pointer to point to the node after ourself instead. We then delete
    ** the key from the present node, and return a pointer to the data it
    ** contains.
    */
    for (last = NULL, ptr = (table->table)[val]; NULL != ptr; last = ptr, ptr = ptr->next)
    {
        if (0 == strcmp(key, ptr -> key))
        {
            if (last != NULL )
            {
                data = ptr -> data;
                last -> next = ptr -> next;
                free(ptr->key);
                free(ptr);
                return data;
            }

            /*
            ** If 'last' still equals NULL, it means that we need to
            ** delete the first node in the list. This simply consists
            ** of putting our own 'next' pointer in the array holding
            ** the head of the list. We then dispose of the current
            ** node as above.
            */
            else
            {
                data = ptr->data;
                (table->table)[val] = ptr->next;
                free(ptr->key);
                free(ptr);
                return data;
            }
        }
    }

    /*
    ** If we get here, it means we didn't find the item in the table.
    ** Signal this by returning NULL.
    */
    return NULL;
}

/*
** free_table iterates the table, calling this repeatedly to free
** each individual node. This, in turn, calls one or two other
** functions - one to free the storage used for the key, the other
** passes a pointer to the data back to a function defined by the user,
** process the data as needed.
*/
static void free_node(char *key, void *data)
{
    (void) data;
    if (function)
    function(del(key,the_table));
    else del(key,the_table);
}

/*
** Frees a complete table by iterating over it and freeing each node.
** the second parameter is the address of a function it will call with a
** pointer to the data associated with each node. This function is
** responsible for freeing the data, or doing whatever is needed with
** it.
*/
void free_table(hash_table *table, void (*func)(void *))
{
    function = func;
    the_table = table;
    enumerate( table, free_node);
    free(table->table);
    table->table = NULL;
    table->size = 0;
    the_table = NULL;
    function = (void (*)(void *))NULL;
}

/*
** Simply invokes the function given as the second parameter for each
** node in the table, passing it the key and the associated data.
*/
void enumerate( hash_table *table, void (*func)(char *, void *))
{
    unsigned i;
    bucket *temp;

    for (i=0;i<table->size; i++)
    {
        if ((table->table)[i] != NULL)
        {
            for (temp = (table->table)[i]; NULL != temp; temp = temp -> next)
            {
                func(temp -> key, temp->data);
            }
        }
    }
}

#ifdef TEST
#include <stdio.h>
void printer(char *string, void *data)
{
    printf("%s: %s\n", string, (char *)data);
}

int main(void)
{
    hash_table table;


        char *strings[] = {
        "The first string",
        "The second string",
        "The third string",
        "The fourth string",
        "A much longer string than the rest in this example.",
        "The last string",
        NULL
    };


        char *junk[] = {
        "The first data",
        "The second data",
        "The third data",
        "The fourth data",
        "The fifth datum",
        "The sixth piece of data"
    };
    int i;
    void *j;
    construct_table(&table,200);

    for (i = 0; NULL != strings[i]; i++ )
        insert(strings[i], junk[i], &table);

    for (i=0;NULL != strings[i];i++)
    {
        printf("\n");
        enumerate(&table, printer);
        del(strings[i],&table);
    }

    for (i=0;NULL != strings[i];i++)
    {
        j = lookup(strings[i], &table);
        if (NULL == j)
        printf("\n'%s' is not in table",strings[i]);
        else printf("\nERROR: %s was deleted but is still in table.",
        strings[i]);
    }
    free_table(&table, NULL);
    return 0;
}

#endif /* TEST */


