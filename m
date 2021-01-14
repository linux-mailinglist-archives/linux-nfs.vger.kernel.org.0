Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A62F65C3
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbhANQXW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 11:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbhANQXW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 14 Jan 2021 11:23:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28AF723B40;
        Thu, 14 Jan 2021 16:22:41 +0000 (UTC)
Subject: [PATCH v1 2/5] svcrdma: Convert rdma_stat_recv to a per-CPU counter
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 14 Jan 2021 11:22:40 -0500
Message-ID: <161064136043.6061.10720720567534020811.stgit@klimt.1015granger.net>
In-Reply-To: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
References: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Receives are frequent events. Avoid the overhead of a memory bus
lock cycle for counting a value that is hardly every used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    3 +-
 net/sunrpc/xprtrdma/svc_rdma.c          |   55 +++++++++++++++++++++++++++++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    3 +-
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 294b56e61522..ff32c59a27e7 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -49,6 +49,7 @@
 #include <linux/sunrpc/rpc_rdma_cid.h>
 #include <linux/sunrpc/svc_rdma_pcl.h>
 
+#include <linux/percpu_counter.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
 
@@ -65,7 +66,7 @@ extern unsigned int svcrdma_max_requests;
 extern unsigned int svcrdma_max_bc_requests;
 extern unsigned int svcrdma_max_req_size;
 
-extern atomic_t rdma_stat_recv;
+extern struct percpu_counter svcrdma_stat_recv;
 extern atomic_t rdma_stat_read;
 extern atomic_t rdma_stat_write;
 extern atomic_t rdma_stat_sq_starve;
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 1fc1d5cbeb9b..3e5e622bad81 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -63,7 +63,7 @@ unsigned int svcrdma_max_req_size = RPCRDMA_DEF_INLINE_THRESH;
 static unsigned int min_max_inline = RPCRDMA_DEF_INLINE_THRESH;
 static unsigned int max_max_inline = RPCRDMA_MAX_INLINE_THRESH;
 
-atomic_t rdma_stat_recv;
+struct percpu_counter svcrdma_stat_recv;
 atomic_t rdma_stat_read;
 atomic_t rdma_stat_write;
 atomic_t rdma_stat_sq_starve;
@@ -110,6 +110,42 @@ static int read_reset_stat(struct ctl_table *table, int write,
 	return 0;
 }
 
+enum {
+	SVCRDMA_COUNTER_BUFSIZ	= sizeof(unsigned long long),
+};
+
+static int svcrdma_counter_handler(struct ctl_table *table, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct percpu_counter *stat = (struct percpu_counter *)table->data;
+	char tmp[SVCRDMA_COUNTER_BUFSIZ + 1];
+	int len;
+
+	if (write) {
+		percpu_counter_set(stat, 0);
+		return 0;
+	}
+
+	len = snprintf(tmp, SVCRDMA_COUNTER_BUFSIZ, "%lld\n",
+		       percpu_counter_sum_positive(stat));
+	if (len >= SVCRDMA_COUNTER_BUFSIZ)
+		return -EFAULT;
+	len = strlen(tmp);
+	if (*ppos > len) {
+		*lenp = 0;
+		return 0;
+	}
+	len -= *ppos;
+	if (len > *lenp)
+		len = *lenp;
+	if (len)
+		memcpy(buffer, tmp, len);
+	*lenp = len;
+	*ppos += len;
+
+	return 0;
+}
+
 static struct ctl_table_header *svcrdma_table_header;
 static struct ctl_table svcrdma_parm_table[] = {
 	{
@@ -149,10 +185,10 @@ static struct ctl_table svcrdma_parm_table[] = {
 	},
 	{
 		.procname	= "rdma_stat_recv",
-		.data		= &rdma_stat_recv,
-		.maxlen		= sizeof(atomic_t),
+		.data		= &svcrdma_stat_recv,
+		.maxlen		= SVCRDMA_COUNTER_BUFSIZ,
 		.mode		= 0644,
-		.proc_handler	= read_reset_stat,
+		.proc_handler	= svcrdma_counter_handler,
 	},
 	{
 		.procname	= "rdma_stat_write",
@@ -230,15 +266,26 @@ static void svc_rdma_proc_cleanup(void)
 		return;
 	unregister_sysctl_table(svcrdma_table_header);
 	svcrdma_table_header = NULL;
+
+	percpu_counter_destroy(&svcrdma_stat_recv);
 }
 
 static int svc_rdma_proc_init(void)
 {
+	int rc;
+
 	if (svcrdma_table_header)
 		return 0;
 
+	rc = percpu_counter_init(&svcrdma_stat_recv, 0, GFP_KERNEL);
+	if (rc)
+		goto out_err;
+
 	svcrdma_table_header = register_sysctl_table(svcrdma_root_table);
 	return 0;
+
+out_err:
+	return rc;
 }
 
 void svc_rdma_cleanup(void)
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index cbdb71247755..7d14a74df716 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -845,8 +845,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	}
 	list_del(&ctxt->rc_list);
 	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
-
-	atomic_inc(&rdma_stat_recv);
+	percpu_counter_inc(&svcrdma_stat_recv);
 
 	svc_rdma_build_arg_xdr(rqstp, ctxt);
 


