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

package org.apache.shardingsphere.readwritesplitting.route.impl;

import com.google.common.base.Strings;
import lombok.RequiredArgsConstructor;
import org.apache.shardingsphere.infra.aware.DataSourceNameAware;
import org.apache.shardingsphere.infra.aware.DataSourceNameAwareFactory;
import org.apache.shardingsphere.infra.binder.statement.CommonSQLStatementContext;
import org.apache.shardingsphere.infra.binder.statement.SQLStatementContext;
import org.apache.shardingsphere.infra.hint.HintManager;
import org.apache.shardingsphere.transaction.TransactionHolder;
import org.apache.shardingsphere.readwritesplitting.rule.ReadwriteSplittingDataSourceRule;
import org.apache.shardingsphere.sql.parser.sql.common.statement.SQLStatement;
import org.apache.shardingsphere.sql.parser.sql.common.statement.dml.SelectStatement;
import org.apache.shardingsphere.sql.parser.sql.dialect.handler.dml.SelectStatementHandler;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Optional;

/**
 * Data source router for readwrite-splitting.
 */
@RequiredArgsConstructor
public final class ReadwriteSplittingDataSourceRouter {
    
    private final ReadwriteSplittingDataSourceRule rule;
    
    /**
     * Route.
     * 
     * @param sqlStatementContext SQL statement context
     * @return data source name
     */
    public String route(final SQLStatementContext<?> sqlStatementContext) {
        if (isPrimaryRoute(sqlStatementContext)) {
            String autoAwareDataSourceName = rule.getAutoAwareDataSourceName();
            if (Strings.isNullOrEmpty(autoAwareDataSourceName)) {
                return rule.getWriteDataSourceName();
            }
            Optional<DataSourceNameAware> dataSourceNameAware = DataSourceNameAwareFactory.getInstance().getDataSourceNameAware();
            if (dataSourceNameAware.isPresent()) {
                return dataSourceNameAware.get().getPrimaryDataSourceName(autoAwareDataSourceName);
            }
        }
        String autoAwareDataSourceName = rule.getAutoAwareDataSourceName();
        if (Strings.isNullOrEmpty(autoAwareDataSourceName)) {
            return rule.getLoadBalancer().getDataSource(rule.getName(), rule.getWriteDataSourceName(), rule.getReadDataSourceNames());
        }
        Optional<DataSourceNameAware> dataSourceNameAware = DataSourceNameAwareFactory.getInstance().getDataSourceNameAware();
        if (dataSourceNameAware.isPresent()) {
            Collection<String> replicaDataSourceNames = dataSourceNameAware.get().getReplicaDataSourceNames(autoAwareDataSourceName);
            return rule.getLoadBalancer().getDataSource(rule.getName(), rule.getWriteDataSourceName(), new ArrayList<>(replicaDataSourceNames));
        }
        return rule.getLoadBalancer().getDataSource(rule.getName(), rule.getWriteDataSourceName(), rule.getReadDataSourceNames());
    }
    
    private boolean isPrimaryRoute(final SQLStatementContext<?> sqlStatementContext) {
        SQLStatement sqlStatement = sqlStatementContext.getSqlStatement();
        return containsLockSegment(sqlStatement) || !(sqlStatement instanceof SelectStatement) || isHintWriteRouteOnly(sqlStatementContext) || TransactionHolder.isTransaction();
    }
    
    private boolean isHintWriteRouteOnly(final SQLStatementContext<?> sqlStatementContext) {
        return HintManager.isWriteRouteOnly() || (sqlStatementContext instanceof CommonSQLStatementContext && ((CommonSQLStatementContext<?>) sqlStatementContext).isHintWriteRouteOnly());
    }
    
    private boolean containsLockSegment(final SQLStatement sqlStatement) {
        return sqlStatement instanceof SelectStatement && SelectStatementHandler.getLockSegment((SelectStatement) sqlStatement).isPresent();
    }
}
