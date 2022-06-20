Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749755520BC
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbiFTP0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbiFTPZZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:25 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A80E39
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:39 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d128so8021950qkg.8
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wo2lc3yDrzVJrgHzbPVSfEJMuBh8U7/O8f4S+8ndsSE=;
        b=DsoMwPjtu4DQdEZRwrXd1GhWWkAAUbAc3636kjyrViEjYE1xLmk79oAC5Z5Nf/RhwG
         tZ59P5RF15L9RL3T42Rby1D1kbOzXXG2hI/ssx9lEepmoIFBxw1gRJBm3EI6z+RveX6A
         hgGEvu7xBDv4pLtrscNsEpQ3+a7RdvNTM9bzkeML9i36EFO4K9/sYsofLld2uPjH8o3t
         MWJbakX0DOFSpc+G4c5TG7bQBykgp82Qoxf8mTzt6OQR3QirivMkYq7jA+XZ1L4dfaWI
         OFXDSU2gj1DMZSfl4tq6P5uHoaG64EIApEFAdomgkPNOaPA3PA/k82iIibc9qhcqsx/8
         P+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wo2lc3yDrzVJrgHzbPVSfEJMuBh8U7/O8f4S+8ndsSE=;
        b=yC9SiNaMtKHahyhywAYCqY8k0J5wMJ+dAKx/qMI6S5pbG0DqvLH33ICu0TGqWKVaQY
         Gi0Km10CnFcOefeMqFr6sw+BJPLCiVuRIlxKzvxNpaA2eZYY5bbpZS6GemcumbQWK46G
         C82gC1hr1ke+SNgqq4gNSqGMCpNxcbockjkAHszTV9HKF9GNQL+V2FspJCplOfdaVvhe
         mBFKf7p8Gt7Mxmw2YILN7m3EhFaihf33rtb3aNMXI6DC9HkgCLY7iS5zCuIfR/UkdZGE
         PODL/+db8x7oiLfI6jg16hvcqmmysL1SVRcuF4og5LKGbXtXtDabBUu6SARjmKuIgEmF
         QNEA==
X-Gm-Message-State: AJIora/d6RNaA9WQ1EXa3e6GnKnMJIjppru2SKi54AATw7iOWnELTFYz
        GkcHTRRQimWV6qsBNOAYusz93RE4QJeLZw==
X-Google-Smtp-Source: AGRyM1sxtrj1CKTcQk944amoz9slJ52QuVmfM9X2CbHF7HgQq452Xrk8Gq9nfY/YhEmZ3bqIO8+FeA==
X-Received: by 2002:a05:620a:240f:b0:6a7:7b60:fa5a with SMTP id d15-20020a05620a240f00b006a77b60fa5amr16235985qkn.601.1655738679154;
        Mon, 20 Jun 2022 08:24:39 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:38 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 07/12] SUNRPC create an rpc function that allows xprt removal from rpc_clnt
Date:   Mon, 20 Jun 2022 11:24:02 -0400
Message-Id: <20220620152407.63127-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Expose a function that allows a removal of xprt from the rpc_clnt.

When called from NFS that's running a trunked transport then don't
decrement the active transport counter.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h          |  1 +
 include/linux/sunrpc/xprtmultipath.h |  2 +-
 net/sunrpc/clnt.c                    | 16 +++++++++++++++-
 net/sunrpc/xprt.c                    |  2 +-
 net/sunrpc/xprtmultipath.c           | 10 +++++-----
 5 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 319bcd3a3593..ac1024da86c5 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -241,6 +241,7 @@ const char *rpc_proc_name(const struct rpc_task *task);
 
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
index 1cbd598f596c..2b2515c121fa 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2157,7 +2157,8 @@ call_connect_status(struct rpc_task *task)
 				xprt_release(task);
 				value = atomic_long_dec_return(&xprt->queuelen);
 				if (value == 0)
-					rpc_xprt_switch_remove_xprt(xps, saved);
+					rpc_xprt_switch_remove_xprt(xps, saved,
+							true);
 				xprt_put(saved);
 				task->tk_xprt = NULL;
 				task->tk_action = call_start;
@@ -3128,6 +3129,19 @@ void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
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
index 6480ae324b27..ac02bf6d109a 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -2184,6 +2184,6 @@ void xprt_delete_locked(struct rpc_xprt *xprt, struct rpc_xprt_switch *xps)
 
 	if (!xprt->sending.qlen && !xprt->pending.qlen &&
 	    !xprt->backlog.qlen && !atomic_long_read(&xprt->queuelen))
-		rpc_xprt_switch_remove_xprt(xps, xprt);
+		rpc_xprt_switch_remove_xprt(xps, xprt, true);
 }
 EXPORT_SYMBOL(xprt_delete_locked);
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 4374cd6acc55..41ec46e5f1a3 100644
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
@@ -83,10 +83,10 @@ static void xprt_switch_remove_xprt_locked(struct rpc_xprt_switch *xps,
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
@@ -155,7 +155,7 @@ static void xprt_switch_free_entries(struct rpc_xprt_switch *xps)
 
 		xprt = list_first_entry(&xps->xps_xprt_list,
 				struct rpc_xprt, xprt_switch);
-		xprt_switch_remove_xprt_locked(xps, xprt);
+		xprt_switch_remove_xprt_locked(xps, xprt, true);
 		spin_unlock(&xps->xps_lock);
 		xprt_put(xprt);
 		spin_lock(&xps->xps_lock);
-- 
2.27.0

