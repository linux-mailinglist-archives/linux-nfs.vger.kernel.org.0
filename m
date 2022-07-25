Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DCA57FFE3
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiGYNcq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiGYNcp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:45 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95DA13D02
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:41 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 125so10665670vsd.5
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=at3mNlfLOH97Ir0Fdue3RGJuX76dg81P3MvlVlvBCks=;
        b=CegaW35mSHtigHvCPO/ei2u+dstKR1r22XNzSLAreUAC1FYJmhh39E/iA7T5dHN5yX
         i1xqJERTl/yIqGY2m5jDrr2Fg1GAQ9K/5muxmfEe3lzxKJaZMgFu8EQgkvgoV9UIVEhR
         wXS26Q1GhORiLW62csgrFAyZivFZGSnH6xliOqcgc1XPWSXQufh/OOD4m6c7BA7Z4XNz
         HWp/2DyooWGA+qRtVn63A6QygrD7Cagw3E+FVPb4SRMP3zhmMCrviZs6iuKYjvmrFCm7
         B4R3oxBubhSUUlxQ4vgCjsFa7kFQM/fipUlVtwRuU/yJFm96wuquKkydZwMTXy+gGuXh
         /PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=at3mNlfLOH97Ir0Fdue3RGJuX76dg81P3MvlVlvBCks=;
        b=RKdvUfUYz/m78EBJHs3xT08NQOuSuI1QQTAJYYQ6G/BswG98ahBGX46ZEEka4tx3L3
         KClyx9KcOy8rcngvDSdWAsPO+U/vGLhddn+A7S85R3PTtIvI45Iz209i5RZGkZznXlmh
         oCVzwsvAK0kRCxhmBynKKEfxkTGapxL0YzMGZ8RPWYbBMC+GEsiEGWbtDA3uQyfzmnQ9
         2+gc8VdrGr0rNo7Klroh8xJR6Jn8z7ur46x71HkUVIF/TdgUVD4+EibKftjajG3YEPAb
         jnOYQ9Nli5F2VkcoZDJxU1UQfWGtZNIwntkM5LKLMisMpG53EEXvXcwtVqvg2JkZs6jy
         DH9g==
X-Gm-Message-State: AJIora+rgRc9OOHxU9rmp9JMksE3AclIgvECSSU3HqZGNuUSZ2T5Z0wf
        1gPu49tNuqRM7aOKBoTs5ww=
X-Google-Smtp-Source: AGRyM1v6Js2mHob8dL6w36sM17dVx3RG8WlXnrNBgiHTkrqtheW2ihfgG63SzjaJUxm9XdBWUM8Qew==
X-Received: by 2002:a67:b809:0:b0:358:4c3:c1bf with SMTP id i9-20020a67b809000000b0035804c3c1bfmr3232490vsf.64.1658755961304;
        Mon, 25 Jul 2022 06:32:41 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:40 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 06/11] SUNRPC create an rpc function that allows xprt removal from rpc_clnt
Date:   Mon, 25 Jul 2022 09:32:26 -0400
Message-Id: <20220725133231.4279-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
References: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Expose a function that allows a removal of xprt from the rpc_clnt.

When called from NFS that's running a trunked transport then don't
decrement the active transport counter.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h          |  1 +
 include/linux/sunrpc/xprtmultipath.h |  2 +-
 net/sunrpc/clnt.c                    | 16 +++++++++++++++-
 net/sunrpc/xprt.c                    |  2 +-
 net/sunrpc/xprtmultipath.c           | 11 ++++++-----
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 71a3a1dd7e81..7a43fd514398 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -240,6 +240,7 @@ const char *rpc_proc_name(const struct rpc_task *task);
 
 void rpc_clnt_xprt_switch_put(struct rpc_clnt *);
 void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *, struct rpc_xprt *);
+void rpc_clnt_xprt_switch_remove_xprt(struct rpc_clnt *, struct rpc_xprt *);
 bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 			const struct sockaddr *sap);
 void rpc_clnt_xprt_set_online(struct rpc_clnt *clnt, struct rpc_xprt *xprt);
diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index 688ca7eb1d01..9fff0768d942 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -55,7 +55,7 @@ extern void rpc_xprt_switch_set_roundrobin(struct rpc_xprt_switch *xps);
 extern void rpc_xprt_switch_add_xprt(struct rpc_xprt_switch *xps,
 		struct rpc_xprt *xprt);
 extern void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
-		struct rpc_xprt *xprt);
+		struct rpc_xprt *xprt, bool offline);
 
 extern void xprt_iter_init(struct rpc_xprt_iter *xpi,
 		struct rpc_xprt_switch *xps);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 9dbce3b0d3a2..26f3102500bb 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2144,7 +2144,8 @@ call_connect_status(struct rpc_task *task)
 				xprt_release(task);
 				value = atomic_long_dec_return(&xprt->queuelen);
 				if (value == 0)
-					rpc_xprt_switch_remove_xprt(xps, saved);
+					rpc_xprt_switch_remove_xprt(xps, saved,
+								    true);
 				xprt_put(saved);
 				task->tk_xprt = NULL;
 				task->tk_action = call_start;
@@ -3118,6 +3119,19 @@ void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_add_xprt);
 
+void rpc_clnt_xprt_switch_remove_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
+{
+	struct rpc_xprt_switch *xps;
+
+	rcu_read_lock();
+	xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
+	rpc_xprt_switch_remove_xprt(rcu_dereference(clnt->cl_xpi.xpi_xpswitch),
+				    xprt, 0);
+	xps->xps_nunique_destaddr_xprts--;
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_remove_xprt);
+
 bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 				   const struct sockaddr *sap)
 {
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 8f8e3c952f24..44348c9f4b00 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -2182,5 +2182,5 @@ void xprt_delete_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps)
 
 	if (!xprt->sending.qlen && !xprt->pending.qlen &&
 	    !xprt->backlog.qlen && !atomic_long_read(&xprt->queuelen))
-		rpc_xprt_switch_remove_xprt(xps, xprt);
+		rpc_xprt_switch_remove_xprt(xps, xprt, true);
 }
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 8def8423fc0a..55da01730311 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -62,11 +62,11 @@ void rpc_xprt_switch_add_xprt(struct rpc_xprt_switch *xps,
 }
 
 static void xprt_switch_remove_xprt_locked(struct rpc_xprt_switch *xps,
-		struct rpc_xprt *xprt)
+		struct rpc_xprt *xprt, bool offline)
 {
 	if (unlikely(xprt == NULL))
 		return;
-	if (!test_bit(XPRT_OFFLINE, &xprt->state))
+	if (!test_bit(XPRT_OFFLINE, &xprt->state) && offline)
 		xps->xps_nactive--;
 	xps->xps_nxprts--;
 	if (xps->xps_nxprts == 0)
@@ -79,14 +79,15 @@ static void xprt_switch_remove_xprt_locked(struct rpc_xprt_switch *xps,
  * rpc_xprt_switch_remove_xprt - Removes an rpc_xprt from a rpc_xprt_switch
  * @xps: pointer to struct rpc_xprt_switch
  * @xprt: pointer to struct rpc_xprt
+ * @offline: indicates if the xprt that's being removed is in an offline state
  *
  * Removes xprt from the list of struct rpc_xprt in xps.
  */
 void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
-		struct rpc_xprt *xprt)
+		struct rpc_xprt *xprt, bool offline)
 {
 	spin_lock(&xps->xps_lock);
-	xprt_switch_remove_xprt_locked(xps, xprt);
+	xprt_switch_remove_xprt_locked(xps, xprt, offline);
 	spin_unlock(&xps->xps_lock);
 	xprt_put(xprt);
 }
@@ -155,7 +156,7 @@ static void xprt_switch_free_entries(struct rpc_xprt_switch *xps)
 
 		xprt = list_first_entry(&xps->xps_xprt_list,
 				struct rpc_xprt, xprt_switch);
-		xprt_switch_remove_xprt_locked(xps, xprt);
+		xprt_switch_remove_xprt_locked(xps, xprt, true);
 		spin_unlock(&xps->xps_lock);
 		xprt_put(xprt);
 		spin_lock(&xps->xps_lock);
-- 
2.27.0

