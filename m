Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE11361864
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhDPDxD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhDPDxC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:53:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0D7C061574
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:38 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x27so12856194qvd.2
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ci+N8cKSZsHwpbXnPcwWXMh4mMw5JQW2neWS/ND3vgo=;
        b=C4fgSRQp8S+I55V2/9TZoGqRab6EgZDwsg99d8C7aLP5TBmeJo/x7U3skozy8NHMvJ
         ukRA4MhUeDLp2j6Lo3lgQ4wR7BCqKbUFBZPBIq2nanuR4mz6auPk7CgjzCT70vG710lt
         RlZDxF1yuS3ucT2xmDmm4J2NxYFIXTvz5qW34hRxr5vSx4vYDr+Uruc5ai2FBbMIY9sa
         nPum6A6BPSPRg4ANg8v3MRD+akeJnhMtdyYL0pUHw9dXWHOE9oRjOn7zk6se1cIQcU0P
         96uKcRDtMbhzWoJIsk37CC3HdnrMBemhVyIFUHe9U5sz9fSOvVyoweagkHHamxWKVBFr
         F+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ci+N8cKSZsHwpbXnPcwWXMh4mMw5JQW2neWS/ND3vgo=;
        b=VzGeYKKdrehOHSrjc5lgLHfu2W++CgvokJnzqsseZEYcdJmPEw3uO4jbpRAIUoBdMB
         /gghLdvUOsMF+aZrtCWKcIW7yWUXzs4Oldc5HaZvGM40gTje7OaXPwd3DDTll2LgaITP
         JjNFysApsQWNeqEKWQFCbn9DnqzqaRHq8MO4njJFOIkHBx/VNQb+32Ml9XCcGY10EaOX
         wZby+XAT+jBTHqDUSUirjIKXoJ3fcf3BPCCGtXAv8cw6M7/Rn3BYQ/X5Z9iwl/dcBGTj
         pW9m7l822K1V3OyyOvjBPRoIujV95PplfedfzZGqlZKgvhwRy4I4Gn9dH0wT0EUy4fcP
         ORPQ==
X-Gm-Message-State: AOAM530EHH6Xi00rAcXCtT76EovGhooQy4L3TfRNZflf/DRODYzxYstw
        haXMKK7Ghzej8B/rD9L5ORM=
X-Google-Smtp-Source: ABdhPJzkAgeyaZN153qQLJfEWggfHkXCVpEAYpFZa2YzoKZv4Zhd5kAUwMhpoXIWEm4jUaoMuyPfaA==
X-Received: by 2002:a0c:ff06:: with SMTP id w6mr6666237qvt.51.1618545158186;
        Thu, 15 Apr 2021 20:52:38 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:37 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/13] sunrpc: add xprt_switch direcotry to sunrpc's sysfs
Date:   Thu, 15 Apr 2021 23:52:21 -0400
Message-Id: <20210416035226.53588-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
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
 include/linux/sunrpc/xprtmultipath.h |  1 +
 net/sunrpc/sysfs.c                   | 97 ++++++++++++++++++++++++++--
 net/sunrpc/sysfs.h                   | 10 +++
 net/sunrpc/xprtmultipath.c           |  4 ++
 4 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index ef95a6f18ccf..47b0a85cdcfa 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -24,6 +24,7 @@ struct rpc_xprt_switch {
 
 	const struct rpc_xprt_iter_ops *xps_iter_ops;
 
+	void			*xps_sysfs;
 	struct rcu_head		xps_rcu;
 };
 
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index d14d54f33c65..0c34330714ab 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -7,7 +7,7 @@
 #include "sysfs.h"
 
 static struct kset *rpc_sunrpc_kset;
-static struct kobject *rpc_sunrpc_client_kobj;
+static struct kobject *rpc_sunrpc_client_kobj, *rpc_sunrpc_xprt_switch_kobj;
 
 static void rpc_sysfs_object_release(struct kobject *kobj)
 {
@@ -47,13 +47,22 @@ int rpc_sysfs_init(void)
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
@@ -64,20 +73,40 @@ static void rpc_sysfs_client_release(struct kobject *kobj)
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
 
@@ -99,6 +128,27 @@ static struct rpc_sysfs_client *rpc_sysfs_client_alloc(struct kobject *parent,
 	return NULL;
 }
 
+static struct rpc_sysfs_xprt_switch *
+rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
+			    struct rpc_xprt_switch *xprt_switch,
+			    struct net *net)
+{
+	struct rpc_sysfs_xprt_switch *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
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
@@ -110,6 +160,27 @@ void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net)
 	}
 }
 
+void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
+				 struct rpc_xprt *xprt)
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
+					    xprt_switch, net);
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
@@ -121,3 +192,15 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
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
index c46afc848993..9b6acd3fd3dc 100644
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
+				 struct rpc_xprt *xprt);
+void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt);
 
 #endif
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index b71dd95ad7de..1ed16e4cc465 100644
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
+		rpc_sysfs_xprt_switch_setup(xps, xprt);
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

