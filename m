Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15BB430527
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbhJPWFI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235616AbhJPWFH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:05:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4E4660EE9;
        Sat, 16 Oct 2021 22:02:58 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 6/7] SUNRPC: Trace calls to .rpc_call_done
Date:   Sat, 16 Oct 2021 18:02:57 -0400
Message-Id:  <163442177754.1585.5840349306714736549.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
References:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5603; h=from:subject:message-id; bh=u10Cv/Zc4BbSfP51ipbDMeZmXW6FIPjDZTzR66hjdf8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha0wRYMNuy2nqJenhab2+r75jBsGcQ0EZzOGIkeQ7 iWI3IxuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtMEQAKCRAzarMzb2Z/l3NZD/ 9G7KRsXNLyUwPJVyUWcOa80uc9tnPxhrBEQ2iWf+EogePflhtPuEJTTUi8atw1rCtdesWAA9zKZmnI b0Ip2lPVFXcxClqjMWC9KSo1Fbf1QXvOdcRmPlntV3alxs3LpI43BCR96qOqbO6QqnX8dXCIM95KBZ jjFmKv0dHVyPHQsawOQHy9PV7mTC0DHlB156LgCTiA6uGyQ/sksnNmkAy0f6Te3sZtMi2PhN1CdCWo x5SxyU5tBQUQvGLoO9UxNtxeEG4CtQdC36/GBUfxVGsd+ITMLfHo36Q7cJw8A55OHWWpMdW0R3lXCF lm85hSLQ35r8h5s7mXzSLJzLz7BAQr5Spt7RxZmeKRWgfH9VFncaLHsRaugeX9KKGOeQ/pMBnHQLeQ 7BUZvxPbPdYHizmUOEs7X0RsfLF6mzfMDRhYPMti1oU9vSKflMZGyU4NHDX5SoirkgK2z6mZS6FXZ0 t5HhwtJCKPwd6+ONfx9LrLK4qC+JBsTJWV/Y41tKmszRClxDrT4Cq4FE9u5D7iAqnAhZNO9TXnoR77 bvGJEE0yICVXgRJX4ndZTImUl2EemcFdL8LgJ+Ji6+eXV/BCtD6YOr8WhBgwydhUZ15esTvnlQd2yr WDgylTClDPrFHPPdWAuvdtzXcCgzzwAFmDYtqwRBs0sILZmxMRsIrUIn8g7Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce a single tracepoint that can replace simple dprintk call
sites in upper layer "rpc_call_done" callbacks. Example:

   kworker/u24:2-1254  [001]   771.026677: rpc_stats_latency:    task:00000001@00000002 xid=0x16a6f3c0 rpcbindv2 GETPORT backlog=446 rtt=101 execute=555
   kworker/u24:2-1254  [001]   771.026677: rpc_task_call_done:   task:00000001@00000002 flags=ASYNC|DYNAMIC|SOFT|SOFTCONN|SENT runstate=RUNNING|ACTIVE status=0 action=rpcb_getport_done
   kworker/u24:2-1254  [001]   771.026678: rpcb_setport:         task:00000001@00000002 status=0 port=20048

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clntproc.c                    |    3 ---
 fs/lockd/svc4proc.c                    |    2 --
 fs/lockd/svcproc.c                     |    2 --
 fs/nfs/filelayout/filelayout.c         |    2 --
 fs/nfs/flexfilelayout/flexfilelayout.c |    2 --
 fs/nfs/pagelist.c                      |    3 ---
 fs/nfs/write.c                         |    3 ---
 include/trace/events/sunrpc.h          |    1 +
 net/sunrpc/sched.c                     |    1 +
 9 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index b11f2afa84f1..99fffc9cb958 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -794,9 +794,6 @@ static void nlmclnt_cancel_callback(struct rpc_task *task, void *data)
 		goto retry_cancel;
 	}
 
-	dprintk("lockd: cancel status %u (task %u)\n",
-			status, task->tk_pid);
-
 	switch (status) {
 	case NLM_LCK_GRANTED:
 	case NLM_LCK_DENIED_GRACE_PERIOD:
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index e10ae2c41279..176b468a61c7 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -269,8 +269,6 @@ nlm4svc_proc_granted(struct svc_rqst *rqstp)
  */
 static void nlm4svc_callback_exit(struct rpc_task *task, void *data)
 {
-	dprintk("lockd: %5u callback returned %d\n", task->tk_pid,
-			-task->tk_status);
 }
 
 static void nlm4svc_callback_release(void *data)
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 99696d3f6dd6..4dc1b40a489a 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -301,8 +301,6 @@ nlmsvc_proc_granted(struct svc_rqst *rqstp)
  */
 static void nlmsvc_callback_exit(struct rpc_task *task, void *data)
 {
-	dprintk("lockd: %5u callback returned %d\n", task->tk_pid,
-			-task->tk_status);
 }
 
 void nlmsvc_release_call(struct nlm_rqst *call)
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index d2103852475f..9c96e3e5ed35 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -293,8 +293,6 @@ static void filelayout_read_call_done(struct rpc_task *task, void *data)
 {
 	struct nfs_pgio_header *hdr = data;
 
-	dprintk("--> %s task->tk_status %d\n", __func__, task->tk_status);
-
 	if (test_bit(NFS_IOHDR_REDO, &hdr->flags) &&
 	    task->tk_status == 0) {
 		nfs41_sequence_done(task, &hdr->res.seq_res);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index d383de00d486..a553d59afa8b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1414,8 +1414,6 @@ static void ff_layout_read_call_done(struct rpc_task *task, void *data)
 {
 	struct nfs_pgio_header *hdr = data;
 
-	dprintk("--> %s task->tk_status %d\n", __func__, task->tk_status);
-
 	if (test_bit(NFS_IOHDR_REDO, &hdr->flags) &&
 	    task->tk_status == 0) {
 		nfs4_sequence_done(task, &hdr->res.seq_res);
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index cc232d1f16f2..9cc057d40ef3 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -870,9 +870,6 @@ static void nfs_pgio_result(struct rpc_task *task, void *calldata)
 	struct nfs_pgio_header *hdr = calldata;
 	struct inode *inode = hdr->inode;
 
-	dprintk("NFS: %s: %5u, (status %d)\n", __func__,
-		task->tk_pid, task->tk_status);
-
 	if (hdr->rw_ops->rw_done(task, hdr, inode) != 0)
 		return;
 	if (task->tk_status < 0)
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1ded0d232ece..dedfdf7ad2ec 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1836,9 +1836,6 @@ static void nfs_commit_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs_commit_data	*data = calldata;
 
-        dprintk("NFS: %5u nfs_commit_done (status %d)\n",
-                                task->tk_pid, task->tk_status);
-
 	/* Call the NFS version-specific code */
 	NFS_PROTO(data->inode)->commit_done(task, data);
 	trace_nfs_commit_done(task, data);
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 83c2a1cb2e3a..2345bdfb30b0 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -372,6 +372,7 @@ DEFINE_RPC_RUNNING_EVENT(complete);
 DEFINE_RPC_RUNNING_EVENT(timeout);
 DEFINE_RPC_RUNNING_EVENT(signalled);
 DEFINE_RPC_RUNNING_EVENT(end);
+DEFINE_RPC_RUNNING_EVENT(call_done);
 
 DECLARE_EVENT_CLASS(rpc_task_queued,
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index b3402aeb8f30..34c71fa95c41 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -837,6 +837,7 @@ void rpc_exit_task(struct rpc_task *task)
 	else if (task->tk_client)
 		rpc_count_iostats(task, task->tk_client->cl_metrics);
 	if (task->tk_ops->rpc_call_done != NULL) {
+		trace_rpc_task_call_done(task, task->tk_ops->rpc_call_done);
 		task->tk_ops->rpc_call_done(task, task->tk_calldata);
 		if (task->tk_action != NULL) {
 			/* Always release the RPC slot and buffer memory */

