Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3F31C0D5
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 18:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhBORlr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 12:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhBORlb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 12:41:31 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA0C06178A
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id y26so12462535eju.13
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTkj77Ym7544w3Cv1HEeqhGGGNI3jkJddVNjSgF5JSM=;
        b=aBhRRxYEGjKIVnW+nFZ2F9hmFqHwnugVFPEzBWtK1AmuexsqeIe9A+M6EPrlISuvoz
         XjOm8hCocShBgUcZqwAl6syKi9vIYRc0Ctu6/ZgraGGAP7rin8fimBdmJUGIM+NI15jj
         ovHFtHo/tXILWDfdW5OMc8xMf8/vcpaSPMoHdalEZKve0IJdWICotjWXgcT6NyQnoqLl
         ZDMQ0kjJEVvq39FCtNm1vP5uXQNbQJOVufIMlVqjjb4Zzi9yoZZqOmmZYuoliHaqDhtQ
         SxCCfNwMoHF01krCcHEwetBDaTu327TxoCi7tMlcFDqC9D9w256RfTYl+/jaWIbxrHEu
         uMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTkj77Ym7544w3Cv1HEeqhGGGNI3jkJddVNjSgF5JSM=;
        b=Tk18dftFzxGK7G+qY0h/er18zgw3/J8YVT19FyM09OhOVR8B/n896SLVJNEYkv5VjR
         zenrqkgS0IW3LrMqU1K8ts5KkvA3lE7UCWsSksA27x1G9e3TSwD44JFgs0Yxx2Y8trfe
         yrcVHRuMJBCDXxXAULIK6Uo0Xh7olf1vK6p3Sn2CJRdUi2CfK4OrSHpx0bMq5vduKBEZ
         MZAG0Y5J6nn6YEDdQ1GmFB8oIqogY6eCEcLAeyeCYYYTOL3zHwNXA7O07SS6S/T570Hy
         zTH5gfm2dhiVns8+sfUPmlBe4AxeWTzTVGauuugFYO9rF0otvPa98+DgtdRQMj5y2z3D
         TYbQ==
X-Gm-Message-State: AOAM5336u8xU7kgb6MNu/eYD11NSZwtIYC+Wjj/rxk54zt22n4AoPvg+
        VrzC97QE2C05r0xYLLzYOkSNDuLlxmqN6Q==
X-Google-Smtp-Source: ABdhPJwDB4FmKOP6iI9YzsZTgSoPqQs9AlvQqocxmvtjcKoFD9C2teTbegtNDfOj3XbAMldL6dhmWw==
X-Received: by 2002:a17:906:1d51:: with SMTP id o17mr16852474ejh.85.1613410810984;
        Mon, 15 Feb 2021 09:40:10 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e11sm11257485ejz.94.2021.02.15.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:40:10 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v1 5/8] sunrpc: add IDs to multipath
Date:   Mon, 15 Feb 2021 19:39:59 +0200
Message-Id: <20210215174002.2376333-6-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215174002.2376333-1-dan@kernelim.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is used to uniquely identify sunrpc multipath objects in /sys.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 include/linux/sunrpc/xprtmultipath.h |  4 ++++
 net/sunrpc/sunrpc_syms.c             |  1 +
 net/sunrpc/xprtmultipath.c           | 27 +++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index c6cce3fbf29d..ef95a6f18ccf 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -14,6 +14,7 @@ struct rpc_xprt_switch {
 	spinlock_t		xps_lock;
 	struct kref		xps_kref;
 
+	unsigned int		xps_id;
 	unsigned int		xps_nxprts;
 	unsigned int		xps_nactive;
 	atomic_long_t		xps_queuelen;
@@ -71,4 +72,7 @@ extern struct rpc_xprt *xprt_iter_get_next(struct rpc_xprt_iter *xpi);
 
 extern bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
 		const struct sockaddr *sap);
+
+extern void xprt_multipath_cleanup_ids(void);
+
 #endif
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index b61b74c00483..691c0000e9ea 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -134,6 +134,7 @@ cleanup_sunrpc(void)
 	rpc_sysfs_exit();
 	rpc_cleanup_clids();
 	xprt_cleanup_ids();
+	xprt_multipath_cleanup_ids();
 	rpcauth_remove_module();
 	cleanup_socket_xprt();
 	svc_cleanup_xprt_sock();
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 78c075a68c04..52a9584b23af 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -86,6 +86,31 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
 	xprt_put(xprt);
 }
 
+static DEFINE_IDA(rpc_xprtswitch_ids);
+
+void xprt_multipath_cleanup_ids(void)
+{
+       ida_destroy(&rpc_xprtswitch_ids);
+}
+
+static int xprt_switch_alloc_id(struct rpc_xprt_switch *xps)
+{
+       int id;
+
+       id = ida_simple_get(&rpc_xprtswitch_ids, 0, 0, GFP_KERNEL);
+       if (id < 0)
+               return id;
+
+       xps->xps_id = id;
+       return 0;
+}
+
+static void xprt_switch_free_id(struct rpc_xprt_switch *xps)
+{
+       ida_simple_remove(&rpc_xprtswitch_ids, xps->xps_id);
+}
+
+
 /**
  * xprt_switch_alloc - Allocate a new struct rpc_xprt_switch
  * @xprt: pointer to struct rpc_xprt
@@ -103,6 +128,7 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 	if (xps != NULL) {
 		spin_lock_init(&xps->xps_lock);
 		kref_init(&xps->xps_kref);
+		xprt_switch_alloc_id(xps);
 		xps->xps_nxprts = xps->xps_nactive = 0;
 		atomic_long_set(&xps->xps_queuelen, 0);
 		xps->xps_net = NULL;
@@ -136,6 +162,7 @@ static void xprt_switch_free(struct kref *kref)
 			struct rpc_xprt_switch, xps_kref);
 
 	xprt_switch_free_entries(xps);
+	xprt_switch_free_id(xps);
 	kfree_rcu(xps, xps_rcu);
 }
 
-- 
2.26.2

