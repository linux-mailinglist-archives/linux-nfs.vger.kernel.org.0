Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAD84BA558
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiBQQFl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:05:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiBQQFk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:05:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BEF29C124
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:05:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B683260A57
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 16:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E15C340E9;
        Thu, 17 Feb 2022 16:05:24 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Subject: [PATCH v2 1/8] SUNRPC: Remove the .svo_enqueue_xprt method
Date:   Thu, 17 Feb 2022 11:05:24 -0500
Message-Id:  <164511392375.1361.8377138036667873411.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
References:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; h=from:subject:message-id; bh=+wBuNq44qBv2nO2SDnTal3ukrlfuKJeCXxPZ75G7Q8w=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDnJDk0FFyEBUQ2N58YXxikDHTG5Pw+LDJvBTF1hy kwdbsCGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg5yQwAKCRAzarMzb2Z/l6N1EA CCA4X6C05DATuDpVVb45Nl/ahLuHXqqjLAX0sTEpG9K2+DzQ9UPuzDla3kIZdGtqCkThDPro94ojKV D8FRLYXoZeAmZaR0yiDtjXxL920Oo9trSuMzr0bw371ct8I7l7VVLanWBvvVCLojcp6eJRr3+nYMeb H0AOFaY/H7mP/I1mLSVYbDHa/fSizf27vOZgsrVEevz7vAMzO/HIULh/0DU/1vZbJzXwZCuQHEjYLD cGW429kCUPGnQu6v6xrvvOguYxtNzjJRDo6B6Psr0tOGh2PVRdk9twjWnKf+wbZWEJC9AKE1HlgUIj Kjkv0OStewiDa7XLXwq94EcQjGDpCmQfWOSQ8HH8WuxPkfcrt680VH6mvtI7zw2faepE5cgirTDRwO YiTPDD7moXwq7YOzIoLR7hg2GDFcN8aonHiHk+n1U/4HINV+AHb2Bpc3BVQN3nTFkuY69x4Z70xKf8 U9VxDia1GfCQ1skSffmO1j57Z554FHVsySjdka+8B/VOE1IxD0GR87U0Ms6mF0YWnG6Rl0rAnX9Mlm YeB+8eg8Bb9/zT4FW52jUIoUn0lsmvuG1Lbe1QsZya8nADXOEyY1VDhC0KuGoj9swPrFsJDqyuXp8P Vd1hou0N6hHmWekpUbaqtoXFhKNVivPwkKJf7AAFWZSkEt8dJ9B3dqQ2Yv5A==
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

We have never been able to track down and address the underlying
cause of the performance issues with workqueue-based service
support. svo_enqueue_xprt is called multiple times per RPC, so
it adds instruction path length, but always ends up at the same
function: svc_xprt_do_enqueue(). We do not anticipate needing
this flexibility for dynamic nfsd thread management support.

As a micro-optimization, remove .svo_enqueue_xprt because
Spectre/Meltdown makes virtual function calls more costly.

This change essentially reverts commit b9e13cdfac70 ("nfsd/sunrpc:
turn enqueueing a svc_xprt into a svc_serv operation").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c                  |    1 -
 fs/nfs/callback.c               |    2 --
 fs/nfsd/nfssvc.c                |    1 -
 include/linux/sunrpc/svc.h      |    3 ---
 include/linux/sunrpc/svc_xprt.h |    1 -
 net/sunrpc/svc_xprt.c           |   10 +++++-----
 6 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 0475c5a5d061..3a05af873625 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -353,7 +353,6 @@ static struct notifier_block lockd_inet6addr_notifier = {
 static const struct svc_serv_ops lockd_sv_ops = {
 	.svo_shutdown		= svc_rpcb_cleanup,
 	.svo_function		= lockd,
-	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
 	.svo_module		= THIS_MODULE,
 };
 
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 054cc1255fac..7a810f885063 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -234,13 +234,11 @@ static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
 
 static const struct svc_serv_ops nfs40_cb_sv_ops = {
 	.svo_function		= nfs4_callback_svc,
-	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
 	.svo_module		= THIS_MODULE,
 };
 #if defined(CONFIG_NFS_V4_1)
 static const struct svc_serv_ops nfs41_cb_sv_ops = {
 	.svo_function		= nfs41_callback_svc,
-	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
 	.svo_module		= THIS_MODULE,
 };
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b8c682b62d29..aeeac6de1f0a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -615,7 +615,6 @@ static int nfsd_get_default_max_blksize(void)
 static const struct svc_serv_ops nfsd_thread_sv_ops = {
 	.svo_shutdown		= nfsd_last_thread,
 	.svo_function		= nfsd,
-	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
 	.svo_module		= THIS_MODULE,
 };
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f35c22b3355f..6ef9c1cafd0b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -61,9 +61,6 @@ struct svc_serv_ops {
 	/* function for service threads to run */
 	int		(*svo_function)(void *);
 
-	/* queue up a transport for servicing */
-	void		(*svo_enqueue_xprt)(struct svc_xprt *);
-
 	/* optional module to count when adding threads.
 	 * Thread function must call module_put_and_kthread_exit() to exit.
 	 */
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 571f605bc91e..a3ba027fb4ba 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -131,7 +131,6 @@ int	svc_create_xprt(struct svc_serv *, const char *, struct net *,
 			const int, const unsigned short, int,
 			const struct cred *);
 void	svc_xprt_received(struct svc_xprt *xprt);
-void	svc_xprt_do_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_put(struct svc_xprt *xprt);
 void	svc_xprt_copy_addrs(struct svc_rqst *rqstp, struct svc_xprt *xprt);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b21ad7994147..9fce4f7774bb 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -32,6 +32,7 @@ static int svc_deferred_recv(struct svc_rqst *rqstp);
 static struct cache_deferred_req *svc_defer(struct cache_req *req);
 static void svc_age_temp_xprts(struct timer_list *t);
 static void svc_delete_xprt(struct svc_xprt *xprt);
+static void svc_xprt_do_enqueue(struct svc_xprt *xprt);
 
 /* apparently the "standard" is that clients close
  * idle connections after 5 minutes, servers after
@@ -266,12 +267,12 @@ void svc_xprt_received(struct svc_xprt *xprt)
 	}
 
 	/* As soon as we clear busy, the xprt could be closed and
-	 * 'put', so we need a reference to call svc_enqueue_xprt with:
+	 * 'put', so we need a reference to call svc_xprt_do_enqueue with:
 	 */
 	svc_xprt_get(xprt);
 	smp_mb__before_atomic();
 	clear_bit(XPT_BUSY, &xprt->xpt_flags);
-	xprt->xpt_server->sv_ops->svo_enqueue_xprt(xprt);
+	svc_xprt_do_enqueue(xprt);
 	svc_xprt_put(xprt);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_received);
@@ -423,7 +424,7 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
 	return false;
 }
 
-void svc_xprt_do_enqueue(struct svc_xprt *xprt)
+static void svc_xprt_do_enqueue(struct svc_xprt *xprt)
 {
 	struct svc_pool *pool;
 	struct svc_rqst	*rqstp = NULL;
@@ -467,7 +468,6 @@ void svc_xprt_do_enqueue(struct svc_xprt *xprt)
 	put_cpu();
 	trace_svc_xprt_enqueue(xprt, rqstp);
 }
-EXPORT_SYMBOL_GPL(svc_xprt_do_enqueue);
 
 /*
  * Queue up a transport with data pending. If there are idle nfsd
@@ -478,7 +478,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 {
 	if (test_bit(XPT_BUSY, &xprt->xpt_flags))
 		return;
-	xprt->xpt_server->sv_ops->svo_enqueue_xprt(xprt);
+	svc_xprt_do_enqueue(xprt);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
 

