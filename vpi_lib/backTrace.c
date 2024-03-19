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

/*
 *  Global debug flags
 */
int backTrace_iteratePorts = 0;

/*
 *  The forward-trace mechanism is used to plod through RTL blocks
 *  looking for a particular statement. When the statement is found,
 *  any objects referenced in surrounding RTL constructs (if, case,
 *  etc) will be back-traced.
 */
static int forwardTrace( int level, p_trace_data data, void* targ, vpiHandle obj, vpiHandle stmt )
{
    char* head = makeSpace( ++level ); /* must be pre-increment */

    #define HEAD makeSpace( level )

    if ( obj == 0 )
    {
        vpi_printf( "Bummer, dude, a null pointer...\n" ); return;
    }

    switch ( vpi_get( vpiType, obj ) )
    {
        case vpiAlways:
        case vpiInitial:
        {
            DBG_TRACE(( "%s>%s:\n", makeSpace( level ), objectName( obj ) ));

            return( forwardTrace( level, data, targ, vpi_handle( vpiStmt, obj ), stmt ) );
        }
        case vpiEventControl:
        {
            DBG_TRACE(( "%s>event control statement:\n", makeSpace( level ) ));

            if ( forwardTrace( level, data, targ, vpi_handle( vpiStmt, obj ), stmt ) )
            {
                DBG_TRACE(( "%s<event control condition:\n", makeSpace( level ) ));

                backTrace( level, data, targ, vpi_handle( vpiCondition, obj ) );

                return( 1 );
            }
            break;
        }
        case vpiDelayControl:
        {
            DBG_TRACE(( "%s>delay control statement:\n", makeSpace( level ) ));

            if ( forwardTrace( level, data, targ, vpi_handle( vpiStmt, obj ), stmt ) )
            {
                DBG_TRACE(( "%s<delay control expression:\n", makeSpace( level ) ));

                backTrace( level, data, targ, vpi_handle( vpiDelay, obj ) );

                return( 1 );
            }
            break;
        }
        case vpiRepeatControl:
        {
            DBG_TRACE(( "%s>repeat control statement:\n", makeSpace( level ) ));

            if ( forwardTrace( level, data, targ, vpi_handle( vpiEventControl, obj ), stmt ) )
            {
                DBG_TRACE(( "%s<repeat control expression:\n", makeSpace( level ) ));

                backTrace( level, data, targ, vpi_handle( vpiDelay, obj ) );

                return( 1 );
            }
            break;
        }
        case vpiFork:
        case vpiBegin:
        case vpiNamedFork:
        case vpiNamedBegin:
        {
            vpiHandle ptr, itr = vpi_iterate( vpiStmt, obj );

            DBG_TRACE(( "%s>%s:\n", makeSpace( level ), objectName( obj ) ));

            while ( itr && ( ptr = vpi_scan( itr ) ) )
            {
                forwardTrace( level, data, targ, ptr, stmt );
            }
            break;
        }
        case vpiIf:
        {
            DBG_TRACE(( "%s>if statement:\n", makeSpace( level ) ));

            if ( forwardTrace( level, data, targ, vpi_handle( vpiStmt, obj ), stmt ) )
            {
                DBG_TRACE(( "%s<if condition:\n", makeSpace( level ) ));

                backTrace( level, data, targ, vpi_handle( vpiCondition, obj ) );

                return( 1 );
            }
            break;
        }
        case vpiIfElse:
        {
            int flag = 0;

            DBG_TRACE(( "%s>if/else true statement:\n", makeSpace( level ) ));

            flag |= forwardTrace( level, data, targ, vpi_handle( vpiStmt, obj ), stmt );

            DBG_TRACE(( "%s>if/else false statement:\n", makeSpace( level ) ));

            flag |= forwardTrace( level, data, targ, vpi_handle( vpiElseStmt, obj ), stmt );

            if ( flag ) /* backtrace if either block contains the given stmt */
            {
                DBG_TRACE(( "%s<if/else condition:\n", makeSpace( level ) ));

                backTrace( level, data, targ, vpi_handle( vpiCondition, obj ) );

                return( 1 );
            }
            break;
        }
        case vpiCase:
        {
            vpiHandle ptr, itr = vpi_iterate( vpiCaseItem, obj );

            DBG_TRACE(( "%s>case statement:\n", makeSpace( level ) ));

            while ( itr && ( ptr = vpi_scan( itr ) ) )
            {
                if ( forwardTrace( level, data, targ, ptr, stmt ) )
                {
                    DBG_TRACE(( "%s<case statement condition:\n", makeSpace( level ) ));

                    backTrace( level, data, targ, vpi_handle( vpiCondition, obj ) );

                    vpi_free_object( itr ); return( 1 ); /* early termination of loop */
                }
            }
            break;
        }
        case vpiCaseItem:
        {
            DBG_TRACE(( "%s>case item:\n", makeSpace( level ) ));

            if ( forwardTrace( level, data, targ, vpi_handle( vpiStmt, obj ), stmt ) )
            {
                DBG_TRACE(( "%s<case item condition:\n", makeSpace( level ) ));

                backTrace( level, data, targ, vpi_handle( vpiExpr, obj ) );

                return( 1 );
            }
            break;
        }
        case vpiWhile:
        {
            DBG_TRACE(( "%s>while statement:\n", makeSpace( level ) ));

            if ( forwardTrace( level, data, targ, vpi_handle( vpiStmt, obj ), stmt ) )
            {
                DBG_TRACE(( "%s<while condition:\n", makeSpace( level ) ));

                backTrace( level, data, targ, vpi_handle( vpiCondition, obj ) );

                return( 1 );
            }
            break;
        }
        case vpiRepeat:
        {
            DBG_TRACE(( "%s>repeat statement:\n", makeSpace( level ) ));

            if ( forwardTrace( level, data, targ, vpi_handle( vpiStmt, obj ), stmt ) )
            {
                DBG_TRACE(( "%s<repeat condition:\n", makeSpace( level ) ));

                backTrace( level, data, targ, vpi_handle( vpiCondition, obj ) );

                return( 1 );
            }
            break;
        }
        case vpiWait:
        {
            DBG_TRACE(( "%s>wait statement:\n", makeSpace( level ) ));

            if ( forwardTrace( level, data, targ, vpi_handle( vpiStmt, obj ), stmt ) )
            {
                DBG_TRACE(( "%s<wait condition:\n", makeSpace( level ) ));

                backTrace( level, data, targ, vpi_handle( vpiCondition, obj ) );

                return( 1 );
            }
            break;
        }
        case vpiAssignment:
        {
            int flag = vpi_compare_objects( obj, stmt );

            DBG_TRACE(( "%s>rtl-assignment %s\n", makeSpace( level ), flag ? "<==" : "" ));

            return( flag );
        }
        case vpiEventStmt:
        {
            int flag = vpi_compare_objects( obj, stmt );

            DBG_TRACE(( "%s>event-trigger %s\n", makeSpace( level ), flag ? "<==" : "" ));

            return( flag );
        }
        default: /* report unknown type and where found */
        {
            DBG_TRACE(( "%s>unknown: type %d (%s) at %s:%d\n", makeSpace( level ),
                                                               vpi_get( vpiType, obj ),
                                                               objectName( obj ),
                                                               vpi_get_str( vpiFile, obj ),
                                                               vpi_get( vpiLineNo, obj ) ));

            break;
        }
    }
    return( 0 );
}

/*
 *  The back-trace mechanism follows the assumed path of causality
 *  looking for all possible contributors to events on the object
 *  of interest. When the trace enters a block of RTL code, the
 *  RTL block is forward-traced from the top in order to identify
 *  the block inputs that could have a bearing on the value of the
 *  object in question (the forward-trace is not fool-proof).
 */
void backTrace( int level, p_trace_data data, void* targ, vpiHandle obj )
{
    char* head = makeSpace( ++level ); /* must be pre-increment */

    #define HEAD makeSpace( level )

    if ( obj == 0 )
    {
        vpi_printf( "Bummer, dude, a null pointer...\n" ); return;
    }

    switch ( vpi_get( vpiType, obj ) )
    {
        case vpiConstant:
        {
            DBG_TRACE(( "%sconstant:\n", HEAD ));
            /*
            DBG_TRACE(( "%sconstant (%s:%d):\n", HEAD, vpi_get( vpiFile, obj ),
                                                       vpi_get( vpiLineNo, obj ) ));
            */

#if 0 /* manhole */

            /*
             *  Protection against looping
             */
            if ( data->fnCheckForLoop && ( *( data->fnCheckForLoop ) )( obj, "<const>" ) )
            {
                DBG_TRACE(( "%s...loop detected...\n", head ));

                if ( data->fnLoopDetected )
                {
                    targ = ( *( data->fnLoopDetected ) )( obj, "<const>", targ );
                }
            }
            else
            {
                if ( data->fnInstallTrace )
                {
                    targ = ( *( data->fnInstallTrace ) )( obj, "<const>", targ );
                }
            }

#endif /* manhole */

            break;
        }
        case vpiNet:
        case vpiNetBit:
        {
            int iterWhat = backTrace_iteratePorts ? vpiPortInst : vpiDriver;

            vpiHandle drv, itr = vpi_iterate( iterWhat, obj );

            char* name = FullName( obj );

            DBG_TRACE(( "%snet: <%s>\n", head, name ));

            /*
             *  Protection against looping
             */
            if ( data->fnCheckForLoop && ( *( data->fnCheckForLoop ) )( obj, name ) )
            {
                DBG_TRACE(( "%s...loop detected...\n", head ));

                if ( data->fnLoopDetected )
                {
                    targ = ( *( data->fnLoopDetected ) )( obj, name, targ );
                }
            }
            else /* new node found */
            {
                if ( data->fnInstallTrace )
                {
                    targ = ( *( data->fnInstallTrace ) )( obj, name, targ );
                }

                while ( itr && ( drv = vpi_scan( itr ) ) ) backTrace( level, data, targ, drv );
            }
            break;
        }
        case vpiReg:
        case vpiRegBit:
        {
            int iterWhat = backTrace_iteratePorts ? vpiPortInst : vpiDriver;

            vpiHandle drv, itr = vpi_iterate( iterWhat, obj );

            char* name = FullName( obj );

            DBG_TRACE(( "%sreg: <%s>\n", head, name ));

            /*
             *  Protection against looping
             */
            if ( data->fnCheckForLoop && ( *( data->fnCheckForLoop ) )( obj, name ) )
            {
                DBG_TRACE(( "%s...loop detected...\n", head ));

                if ( data->fnLoopDetected )
                {
                    targ = ( *( data->fnLoopDetected ) )( obj, name, targ );
                }
            }
            else /* new node found */
            {
                if ( data->fnInstallTrace )
                {
                    targ = ( *( data->fnInstallTrace ) )( obj, name, targ );
                }

                while ( itr && ( drv = vpi_scan( itr ) ) ) backTrace( level, data, targ, drv );
            }
            break;
        }
        case vpiPort:
        case vpiPortBit:
        {
            char* name = 0; /* vpi_get_str( vpiName, obj );  */

            if ( name == 0 ) name = "<null>";

vpi_printf( "port/portbit direction = %d\n", vpi_get( vpiDirection, obj ) );

            if ( vpi_get( vpiDirection, obj ) == vpiOutput )
            {
                DBG_TRACE(( "%soutput port (%s):\n", makeSpace( level ), name ));

                backTrace( level, data, targ, vpi_handle( vpiLowConn, obj ) );
            }

            if ( vpi_get( vpiDirection, obj ) == vpiInput )
            {
                DBG_TRACE(( "%sinput port (%s):\n", makeSpace( level ), name ));

                backTrace( level, data, targ, vpi_handle( vpiHighConn, obj ) );
            }

            if ( vpi_get( vpiDirection, obj ) == vpiInout )
            {
                DBG_TRACE(( "%sinout port (%s), hiconn:\n", makeSpace( level ), name ));

                backTrace( level, data, targ, vpi_handle( vpiHighConn, obj ) );

                DBG_TRACE(( "%sinout port (%s), loconn:\n", makeSpace( level ), name ));

                backTrace( level, data, targ, vpi_handle( vpiLowConn, obj ) );
            }
            break;
        }
        case vpiContAssign:
        {
            DBG_TRACE(( "%scontinuous assignment rhs:\n", makeSpace( level ) ));

            backTrace( level, data, targ, vpi_handle( vpiRhs, obj ) );

            break;
        }
        case vpiAssignment:
        {
            DBG_TRACE(( "%srtl-assignment (block):\n", makeSpace( level ) ));

            forwardTrace( level, data, targ, vpi_handle( vpiProcess, obj ), obj );

            DBG_TRACE(( "%srtl-assignment rhs:\n", makeSpace( level ) ));

            backTrace( level, data, targ, vpi_handle( vpiRhs, obj ) );

            break;
        }
        case vpiEventStmt:
        {
            DBG_TRACE(( "%sevent-trigger (block):\n", makeSpace( level ) ));

            forwardTrace( level, data, targ, vpi_handle( vpiProcess, obj ), obj );

            break;
        }
        case vpiOperation:
        {
            vpiHandle drv, itr = vpi_iterate( vpiOperand, obj );

            DBG_TRACE(( "%soperation (%s):\n", head, operationName( obj ) ));

            while ( itr && ( drv = vpi_scan( itr ) ) ) backTrace( level, data, targ, drv );

            break;
        }
        case vpiPartSelect:
        {
            DBG_TRACE(( "%spart select (lowRange):\n", makeSpace( level ) ));

            backTrace( level, data, targ, vpi_handle( vpiLeftRange, obj ) );

            DBG_TRACE(( "%spart select (highRange):\n", makeSpace( level ) ));

            backTrace( level, data, targ, vpi_handle( vpiRightRange, obj ) );

            DBG_TRACE(( "%spart select (parent object):\n", makeSpace( level ) ));

            backTrace( level, data, targ, vpi_handle( vpiParent, obj ) );

            break;
        }
        case vpiContAssignBit:
        {
            DBG_TRACE(( "%scont assign bit:\n", makeSpace( level ) ));

            backTrace( level, data, targ, vpi_handle( vpiRhs, obj ) );

            break;
        }
        case vpiUdp:
        case vpiGate:
        case vpiSwitch:
        {
            vpiHandle pin, itr = vpi_iterate( vpiPrimTerm, obj );

            DBG_TRACE(( "%s%s (%s):\n", makeSpace( level ), objectName( obj ), gateName( obj ) ));

            while ( itr && ( pin = vpi_scan( itr ) ) )
            {
                DBG_TRACE(( "%spin %d:\n", makeSpace( level ), vpi_get( vpiTermIndex, pin ) ));

                if ( vpi_get( vpiDirection, pin ) == vpiInput ) backTrace( level, data, targ, pin );
            }
            break;
        }
        case vpiPrimTerm:
        {
            if ( vpi_get( vpiDirection, obj ) == vpiOutput )
            {
                DBG_TRACE(( "%sprim output:\n", head ));

                backTrace( level, data, targ, vpi_handle( vpiPrimitive, obj ) );
            }

            if ( vpi_get( vpiDirection, obj ) == vpiInput )
            {
                DBG_TRACE(( "%sprim input:\n", head ));

                backTrace( level, data, targ, vpi_handle( vpiExpr, obj ) );
            }
            break;
        }
        case vpiFuncCall:
        {
            DBG_TRACE(( "%sfunction call (%s)\n", makeSpace( level ), vpi_get_str( vpiName, obj ) ));

            /*
            backTrace( level, data, targ, vpi_handle( vpiFunction, obj ) );
            */

            break;
        }
        case vpiFunction:
        {
            DBG_TRACE(( "%sfunction (%s)\n", makeSpace( level ), vpi_get_str( vpiName, obj ) ));

            break;
        }
        case vpiForce:
        case vpiAssignStmt:
        {
            DBG_TRACE(( "%s%s (follow rhs)\n", makeSpace( level ), objectName( obj ) ));

/*
            backTrace( level, data, targ, vpi_handle( vpiRhs, obj ) );
*/

            break;
        }
        case vpiRelease:
        case vpiDeassign:
        {
            DBG_TRACE(( "%s%s\n", makeSpace( level ), objectName( obj ) ));

            break;
        }
        default: /* report unknown type and where found */
        {
            DBG_TRACE(( "%sunknown: type %d (%s) at %s:%d\n", makeSpace( level ),
                                                              vpi_get( vpiType, obj ),
                                                              objectName( obj ),
                                                              vpi_get_str( vpiFile, obj ),
                                                              vpi_get( vpiLineNo, obj ) ));

            break;
        }
    }
}
