Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB45339ADEC
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCWXr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:23:47 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:37571 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhFCWXq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:23:46 -0400
Received: by mail-qk1-f171.google.com with SMTP id i67so7551991qkc.4
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGOpSsX0RI8U/ko+9V6YHdVM++uPnR7REoldeJWyPrQ=;
        b=BjoBdMhUlUtnDZ9vrtU3O0C/cZQBOE8VRCU27pQHVXqt1i2ENtZYMoqu4+lJQzYtLe
         eqmok/I4mD8BA1deJ6LDS9oiMIKUGtql+E1eCckvATg57qKfEzeKB2F3abvg8at5Hkif
         b7vXBl2I9Yi0zMWwO2el/Os3ULf/BSdkfCpuDcVgGtdtoNK1q7Fr+DIUq9sZyp1s+3Ha
         UldS4I08oB2lbI1c0RkI35OB8V3pUaUY3eADeGN51hUmUE/bBYtLyfj0e8oA/5ZJw5Ub
         y3A/Apnd0TovF1IhQoj121FtFN0IzfHbPlF+SseLFGN38uWJRfjlMTiljcxKit78ra6v
         hjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGOpSsX0RI8U/ko+9V6YHdVM++uPnR7REoldeJWyPrQ=;
        b=SENKx5Oy2Hr7e31SlFHuR0ASSFPIWXmGlgPKO9iNfj+NdaZ08YXzZL23k6CRTVKueQ
         KxT0xJmmdRknf9iewyQ/f7znsNyrgdOo641duPza9vbjkA3EiR/gthRk0ei7/G16poig
         vApwP4XAizW6iGXoNv8G14/4GxrHXh05HQEcoloNCXq0/Rsn2101EWrQ1MrS8WlCHGsU
         itKDcV/0nIMPHRk3p020Pxo7fdX0xcKOnepXGbDNZFtvwXDXZAfHDadvagI2xGicm6Q6
         joPZiEovpHS9g2SkXI8NHWjtPrCTKXS4AfjM2bqycywG8ZvwbshRZIX/Z4whqCxgmz5c
         ZScA==
X-Gm-Message-State: AOAM533W0i+yjR03xOo4TjiaEp5lBvqXZAKJAlNxwb7hfSr5Zwg298ot
        l3vZvAAJze/JBabRWrrvPhI=
X-Google-Smtp-Source: ABdhPJyGnW18ilINua37+kNGXujz/le9zRJY83qodcz1VHZb5TmyvWvKG7OI6rznlIo2pTbFiWKcUw==
X-Received: by 2002:a05:620a:a0d:: with SMTP id i13mr1506140qka.280.1622758850330;
        Thu, 03 Jun 2021 15:20:50 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:49 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 07/13] sunrpc: add xprt_switch direcotry to sunrpc's sysfs
Date:   Thu,  3 Jun 2021 18:20:33 -0400
Message-Id: <20210603222039.19182-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
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

