Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4731C0D6
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 18:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhBORlu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 12:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhBORlb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 12:41:31 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8282C06178B
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ot7so9865139ejb.9
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMJwaE085VRNtJZh9eXFNy6KZgDYnyktHgUAm71FMVY=;
        b=EC6SW1/X0H0hql3o1tfvknduBtdvtjFZxL01Jb0JMDV6+fGOBUhPkbAYPMN3XEzO4t
         K2CvAVNubb0YnLF0n5jv8x1D2WZxFjSGYgLWQgcIx0kDuT79J7tQDpabPjb05s2VGOu7
         FhHgB/Z9ADQHNVrCFHVA4jUilg5FWBbOQCzLf+KLSbFUP479pJG1OenZWoQdi4j74Cle
         Kfk1DdX2mfaq9GPjbhT7haaNc9MbuwCLz3XJAZPS5fkMZtTcaWWkXIentQfXgZc4Nr5K
         eJhHulhVe41eE2RZQx/dr3dJYy4JC/MoGrqtAQou/5e12iAQzsgRZzYQR4jjeOl2jLD2
         TVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMJwaE085VRNtJZh9eXFNy6KZgDYnyktHgUAm71FMVY=;
        b=S2reMJLFgyUGx63FxjCnFuJmXBCWg26c3hsgbDLZR991oLzdJgBvYjOvx6PK4ipM/k
         qh9wDx9h7Dwv3OvTlQp5sXQSGURKglI6n+Mzgu7bKSzhBGCzBhIG7byhqa1CCTByEgf3
         HMwdJI4uoEWTlpSqw8zs+JlTknZrm9eP/tLUgCSbXSxYykZsClC+f8PBFR49PQoVfysL
         vVSnB+FtbqxlIm13LE3VO0SI3R2srOVk3p+NXvkHk0+fWAcmt6RftfJ+Ae7/81DFIE63
         srthL/9gstUHG+UVD3C5U2sukpSsgqHFluF2JrXkqAiFPwbj+0HqN/nhTLgY0SljTCGp
         SsGw==
X-Gm-Message-State: AOAM53169aHl4s6fHY9bRNyBkQ/dX+ZThVWYb/MB3mYENjxOFxB9AcNS
        7UpP9IDpAvlETppydo+QKmGRygcaeZAB0g==
X-Google-Smtp-Source: ABdhPJxoTMhJxnouCNEmc+SY/9IvyxyxBZSHOBaJkdTXvU6Jj0x2D4DKIf83/521zRv8dKjI8vP6yg==
X-Received: by 2002:a17:906:bce5:: with SMTP id op5mr3599494ejb.83.1613410812066;
        Mon, 15 Feb 2021 09:40:12 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e11sm11257485ejz.94.2021.02.15.09.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:40:11 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v1 6/8] sunrpc: add multipath directory and symlink from client
Date:   Mon, 15 Feb 2021 19:40:00 +0200
Message-Id: <20210215174002.2376333-7-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215174002.2376333-1-dan@kernelim.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This also adds a `list` attribute to multipath directory that provides
the transport IDs of the transports contained in the multipath object.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 include/linux/sunrpc/xprtmultipath.h |   2 +
 net/sunrpc/sysfs.c                   | 122 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |   8 ++
 net/sunrpc/xprtmultipath.c           |  10 +++
 4 files changed, 142 insertions(+)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index ef95a6f18ccf..2d0832dc10f5 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -24,6 +24,8 @@ struct rpc_xprt_switch {
 
 	const struct rpc_xprt_iter_ops *xps_iter_ops;
 
+	void                    *xps_sysfs; /* /sys/kernel/sunrpc/multipath/<id> */
+
 	struct rcu_head		xps_rcu;
 };
 
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index ae608235d7e0..3592f3b862b2 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -10,6 +10,7 @@
 
 struct kobject *rpc_client_kobj;
 struct kobject *rpc_xprt_kobj;
+struct kobject *rpc_xps_kobj;
 static struct kset *rpc_sunrpc_kset;
 
 static void rpc_netns_object_release(struct kobject *kobj)
@@ -58,8 +59,15 @@ int rpc_sysfs_init(void)
 	if (!rpc_xprt_kobj)
 		goto err_client;
 
+	rpc_xps_kobj = rpc_netns_object_alloc("multipath", rpc_sunrpc_kset, NULL);
+	if (!rpc_xps_kobj)
+		goto err_xprt;
+
 	return 0;
 
+err_xprt:
+	kobject_put(rpc_xprt_kobj);
+	rpc_xprt_kobj = NULL;
 err_client:
 	kobject_put(rpc_client_kobj);
 	rpc_client_kobj = NULL;
@@ -95,6 +103,7 @@ static struct kobj_type rpc_netns_client_type = {
 
 void rpc_sysfs_exit(void)
 {
+	kobject_put(rpc_xps_kobj);
 	kobject_put(rpc_xprt_kobj);
 	kobject_put(rpc_client_kobj);
 	kset_unregister(rpc_sunrpc_kset);
@@ -122,17 +131,29 @@ void rpc_netns_client_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
 	struct rpc_netns_client *rpc_client;
 	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
 	struct rpc_netns_xprt *rpc_xprt;
+	struct rpc_netns_multipath *rpc_multipath;
+	struct rpc_xprt_switch *xps;
 	int ret;
 
+	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
+
 	rpc_client = rpc_netns_client_alloc(rpc_client_kobj, net, clnt->cl_clid);
 	if (rpc_client) {
 		rpc_xprt = xprt->sysfs;
 		ret = sysfs_create_link_nowarn(&rpc_client->kobject,
 					 &rpc_xprt->kobject, "transport");
+		if (xps) {
+			rpc_multipath = xps->xps_sysfs;
+			ret = sysfs_create_link_nowarn(&rpc_client->kobject,
+						       &rpc_multipath->kobject,
+						       "multipath");
+		}
 		clnt->cl_sysfs = rpc_client;
 		rpc_client->clnt = clnt;
 		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
 	}
+
+	xprt_switch_put(xps);
 }
 
 void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt)
@@ -141,6 +162,7 @@ void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt)
 
 	if (rpc_client) {
 		sysfs_remove_link(&rpc_client->kobject, "transport");
+		sysfs_remove_link(&rpc_client->kobject, "multipath");
 		kobject_uevent(&rpc_client->kobject, KOBJ_REMOVE);
 		kobject_del(&rpc_client->kobject);
 		kobject_put(&rpc_client->kobject);
@@ -255,3 +277,103 @@ void rpc_netns_xprt_sysfs_destroy(struct rpc_xprt *xprt)
 		xprt->sysfs = NULL;
 	}
 }
+
+static void rpc_netns_multipath_release(struct kobject *kobj)
+{
+	struct rpc_netns_multipath *c;
+
+	c = container_of(kobj, struct rpc_netns_multipath, kobject);
+	kfree(c);
+}
+
+static const void *rpc_netns_multipath_namespace(struct kobject *kobj)
+{
+	return container_of(kobj, struct rpc_netns_multipath, kobject)->net;
+}
+
+static ssize_t rpc_netns_multipath_list_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct rpc_netns_multipath *c =
+		container_of(kobj, struct rpc_netns_multipath, kobject);
+	struct rpc_xprt_switch *xps = c->xps;
+	struct rpc_xprt_iter xpi;
+	int pos = 0;
+
+	xprt_iter_init_listall(&xpi, xps);
+	for (;;) {
+		struct rpc_xprt *xprt = xprt_iter_get_next(&xpi);
+		if (!xprt)
+			break;
+
+		snprintf(&buf[pos], PAGE_SIZE - pos, "%d\n", xprt->id);
+		pos += strlen(&buf[pos]);
+		xprt_put(xprt);
+	}
+	xprt_iter_destroy(&xpi);
+
+	return pos;
+}
+
+static ssize_t rpc_netns_multipath_list_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	return -EINVAL;
+}
+
+static struct kobj_attribute rpc_netns_multipath_list = __ATTR(list,
+	0644, rpc_netns_multipath_list_show, rpc_netns_multipath_list_store);
+
+
+static struct attribute *rpc_netns_multipath_attrs[] = {
+	&rpc_netns_multipath_list.attr,
+	NULL,
+};
+
+static struct kobj_type rpc_netns_multipath_type = {
+	.release = rpc_netns_multipath_release,
+	.default_attrs = rpc_netns_multipath_attrs,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace = rpc_netns_multipath_namespace,
+};
+
+static struct rpc_netns_multipath *rpc_netns_multipath_alloc(struct kobject *parent,
+							     struct net *net, int id)
+{
+	struct rpc_netns_multipath *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (p) {
+		p->net = net;
+		p->kobject.kset = rpc_sunrpc_kset;
+		if (kobject_init_and_add(&p->kobject, &rpc_netns_multipath_type,
+					 parent, "%d", id) == 0)
+			return p;
+		kobject_put(&p->kobject);
+	}
+	return NULL;
+}
+
+void rpc_netns_multipath_sysfs_setup(struct rpc_xprt_switch *xps, struct net *net)
+{
+	struct rpc_netns_multipath *rpc_multipath;
+
+	rpc_multipath = rpc_netns_multipath_alloc(rpc_xps_kobj, net, xps->xps_id);
+	if (rpc_multipath) {
+		xps->xps_sysfs = rpc_multipath;
+		rpc_multipath->xps = xps;
+		kobject_uevent(&rpc_multipath->kobject, KOBJ_ADD);
+	}
+}
+
+void rpc_netns_multipath_sysfs_destroy(struct rpc_xprt_switch *xps)
+{
+	struct rpc_netns_multipath *rpc_multipath = xps->xps_sysfs;
+
+	if (rpc_multipath) {
+		kobject_uevent(&rpc_multipath->kobject, KOBJ_REMOVE);
+		kobject_del(&rpc_multipath->kobject);
+		kobject_put(&rpc_multipath->kobject);
+		xps->xps_sysfs = NULL;
+	}
+}
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index e08dd7f6a1ec..b2e379f78b91 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -17,6 +17,12 @@ struct rpc_netns_xprt {
 	struct rpc_xprt *xprt;
 };
 
+struct rpc_netns_multipath {
+	struct kobject kobject;
+	struct net *net;
+	struct rpc_xprt_switch *xps;
+};
+
 extern struct kobject *rpc_client_kobj;
 extern struct kobject *rpc_xprt_kobj;
 
@@ -27,5 +33,7 @@ void rpc_netns_client_sysfs_setup(struct rpc_clnt *clnt, struct net *net);
 void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt);
 void rpc_netns_xprt_sysfs_setup(struct rpc_xprt *xprt, struct net *net);
 void rpc_netns_xprt_sysfs_destroy(struct rpc_xprt *xprt);
+void rpc_netns_multipath_sysfs_setup(struct rpc_xprt_switch *xps, struct net *net);
+void rpc_netns_multipath_sysfs_destroy(struct rpc_xprt_switch *xps);
 
 #endif
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 52a9584b23af..d03fb3bb74ce 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -19,6 +19,8 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/xprtmultipath.h>
 
+#include "sysfs.h"
+
 typedef struct rpc_xprt *(*xprt_switch_find_xprt_t)(struct rpc_xprt_switch *xps,
 		const struct rpc_xprt *cur);
 
@@ -83,6 +85,9 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
 	spin_lock(&xps->xps_lock);
 	xprt_switch_remove_xprt_locked(xps, xprt);
 	spin_unlock(&xps->xps_lock);
+
+	if (!xps->xps_net)
+		rpc_netns_multipath_sysfs_destroy(xps);
 	xprt_put(xprt);
 }
 
@@ -135,6 +140,10 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 		INIT_LIST_HEAD(&xps->xps_xprt_list);
 		xps->xps_iter_ops = &rpc_xprt_iter_singular;
 		xprt_switch_add_xprt_locked(xps, xprt);
+		xps->xps_sysfs = NULL;
+
+		if (xprt->xprt_net != NULL)
+			rpc_netns_multipath_sysfs_setup(xps, xprt->xprt_net);
 	}
 
 	return xps;
@@ -162,6 +171,7 @@ static void xprt_switch_free(struct kref *kref)
 			struct rpc_xprt_switch, xps_kref);
 
 	xprt_switch_free_entries(xps);
+	rpc_netns_multipath_sysfs_destroy(xps);
 	xprt_switch_free_id(xps);
 	kfree_rcu(xps, xps_rcu);
 }
-- 
2.26.2

