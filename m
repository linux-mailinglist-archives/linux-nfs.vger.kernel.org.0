Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0CC49BBB5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiAYTBA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiAYTA7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:00:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8508CC06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:00:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B6AFB81A23
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 19:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BF9C340E0;
        Tue, 25 Jan 2022 19:00:53 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     neilb@suse.de
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 2/2] SUNRPC: Remove svo_shutdown method
Date:   Tue, 25 Jan 2022 14:00:52 -0500
Message-Id:  <164313725230.3285.5420060785593218794.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164313706374.3285.4265550102084857832.stgit@bazille.1015granger.net>
References:  <164313706374.3285.4265550102084857832.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; h=from:subject:message-id; bh=NEPktSkWLjLaTKQaHMfTHny5YeSIEqvGtcdh6iTLz6w=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8EjkaJZT3Fg1Ks6HNuTvhxt1Nyihl2OpLyJEGckZ nQ3iLziJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfBI5AAKCRAzarMzb2Z/lxoPD/ 9j1LKAxNTMF7lpMPuXL1duf/Ve75fqk8HFM4V3bDWNWxi6SX6ha7MKj7nhoR9PdMAzMKauZ+MXq45x rm/q92FJU2Gj+RZiRXB6ry6eqbyaosFRurfhY2cn/iIRGWYJ6xo7m46mJ9C8srftTsaOZczlvSFSc7 pZtr+HGZsvr6laWkFIHIRSe4XNoOzYCZEBqVb2097zY54j0BwIMaV9BheDKa2xzlMK6gpAYPBG8RvA L/cgYD1G3fxuXx3HTsLUX9eSR4aOuLjC3lQREhVYCbYI7RVOnm1GCLHaE2Im9HxAE8txLkGqEQB0bf SJcM6Ww41h4pJ++mka29VtXn8gEoIiPJI6vdgeiVMoIEkSgTz+CRKaB02+rHQQW0F6LrISxIg9tivR EUMyfULa1/I6m4A+Sb8yyRiIFrm7Yzf5LREeCY4zwwC6MMwVF08y4HVRdDJXYnPovDETdlClTtQut+ TxmCdWKYD1U92b0t5/AiIevdHiMvH9N3/vLvVB5APVAArQZZduacTQCQGxHRLUoDALnDzzstBrc8/X s6OL0ADSdG5YhHZrNU/zlWoCeYfRgmEnlQbL6d+b/tiWyPYfxcS1uxnm3l59vXW81bqp5N6YwS4/wL DBGuA9b+DK5ZXkoGNWmhavs6EB6nTCAuvc3c75bZxB6VzII0PZArWb5ATrmA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. Neil observed that "any code that calls svc_shutdown_net()
knows what the shutdown function should be, and so can call it
directly."

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c             |    5 ++---
 fs/nfsd/nfssvc.c           |    2 +-
 include/linux/sunrpc/svc.h |    3 ---
 net/sunrpc/svc.c           |    3 ---
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 3a05af873625..f5b688a844aa 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -249,6 +249,7 @@ static int make_socks(struct svc_serv *serv, struct net *net,
 		printk(KERN_WARNING
 			"lockd_up: makesock failed, error=%d\n", err);
 	svc_shutdown_net(serv, net);
+	svc_rpcb_cleanup(serv, net);
 	return err;
 }
 
@@ -287,8 +288,7 @@ static void lockd_down_net(struct svc_serv *serv, struct net *net)
 			cancel_delayed_work_sync(&ln->grace_period_end);
 			locks_end_grace(&ln->lockd_manager);
 			svc_shutdown_net(serv, net);
-			dprintk("%s: per-net data destroyed; net=%x\n",
-				__func__, net->ns.inum);
+			svc_rpcb_cleanup(serv, net);
 		}
 	} else {
 		pr_err("%s: no users! net=%x\n",
@@ -351,7 +351,6 @@ static struct notifier_block lockd_inet6addr_notifier = {
 #endif
 
 static const struct svc_serv_ops lockd_sv_ops = {
-	.svo_shutdown		= svc_rpcb_cleanup,
 	.svo_function		= lockd,
 	.svo_module		= THIS_MODULE,
 };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index aeeac6de1f0a..0c6b216e439e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -613,7 +613,6 @@ static int nfsd_get_default_max_blksize(void)
 }
 
 static const struct svc_serv_ops nfsd_thread_sv_ops = {
-	.svo_shutdown		= nfsd_last_thread,
 	.svo_function		= nfsd,
 	.svo_module		= THIS_MODULE,
 };
@@ -724,6 +723,7 @@ void nfsd_put(struct net *net)
 
 	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
 		svc_shutdown_net(nn->nfsd_serv, net);
+		nfsd_last_thread(nn->nfsd_serv, net);
 		svc_destroy(&nn->nfsd_serv->sv_refcnt);
 		spin_lock(&nfsd_notifier_lock);
 		nn->nfsd_serv = NULL;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 6ef9c1cafd0b..63794d772eb3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -55,9 +55,6 @@ struct svc_pool {
 struct svc_serv;
 
 struct svc_serv_ops {
-	/* Callback to use when last thread exits. */
-	void		(*svo_shutdown)(struct svc_serv *, struct net *);
-
 	/* function for service threads to run */
 	int		(*svo_function)(void *);
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 2aabec2b4bec..74a75a22da9a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -539,9 +539,6 @@ EXPORT_SYMBOL_GPL(svc_create_pooled);
 void svc_shutdown_net(struct svc_serv *serv, struct net *net)
 {
 	svc_close_net(serv, net);
-
-	if (serv->sv_ops->svo_shutdown)
-		serv->sv_ops->svo_shutdown(serv, net);
 }
 EXPORT_SYMBOL_GPL(svc_shutdown_net);
 

