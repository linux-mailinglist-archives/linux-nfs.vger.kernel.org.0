Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629BB36F544
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Apr 2021 07:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhD3FJ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Apr 2021 01:09:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41310 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3FJ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Apr 2021 01:09:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13U54WhV128717;
        Fri, 30 Apr 2021 05:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=/1CeB9u0dIOPgCNAFspnXXn17VTmQ1bKeso4x4kIPr8=;
 b=hoq9Z7fLXuu8dqs+3OkXu6BKpJbF+IfjU0ELAO/PhSsgfkuwFge7aelHELtGSR4gg2gl
 TmH5FQ8uUDJI54ZCwaFARF+RhJqSOEnqeIHXIYEJnQgnkBTrQSGr3sD+iG/UsgChxYpX
 yXMBvLN9WnhamFC/dE7ZoNbxg/FY0Na6YhSzXN1qW5sjILbDzaNIYLDgOIXzh7sZ2tvj
 8CWV00LIpU78AZqT0b0RyL1yuphqh3ZW8NT67AqmjV4R9ZzJPD3p7QPqOn1lIXbm+MTY
 DfY7VIsg5O7xvjRYwlQzOj90eQvvD6gujS3IbBoSPZUDbcFNdtPU/RJt3Z/D6k16P+Vd HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 385aeq6f09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 05:09:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13U54uAh036067;
        Fri, 30 Apr 2021 05:09:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3874d4gc7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 05:09:05 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13U595ok047549;
        Fri, 30 Apr 2021 05:09:05 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 3874d4gc6v-1;
        Fri, 30 Apr 2021 05:09:05 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4: can_open_cached needs to be called with so_lock
Date:   Fri, 30 Apr 2021 01:09:00 -0400
Message-Id: <20210430050900.106851-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4KZFg2J8HIWk-4c_eR7nuZVUqiIUJsPc
X-Proofpoint-GUID: 4KZFg2J8HIWk-4c_eR7nuZVUqiIUJsPc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300034
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently can_open_cached accesses the openstate's flags without the
so_lock and also does not update the flags of the cached state. This
results in the openstate's flags be out of sync which can cause the
file to be closed prematurely.

This patch adds the missing so_lock around the call to can_open_cached
and also updates the openstate's flags if the cached openstate is used.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4proc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c65c4b41e2c1..2464e77c51f9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2410,9 +2410,15 @@ static void nfs4_open_prepare(struct rpc_task *task, void *calldata)
 	if (data->state != NULL) {
 		struct nfs_delegation *delegation;
 
+		spin_lock(&data->state->owner->so_lock);
 		if (can_open_cached(data->state, data->o_arg.fmode,
-					data->o_arg.open_flags, claim))
+				data->o_arg.open_flags, claim)) {
+			update_open_stateflags(data->state, data->o_arg.fmode);
+			spin_unlock(&data->state->owner->so_lock);
 			goto out_no_action;
+		}
+		spin_unlock(&data->state->owner->so_lock);
+
 		rcu_read_lock();
 		delegation = nfs4_get_valid_delegation(data->state->inode);
 		if (can_open_delegated(delegation, data->o_arg.fmode, claim))
-- 
2.9.5

