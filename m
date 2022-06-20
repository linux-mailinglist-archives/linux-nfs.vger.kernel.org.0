Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89DD5520C3
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244363AbiFTPZ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbiFTPZX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:23 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149DD5B
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:33 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d128so8021950qkg.8
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GoaoM6ogY4Mum6uu9CHrMnGbDA5hu/5lbm7nPIoCHRI=;
        b=lk/FT0PoLGS5U1RSeu2ksB1pfWRVsaXQ9KuAWJmAwUTsdpdiJ7vkOqmBrAWVcTMuxN
         nFpZTRH+B2UyavWbNc+1tCDHi84hwMoKrKXHDUS9huf0wu89ruFnMAFv2TIaQMktdnbW
         IOr0KOkoT8b35Wibuy5tx3/k3P4lVjJ6FMhYf+XU6kSe+hnqa1EOdXPZR6Fv9omV4NML
         S7oLA4rQQfFpwL5AU0DezQZKQDJkNrGJb4OIhmhVXwWHooZyZWKzcgibAYLQ42Z25YBu
         RXROfYrnM8oR294xX8qZWBV+gnAiZjzq+i0sOHwVuI5G9YnAgJkZdUvZ1kNT4gzUIFHT
         ffrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GoaoM6ogY4Mum6uu9CHrMnGbDA5hu/5lbm7nPIoCHRI=;
        b=Yj4CQSivNaJYS89/RzTeWHlA4GWKLrXpm2WHCjlq/vKCa4itTDgOYaBqGalGFGV5g2
         ioBx16mQh0oRj9c3jgPg6xthBF0HMLldsEDbQBiEaeVz+XKjYLyhKJ8hhSLm0HxJUVxy
         GRD8uUnDsuCy+k0CUNNLGQ7mQH8zrdGU9UHQz8NDTLIkT2P82fKB9eMKaf+0T+NTDfk0
         dXLnDU+AX2H2YDFZQ9qSsoc2YRnuIq2EGLWWeLynFlxMB56YtSRXnkCcUsNcy9OvW85r
         ROgaw68MJNMx3ODMpuuBRjGdfklSdE+miOtrbZbDa2irD7mTAA/z6jeIlPVMPqvGRwCw
         OGSA==
X-Gm-Message-State: AJIora9/1QezOU/hhe28n84p779/IkNPcHif2MnSkNKtbH6OX78Ii42C
        t4JALvRl1QyfZkJoPm72bfA=
X-Google-Smtp-Source: AGRyM1uOKbz3OSpVRP6/brJgzV6OjAgfa8mYbI2poZE09dXbe5P2JQzxsFiwsj/IHzjckMJSYpOBDg==
X-Received: by 2002:a05:620a:29c7:b0:6a7:4252:2607 with SMTP id s7-20020a05620a29c700b006a742522607mr16905411qkp.115.1655738672873;
        Mon, 20 Jun 2022 08:24:32 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:32 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 02/12] SUNRPC add function to offline remove trunkable transports
Date:   Mon, 20 Jun 2022 11:23:57 -0400
Message-Id: <20220620152407.63127-3-olga.kornievskaia@gmail.com>
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

Iterate thru available transports in the xprt_switch for all
trunkable transports offline and possibly remote them as well.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 90501404fa49..e74a0740603b 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -234,6 +234,7 @@ int		rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *,
 			struct rpc_xprt_switch *,
 			struct rpc_xprt *,
 			void *);
+void		rpc_clnt_manage_trunked_xprts(struct rpc_clnt *, void *);
 
 const char *rpc_proc_name(const struct rpc_task *task);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index e2c6eca0271b..544b55a3aa20 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2999,6 +2999,48 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_add_xprt);
 
+static int rpc_xprt_offline_destroy(struct rpc_clnt *clnt,
+				    struct rpc_xprt *xprt,
+				    void *data)
+{
+	struct rpc_xprt *main_xprt;
+	struct rpc_xprt_switch *xps;
+	int err = 0;
+	int *offline_destroy = (int *)data;
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
+	if (*offline_destroy)
+		xprt_delete_locked(xprt, xps);
+
+	xprt_release_write(xprt, NULL);
+out:
+	xprt_put(xprt);
+	xprt_switch_put(xps);
+	return err;
+}
+
+void rpc_clnt_manage_trunked_xprts(struct rpc_clnt *clnt, void *data)
+{
+	rpc_clnt_iterate_for_each_xprt(clnt, rpc_xprt_offline_destroy, data);
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_manage_trunked_xprts);
+
 struct connect_timeout_data {
 	unsigned long connect_timeout;
 	unsigned long reconnect_timeout;
-- 
2.27.0

