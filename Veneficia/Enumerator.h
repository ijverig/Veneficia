//
//  Enumerator.h
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 12/04/14.
//  Copyright (c) 2014 Veneficia. All rights reserved.
//

#ifndef Veneficia_Enumerator_h
#define Veneficia_Enumerator_h

/////////////////////////////////
// DEFINIÇÃO DOS CONTATOS

typedef enum : uint32_t
{
    GOOD_GUY = 0x1 << 0,
    BAD_GUY = 0x1 << 1,
    MAP = 0x1 << 2,
    POWER = 0x1 << 3,
    DOODADS = 0x1 << 4,
    WORLD = 0x1 << 5

    
}BIT_MASK;




#endif
