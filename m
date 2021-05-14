Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68465380B41
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhENOOq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhENOOn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:43 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C0C06174A
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:31 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o21so27813173iow.13
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=VoCx59J3l0VqWbhGarPTEWjkhenXxIEHJkSIHm5jZRprtTCnfVs3ICoJtL0lTQkJRe
         D+o8BUNodQkTKUPKrHOpuTu4yy2zKKSFF2khexInpmx/EmJmJxtmDhPndqqKuOgxuaqZ
         5YeQAGQBfO/aQAIkNde95dm9VFzz+iur72ILCi4Pf1FgLtz2S3lUBK7OWwcfDdcgo6YH
         KtA/GR3Oi/Bz5/9dv3TQEfhXwmGy5ueEbMsIJYwrcRb2yobbyWyjFSCzBpV7wHQYsHYz
         LpUgpsrBJbXqYThTBeIASWMFoBPCpBF1sQm0thL0OrdC62tZMVHNfTA93mNutEf6jQ/0
         oghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Fg1CTEpqXVj95kKutPWoBVqcxEtRPxgNEonrsSkYnU=;
        b=T3FoNIwef4V+p612thqE6ZuQHmeR81CuS22rsmM8xJfypfH4a6CJFG6vTsH31tYOc/
         vex+paHirQKQ6/4w1Y/gsFL2RVDY52+kocN/PWa0hl/0HvCVFpz7+nQ/O+wIB/Oiy/fH
         +vD6LS7LJN2ybDXxwJw7TIyNR8ikcpleTtO2lmQAyKcT3xekhRMfqQgF7Gj4Ku+idM87
         CHKAamVH2RUaeNEK3CwGMrHoxFURCwVzyZJTaCOcmgUXRzlfZx6aEkYqoh5Ruvfvphzs
         pPE0O0i10wWhhnBfvgIH9/q9kCzKzVIIkHnFUXg8Hyc/eiX3p3maTGjUCQHkEot6Hg9T
         wMMA==
X-Gm-Message-State: AOAM533Y1aEvsaGubVONbTRcZJIbk2mMGSbN3RZPht5hwSKlnRGFhWw+
        NjVDRdjO0NZulQcdV0da1KY=
X-Google-Smtp-Source: ABdhPJy5urrj2GD3kOuIm8Q1Y4RF9t83ycxWzXISrez4AXJdAZXyqJxToLd8z9QSo2R3q7ze3ox3Lg==
X-Received: by 2002:a6b:ec03:: with SMTP id c3mr35058438ioh.103.1621001611257;
        Fri, 14 May 2021 07:13:31 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:30 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 05/12] sunrpc: add IDs to multipath
Date:   Fri, 14 May 2021 10:13:16 -0400
Message-Id: <20210514141323.67922-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
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

