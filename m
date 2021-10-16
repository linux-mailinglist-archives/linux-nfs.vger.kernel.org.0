Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F8743057C
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbhJPWuD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240998AbhJPWt7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D626561244;
        Sat, 16 Oct 2021 22:47:50 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 14/14] SUNRPC: Yank some low-value dprintk call sites
Date:   Sat, 16 Oct 2021 18:47:49 -0400
Message-Id:  <163442446972.1001.174496904271883067.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3739; h=from:subject:message-id; bh=FA7M9QhADGW1rqNzKNuCaofdCkgoHYRcbNm1k2t/9SE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1aVNtWWMW1ZhYE8HMw38DDafXMfmdoqjglZhDrQ g9S3O/OJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWlQAKCRAzarMzb2Z/l1dMEA Cno7ifXmMmGg+8ZltRtwy/DYyuu1X9ywikT1BttH8Hdv7TEtzp4qmYRj0abrfaZMRiTH8Bc1hVFZdO kHXy44RnSHDUdGrG3mvV6M30Zu/AHxbnJSvJqMXK8+h32c+Q1X0krA21sKiNkW341zc7tI9IVZqa2c 6RLhhI3K0EN+b+ZAdoJ/c/WkP3TB/7mstg08t8dp+kSVn7WapUtM0QI/lBDuy/tdYnI/lK32coCfeV 9rDLGcbwWmTPw0OrPw+toEcdYwbgCIk8shFF5kKFKlJ8PkILv2EwZdF/kvHDgX645d/RWVD0oh14Xd gQS9Blb86F0ko/yYc/ZdTuMqMgp4IvavVSr5eJO4cpsdntKjOVPH/3vgUJHbOHXcFtC5c+M+81AFxg CmECSDBriErEXAi3xcOqiFSnULSPvQFUve0krzKru3m0xGyxfbuMI1c6Bbvk8cN6zwmiu0GXOPbU1U MeQU/yUiyR968gyaVmUnmF9pQ60I05kmnb9rDQG13RZ50m4UiEsXGy15Y9+VhMEtEkI6Lx18aj9nsB uFFzByLP0MIp1HEiyewIF7FXXgZPGMMwnhKgAz71kIMUAuDg7oGM2HW1hXpq9kbf4/qe+BILsIMAa4 FfDKHv2oAqpiLt4YEaorEwTIirA4nfEmVZ4tjwDBEmWfDViCeD7F0INJFa3w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. These can be replaced by function-boundary tracing.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |   19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 1e99ba1b9d72..f40b88eb5e12 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -20,8 +20,6 @@
 #include <linux/netdevice.h>
 #include <trace/events/sunrpc.h>
 
-#define RPCDBG_FACILITY	RPCDBG_SVCXPRT
-
 static unsigned int svc_rpc_per_connection_limit __read_mostly;
 module_param(svc_rpc_per_connection_limit, uint, 0644);
 
@@ -78,8 +76,6 @@ int svc_reg_xprt_class(struct svc_xprt_class *xcl)
 	struct svc_xprt_class *cl;
 	int res = -EEXIST;
 
-	dprintk("svc: Adding svc transport class '%s'\n", xcl->xcl_name);
-
 	INIT_LIST_HEAD(&xcl->xcl_list);
 	spin_lock(&svc_xprt_class_lock);
 	/* Make sure there isn't already a class with the same name */
@@ -97,7 +93,6 @@ EXPORT_SYMBOL_GPL(svc_reg_xprt_class);
 
 void svc_unreg_xprt_class(struct svc_xprt_class *xcl)
 {
-	dprintk("svc: Removing svc transport class '%s'\n", xcl->xcl_name);
 	spin_lock(&svc_xprt_class_lock);
 	list_del_init(&xcl->xcl_list);
 	spin_unlock(&svc_xprt_class_lock);
@@ -829,9 +824,6 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		svc_xprt_received(xprt);
 	} else if (svc_xprt_reserve_slot(rqstp, xprt)) {
 		/* XPT_DATA|XPT_DEFERRED case: */
-		dprintk("svc: server %p, pool %u, transport %p, inuse=%d\n",
-			rqstp, rqstp->rq_pool->sp_id, xprt,
-			kref_read(&xprt->xpt_ref));
 		rqstp->rq_deferred = svc_deferred_dequeue(xprt);
 		if (rqstp->rq_deferred)
 			len = svc_deferred_recv(rqstp);
@@ -951,11 +943,8 @@ static void svc_age_temp_xprts(struct timer_list *t)
 	struct svc_xprt *xprt;
 	struct list_head *le, *next;
 
-	dprintk("svc_age_temp_xprts\n");
-
 	if (!spin_trylock_bh(&serv->sv_lock)) {
 		/* busy, try again 1 sec later */
-		dprintk("svc_age_temp_xprts: busy\n");
 		mod_timer(&serv->sv_temptimer, jiffies + HZ);
 		return;
 	}
@@ -972,7 +961,6 @@ static void svc_age_temp_xprts(struct timer_list *t)
 			continue;
 		list_del_init(le);
 		set_bit(XPT_CLOSE, &xprt->xpt_flags);
-		dprintk("queuing xprt %p for closing\n", xprt);
 
 		/* a thread will dequeue and close it soon */
 		svc_xprt_enqueue(xprt);
@@ -999,7 +987,6 @@ void svc_age_temp_xprts_now(struct svc_serv *serv, struct sockaddr *server_addr)
 		xprt = list_entry(le, struct svc_xprt, xpt_list);
 		if (rpc_cmp_addr(server_addr, (struct sockaddr *)
 				&xprt->xpt_local)) {
-			dprintk("svc_age_temp_xprts_now: found %p\n", xprt);
 			list_move(le, &to_be_closed);
 		}
 	}
@@ -1011,8 +998,6 @@ void svc_age_temp_xprts_now(struct svc_serv *serv, struct sockaddr *server_addr)
 		xprt = list_entry(le, struct svc_xprt, xpt_list);
 		set_bit(XPT_CLOSE, &xprt->xpt_flags);
 		set_bit(XPT_KILL_TEMP, &xprt->xpt_flags);
-		dprintk("svc_age_temp_xprts_now: queuing xprt %p for closing\n",
-				xprt);
 		svc_xprt_enqueue(xprt);
 	}
 }
@@ -1386,8 +1371,6 @@ static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
 	unsigned int pidx = (unsigned int)*pos;
 	struct svc_serv *serv = m->private;
 
-	dprintk("svc_pool_stats_start, *pidx=%u\n", pidx);
-
 	if (!pidx)
 		return SEQ_START_TOKEN;
 	return (pidx > serv->sv_nrpools ? NULL : &serv->sv_pools[pidx-1]);
@@ -1398,8 +1381,6 @@ static void *svc_pool_stats_next(struct seq_file *m, void *p, loff_t *pos)
 	struct svc_pool *pool = p;
 	struct svc_serv *serv = m->private;
 
-	dprintk("svc_pool_stats_next, *pos=%llu\n", *pos);
-
 	if (p == SEQ_START_TOKEN) {
 		pool = &serv->sv_pools[0];
 	} else {

