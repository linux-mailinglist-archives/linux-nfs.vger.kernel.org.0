Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701B63B4D79
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jun 2021 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFZHrI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Jun 2021 03:47:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5085 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFZHrF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Jun 2021 03:47:05 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GBm3M1KVYzXlMQ;
        Sat, 26 Jun 2021 15:39:27 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:44:41 +0800
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:44:41 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <zhangxiaoxu5@huawei.com>, <trond.myklebust@hammerspace.com>,
        <anna.schumaker@netapp.com>, <bfields@fieldses.org>,
        <chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] SUNRPC: Fix the batch tasks count wraparound.
Date:   Sat, 26 Jun 2021 15:50:41 +0800
Message-ID: <20210626075042.805548-2-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210626075042.805548-1-zhangxiaoxu5@huawei.com>
References: <20210626075042.805548-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The 'queue->nr' will wraparound from 0 to 255 when only current
priority queue has tasks. This maybe lead a deadlock same as commit
dfe1fe75e00e ("NFSv4: Fix deadlock between nfs4_evict_inode()
and nfs4_opendata_get_inode()"):

Privileged delegreturn task is queued to privileged list because all
the slots are assigned. When non-privileged task complete and release
the slot, a non-privileged maybe picked out. It maybe allocate slot
failed when the session on draining.

If the 'queue->nr' has wraparound to 255, and no enough slot to
service it, then the privileged delegreturn will lost to wake up.

So we should avoid the wraparound on 'queue->nr'.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5fcdfacc01f3 ("NFSv4: Return delegations synchronously in evict_inode")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 net/sunrpc/sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 39ed0e0afe6d..37cd09574628 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -595,7 +595,8 @@ static struct rpc_task *__rpc_find_next_queued_priority(struct rpc_wait_queue *q
 	 * Service a batch of tasks from a single owner.
 	 */
 	q = &queue->tasks[queue->priority];
-	if (!list_empty(q) && --queue->nr) {
+	if (!list_empty(q) && queue->nr) {
+		queue->nr -= 1;
 		task = list_first_entry(q, struct rpc_task, u.tk_wait.list);
 		goto out;
 	}
-- 
2.25.4

