Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474ED36E0FC
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhD1VdE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhD1VdD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:33:03 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80D8C06138B
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 1so47802692qtb.0
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGOpSsX0RI8U/ko+9V6YHdVM++uPnR7REoldeJWyPrQ=;
        b=otjLOv3hmOjQ2DsXqAFwlE2tU5a8JqITlfHytzAglLqhtmtvwa4HikXngWP3Mc2qm2
         yy/rW3TkNKXs96Icgf4/gzcCiyyNqEIga8Q6bomvn4mv5rqos2sMQMtEqAc/ZoHdA6sN
         Qg8ahYjr+0lzShKG3p3INACNH+oYXjkbbtROfTGck1gCq8AZ0+Th6N/GZQrFkhYgwTkI
         XYd5oH8trbZWnBtVcOY8FKGrI9227udkD2kZdaqhgiTYrmA52PFnm6M5mTs7LGKZ2HGe
         FjABRejLCE/Uxf2UXAbHIEOIkYYAhzyu7NO+c5cWO5N6yYLdRbncVOIQwg6Cfq421Kh+
         sxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGOpSsX0RI8U/ko+9V6YHdVM++uPnR7REoldeJWyPrQ=;
        b=iTtlJMo1ErkTvkbWlSwwSD1E6N1EBIoYws6qZEHg01WG1GUSrqNQn8HGiDe14wADhV
         GEEimKhtI4pQl65IsKT4biTA8/CRrHdpmw1dfizMOQy1b2vyqneMkHR/Xep3RCHCZ8xg
         WUxHhwzJjm807ltrtcnYmzkr88ejivNBZLIj9P652gfVWtYuv1WeyI2Jbf8ZRLgYif0D
         YaC7Pa+l8BxPPavORSqFvJ82X60DRqVvlYBlWKls91NtGLIzapkwZWXI8bgAFCebxPBp
         Dc7mggE3my4jWsYr8iHuS10y9hkezwPdBzaTEcB9VsTsFxYO6BprzmK0xV/Cy0+2oStO
         KCTw==
X-Gm-Message-State: AOAM532P4ooYxHVEBhoalelM2cKeBoLJ+w25BKElOvBj54GJa+VCu16D
        7mKS4+702DOYbcLgY88VhyU=
X-Google-Smtp-Source: ABdhPJzfGG/01XQRPpRTtnSQZI/QfQ9rdi+Y07mGy0YDG3/wvWTvDgzbJHJK/FJCOVgS5A0+Rk3dHQ==
X-Received: by 2002:ac8:4747:: with SMTP id k7mr90647qtp.323.1619645536173;
        Wed, 28 Apr 2021 14:32:16 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:15 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 08/13] sunrpc: add xprt_switch direcotry to sunrpc's sysfs
Date:   Wed, 28 Apr 2021 17:31:58 -0400
Message-Id: <20210428213203.40059-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add xprt_switch directory to the sysfs and create individual
xprt_swith subdirectories for multipath transport group.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtmultipath.h |  2 +
 net/sunrpc/sysfs.c                   | 99 ++++++++++++++++++++++++++--
 net/sunrpc/sysfs.h                   | 10 +++
 net/sunrpc/xprtmultipath.c           |  4 ++
 4 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index ef95a6f18ccf..b19addc8b715 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -10,6 +10,7 @@
 #define _NET_SUNRPC_XPRTMULTIPATH_H
 
 struct rpc_xprt_iter_ops;
+struct rpc_sysfs_xprt_switch;
 struct rpc_xprt_switch {
 	spinlock_t		xps_lock;
 	struct kref		xps_kref;
@@ -24,6 +25,7 @@ struct rpc_xprt_switch {
 
 	const struct rpc_xprt_iter_ops *xps_iter_ops;
 
+	struct rpc_sysfs_xprt_switch *xps_sysfs;
 	struct rcu_head		xps_rcu;
 };
 
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index f3b7547ee218..ed9f7131543f 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -7,7 +7,7 @@
 #include "sysfs.h"
 
 static struct kset *rpc_sunrpc_kset;
-static struct kobject *rpc_sunrpc_client_kobj;
+static struct kobject *rpc_sunrpc_client_kobj, *rpc_sunrpc_xprt_switch_kobj;
 
 static void rpc_sysfs_object_release(struct kobject *kobj)
 {
@@ -48,13 +48,22 @@ int rpc_sysfs_init(void)
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
 	if (!rpc_sunrpc_kset)
 		return -ENOMEM;
-	rpc_sunrpc_client_kobj = rpc_sysfs_object_alloc("client", rpc_sunrpc_kset, NULL);
-	if (!rpc_sunrpc_client_kobj) {
-		kset_unregister(rpc_sunrpc_kset);
-		rpc_sunrpc_client_kobj = NULL;
-		return -ENOMEM;
-	}
+	rpc_sunrpc_client_kobj =
+		rpc_sysfs_object_alloc("rpc-clients", rpc_sunrpc_kset, NULL);
+	if (!rpc_sunrpc_client_kobj)
+		goto err_client;
+	rpc_sunrpc_xprt_switch_kobj =
+		rpc_sysfs_object_alloc("xprt-switches", rpc_sunrpc_kset, NULL);
+	if (!rpc_sunrpc_xprt_switch_kobj)
+		goto err_switch;
 	return 0;
+err_switch:
+	kobject_put(rpc_sunrpc_client_kobj);
+	rpc_sunrpc_client_kobj = NULL;
+err_client:
+	kset_unregister(rpc_sunrpc_kset);
+	rpc_sunrpc_kset = NULL;
+	return -ENOMEM;
 }
 
 static void rpc_sysfs_client_release(struct kobject *kobj)
@@ -65,20 +74,40 @@ static void rpc_sysfs_client_release(struct kobject *kobj)
 	kfree(c);
 }
 
+static void rpc_sysfs_xprt_switch_release(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt_switch *xprt_switch;
+
+	xprt_switch = container_of(kobj, struct rpc_sysfs_xprt_switch, kobject);
+	kfree(xprt_switch);
+}
+
 static const void *rpc_sysfs_client_namespace(struct kobject *kobj)
 {
 	return container_of(kobj, struct rpc_sysfs_client, kobject)->net;
 }
 
+static const void *rpc_sysfs_xprt_switch_namespace(struct kobject *kobj)
+{
+	return container_of(kobj, struct rpc_sysfs_xprt_switch, kobject)->net;
+}
+
 static struct kobj_type rpc_sysfs_client_type = {
 	.release = rpc_sysfs_client_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_client_namespace,
 };
 
+static struct kobj_type rpc_sysfs_xprt_switch_type = {
+	.release = rpc_sysfs_xprt_switch_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace = rpc_sysfs_xprt_switch_namespace,
+};
+
 void rpc_sysfs_exit(void)
 {
 	kobject_put(rpc_sunrpc_client_kobj);
+	kobject_put(rpc_sunrpc_xprt_switch_kobj);
 	kset_unregister(rpc_sunrpc_kset);
 }
 
@@ -100,6 +129,28 @@ static struct rpc_sysfs_client *rpc_sysfs_client_alloc(struct kobject *parent,
 	return NULL;
 }
 
+static struct rpc_sysfs_xprt_switch *
+rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
+			    struct rpc_xprt_switch *xprt_switch,
+			    struct net *net,
+			    gfp_t gfp_flags)
+{
+	struct rpc_sysfs_xprt_switch *p;
+
+	p = kzalloc(sizeof(*p), gfp_flags);
+	if (p) {
+		p->net = net;
+		p->kobject.kset = rpc_sunrpc_kset;
+		if (kobject_init_and_add(&p->kobject,
+					 &rpc_sysfs_xprt_switch_type,
+					 parent, "switch-%d",
+					 xprt_switch->xps_id) == 0)
+			return p;
+		kobject_put(&p->kobject);
+	}
+	return NULL;
+}
+
 void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net)
 {
 	struct rpc_sysfs_client *rpc_client;
@@ -111,6 +162,28 @@ void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net)
 	}
 }
 
+void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
+				 struct rpc_xprt *xprt,
+				 gfp_t gfp_flags)
+{
+	struct rpc_sysfs_xprt_switch *rpc_xprt_switch;
+	struct net *net;
+
+	if (xprt_switch->xps_net)
+		net = xprt_switch->xps_net;
+	else
+		net = xprt->xprt_net;
+	rpc_xprt_switch =
+		rpc_sysfs_xprt_switch_alloc(rpc_sunrpc_xprt_switch_kobj,
+					    xprt_switch, net, gfp_flags);
+	if (rpc_xprt_switch) {
+		xprt_switch->xps_sysfs = rpc_xprt_switch;
+		rpc_xprt_switch->xprt_switch = xprt_switch;
+		rpc_xprt_switch->xprt = xprt;
+		kobject_uevent(&rpc_xprt_switch->kobject, KOBJ_ADD);
+	}
+}
+
 void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
 {
 	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
@@ -122,3 +195,15 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
 		clnt->cl_sysfs = NULL;
 	}
 }
+
+void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt_switch)
+{
+	struct rpc_sysfs_xprt_switch *rpc_xprt_switch = xprt_switch->xps_sysfs;
+
+	if (rpc_xprt_switch) {
+		kobject_uevent(&rpc_xprt_switch->kobject, KOBJ_REMOVE);
+		kobject_del(&rpc_xprt_switch->kobject);
+		kobject_put(&rpc_xprt_switch->kobject);
+		xprt_switch->xps_sysfs = NULL;
+	}
+}
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index c46afc848993..52ec472bd4a9 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -10,10 +10,20 @@ struct rpc_sysfs_client {
 	struct net *net;
 };
 
+struct rpc_sysfs_xprt_switch {
+	struct kobject kobject;
+	struct net *net;
+	struct rpc_xprt_switch *xprt_switch;
+	struct rpc_xprt *xprt;
+};
+
 int rpc_sysfs_init(void);
 void rpc_sysfs_exit(void);
 
 void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net);
 void rpc_sysfs_client_destroy(struct rpc_clnt *clnt);
+void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
+				 struct rpc_xprt *xprt, gfp_t gfp_flags);
+void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt);
 
 #endif
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 4969a4c216f7..2d73a35df9ee 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -19,6 +19,8 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/xprtmultipath.h>
 
+#include "sysfs.h"
+
 typedef struct rpc_xprt *(*xprt_switch_find_xprt_t)(struct rpc_xprt_switch *xps,
 		const struct rpc_xprt *cur);
 
@@ -133,6 +135,7 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 		xps->xps_net = NULL;
 		INIT_LIST_HEAD(&xps->xps_xprt_list);
 		xps->xps_iter_ops = &rpc_xprt_iter_singular;
+		rpc_sysfs_xprt_switch_setup(xps, xprt, gfp_flags);
 		xprt_switch_add_xprt_locked(xps, xprt);
 	}
 
@@ -161,6 +164,7 @@ static void xprt_switch_free(struct kref *kref)
 			struct rpc_xprt_switch, xps_kref);
 
 	xprt_switch_free_entries(xps);
+	rpc_sysfs_xprt_switch_destroy(xps);
 	xprt_switch_free_id(xps);
 	kfree_rcu(xps, xps_rcu);
 }
-- 
2.27.0

