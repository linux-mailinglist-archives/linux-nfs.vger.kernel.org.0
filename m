Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0A4BA565
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiBQQG1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:06:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiBQQG1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:06:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA97E29C124
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:06:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E4760C78
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 16:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81ED2C340E8;
        Thu, 17 Feb 2022 16:06:11 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Subject: [PATCH v2 8/8] NFSD: Move svc_serv_ops::svo_function into struct svc_serv
Date:   Thu, 17 Feb 2022 11:06:10 -0500
Message-Id:  <164511397026.1361.11840968118260314911.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
References:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=8750; h=from:subject:message-id; bh=WvSlLmYZntUh0Jjy1nMiK45HSoBM3Q8UY9vkvBdNJa8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDnJyNZyc/jwpF1Qq06QEV13++MO0Rn7P/BMUgBZx 0l12NqqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg5ycgAKCRAzarMzb2Z/lwK1D/ 4uKueDSfA1I6dUZyJ1U1QVOkNRem96VS8hWhXBBo9e8SyBfo1qtSlT11+wr58Dmg3GR/VIpBG5HzpC MBnnl0BSfR9jRiXKm2T+4WMIe2mxZLxIjasq+l4z/4+wV79EC0wP0ORbebwo6+eqWIC/K1oWyXghpd 3vNPqs86W4cj6lgJ+1TxtUQblWygmEs31xr2T+Reeved8N5qCTWsGEBlXI14t2e12a+75gD/CjfKEs Yp2bNsOejr3lSVskeMypp36TAyG1WmpKMKsY0OZg0KvDE+KnOp40+P5jIlqP2Wbx5Lk8QZaNcGIjRv m+LIlEcvZYFiOgkxV3HgNUwuxopofnhk4Mv2bM5OUWmcBL1IJs/b50LOU4gvPAGTX8RpEZp1ZdqxFZ 2e1SksPkcQCruwwhYSwtWCFTjJt9loR0iWJsG8Aj7ad5PiJqHkWxq4leimGN5K3Bw8rulbpfCMuxhk TR5g14CX4/c4EhnI2jUYUEJNQHAl+zK4DYvX0zy2AVMsOSbikwU6fxb+pbCJFUK4G5RM7lfI7lSXD1 rNj6s5RcxvgpxoDkcir5Qs3pT3WEZPvmTV+lmz3d5ygRW6/UOnKqnqAHkGYmAOZk5H13xjv7rs0n70 PMtuLEgk1uS7QpwGbCL2Gjz1MGx0J1ea8rD+a7eCApv6czYE/h9bC2HrDPwg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hoist svo_function back into svc_serv and remove struct
svc_serv_ops, since the struct is now devoid of fields.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c             |    6 +-----
 fs/nfs/callback.c          |   43 +++++++++++--------------------------------
 fs/nfsd/nfssvc.c           |    7 +------
 include/linux/sunrpc/svc.h |   14 ++++----------
 net/sunrpc/svc.c           |   37 ++++++++++++++++++++++++++-----------
 5 files changed, 43 insertions(+), 64 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index bfde31124f3a..59ef8a1f843f 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -349,10 +349,6 @@ static struct notifier_block lockd_inet6addr_notifier = {
 };
 #endif
 
-static const struct svc_serv_ops lockd_sv_ops = {
-	.svo_function		= lockd,
-};
-
 static int lockd_get(void)
 {
 	struct svc_serv *serv;
@@ -376,7 +372,7 @@ static int lockd_get(void)
 		nlm_timeout = LOCKD_DFLT_TIMEO;
 	nlmsvc_timeout = nlm_timeout * HZ;
 
-	serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE, &lockd_sv_ops);
+	serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE, lockd);
 	if (!serv) {
 		printk(KERN_WARNING "lockd_up: create service failed\n");
 		return -ENOMEM;
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index a494f9e7bd0a..456af7d230cf 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -231,29 +231,10 @@ static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
 	return ret;
 }
 
-static const struct svc_serv_ops nfs40_cb_sv_ops = {
-	.svo_function		= nfs4_callback_svc,
-};
-#if defined(CONFIG_NFS_V4_1)
-static const struct svc_serv_ops nfs41_cb_sv_ops = {
-	.svo_function		= nfs41_callback_svc,
-};
-
-static const struct svc_serv_ops *nfs4_cb_sv_ops[] = {
-	[0] = &nfs40_cb_sv_ops,
-	[1] = &nfs41_cb_sv_ops,
-};
-#else
-static const struct svc_serv_ops *nfs4_cb_sv_ops[] = {
-	[0] = &nfs40_cb_sv_ops,
-	[1] = NULL,
-};
-#endif
-
 static struct svc_serv *nfs_callback_create_svc(int minorversion)
 {
 	struct nfs_callback_data *cb_info = &nfs_callback_info[minorversion];
-	const struct svc_serv_ops *sv_ops;
+	int (*threadfn)(void *data);
 	struct svc_serv *serv;
 
 	/*
@@ -262,17 +243,6 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 	if (cb_info->serv)
 		return svc_get(cb_info->serv);
 
-	switch (minorversion) {
-	case 0:
-		sv_ops = nfs4_cb_sv_ops[0];
-		break;
-	default:
-		sv_ops = nfs4_cb_sv_ops[1];
-	}
-
-	if (sv_ops == NULL)
-		return ERR_PTR(-ENOTSUPP);
-
 	/*
 	 * Sanity check: if there's no task,
 	 * we should be the first user ...
@@ -281,7 +251,16 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 		printk(KERN_WARNING "nfs_callback_create_svc: no kthread, %d users??\n",
 			cb_info->users);
 
-	serv = svc_create(&nfs4_callback_program, NFS4_CALLBACK_BUFSIZE, sv_ops);
+	threadfn = nfs4_callback_svc;
+#if defined(CONFIG_NFS_V4_1)
+	if (minorversion)
+		threadfn = nfs41_callback_svc;
+#else
+	if (minorversion)
+		return ERR_PTR(-ENOTSUPP);
+#endif
+	serv = svc_create(&nfs4_callback_program, NFS4_CALLBACK_BUFSIZE,
+			  threadfn);
 	if (!serv) {
 		printk(KERN_ERR "nfs_callback_create_svc: create service failed\n");
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 544187a8a22b..5abbe5d1c77f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -612,10 +612,6 @@ static int nfsd_get_default_max_blksize(void)
 	return ret;
 }
 
-static const struct svc_serv_ops nfsd_thread_sv_ops = {
-	.svo_function		= nfsd,
-};
-
 void nfsd_shutdown_threads(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
@@ -654,8 +650,7 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize,
-				 &nfsd_thread_sv_ops);
+	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index dfc9283f412f..a5dda4987e8b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -52,13 +52,6 @@ struct svc_pool {
 	unsigned long		sp_flags;
 } ____cacheline_aligned_in_smp;
 
-struct svc_serv;
-
-struct svc_serv_ops {
-	/* function for service threads to run */
-	int		(*svo_function)(void *);
-};
-
 /*
  * RPC service.
  *
@@ -91,7 +84,8 @@ struct svc_serv {
 
 	unsigned int		sv_nrpools;	/* number of thread pools */
 	struct svc_pool *	sv_pools;	/* array of thread pools */
-	const struct svc_serv_ops *sv_ops;	/* server operations */
+	int			(*sv_threadfn)(void *data);
+
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 	struct list_head	sv_cb_list;	/* queue for callback requests
 						 * that arrive over the same
@@ -492,7 +486,7 @@ int svc_rpcb_setup(struct svc_serv *serv, struct net *net);
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
 int svc_bind(struct svc_serv *serv, struct net *net);
 struct svc_serv *svc_create(struct svc_program *, unsigned int,
-			    const struct svc_serv_ops *);
+			    int (*threadfn)(void *data));
 struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
 void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
@@ -500,7 +494,7 @@ void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
-			const struct svc_serv_ops *);
+				     int (*threadfn)(void *data));
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
 int		   svc_process(struct svc_rqst *);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index a90d555aa163..557004017548 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -448,7 +448,7 @@ __svc_init_bc(struct svc_serv *serv)
  */
 static struct svc_serv *
 __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
-	     const struct svc_serv_ops *ops)
+	     int (*threadfn)(void *data))
 {
 	struct svc_serv	*serv;
 	unsigned int vers;
@@ -465,7 +465,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		bufsize = RPCSVC_MAXPAYLOAD;
 	serv->sv_max_payload = bufsize? bufsize : 4096;
 	serv->sv_max_mesg  = roundup(serv->sv_max_payload + PAGE_SIZE, PAGE_SIZE);
-	serv->sv_ops = ops;
+	serv->sv_threadfn = threadfn;
 	xdrsize = 0;
 	while (prog) {
 		prog->pg_lovers = prog->pg_nvers-1;
@@ -511,22 +511,37 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 	return serv;
 }
 
-struct svc_serv *
-svc_create(struct svc_program *prog, unsigned int bufsize,
-	   const struct svc_serv_ops *ops)
+/**
+ * svc_create - Create an RPC service
+ * @prog: the RPC program the new service will handle
+ * @bufsize: maximum message size for @prog
+ * @threadfn: a function to service RPC requests for @prog
+ *
+ * Returns an instantiated struct svc_serv object or NULL.
+ */
+struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
+			    int (*threadfn)(void *data))
 {
-	return __svc_create(prog, bufsize, /*npools*/1, ops);
+	return __svc_create(prog, bufsize, 1, threadfn);
 }
 EXPORT_SYMBOL_GPL(svc_create);
 
-struct svc_serv *
-svc_create_pooled(struct svc_program *prog, unsigned int bufsize,
-		  const struct svc_serv_ops *ops)
+/**
+ * svc_create_pooled - Create an RPC service with pooled threads
+ * @prog: the RPC program the new service will handle
+ * @bufsize: maximum message size for @prog
+ * @threadfn: a function to service RPC requests for @prog
+ *
+ * Returns an instantiated struct svc_serv object or NULL.
+ */
+struct svc_serv *svc_create_pooled(struct svc_program *prog,
+				   unsigned int bufsize,
+				   int (*threadfn)(void *data))
 {
 	struct svc_serv *serv;
 	unsigned int npools = svc_pool_map_get();
 
-	serv = __svc_create(prog, bufsize, npools, ops);
+	serv = __svc_create(prog, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;
 	return serv;
@@ -736,7 +751,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		if (IS_ERR(rqstp))
 			return PTR_ERR(rqstp);
 
-		task = kthread_create_on_node(serv->sv_ops->svo_function, rqstp,
+		task = kthread_create_on_node(serv->sv_threadfn, rqstp,
 					      node, "%s", serv->sv_name);
 		if (IS_ERR(task)) {
 			svc_exit_thread(rqstp);

