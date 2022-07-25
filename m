Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D011457FFE4
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiGYNcr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiGYNcp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:45 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A5DF74
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:41 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id a7so3733650vkl.0
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y70jAlZuFllBcs0jQL6+urZP8GkrpekIVhztVZKEesg=;
        b=hQikaHH9gWj/3YMtoGB0sfl+MrlyL7Vbh/PuQoORrcsKO6tVQps0DWW7u0hP4Ayht4
         ZZRsGPCiaGTY1vrCpTpfqr8Tb3h1sUgeYNhj6aTKe40PisAxqD3jgLT/k5s5+7KslXzD
         n8A3UmfL3pvsQU70vaeikZuxDWYPXmt1HgBKSr9xczzlP5OCxO4/tNT2sjMS2Lwl7JfM
         AqZnsN4F/wmkrPgKqysEqpkwyFiOWp3lHSILQuhbdUKBThrxY3kRqaMs4kucgTdeiSGI
         kjuqyqZtWbmevXqy4Ep3RRz+UR9yL4Q3fDlnm1vYQzjLvS52GtzNn7UadunoRfkVUVId
         1RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y70jAlZuFllBcs0jQL6+urZP8GkrpekIVhztVZKEesg=;
        b=aAIQn+Y+Dt50KW90itt1myRDL4i0mMmgqheDhfsg/W44LXMliuByXa92O+uyQRZIbD
         bbmugQJZI+ke4nT9Ph/UJu8QGNch7Hw5mz2mD4Zq0zHUTWKh67bXfSaUeNirJfIzX2eW
         baGDCF/QWI7ObnlVXVjRCDQECjbDz+MNQqRhbTPMP21NZwytG+47n1Eexicoa0GnWyGz
         8XSaN5oOOZf/SKavaN/0Yo0fCbsoDCyFMrkCudixU78V82dfFIPaKUBU4TBUOCtFs8C6
         DC4wPje8/bjtYIphhFT3dM+KOcUu8gCOpCBpaFy3FxfYo1qB90t+ASAE6UY6Ly8kf0dw
         twag==
X-Gm-Message-State: AJIora++D6dwkqalW5RvCGb3pFoP2fbnELw4+7m2Yg+dSeP5N478C33L
        ZZb1OExtLrvEk76jPyreAVA=
X-Google-Smtp-Source: AGRyM1t9Dhtyj504K+QVrehSC3GeIOvaREfbDbPDFKte2+Y9iFJws4JrD0Mr/LpMuHs+F9IoEd6YWA==
X-Received: by 2002:a1f:48c7:0:b0:376:3a67:4c13 with SMTP id v190-20020a1f48c7000000b003763a674c13mr2386003vka.2.1658755959954;
        Mon, 25 Jul 2022 06:32:39 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:39 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 05/11] SUNRPC enable back offline transports in trunking discovery
Date:   Mon, 25 Jul 2022 09:32:25 -0400
Message-Id: <20220725133231.4279-6-olga.kornievskaia@gmail.com>
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
index 68021b70340d..9dbce3b0d3a2 100644
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

