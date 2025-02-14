<#--
  ~ Licensed to the Apache Software Foundation (ASF) under one or more
  ~ contributor license agreements.  See the NOTICE file distributed with
  ~ this work for additional information regarding copyright ownership.
  ~ The ASF licenses this file to You under the Apache License, Version 2.0
  ~ (the "License"); you may not use this file except in compliance with
  ~ the License.  You may obtain a copy of the License at
  ~
  ~     http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  -->

spring.shardingsphere.datasource.names=ds-0

spring.shardingsphere.rules.encrypt.encryptors.phone-encryptor.type=AES
spring.shardingsphere.rules.encrypt.encryptors.phone-encryptor.props.aes-key-value=123456

spring.shardingsphere.rules.encrypt.encryptors.string_encryptor.type=assistedTest

spring.shardingsphere.rules.encrypt.tables.t_order.columns.status.cipher-column=status
spring.shardingsphere.rules.encrypt.tables.t_order.columns.status.assisted-query-column=assisted_query_status
spring.shardingsphere.rules.encrypt.tables.t_order.columns.status.encryptor-name=string_encryptor

spring.shardingsphere.rules.encrypt.tables.t_order_item.columns.phone.cipher-column=phone
spring.shardingsphere.rules.encrypt.tables.t_order_item.columns.phone.plain-column=phone_plain
spring.shardingsphere.rules.encrypt.tables.t_order_item.columns.phone.encryptor-name=phone-encryptor
