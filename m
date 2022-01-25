Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592ED49BBB3
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiAYTAx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiAYTAv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:00:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C76C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:00:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B524FCE1A5C
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 19:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD621C340E0;
        Tue, 25 Jan 2022 19:00:46 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     neilb@suse.de
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 1/2] SUNRPC: Remove the .svo_enqueue_xprt method
Date:   Tue, 25 Jan 2022 14:00:45 -0500
Message-Id:  <164313724534.3285.9750535460628123459.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164313706374.3285.4265550102084857832.stgit@bazille.1015granger.net>
References:  <164313706374.3285.4265550102084857832.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; h=from:subject:message-id; bh=+wBuNq44qBv2nO2SDnTal3ukrlfuKJeCXxPZ75G7Q8w=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8EjdAJt4QLJF6CCuWJvqjGQg2OcFTDhKpE4XRHwm FFvmE3KJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfBI3QAKCRAzarMzb2Z/l5SoEA C0Id5IceUkDOoJGxjpAgHRLhRNMlza0lI5ZV8SjOPLDFqmwfo4n/mt/HIx+5CNSL9XuSU+R5P1jX0K bTUU6NentVAsozY1qyFoA+YASiyI0O5G4UA3JraWD61mJHKHIIp7OgAQg62xP0k9SYCaRPWhAQkPC4 iR5gChCagUO038EEpb0p7TmdkM18x7i9nQrjQjpWFdon88aMEwIffu+sHat/w0/n1LN0EYJyByRTLf V/hOKz/tdo92aq42lDL9j6TDzSkRnzuS6BGljEeoQf32NEvLqfO9CLLoCiiLCwMgKfWENX8zC/oQQq spOwTH++XPGQv3VqFzyuEXsr+reBXodUDEqJUwkcZPKYvQ6g8NKGIBPSFxvmKbpsT8jI7OOYC77BD0 Sdf6VgvIbY8Y/45lNO5OAp5dhQMPhhdPMoLCLf2JmjIkHMQzY46q1+WpgbxdmLshSIZ8AHYrWbBpZB NeqKkRTzqYaRwrdYJFgwK9n+ccKyNRSLGdmNBpB/Z4+6xybW5PIYRSHR58oV4dkcKbkm9Xuuvx7t/t yHCpF8x16rr18EsbvfJa4TgFlD/ql92Rd9a47KF/sl7J2IZ5vH7/VSd1A1U7pbqFa4guag8Ll5CMoB QGxb38vWyg2P73TddYsgKTGtcwy/B5PGatoyYPH+lMaMh8wvfHdwFhnhFlmQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
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
 

