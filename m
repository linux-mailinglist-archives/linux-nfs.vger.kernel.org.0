Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE53A04E1
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhFHUCk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:02:40 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:40590 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbhFHUCh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:02:37 -0400
Received: by mail-qt1-f172.google.com with SMTP id t9so9773205qtw.7
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=pwZjDtLSm9GkvizQzX+4ZFhuzEFRjTZGQEHv/Spe/yxwEA3y5Gkxzp81V7G+xAlOxk
         Pn0yv6IdUBzXcxCbDjIMKxak7GNgkGBludBICqTyGeWBMJBPaQPWapBeto01CnnXncOb
         7BX5eat5uRClWjtnHI2mML0JfCgMoJYUvasuy19iyov8PBshm5R/p3qhYw5YY1Eu23sE
         IQbmHUGXpVNw+GsKePuWVcuhrPj9KFjFICD7uPBhxc0MVkJXjrnuKomBZHBPZ6oxx+MD
         8fYXVxkhZZiPsq+l+mpatzkXtowslJSx1uHoQxQ5YVeCxdh7f3FYdCVHmwhXnn9/sb/e
         9tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=IiYe4YXwKqpqYBL4ee34o+pvUIEgjdABWmHnjkZTggYcxUshgLtcaxVYFuGlfDR7Q2
         riyX4P3PlfLrAmMp6h+vr49K+Khab9MnDY9TqC00PIjBOWXs4sl55q9ZJL60776AYrWW
         7iiDhq85BfxRhtnEekHa+iXreTX2gTwEW8Pg+BC3+ejlYWd0e93bpnpuDyfCKYn0FKqp
         AY7SsPUbHMF7QB5TunTvdnXIJ9ArmPFt9b6GUVHyn/TScg0+1qNRUu7MbkooyUxu2QmJ
         KgAJOBltsEULpoiKkb//cMI4dmc4EilAPbabIBrj5H8MiUajsrmnFeV4FBHw05TXirgR
         00hA==
X-Gm-Message-State: AOAM533m0P5xmP50tiIPucmD3ZZ5NyuF3e5KpizgehzvWwcBhnwDgCJH
        9nhsKIR3lTu5MmaJz9fDefE=
X-Google-Smtp-Source: ABdhPJxGxtVn6BmafLWJDS9qketg5KBUpwfj+cbXWXghwkGiaHkyQyF2po7Qi7c5lWLgEPOam/XNHg==
X-Received: by 2002:aed:30c1:: with SMTP id 59mr22552695qtf.16.1623182372938;
        Tue, 08 Jun 2021 12:59:32 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:32 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 05/13] sunrpc: add IDs to multipath
Date:   Tue,  8 Jun 2021 15:59:14 -0400
Message-Id: <20210608195922.88655-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This is used to uniquely identify sunrpc multipath objects in /sys.

Signed-off-by: Dan Aloni <dan@kernelim.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtmultipath.h |  4 ++++
 net/sunrpc/sunrpc_syms.c             |  1 +
 net/sunrpc/xprtmultipath.c           | 26 ++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

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
index 78c075a68c04..4969a4c216f7 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -86,6 +86,30 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
 	xprt_put(xprt);
 }
 
+static DEFINE_IDA(rpc_xprtswitch_ids);
+
+void xprt_multipath_cleanup_ids(void)
+{
+	ida_destroy(&rpc_xprtswitch_ids);
+}
+
+static int xprt_switch_alloc_id(struct rpc_xprt_switch *xps, gfp_t gfp_flags)
+{
+	int id;
+
+	id = ida_simple_get(&rpc_xprtswitch_ids, 0, 0, gfp_flags);
+	if (id < 0)
+		return id;
+
+	xps->xps_id = id;
+	return 0;
+}
+
+static void xprt_switch_free_id(struct rpc_xprt_switch *xps)
+{
+	ida_simple_remove(&rpc_xprtswitch_ids, xps->xps_id);
+}
+
 /**
  * xprt_switch_alloc - Allocate a new struct rpc_xprt_switch
  * @xprt: pointer to struct rpc_xprt
@@ -103,6 +127,7 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 	if (xps != NULL) {
 		spin_lock_init(&xps->xps_lock);
 		kref_init(&xps->xps_kref);
+		xprt_switch_alloc_id(xps, gfp_flags);
 		xps->xps_nxprts = xps->xps_nactive = 0;
 		atomic_long_set(&xps->xps_queuelen, 0);
 		xps->xps_net = NULL;
@@ -136,6 +161,7 @@ static void xprt_switch_free(struct kref *kref)
 			struct rpc_xprt_switch, xps_kref);
 
 	xprt_switch_free_entries(xps);
+	xprt_switch_free_id(xps);
 	kfree_rcu(xps, xps_rcu);
 }
 
-- 
2.27.0

