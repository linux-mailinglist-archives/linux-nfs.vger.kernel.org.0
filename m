Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B857D681
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiGUWHY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiGUWHX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2973788744
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r70so2424995iod.10
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIyXLih17IFq9Hem/fPPzOaVUqi9lAXKUF6zPciEpd0=;
        b=b8aJtlsGTgDRcNnZJBYO2Pb+gfpxgRuwL6yqzSPRIqb7hyYECtWr0kAqgLHcThG4TI
         48j5h89AsAk8jCmM+BUuXH1rQbVlNlPi0nB/7u4STL+CWEMQQfsxXFXsc1OkOq1ZDzIw
         GC5O2WmAI6KdS64xu6Aqs9Z8sEDrdoEL38DlPEcym/84EX92+6aDbIttK3w9TsvMkM9m
         hevU6tqF/7uoazlaecYzmn12yeK+cP6EapiPY84R0Y6XkYk8m0nWlCbq14MJvnaAdhuM
         vG0N4X7bXaRCj98qk2Bk232ohrIRqW9Q1W4ziB0Y9Ua/a4Ua04W50T+YcYVD7F3+Tr21
         pUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIyXLih17IFq9Hem/fPPzOaVUqi9lAXKUF6zPciEpd0=;
        b=icGfx2PknKwXJay1UXtoCtMmWBGjvSnhG3GFC+funDv8ZP8XgRx3651TMQzF8m80MD
         /g+QShIqM6fHFlVvSbyMMz3KYFQBb1uteCyrmO8nZ2dkoXAM/wRLvd1ER3+EdPoXE98v
         FrkNk0gEqQj/gtNUj5haBx3+HXMSvK1f8M9DriMLb1DP4OpOv9xVp7xTWeuA8XsW5rdM
         /MPl5CadTdwsfia7h2XdbGWNd6CGu8fMX5MQXppKIipjIpsi92c7fzvOyRGBgYTSVnKh
         5STmF5hr4RPXNDbVf1F/SeYiSyqTd/h5ZHO9mjD0eo0ZNo5SM4V4mZgc21TI9uYPo1XZ
         pFlQ==
X-Gm-Message-State: AJIora9XPk/T+3NXvV+QZQAHVpwqbQYGQUW/GnQrPGP1OX+/4MRFSJdb
        9t3mQ0j9AQt+I9dQtfMN+Kw=
X-Google-Smtp-Source: AGRyM1v7LLPmvyF4KXid4q0s9By+Z5RkVqK7guI4PE7vIz/3UyPps8v5Yw5nmBv8wHV8M1xFiaEgGw==
X-Received: by 2002:a6b:f910:0:b0:67c:4d66:3a88 with SMTP id j16-20020a6bf910000000b0067c4d663a88mr228950iog.49.1658441242572;
        Thu, 21 Jul 2022 15:07:22 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:22 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/11] SUNRPC enable back offline transports in trunking discovery
Date:   Thu, 21 Jul 2022 18:07:08 -0400
Message-Id: <20220721220714.22620-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
References: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
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
index d14333f4947a..71a3a1dd7e81 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -242,6 +242,7 @@ void rpc_clnt_xprt_switch_put(struct rpc_clnt *);
 void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *, struct rpc_xprt *);
 bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 			const struct sockaddr *sap);
+void rpc_clnt_xprt_set_online(struct rpc_clnt *clnt, struct rpc_xprt *xprt);
 void rpc_cleanup_clids(void);
 
 static inline int rpc_reply_expected(struct rpc_task *task)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index ada45b3b1dad..036ccf01bd25 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3095,8 +3095,22 @@ void rpc_clnt_xprt_switch_put(struct rpc_clnt *clnt)
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

