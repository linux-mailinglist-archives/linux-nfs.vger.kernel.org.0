Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E92F65CC
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbhANQXf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 11:23:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbhANQXe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 14 Jan 2021 11:23:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60C5A23B4B;
        Thu, 14 Jan 2021 16:22:53 +0000 (UTC)
Subject: [PATCH v1 4/5] svcrdma: Restore read and write stats
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 14 Jan 2021 11:22:52 -0500
Message-ID: <161064137260.6061.10841551530212745683.stgit@klimt.1015granger.net>
In-Reply-To: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
References: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that we have an efficient mechanism to update these two stats,
let's start maintaining them again.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |    4 ++--
 net/sunrpc/xprtrdma/svc_rdma.c    |   26 ++++++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    2 ++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index c06b16ccf83e..c882816cba8e 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -66,10 +66,10 @@ extern unsigned int svcrdma_max_requests;
 extern unsigned int svcrdma_max_bc_requests;
 extern unsigned int svcrdma_max_req_size;
 
+extern struct percpu_counter svcrdma_stat_read;
 extern struct percpu_counter svcrdma_stat_recv;
-extern atomic_t rdma_stat_read;
-extern atomic_t rdma_stat_write;
 extern struct percpu_counter svcrdma_stat_sq_starve;
+extern struct percpu_counter svcrdma_stat_write;
 extern atomic_t rdma_stat_rq_starve;
 extern atomic_t rdma_stat_rq_poll;
 extern atomic_t rdma_stat_rq_prod;
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index ee768d4c3c90..c8336df7a142 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -63,10 +63,10 @@ unsigned int svcrdma_max_req_size = RPCRDMA_DEF_INLINE_THRESH;
 static unsigned int min_max_inline = RPCRDMA_DEF_INLINE_THRESH;
 static unsigned int max_max_inline = RPCRDMA_MAX_INLINE_THRESH;
 
+struct percpu_counter svcrdma_stat_read;
 struct percpu_counter svcrdma_stat_recv;
-atomic_t rdma_stat_read;
-atomic_t rdma_stat_write;
 struct percpu_counter svcrdma_stat_sq_starve;
+struct percpu_counter svcrdma_stat_write;
 atomic_t rdma_stat_rq_starve;
 atomic_t rdma_stat_rq_poll;
 atomic_t rdma_stat_rq_prod;
@@ -178,10 +178,10 @@ static struct ctl_table svcrdma_parm_table[] = {
 
 	{
 		.procname	= "rdma_stat_read",
-		.data		= &rdma_stat_read,
-		.maxlen		= sizeof(atomic_t),
+		.data		= &svcrdma_stat_read,
+		.maxlen		= SVCRDMA_COUNTER_BUFSIZ,
 		.mode		= 0644,
-		.proc_handler	= read_reset_stat,
+		.proc_handler	= svcrdma_counter_handler,
 	},
 	{
 		.procname	= "rdma_stat_recv",
@@ -192,10 +192,10 @@ static struct ctl_table svcrdma_parm_table[] = {
 	},
 	{
 		.procname	= "rdma_stat_write",
-		.data		= &rdma_stat_write,
-		.maxlen		= sizeof(atomic_t),
+		.data		= &svcrdma_stat_write,
+		.maxlen		= SVCRDMA_COUNTER_BUFSIZ,
 		.mode		= 0644,
-		.proc_handler	= read_reset_stat,
+		.proc_handler	= svcrdma_counter_handler,
 	},
 	{
 		.procname	= "rdma_stat_sq_starve",
@@ -267,8 +267,10 @@ static void svc_rdma_proc_cleanup(void)
 	unregister_sysctl_table(svcrdma_table_header);
 	svcrdma_table_header = NULL;
 
+	percpu_counter_destroy(&svcrdma_stat_write);
 	percpu_counter_destroy(&svcrdma_stat_sq_starve);
 	percpu_counter_destroy(&svcrdma_stat_recv);
+	percpu_counter_destroy(&svcrdma_stat_read);
 }
 
 static int svc_rdma_proc_init(void)
@@ -278,10 +280,16 @@ static int svc_rdma_proc_init(void)
 	if (svcrdma_table_header)
 		return 0;
 
+	rc = percpu_counter_init(&svcrdma_stat_read, 0, GFP_KERNEL);
+	if (rc)
+		goto out_err;
 	rc = percpu_counter_init(&svcrdma_stat_recv, 0, GFP_KERNEL);
 	if (rc)
 		goto out_err;
 	rc = percpu_counter_init(&svcrdma_stat_sq_starve, 0, GFP_KERNEL);
+	if (rc)
+		goto out_err;
+	rc = percpu_counter_init(&svcrdma_stat_write, 0, GFP_KERNEL);
 	if (rc)
 		goto out_err;
 
@@ -289,7 +297,9 @@ static int svc_rdma_proc_init(void)
 	return 0;
 
 out_err:
+	percpu_counter_destroy(&svcrdma_stat_sq_starve);
 	percpu_counter_destroy(&svcrdma_stat_recv);
+	percpu_counter_destroy(&svcrdma_stat_read);
 	return rc;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index d7d98b2df00b..693d139a8633 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -469,6 +469,7 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 					   DMA_TO_DEVICE);
 		if (ret < 0)
 			return -EIO;
+		percpu_counter_inc(&svcrdma_stat_write);
 
 		list_add(&ctxt->rw_list, &cc->cc_rwctxts);
 		cc->cc_sqecount += ret;
@@ -719,6 +720,7 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 				   segment->rs_handle, DMA_FROM_DEVICE);
 	if (ret < 0)
 		return -EIO;
+	percpu_counter_inc(&svcrdma_stat_read);
 
 	list_add(&ctxt->rw_list, &cc->cc_rwctxts);
 	cc->cc_sqecount += ret;


