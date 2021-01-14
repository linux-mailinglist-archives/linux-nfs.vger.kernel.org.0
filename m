Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8392F65CD
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbhANQXu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 11:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbhANQXu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 14 Jan 2021 11:23:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7743423B46;
        Thu, 14 Jan 2021 16:22:59 +0000 (UTC)
Subject: [PATCH v1 5/5] svcrdma: Deprecate stat variables that are no longer
 used
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 14 Jan 2021 11:22:58 -0500
Message-ID: <161064137876.6061.18396690353957236238.stgit@klimt.1015granger.net>
In-Reply-To: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
References: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. We are not permitted to remove old proc files. Instead,
convert these variables to stubs that are only ever allowed to be
zero.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h |    5 --
 net/sunrpc/xprtrdma/svc_rdma.c  |   84 +++++++++++++--------------------------
 2 files changed, 27 insertions(+), 62 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index c882816cba8e..1e76ed688044 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -70,11 +70,6 @@ extern struct percpu_counter svcrdma_stat_read;
 extern struct percpu_counter svcrdma_stat_recv;
 extern struct percpu_counter svcrdma_stat_sq_starve;
 extern struct percpu_counter svcrdma_stat_write;
-extern atomic_t rdma_stat_rq_starve;
-extern atomic_t rdma_stat_rq_poll;
-extern atomic_t rdma_stat_rq_prod;
-extern atomic_t rdma_stat_sq_poll;
-extern atomic_t rdma_stat_sq_prod;
 
 struct svcxprt_rdma {
 	struct svc_xprt      sc_xprt;		/* SVC transport structure */
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index c8336df7a142..5bc20e9d09cd 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -62,53 +62,13 @@ static unsigned int max_max_requests = 16384;
 unsigned int svcrdma_max_req_size = RPCRDMA_DEF_INLINE_THRESH;
 static unsigned int min_max_inline = RPCRDMA_DEF_INLINE_THRESH;
 static unsigned int max_max_inline = RPCRDMA_MAX_INLINE_THRESH;
+static unsigned int svcrdma_stat_unused;
+static unsigned int zero;
 
 struct percpu_counter svcrdma_stat_read;
 struct percpu_counter svcrdma_stat_recv;
 struct percpu_counter svcrdma_stat_sq_starve;
 struct percpu_counter svcrdma_stat_write;
-atomic_t rdma_stat_rq_starve;
-atomic_t rdma_stat_rq_poll;
-atomic_t rdma_stat_rq_prod;
-atomic_t rdma_stat_sq_poll;
-atomic_t rdma_stat_sq_prod;
-
-/*
- * This function implements reading and resetting an atomic_t stat
- * variable through read/write to a proc file. Any write to the file
- * resets the associated statistic to zero. Any read returns it's
- * current value.
- */
-static int read_reset_stat(struct ctl_table *table, int write,
-			   void *buffer, size_t *lenp, loff_t *ppos)
-{
-	atomic_t *stat = (atomic_t *)table->data;
-
-	if (!stat)
-		return -EINVAL;
-
-	if (write)
-		atomic_set(stat, 0);
-	else {
-		char str_buf[32];
-		int len = snprintf(str_buf, 32, "%d\n", atomic_read(stat));
-		if (len >= 32)
-			return -EFAULT;
-		len = strlen(str_buf);
-		if (*ppos > len) {
-			*lenp = 0;
-			return 0;
-		}
-		len -= *ppos;
-		if (len > *lenp)
-			len = *lenp;
-		if (len)
-			memcpy(buffer, str_buf, len);
-		*lenp = len;
-		*ppos += len;
-	}
-	return 0;
-}
 
 enum {
 	SVCRDMA_COUNTER_BUFSIZ	= sizeof(unsigned long long),
@@ -206,38 +166,48 @@ static struct ctl_table svcrdma_parm_table[] = {
 	},
 	{
 		.procname	= "rdma_stat_rq_starve",
-		.data		= &rdma_stat_rq_starve,
-		.maxlen		= sizeof(atomic_t),
+		.data		= &svcrdma_stat_unused,
+		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= read_reset_stat,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &zero,
 	},
 	{
 		.procname	= "rdma_stat_rq_poll",
-		.data		= &rdma_stat_rq_poll,
-		.maxlen		= sizeof(atomic_t),
+		.data		= &svcrdma_stat_unused,
+		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= read_reset_stat,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &zero,
 	},
 	{
 		.procname	= "rdma_stat_rq_prod",
-		.data		= &rdma_stat_rq_prod,
-		.maxlen		= sizeof(atomic_t),
+		.data		= &svcrdma_stat_unused,
+		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= read_reset_stat,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &zero,
 	},
 	{
 		.procname	= "rdma_stat_sq_poll",
-		.data		= &rdma_stat_sq_poll,
-		.maxlen		= sizeof(atomic_t),
+		.data		= &svcrdma_stat_unused,
+		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= read_reset_stat,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &zero,
 	},
 	{
 		.procname	= "rdma_stat_sq_prod",
-		.data		= &rdma_stat_sq_prod,
-		.maxlen		= sizeof(atomic_t),
+		.data		= &svcrdma_stat_unused,
+		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= read_reset_stat,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &zero,
 	},
 	{ },
 };


