Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062E557D67E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiGUWHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiGUWHU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:20 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48AB93C2B
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:19 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id l24so2420293ion.13
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tv7+BXQfUtmPW8f36OVJmuLUqqT8kBfIbwZL2xjHZaw=;
        b=YdrxKhRbMyJUYP71zewWvp0/hgCpjzLsC29WM60TnSb7YDOhhMMdQvUXs90Ly04Y3o
         oQl+bgB3oSURT8wf2RfpCwnV8h7//Rzqg2UxO/aghKsrRucD6L//vYjjvaX3thTsMpbI
         qENUKs4cgetzFW9PHLZ5m3cRM/PJbIKQuHUhqfxcjoS0+x8yljwpeIxLMiA/yQJB2DQd
         +HJrLO0W0f1fakbV406tSa6B5h+X/sk8D3iDpZNZ9bTQpttQmCLwRZmlMh1Q5xyyw1J9
         WLeaHuE24RbSnsIvJE7Jbo14pHzK4wugnjPjy3AJMdTeY3TlaThZsF6dhsvLhrdot/yU
         5TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tv7+BXQfUtmPW8f36OVJmuLUqqT8kBfIbwZL2xjHZaw=;
        b=3HMA0I3K0xjRInzEIJlFn1CRQU55vxa/V+1goB2gp1835KSFvkD0TfB4RMslkSjUl6
         JkLbp203PC1gebr9+OCUHGKd50TdfAPeTBinh9likMOzE21RaVuGaQYWfNFjn+SC7ZlP
         6xQww4hezZOMDg4NKEV7YqwUETBU0Y+oZuZMOVi5L334vICmD9GUK5hgKbYtlRmEtq4+
         nxLb2xBgoclvatvflrXnbVVuLfsBPoOBUTuxFtm6RCegfmvYrVGxOuNv1a5piZCD5+9w
         kZ2L7VWL59pAuOGOqNiC6eHVXxoX6Hqf0CcjQsn/czywAeE4+AzRn3DQekkT9SdZekcX
         u3/Q==
X-Gm-Message-State: AJIora+BxEmsWnxXohe+V4vgEHy7Ez9+Hago0QkvsQmE1e63jLvCf/pV
        HS0At5V1kMgbwWeRHUw6B7k=
X-Google-Smtp-Source: AGRyM1tMcV7mt6oVs3kxT3BlFqbfd/TO88bPU/Ed9zep/nsTJ95hRtWM7wXRASVABbfDizex94WjcQ==
X-Received: by 2002:a05:6602:2d16:b0:67c:1472:815e with SMTP id c22-20020a0566022d1600b0067c1472815emr213399iow.86.1658441239438;
        Thu, 21 Jul 2022 15:07:19 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:18 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 02/11] SUNRPC add function to offline remove trunkable transports
Date:   Thu, 21 Jul 2022 18:07:05 -0400
Message-Id: <20220721220714.22620-3-olga.kornievskaia@gmail.com>
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

Iterate thru available transports in the xprt_switch for all
trunkable transports offline and possibly remote them as well.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 90501404fa49..d14333f4947a 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -234,6 +234,7 @@ int		rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *,
 			struct rpc_xprt_switch *,
 			struct rpc_xprt *,
 			void *);
+void		rpc_clnt_manage_trunked_xprts(struct rpc_clnt *);
 
 const char *rpc_proc_name(const struct rpc_task *task);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index b6781ada3aa8..6417ccc283f4 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3000,6 +3000,52 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_add_xprt);
 
+static int rpc_xprt_offline(struct rpc_clnt *clnt,
+			    struct rpc_xprt *xprt,
+			    void *data)
+{
+	struct rpc_xprt *main_xprt;
+	struct rpc_xprt_switch *xps;
+	int err = 0;
+
+	xprt_get(xprt);
+
+	rcu_read_lock();
+	main_xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
+	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
+	err = rpc_cmp_addr_port((struct sockaddr *)&xprt->addr,
+				(struct sockaddr *)&main_xprt->addr);
+	rcu_read_unlock();
+	xprt_put(main_xprt);
+	if (err)
+		goto out;
+
+	if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE)) {
+		err = -EINTR;
+		goto out;
+	}
+	xprt_set_offline_locked(xprt, xps);
+
+	xprt_release_write(xprt, NULL);
+out:
+	xprt_put(xprt);
+	xprt_switch_put(xps);
+	return err;
+}
+
+/* rpc_clnt_manage_trunked_xprts -- offline trunked transports
+ * @clnt rpc_clnt structure
+ *
+ * For each active transport found in the rpc_clnt structure call
+ * the function rpc_xprt_offline() which will identify trunked transports
+ * and will mark them offline.
+ */
+void rpc_clnt_manage_trunked_xprts(struct rpc_clnt *clnt)
+{
+	rpc_clnt_iterate_for_each_xprt(clnt, rpc_xprt_offline, NULL);
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_manage_trunked_xprts);
+
 struct connect_timeout_data {
 	unsigned long connect_timeout;
 	unsigned long reconnect_timeout;
-- 
2.27.0

