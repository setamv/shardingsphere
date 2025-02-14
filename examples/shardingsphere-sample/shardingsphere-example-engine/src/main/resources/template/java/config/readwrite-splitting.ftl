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
    
    /**
     * Create a DataSource object, which is an object rewritten by ShardingSphere itself 
     * and contains various rules for rewriting the original data storage. When in use, you only need to use this object.
     * @return
     * @throws SQLException
    */
    public DataSource getDataSource() throws SQLException {
        return ShardingSphereDataSourceFactory.createDataSource(createDataSourceMap(), Collections.singleton(createReadwriteSplittingRuleConfiguration()), new Properties());
    }
    
    private ReadwriteSplittingRuleConfiguration createReadwriteSplittingRuleConfiguration() {
        ReadwriteSplittingDataSourceRuleConfiguration dataSourceConfig = new ReadwriteSplittingDataSourceRuleConfiguration(
                "demo_read_query_ds", "", "demo_write_ds", Arrays.asList("demo_read_ds_0", "demo_read_ds_1"), null);
        return new ReadwriteSplittingRuleConfiguration(Collections.singleton(dataSourceConfig), Collections.emptyMap());
    }
    
    private Map<String, DataSource> createDataSourceMap() {
        Map<String, DataSource> result = new HashMap<>(3, 1);
        result.put("demo_write_ds", createDataSource("demo_write_ds"));
        result.put("demo_read_ds_0", createDataSource("demo_read_ds_0"));
        result.put("demo_read_ds_1", createDataSource("demo_read_ds_1"));
        return result;
    }
    