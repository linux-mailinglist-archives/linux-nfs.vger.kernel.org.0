Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1104BA560
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbiBQQGW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:06:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiBQQGW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:06:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9429C129
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:06:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71D87B8235A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 16:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C60C340E9;
        Thu, 17 Feb 2022 16:06:04 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Subject: [PATCH v2 7/8] NFSD: Remove svc_serv_ops::svo_module
Date:   Thu, 17 Feb 2022 11:06:03 -0500
Message-Id:  <164511396364.1361.17015960520452464789.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
References:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4992; h=from:subject:message-id; bh=S6ZESeG0xl/6GJfYBpTM3wMvCllKmEqICbcc7nHPD3E=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDnJrQb7ttt7Cu470/qWG50r951t/nA9NXEBuLAwF 1SA2126JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg5yawAKCRAzarMzb2Z/l3utEA CLRCXyIgbCScwOM1nr37KSGS7JW3CWaX4QliA82ed8OjRo4/MVgwHsQ59uxkRxmBV8Q6LX1YL6ACep lwK7g7l+bwCRT5mb9qT2Fff+2MaZ6Wh2SxYrh3E9wSBb1lvuAiMSXPPkmn3Dg94Z5NB+Ql1bwbJpko 0zg8oBbnC6LvH6r+08LcBsSQn3zTIbt4l7a8RA4C62W08j2fosKhV9xIIZmUWXI0NPNSKrScSjmisz cURd6AimqV8YjKdDBf2VU1Ajm3/0Z2hryVSxBviqeZgpfXYz/doDzGd1jdBhL2tnoywbAKf1X2Acfv rVC5XZcorFFOAkTUsf19rfmmwqBqh5tbNKyzP9bbH9Mzuj6F53kpmbZINtxNkRXWxBzlODZ6UTD8+c F4d43sDybA98tsRiCRA9N2C2gEynudZM53+fdCAPHfHH86jqOBHqa0ZlaYGkiz9jlk5niLaNG3cSxG fo6XYPplWNtoyF3ghbzhEVPtuskUwUP2mHC/vlcura8OhAuz0Zyh1nXMKtDZdalenpm7FWjBd8zhGB eUmjbY/yFz7W+M/bKcVFJ2hn0J4o2IXjB6RV8Wf85cfkIN/Czfw89T4cLmYMebrz6KwoEow6F0u5uo JmuSoQWc/LQzV8De1g6X5gy9PtJFa20iG6GsD/aqx+ezdp34ub5qTBOQg0bw==
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

struct svc_serv_ops is about to be removed.

Neil Brown says:
> I suspect svo_module can go as well - I don't think the thread is
> ever the thing that primarily keeps a module active.

A random sample of kthread_create() callers shows sunrpc is the only
one that manages module reference count in this way.

Suggested-by: Neil Brown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c             |    4 +---
 fs/nfs/callback.c          |    7 ++-----
 fs/nfs/nfs4state.c         |    1 -
 fs/nfsd/nfssvc.c           |    3 ---
 include/linux/sunrpc/svc.h |    5 -----
 kernel/module.c            |    2 +-
 net/sunrpc/svc.c           |    2 --
 7 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index c83ec4a375bc..bfde31124f3a 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -184,8 +184,7 @@ lockd(void *vrqstp)
 	dprintk("lockd_down: service stopped\n");
 
 	svc_exit_thread(rqstp);
-
-	module_put_and_kthread_exit(0);
+	return 0;
 }
 
 static int create_lockd_listener(struct svc_serv *serv, const char *name,
@@ -352,7 +351,6 @@ static struct notifier_block lockd_inet6addr_notifier = {
 
 static const struct svc_serv_ops lockd_sv_ops = {
 	.svo_function		= lockd,
-	.svo_module		= THIS_MODULE,
 };
 
 static int lockd_get(void)
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index c98c68513590..a494f9e7bd0a 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -17,7 +17,6 @@
 #include <linux/errno.h>
 #include <linux/mutex.h>
 #include <linux/freezer.h>
-#include <linux/kthread.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/bc_xprt.h>
 
@@ -92,8 +91,8 @@ nfs4_callback_svc(void *vrqstp)
 			continue;
 		svc_process(rqstp);
 	}
+
 	svc_exit_thread(rqstp);
-	module_put_and_kthread_exit(0);
 	return 0;
 }
 
@@ -136,8 +135,8 @@ nfs41_callback_svc(void *vrqstp)
 			finish_wait(&serv->sv_cb_waitq, &wq);
 		}
 	}
+
 	svc_exit_thread(rqstp);
-	module_put_and_kthread_exit(0);
 	return 0;
 }
 
@@ -234,12 +233,10 @@ static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
 
 static const struct svc_serv_ops nfs40_cb_sv_ops = {
 	.svo_function		= nfs4_callback_svc,
-	.svo_module		= THIS_MODULE,
 };
 #if defined(CONFIG_NFS_V4_1)
 static const struct svc_serv_ops nfs41_cb_sv_ops = {
 	.svo_function		= nfs41_callback_svc,
-	.svo_module		= THIS_MODULE,
 };
 
 static const struct svc_serv_ops *nfs4_cb_sv_ops[] = {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f5a62c0d999b..02a899e4390f 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2697,6 +2697,5 @@ static int nfs4_run_state_manager(void *ptr)
 	allow_signal(SIGKILL);
 	nfs4_state_manager(clp);
 	nfs_put_client(clp);
-	module_put_and_kthread_exit(0);
 	return 0;
 }
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b92d272f4ba6..544187a8a22b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -614,7 +614,6 @@ static int nfsd_get_default_max_blksize(void)
 
 static const struct svc_serv_ops nfsd_thread_sv_ops = {
 	.svo_function		= nfsd,
-	.svo_module		= THIS_MODULE,
 };
 
 void nfsd_shutdown_threads(struct net *net)
@@ -1018,8 +1017,6 @@ nfsd(void *vrqstp)
 		msleep(20);
 	}
 
-	/* Release module */
-	module_put_and_kthread_exit(0);
 	return 0;
 }
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5603158b2aa7..dfc9283f412f 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -57,11 +57,6 @@ struct svc_serv;
 struct svc_serv_ops {
 	/* function for service threads to run */
 	int		(*svo_function)(void *);
-
-	/* optional module to count when adding threads.
-	 * Thread function must call module_put_and_kthread_exit() to exit.
-	 */
-	struct module	*svo_module;
 };
 
 /*
diff --git a/kernel/module.c b/kernel/module.c
index 46a5c2ed1928..6cea788fd965 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -335,7 +335,7 @@ static inline void add_taint_module(struct module *mod, unsigned flag,
 
 /*
  * A thread that wants to hold a reference to a module only while it
- * is running can call this to safely exit.  nfsd and lockd use this.
+ * is running can call this to safely exit.
  */
 void __noreturn __module_put_and_kthread_exit(struct module *mod, long code)
 {
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 08d684746452..a90d555aa163 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -736,11 +736,9 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		if (IS_ERR(rqstp))
 			return PTR_ERR(rqstp);
 
-		__module_get(serv->sv_ops->svo_module);
 		task = kthread_create_on_node(serv->sv_ops->svo_function, rqstp,
 					      node, "%s", serv->sv_name);
 		if (IS_ERR(task)) {
-			module_put(serv->sv_ops->svo_module);
 			svc_exit_thread(rqstp);
 			return PTR_ERR(task);
 		}

