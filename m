Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87A375CE1
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhEFVfn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 17:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhEFVfm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 17:35:42 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6FAC061574
        for <linux-nfs@vger.kernel.org>; Thu,  6 May 2021 14:34:44 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i22so5992163ila.11
        for <linux-nfs@vger.kernel.org>; Thu, 06 May 2021 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=dn6N/rkPPnc8N/MuY2x/KfuWKdQMTIykyYVJCb0U+SWjgoSsl+NgkOQoQfvZiC5lOn
         h3vh3cnPs4RyJUjzXp09n+iS7XfIFBE5QrdjNBHOQJrGYB9g85mEwSj50SDVnJrNpVI6
         vUJYtTwDA/yrCJfBTjm/LHyYU2A1iWEXcle4iz5LLqMycsrHuHLj7rNJkE/fF3njxnNS
         j9ln6smUG2CqZqqAz87hJ1EDLB3R1FeDbhV6Si3tzRQYt+BrB08QYIsos89h6/Yw0Qt5
         pGVOEj/CUJxrBD6OLr66P/csRow0W4VOXZigzqOvx00dGfWIlGVRVFk83lfXxofhIYwo
         b8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=m0Pf+EPIcyXcMr/lkQTXTbQp1LhTEL9nii2x5ULaX/bkZhlo/Cb7Er0Fxcpgo1DcNE
         9mNe8z1kqxZqVrUAGze3o8aWbATtQNb5pxfRK5f5kYs9nBTQDB4KCeo4+8bCGhHAvvE2
         Akvjm9z5idEpoM0VtCIs3dF9xqvEedE9ijKY3oY/kzje19Rh/B6uEjqrIv/vRfu5ArmY
         WFHcfYis6h/nmbyiYuUQMV8IQB4jcscq1Mj1kP4q2SKBhSFlNLiSZv+jAtdC/nNu/gyz
         zatrfz59VQVc8chQjt9nsJ+fjcaCWgkKhoNPEkdsEeAd5lSzr41IXKnNyJWUvLJj3wRG
         9nUQ==
X-Gm-Message-State: AOAM530xo1e1l/kAd18RyTUBfsBLBygwGmo9EQiPeFUzF4wCY4sEs5FD
        cL6uvLCIuF/qunYqhjM06mM=
X-Google-Smtp-Source: ABdhPJw8aUB3mdLgNvwHaFhxQHh6393om5Yz+82Gldp+nXp8s/GIwZtnqr4lYJQN8xjmeVP8UzxfeA==
X-Received: by 2002:a92:c7a1:: with SMTP id f1mr6193483ilk.33.1620336883789;
        Thu, 06 May 2021 14:34:43 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id 6sm1486019iog.36.2021.05.06.14.34.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 14:34:43 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 05/12] sunrpc: add IDs to multipath
Date:   Thu,  6 May 2021 17:34:28 -0400
Message-Id: <20210506213435.42457-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
References: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
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

