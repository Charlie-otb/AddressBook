<?php
function smarty_function_getvaluebyid ($params, &$smarty)
{
    $value = DBUtil::selectFieldByID($params['table'],$params['field'],$params['id']);

    if ($params['assign'])
    $smarty->assign($params['assign'], $value);
    else
    return ($value);
}
