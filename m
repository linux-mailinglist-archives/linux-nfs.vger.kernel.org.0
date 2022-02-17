Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D272E4BA563
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242927AbiBQQGQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:06:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiBQQGP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:06:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA9D29C123
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:06:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFA11B8235B
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 16:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F877C340E9;
        Thu, 17 Feb 2022 16:05:58 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Subject: [PATCH v2 6/8] SUNRPC: Remove svc_shutdown_net()
Date:   Thu, 17 Feb 2022 11:05:57 -0500
Message-Id:  <164511395701.1361.2321498517172060697.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
References:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5306; h=from:subject:message-id; bh=dfpjf2A6A3MjKaO5wTDQouwREOVn8RLIEd482495MP8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDnJljGyYDP8o5BNgApkOW7ALCWAQLMM8pKrZvoJE Nl44tjmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg5yZQAKCRAzarMzb2Z/lygfD/ 9Az1vHt4B3AC9DfmiA2U6wfcBzhxokCrX4kvDcwiiHM+yv/9XBHJBNivZeUVm9PrIlN8XJ3n9SkaHz ySjWgXGwlaHM7ukKRuEcelVwILfR4GG08OQ3tqp+Rkmstj3pDLQwEfWgYmUsPGXoe69ePcb0SuKxOb M+SyzpkihuYPqvc3lQgPO36Uymw+5LkQMi4hQWrkCvYtch9c3R70wh05ZAy2EqmSg75aUMjElT5Hxh slEbGaQO0qscPDzPdtRGgD2a7oFwC9K+QhPdFW6789sM/GRuUGBUg4QqipTcjV0FDI60ChfxgIoao9 gdgSy2jDBh7kDOD9YE5X0BbY3+b9Sxf5hmpmLm96CaAiWhcMV2E9c8U4l6AYBuXNFDhzhPNRNFc3Zk z3h/3nu9N0Ag6uQMYxryD7CoG029t8baQQ49vXUKckZkzzvgqPcA+aov8y2sR8wzpigvp1PaWL7sm/ bePaLFRbmLLfeiL4xErVgOGu6uV/MAv+5zw+kEJ1GgjbnB5WhiPaShT7SpTY34iKKGJW4fM9ftNir/ CYaL4HanHJYGKtLZNI1nKXcLOJ3vtBjj0e0Hcfvq4BhDbClxGLb8gUDajz9GvZdP0xGB9dI00x+yzF 7yX1LoE7u8/rK+ixMHz+9C284ZxQibMt6ckNBVejpu2kxCo1ikZGdQ8gUSmQ==
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

Clean up: svc_shutdown_net() now does nothing but call
svc_close_net(). Replace all external call sites.

svc_close_net() is renamed to be the inverse of svc_xprt_create().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c                  |    4 ++--
 fs/nfs/callback.c               |    2 +-
 fs/nfsd/nfssvc.c                |    2 +-
 include/linux/sunrpc/svc.h      |    1 -
 include/linux/sunrpc/svc_xprt.h |    1 +
 net/sunrpc/svc.c                |    6 ------
 net/sunrpc/svc_xprt.c           |    9 +++++++--
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index bba6f2b45b64..c83ec4a375bc 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -248,7 +248,7 @@ static int make_socks(struct svc_serv *serv, struct net *net,
 	if (warned++ == 0)
 		printk(KERN_WARNING
 			"lockd_up: makesock failed, error=%d\n", err);
-	svc_shutdown_net(serv, net);
+	svc_xprt_destroy_all(serv, net);
 	svc_rpcb_cleanup(serv, net);
 	return err;
 }
@@ -287,7 +287,7 @@ static void lockd_down_net(struct svc_serv *serv, struct net *net)
 			nlm_shutdown_hosts_net(net);
 			cancel_delayed_work_sync(&ln->grace_period_end);
 			locks_end_grace(&ln->lockd_manager);
-			svc_shutdown_net(serv, net);
+			svc_xprt_destroy_all(serv, net);
 			svc_rpcb_cleanup(serv, net);
 		}
 	} else {
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index c1a8767100ae..c98c68513590 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -189,7 +189,7 @@ static void nfs_callback_down_net(u32 minorversion, struct svc_serv *serv, struc
 		return;
 
 	dprintk("NFS: destroy per-net callback data; net=%x\n", net->ns.inum);
-	svc_shutdown_net(serv, net);
+	svc_xprt_destroy_all(serv, net);
 }
 
 static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ae25b7b3af99..b92d272f4ba6 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -722,7 +722,7 @@ void nfsd_put(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
-		svc_shutdown_net(nn->nfsd_serv, net);
+		svc_xprt_destroy_all(nn->nfsd_serv, net);
 		nfsd_last_thread(nn->nfsd_serv, net);
 		svc_destroy(&nn->nfsd_serv->sv_refcnt);
 		spin_lock(&nfsd_notifier_lock);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 63794d772eb3..5603158b2aa7 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -508,7 +508,6 @@ struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 			const struct svc_serv_ops *);
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
-void		   svc_shutdown_net(struct svc_serv *, struct net *);
 int		   svc_process(struct svc_rqst *);
 int		   bc_svc_process(struct svc_serv *, struct rpc_rqst *,
 			struct svc_rqst *);
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index bf7d029fb48c..42e113742429 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -131,6 +131,7 @@ int	svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 			struct net *net, const int family,
 			const unsigned short port, int flags,
 			const struct cred *cred);
+void	svc_xprt_destroy_all(struct svc_serv *serv, struct net *net);
 void	svc_xprt_received(struct svc_xprt *xprt);
 void	svc_xprt_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_put(struct svc_xprt *xprt);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 53efef3db3a9..08d684746452 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -536,12 +536,6 @@ svc_create_pooled(struct svc_program *prog, unsigned int bufsize,
 }
 EXPORT_SYMBOL_GPL(svc_create_pooled);
 
-void svc_shutdown_net(struct svc_serv *serv, struct net *net)
-{
-	svc_close_net(serv, net);
-}
-EXPORT_SYMBOL_GPL(svc_shutdown_net);
-
 /*
  * Destroy an RPC service. Should be called with appropriate locking to
  * protect sv_permsocks and sv_tempsocks.
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 6809116c996a..0c117d3bfda8 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1140,7 +1140,11 @@ static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
 	}
 }
 
-/*
+/**
+ * svc_xprt_destroy_all - Destroy transports associated with @serv
+ * @serv: RPC service to be shut down
+ * @net: target network namespace
+ *
  * Server threads may still be running (especially in the case where the
  * service is still running in other network namespaces).
  *
@@ -1152,7 +1156,7 @@ static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
  * threads, we may need to wait a little while and then check again to
  * see if they're done.
  */
-void svc_close_net(struct svc_serv *serv, struct net *net)
+void svc_xprt_destroy_all(struct svc_serv *serv, struct net *net)
 {
 	int delay = 0;
 
@@ -1163,6 +1167,7 @@ void svc_close_net(struct svc_serv *serv, struct net *net)
 		msleep(delay++);
 	}
 }
+EXPORT_SYMBOL_GPL(svc_xprt_destroy_all);
 
 /*
  * Handle defer and revisit of requests

