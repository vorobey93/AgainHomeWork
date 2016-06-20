extern "C" {
#include <stdlib.h>
#include <Python.h>
#include <lualib.h>
#include <string.h>
#include <lua.h>
#include <lauxlib.h>
}


static PyObject * eval_lua(PyObject* module, PyObject* args)
{

	char* str_prog;

	if (!PyArg_ParseTuple(args, "s", &str_prog)) 
	{
		printf("Error, error, error. No program found");
		return NULL;
	}

   
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);
    
    int err_log = luaL_dostring(L,str_prog);
    
    if (err_log != 0)
    {
    	printf("Lua program error:" + lua_tostring(L,-1));
    	return NULL;
    }
    
    int luaReturn = lua_type(L,-1);
    
    switch ( luaReturn) 
    {
    	case -1: { Py_RETURN_NONE; }
    	case 0: { Py_RETURN_NONE; }
    	case 1 : {
    		if (lua_toboolean(L,-1))
    			Py_RETURN_TRUE;
    	}
    	case 3 : {
    		PyObject* p = PyFloat_FrimDouble(lua_tonumber(L,-1));
    		Py_INCREF(p);
    		return p;
    	}
    	case 4 : {
    		const char* lua_str = lua_tostring(L,-1);
    		PyObject* p = PyBytes_FromString(lua_str);
    		Py_INCREF(p);
    		return p;
    	
    	}
    	default: Py_RETURN_NONE;
    }
}

PyMODINIT_FUNC PyInit_lua(void)
{
    static PyMethodDef LuaMethods[] = {
        { "eval", eval_lua, METH_VARARGS, "Lua Evaluation" },
        { NULL, NULL, 0, NULL }
    };
    static struct PyModuleDef ModuleDef = {
        PyModuleDef_HEAD_INIT,
        "lua",
        "Lua Evaluation",
            -1, LuaMethods};

    return PyModule_Create(&ModuleDef);
}