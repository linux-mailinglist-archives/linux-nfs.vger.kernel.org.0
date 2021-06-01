Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0039792D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jun 2021 19:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFARiU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 13:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhFARiU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Jun 2021 13:38:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9012D6008E;
        Tue,  1 Jun 2021 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622568998;
        bh=KmFkLQs6oz5M3cuuDAhzij1FpVGUEu5+v+X5VNhQ7/s=;
        h=From:To:Cc:Subject:Date:From;
        b=jDhlXF+fhnAxBZlheH4T7Sz3E/7FqyT1GXUocfS7d2LYNYhZyUJq6nW9nWJGPeJ5S
         MdpDzsaN2+heo9UDjDZsuXXGc4B+kMs3fvqH2oCuq5FX82wyaYn8nVyYKm0jvgZSUR
         +2TJaIKCFO9fVD00oK+QtNj5TS/0I44qJ1y+To8pYZk0Tf5aSJyZkuxOAc/2E3DUQF
         ORH7NuOFefIW53w9pRiXQFW9xjLbHUDzGsc4bl+K9hsyoKdaPa3W6fL/hxMlqg6XT+
         oreEONeGqC3ex5O+HMewjLTt/Gok2M0LeKPQnmiX5ko6OIJAwOtk8I+bq5jOdKa2ED
         RJROwQlo56+dQ==
From:   trondmy@kernel.org
To:     zhangxiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Fix deadlock between nfs4_evict_inode() and nfs4_opendata_get_inode()
Date:   Tue,  1 Jun 2021 13:36:33 -0400
Message-Id: <20210601173634.243152-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the inode is being evicted, but has to return a delegation first,
then it can cause a deadlock in the corner case where the server reboots
before the delegreturn completes, but while the call to iget5_locked() in
nfs4_opendata_get_inode() is waiting for the inode free to complete.
Since the open call still holds a session slot, the reboot recovery
cannot proceed.

In order to break the logjam, we can turn the delegation return into a
privileged operation for the case where we're evicting the inode. We
know that in that case, there can be no other state recovery operation
that conflicts.

Reported-by: zhangxiaoxu (A) <zhangxiaoxu5@huawei.com>
Fixes: 5fcdfacc01f3 ("NFSv4: Return delegations synchronously in evict_inode")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4_fs.h  |  1 +
 fs/nfs/nfs4proc.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 065cb04222a1..543d916f79ab 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -205,6 +205,7 @@ struct nfs4_exception {
 	struct inode *inode;
 	nfs4_stateid *stateid;
 	long timeout;
+	unsigned char task_is_privileged : 1;
 	unsigned char delay : 1,
 		      recovering : 1,
 		      retry : 1;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d671b2884d5a..673809644981 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -589,6 +589,8 @@ int nfs4_handle_exception(struct nfs_server *server, int errorcode, struct nfs4_
 		goto out_retry;
 	}
 	if (exception->recovering) {
+		if (exception->task_is_privileged)
+			return -EDEADLOCK;
 		ret = nfs4_wait_clnt_recover(clp);
 		if (test_bit(NFS_MIG_FAILED, &server->mig_status))
 			return -EIO;
@@ -614,6 +616,8 @@ nfs4_async_handle_exception(struct rpc_task *task, struct nfs_server *server,
 		goto out_retry;
 	}
 	if (exception->recovering) {
+		if (exception->task_is_privileged)
+			return -EDEADLOCK;
 		rpc_sleep_on(&clp->cl_rpcwaitq, task, NULL);
 		if (test_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) == 0)
 			rpc_wake_up_queued_task(&clp->cl_rpcwaitq, task);
@@ -6417,6 +6421,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 	struct nfs4_exception exception = {
 		.inode = data->inode,
 		.stateid = &data->stateid,
+		.task_is_privileged = data->args.seq_args.sa_privileged,
 	};
 
 	if (!nfs4_sequence_done(task, &data->res.seq_res))
@@ -6540,7 +6545,6 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 	data = kzalloc(sizeof(*data), GFP_NOFS);
 	if (data == NULL)
 		return -ENOMEM;
-	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, 0);
 
 	nfs4_state_protect(server->nfs_client,
 			NFS_SP4_MACH_CRED_CLEANUP,
@@ -6571,6 +6575,12 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 		}
 	}
 
+	if (!data->inode)
+		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
+				   1);
+	else
+		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
+				   0);
 	task_setup_data.callback_data = data;
 	msg.rpc_argp = &data->args;
 	msg.rpc_resp = &data->res;
-- 
2.31.1

