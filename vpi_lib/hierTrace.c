/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

#include "vpiDebug.h"

void reportObject( char* head, vpiHandle obj )
{
    switch ( vpi_get( vpiType, obj ) )
    {
        case vpiModule:
        {
            vpi_printf( "%smodule %s <%s> [%s:%d]:\n", head, vpi_get_str( vpiDefName, obj ),
                                                             vpi_get_str( vpiName, obj ),
                                                             vpi_get_str( vpiFile, obj ),
                                                             vpi_get( vpiLineNo, obj ) );
            break;
        }
        case vpiPort:
        {
            vpi_printf( "%sport <%s>:\n", head, vpi_get_str( vpiName, obj ) );

            break;
        }
        case vpiGate:
        case vpiSwitch:
        case vpiUdp:
        {
            vpi_printf( "%s%s %s <%s>:\n", head, objectName( obj ),
                                                 vpi_get_str( vpiDefName, obj ),
                                                 vpi_get_str( vpiName, obj ) );

            break;
        }
        case vpiPrimTerm:
        {
            vpi_printf( "%sprim term %d:\n", head, vpi_get( vpiTermIndex, obj ) );

            break;
        }
        case vpiOperation:
        {
            vpi_printf( "%soperation (%s):\n", head, operationName( obj ) );

            break;
        }
        case vpiPartSelect:
        {
            vpi_printf( "%spart select:\n", head );

            break;
        }
        case vpiNet:
        case vpiNetBit:
        case vpiReg:
        case vpiRegBit:
        {
            vpi_printf( "%s%s <%s>:\n", head, objectName( obj ),
                                              vpi_get_str( vpiName, obj ) );
 
            break;
        }
        default:
        {
            vpi_printf( "%sunknown: type %d at %s:%d\n", head, vpi_get( vpiType, obj ),
                                                               vpi_get_str( vpiFile, obj ),
                                                               vpi_get( vpiLineNo, obj ) );
 
            break;
        }
    }
}

void hierTrace( int level, vpiHandle obj, int ( *cback )( ), void* userData )
{
    if ( obj == 0 )
    {
        vpi_printf( "Bummer, dude, a null pointer...\n" ); return;
    }
 
    /*
     *  Report what we just found (assuming trace debug is enabled)
     */
    if ( DbgTrace ) reportObject( makeSpace( ++level ), obj );

    /*
     *  Inform user and abort (if so instructed)...
     */
    if ( cback && ( *cback )( level, obj, userData ) ) return;

    /*
     *  ...or continue at this level if that be our destiny
     */
    hierTraceCont( level, obj, cback, userData );
}

void hierTraceCont( int level, vpiHandle obj, int ( *cback )( ), void* userData )
{
    vpiHandle ptr, itr; /* general use */

    #define ITER( a, b ) if ( itr = vpi_iterate( a, b ) ) while ( ptr = vpi_scan( itr ) )

    /*
     *  Iterate downward according to the object type
     */
    switch ( vpi_get( vpiType, obj ) )
    {
        case vpiModule:
        {
            ITER( vpiPort, obj )      hierTrace( level, ptr, cback, userData );
            ITER( vpiNet, obj )       hierTrace( level, ptr, cback, userData );
            ITER( vpiReg, obj )       hierTrace( level, ptr, cback, userData );
            ITER( vpiModule, obj )    hierTrace( level, ptr, cback, userData );
            ITER( vpiPrimitive, obj ) hierTrace( level, ptr, cback, userData );

            break;
        }
        case vpiPort:
        {
            DBG_TRACE(( "%shiconn:\n", makeSpace( ++level ) ));

            hierTrace( level, vpi_handle( vpiHighConn, obj ), cback, userData );

            DBG_TRACE(( "%sloconn:\n", makeSpace( level ) ));

            hierTrace( level, vpi_handle( vpiLowConn, obj ), cback, userData );

            break;
        }
        case vpiGate:
        case vpiUdp:
        {
            ITER( vpiPrimTerm, obj )  hierTrace( level, ptr, cback, userData );

            break;
        }
        case vpiPrimTerm:
        {
            DBG_TRACE(( "%shiconn:\n", makeSpace( ++level ) ));

            hierTrace( level, vpi_handle( vpiExpr, obj ), cback, userData );

            break;
        }
        case vpiOperation:
        {
            ITER( vpiOperand, obj )  hierTrace( level, ptr, cback, userData );

            break;
        }
        case vpiPartSelect:
        {
            DBG_TRACE(( "%sparent:\n", makeSpace( ++level ) ));

            hierTrace( level, vpi_handle( vpiParent, obj ), cback, userData );

            DBG_TRACE(( "%sleft range:\n", makeSpace( ++level ) ));

            hierTrace( level, vpi_handle( vpiLeftRange, obj ), cback, userData );

            DBG_TRACE(( "%sright range:\n", makeSpace( ++level ) ));

            hierTrace( level, vpi_handle( vpiRightRange, obj ), cback, userData );

            break;
        }
        case vpiNet:
        case vpiNetBit:
        case vpiReg:
        case vpiRegBit:
        case vpiForce:
        {
            break; /* these have no heirarchy */
        }
        default:
        {
            /*
             *  If this error shows up for an un-tracable construct,
             *  add the type of the offending construct to the null
             *  case statement above.
             */
            vpi_printf( "Can't follow unknown type %d at %s:%d\n", vpi_get( vpiType, obj ),
                                                                   vpi_get_str( vpiFile, obj ),
                                                                   vpi_get( vpiLineNo, obj ) );
 
            break;
        }
    }
}
