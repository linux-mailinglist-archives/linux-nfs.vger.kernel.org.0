Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2575520CB
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbiFTPZ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244800AbiFTPZZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:25 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D5E2E
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:38 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b142so8029625qkg.2
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAI8gGH9avnmA+NDRHBSfMccao83qkbgBJ+Hjofwigk=;
        b=Xbtm1MaKT836KRHr51Znlq7oaV+zKFi+DIoW6SjfderN7BERl19vOBq/h9SnzhGCgm
         GAe6D4SF5e9l8Hb1iwkAfbNgcZCvvfNOxcA3no/CPdu5kOKS2HSaYUtE2shgbID6/4lH
         aploBZNv7SY2FzpbJjQbkB1VE0O/EVwuWcldG99OEiEMT7QEyMUZZfCIa21A+MCyvOpS
         pVmbqzzpC6m1n1rWqTZbWD2oaLus3rt5XcSTlRtPXJmzzD9THnfzmQAa0qaGc6wv/Bqu
         9TOLY4O405iTC7Hv2u+Kkm4en/YR9Id8UQn8hIpsRqy8j/4LNluuy4vB1Z68vu3Orv+y
         cbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAI8gGH9avnmA+NDRHBSfMccao83qkbgBJ+Hjofwigk=;
        b=hBHvfXqdbpHoWyBclDkgvlY9a07z+rOgqp8hmUYold+6/awEVliq8wc1l5R9ADuGRL
         vbpCMrs+nEpPtHf0a8271Nvt25WARuoC7kSI0PoH4OUef/9K8H0iB15R9yfKc8mGpZwo
         F+EI4E+7ihwV+gDHxe0tX4Q9la3brFJPkubJsqlKRW0c7XqYMVINBuqMiEZdb47xvZoZ
         OX2m1ap4zhhQQV5f3ZmOw6sL7GWzYH4IgKrUc2sdgiHwdmywNgBdJhqly2ayx/wqLcMX
         55BO7InwKx4v0ao79ssUeHmD+3bVm/gLBso+IugyasKc8XAVVqNv2g68fpxFcrSuShO0
         mclw==
X-Gm-Message-State: AJIora8FsHAK2JfBwUzAcRiPCBL6E7gRaRX/MAs5mJY+QGZ0erTFN2Uo
        2uvTUGOCdldzsDBCu9sBIpM7JSZLA5/sXw==
X-Google-Smtp-Source: AGRyM1tWKm5IydFqFIFIkxq9NkRm/UPPMtidPzyHsUVNu89TFBSGtIjzR0nrJV5Yjkg9bVFx+Q1BOA==
X-Received: by 2002:a05:620a:1272:b0:6a6:bdc1:8f92 with SMTP id b18-20020a05620a127200b006a6bdc18f92mr16608710qkl.330.1655738677643;
        Mon, 20 Jun 2022 08:24:37 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:37 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 06/12] SUNRPC enable back offline transports in trunking discovery
Date:   Mon, 20 Jun 2022 11:24:01 -0400
Message-Id: <20220620152407.63127-7-olga.kornievskaia@gmail.com>
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

When we are adding a transport to a xprt_switch that's already on
the list but has been marked OFFLINE, then make the state ONLINE
since it's been tested now.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 20aed14fe222..319bcd3a3593 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -243,6 +243,7 @@ void rpc_clnt_xprt_switch_put(struct rpc_clnt *);
 void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *, struct rpc_xprt *);
 bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 			const struct sockaddr *sap);
+void rpc_clnt_xprt_set_online(struct rpc_clnt *clnt, struct rpc_xprt *xprt);
 void rpc_cleanup_clids(void);
 
 static inline int rpc_reply_expected(struct rpc_task *task)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index b26267606de0..1cbd598f596c 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3105,8 +3105,22 @@ void rpc_clnt_xprt_switch_put(struct rpc_clnt *clnt)
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_put);
 
+void rpc_clnt_xprt_set_online(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
+{
+	struct rpc_xprt_switch *xps;
+
+	rcu_read_lock();
+	xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
+	rcu_read_unlock();
+	xprt_set_online_locked(xprt, xps);
+}
+
 void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
 {
+	if (rpc_clnt_xprt_switch_has_addr(clnt,
+		(const struct sockaddr *)&xprt->addr)) {
+		return rpc_clnt_xprt_set_online(clnt, xprt);
+	}
 	rcu_read_lock();
 	rpc_xprt_switch_add_xprt(rcu_dereference(clnt->cl_xpi.xpi_xpswitch),
 				 xprt);
-- 
2.27.0

