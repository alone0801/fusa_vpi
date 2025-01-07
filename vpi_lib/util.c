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
#include "vpi_user.h"
char* objectName( vpiHandle obj )
{
    switch ( vpi_get( vpiType, obj ) )
    {
        case vpiAlways:        return( "always" );
        case vpiAssignStmt:    return( "quasi-continuous assignment" );
        case vpiAssignment:    return( "assignment" );
        case vpiBegin:         return( "begin block" );
        case vpiCase:          return( "case statement" );
        case vpiCaseItem:      return( "case item" );
        case vpiConstant:      return( "constant/string" );
        case vpiContAssign:    return( "continuous assign" );
        case vpiDeassign:      return( "deassignment" );
        case vpiDefParam:      return( "defparam" );
        case vpiDelayControl:  return( "delay control" );
        case vpiDisable:       return( "named block disable" );
        case vpiEventControl:  return( "event control" );
        case vpiEventStmt:     return( "event trigger" );
        case vpiFor:           return( "for" );
        case vpiForce:         return( "force" );
        case vpiForever:       return( "forever" );
        case vpiFork:          return( "fork-join" );
        case vpiFuncCall:      return( "function call" );
        case vpiFunction:      return( "function" );
        case vpiGate:          return( "primitive gate" );
        case vpiIf:            return( "if" );
        case vpiIfElse:        return( "if-else" );
        case vpiInitial:       return( "initial" );
        case vpiIntegerVar:    return( "integer variable" );
        case vpiInterModPath:  return( "intermodule wire delay" );
        case vpiIterator:      return( "iterator" );
        case vpiIODecl:        return( "i/o declaration" );
        case vpiMemory:        return( "memory" );
        case vpiMemoryWord:    return( "memory word" );
        case vpiModPath:       return( "module path" );
        case vpiModule:        return( "module" );
        case vpiNamedBegin:    return( "named block" );
        case vpiNamedEvent:    return( "event variable" );
        case vpiNamedFork:     return( "named fork-join" );
        case vpiNet:           return( "net" );
        case vpiNetBit:        return( "net bit" );
        case vpiNullStmt:      return( "null statement" );
        case vpiOperation:     return( "operation" );
        case vpiParamAssign:   return( "parameter assignment" );
        case vpiParameter:     return( "parameter" );
        case vpiPartSelect:    return( "part select" );
        case vpiPathTerm:      return( "path terminal" );
        case vpiPort:          return( "port" );
        case vpiPortBit:       return( "port bit" );
        case vpiPrimTerm:      return( "primitive terminal" );
        case vpiRealVar:       return( "real variable" );
        case vpiReg:           return( "reg" );
        case vpiRegBit:        return( "reg bit" );
        case vpiRelease:       return( "release" );
        case vpiRepeat:        return( "repeat" );
        case vpiRepeatControl: return( "repeat control" );
        case vpiSchedEvent:    return( "vpi_put_value event" );
        case vpiSpecParam:     return( "specparam" );
        case vpiSwitch:        return( "switch" );
        case vpiSysFuncCall:   return( "sys function call" );
        case vpiSysTaskCall:   return( "sys task call" );
        case vpiTableEntry:    return( "UDP table entry" );
        case vpiTask:          return( "task" );
        case vpiTaskCall:      return( "task call" );
        case vpiTchk:          return( "timing check" );
        case vpiTchkTerm:      return( "timing check terminal" );
        case vpiTimeVar:       return( "time variable" );
        case vpiTimeQueue:     return( "simulation event queue" );
        case vpiUdp:           return( "udp" );
        case vpiUdpDefn:       return( "udp definition" );
        case vpiUserSystf:     return( "user system tf" );
        case vpiVarSelect:     return( "variable array selection" );
        case vpiWait:          return( "wait" );
        case vpiWhile:         return( "while" );

        default:               return( "unknown" );
    }
}

char* operationName( vpiHandle obj )
{
    switch ( vpi_get( vpiOpType, obj ) )
    {
        case vpiMinusOp:       return( "unary minus" );
        case vpiPlusOp:        return( "unary plus" );
        case vpiNotOp:         return( "unary not" );
        case vpiBitNegOp:      return( "bitwise negation" );
        case vpiUnaryAndOp:    return( "bitwise reduction and" );
        case vpiUnaryNandOp:   return( "bitwise reduction nand" );
        case vpiUnaryOrOp:     return( "bitwise reduction or" );
        case vpiUnaryNorOp:    return( "bitwise reduction nor" );
        case vpiUnaryXorOp:    return( "bitwise reduction xor" );
        case vpiUnaryXNorOp:   return( "bitwise reduction xnor" );
        case vpiSubOp:         return( "binary subtraction" );
        case vpiDivOp:         return( "binary division" );
        case vpiModOp:         return( "binary modulus" );
        case vpiEqOp:          return( "binary equality" );
        case vpiNeqOp:         return( "binary inequality" );
        case vpiCaseEqOp:      return( "case (x and z) equality" );
        case vpiCaseNeqOp:     return( "case inequality" );
        /*case vpiWildEqOp:      return( "wild equality" ); */
        /*case vpiWildNeqOp:     return( "wild inequality" ); */
        case vpiGtOp:          return( "binary greater than" );
        case vpiGeOp:          return( "binary greater than or equal" );
        case vpiLtOp:          return( "binary less than" );
        case vpiLeOp:          return( "binary less than or equal" );
        case vpiLShiftOp:      return( "binary left shift" );
        case vpiRShiftOp:      return( "binary right shift" );
        case vpiAddOp:         return( "binary addition" );
        case vpiMultOp:        return( "binary multiplication" );
        case vpiLogAndOp:      return( "binary logical and" );
        case vpiLogOrOp:       return( "binary logical or" );
        case vpiBitAndOp:      return( "binary bitwise and" );
        case vpiBitOrOp:       return( "binary bitwise or" );
        case vpiBitXorOp:      return( "binary bitwise xor" );
        case vpiBitXnorOp:     return( "binary bitwise xnor" );
        case vpiConditionOp:   return( "ternary conditional" );
        case vpiConcatOp:      return( "n ary concatenation" );
        case vpiMultiConcatOp: return( "repeated concatenation" );
        case vpiEventOrOp:     return( "event or" );
        case vpiNullOp:        return( "null operation" );
        case vpiListOp:        return( "list of expressions" );
        case vpiMinTypMaxOp:   return( "min:typ:max delay expression" );
        case vpiPosedgeOp:     return( "posedge" );
        case vpiNegedgeOp:     return( "negedge" );
        case vpiArithLShiftOp: return( "arithmetic left shift" );
        case vpiArithRShiftOp: return( "arithmetic right shift" );
        case vpiPowerOp:       return( "arithmetic power op" );

        default:               return( "unknown" );
    }
}

char* gateName( vpiHandle obj )
{
    switch ( vpi_get( vpiPrimType, obj ) )
    {
        case vpiAndPrim:       return( "and gate" );
        case vpiNandPrim:      return( "nand gate" );
        case vpiNorPrim:       return( "nor gate" );
        case vpiOrPrim:        return( "or gate" );
        case vpiXorPrim:       return( "xor gate" );
        case vpiXnorPrim:      return( "xnor gate" );
        case vpiBufPrim:       return( "buffer" );
        case vpiNotPrim:       return( "not gate" );
        case vpiBufif0Prim:    return( "zero-enabled buffer" );
        case vpiBufif1Prim:    return( "one-enabled buffer" );
        case vpiNotif0Prim:    return( "zero-enabled not gate" );
        case vpiNotif1Prim:    return( "one-enabled not gate" );
        case vpiNmosPrim:      return( "nmos switch" );
        case vpiPmosPrim:      return( "pmos switch" );
        case vpiCmosPrim:      return( "cmos switch" );
        case vpiRnmosPrim:     return( "resistive nmos switch" );
        case vpiRpmosPrim:     return( "resistive pmos switch" );
        case vpiRcmosPrim:     return( "resistive cmos switch" );
        case vpiRtranPrim:     return( "resistive bidirectional" );
        case vpiRtranif0Prim:  return( "zero-enable resistive bidirectional" );
        case vpiRtranif1Prim:  return( "one-enable resistive bidirectional" );
        case vpiTranPrim:      return( "bidirectional" );
        case vpiTranif0Prim:   return( "zero-enabled bidirectional" );
        case vpiTranif1Prim:   return( "one-enabled bidirectional" );
        case vpiPullupPrim:    return( "pullup" );
        case vpiPulldownPrim:  return( "pulldown" );
        case vpiSeqPrim:       return( "sequential UDP" );
        case vpiCombPrim:      return( "combinational UDP" );

        default:               return( "unknown" );
    }
}

char* makeSpace( int len )
{
    static char* buff = 0; int size = buff ? strlen( buff ) : 1;

    while ( ( buff == 0 ) || ( len > size ) ) /* generate a block of spaces */
    {
        buff = ( char* )realloc( buff, ( size *= 2 ) + 1 ); sprintf( buff, "%*s", size, "" );
    }
    return( buff + ( size - len ) );
}

/*
 *  Compare the absolute time of two trace_node objects
 */
int nodeTimeCompare( p_trace_node a, p_trace_node b )
{
    if ( a->t_hi < b->t_hi ) return( -1 );
    if ( a->t_hi > b->t_hi ) return(  1 );
 
    if ( a->t_lo < b->t_lo ) return( -1 );
    if ( a->t_lo > b->t_lo ) return(  1 );
 
    return( 0 ); /* equal */
}

/*
 *  Add object to generic list of named objects
 */
void addNewObject( p_object_list* ptr, vpiHandle refn, char* name )
{
    /*
     *  Add new module to the end of the list (preserve sequence)
     */
    while ( *ptr ) ptr = &( ( *ptr )->next );
 
    ( *ptr ) = ( p_object_list )malloc( sizeof( s_object_list ) );
 
    ( *ptr )->refn = refn;
    ( *ptr )->name = strdup( name );
 
    ( *ptr )->next = ( p_object_list )0;
}
