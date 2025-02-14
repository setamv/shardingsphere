/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

lexer grammar Keyword;

import Alphabet;

WS
    : [ \t\r\n] + ->skip
    ;

CREATE
    : C R E A T E
    ;

ALGORITHMS
    : A L G O R I T H M S
    ;

DROP
    : D R O P
    ;

SHARDING
    : S H A R D I N G
    ;

SHOW
    : S H O W
    ;

START
    : S T A R T
    ;

STOP
    : S T O P
    ;

RESET
    : R E S E T
    ;

CHECK
    : C H E C K
    ;

CHECKOUT
    : C H E C K O U T
    ;

SCALING
    : S C A L I N G
    ;

JOB
    : J O B
    ;

LIST
    : L I S T
    ;

STATUS
    : S T A T U S
    ;

SOURCE
    : S O U R C E
    ;

WRITING
    : W R I T I N G
    ;

BY
    : B Y
    ;

TYPE
    : T Y P E
    ;

NAME
    : N A M E
    ;

PROPERTIES
    : P R O P E R T I E S
    ;
