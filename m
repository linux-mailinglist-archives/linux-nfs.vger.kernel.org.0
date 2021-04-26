Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1436B7FD
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbhDZRUy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbhDZRUn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89D5C061760
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:01 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b10so56765689iot.4
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peXzpoOc4puVVmUJNSS5qW9OdxmrCfb8OZ3gqV/sQSg=;
        b=TKH71u3Ej8dcMwLgkpmt/oBK5spdcMCbPQSi8uP0axRK1Cj68zGboW2Up8lVA3DSlX
         zGjWXsUX7SBsvZl9uUCHMGhQaFUzf8lqDW6qEuR9MBjD0gGehWZiQPNFuILYzpimI2wb
         mo4yAP8774P8EL2IVpaNfjlhVNNKpTtNqQ5NWX49ZCaHFZD4K5AqPI6LoGe7yMIvl8zx
         2kr4/CXTY488808dg4zYiIqlwnp5ekS+iAjaynr0ZdBZoG5Z4IHP5RRJYdgiDZrKK9w+
         NWPnxCXo2iWO06vwWJ8r4ayoqj7YW9zWTNZYAbqQfL4An++MvSP2lbX4Hb96U3nD+9VA
         Spmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peXzpoOc4puVVmUJNSS5qW9OdxmrCfb8OZ3gqV/sQSg=;
        b=l5zuaLyXtEEH/tv0kcIp1cSjl6hxQ9WNj9tnZLo+XwjCGe+lU5VzDpvgixPAESUaMj
         dKBBEkukpuHVNxR/zGidAcRo711kCPZ0MPPb4AQpN8rh8RfFmyJfgmr4xme/nddtEio1
         LstgG5hIbIzWbIu74KJq+P6fo7R9t0vp0orGqfddZerlD9f61bK825WSMyvR0RAhEXhL
         yLX8iiRMNkyTuBI2O/Fu1mXa2mchnOzDgdIRdefyIfeOtlScq8f1YdiHBAbJpkdTRWLD
         cFnEOYgDSOoquIPyGEbUKsilR7BXSWzmnmrUD29C1SbbmWgMlA52qslRMSM6b0OanbkE
         LRNQ==
X-Gm-Message-State: AOAM532S9GLTqhOBN0M15XGGCv2oU/c30NVTUJ1+sO0wpvpojb9d7oqu
        QgMEYls6bMXqDlAhi/WC0Qw=
X-Google-Smtp-Source: ABdhPJyWZJHvCwlSDu1078QJA5Aqg77IGLSUpWJhBu99WjnwwP3R9eWSlu3A7toNL29eKCYDx5cKvw==
X-Received: by 2002:a05:6638:f:: with SMTP id z15mr17270917jao.26.1619457601247;
        Mon, 26 Apr 2021 10:20:01 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.20.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:20:00 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 10/13] sunrpc: add add sysfs directory per xprt under each xprt_switch
Date:   Mon, 26 Apr 2021 13:19:44 -0400
Message-Id: <20210426171947.99233-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add individual transport directories under each transport switch
group. For instance, for each nconnect=X connections there will be
a transport directory. Naming conventions also identifies transport
type -- xprt-<id>-<type> where type is udp, tcp, rdma, local, bc.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h |  1 +
 net/sunrpc/sysfs.c          | 86 +++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  9 ++++
 net/sunrpc/xprtmultipath.c  | 10 +++++
 4 files changed, 106 insertions(+)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index a2edcc42e6c4..1e4906759a6a 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -291,6 +291,7 @@ struct rpc_xprt {
 #endif
 	struct rcu_head		rcu;
 	const struct xprt_class	*xprt_class;
+	void			*xprt_sysfs;
 };
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 871f7c696a93..682def4293f2 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -81,6 +81,14 @@ static void rpc_sysfs_xprt_switch_release(struct kobject *kobj)
 	kfree(xprt_switch);
 }
 
+static void rpc_sysfs_xprt_switch_xprt_release(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt_switch_xprt *xprt;
+
+	xprt = container_of(kobj, struct rpc_sysfs_xprt_switch_xprt, kobject);
+	kfree(xprt);
+}
+
 static const void *rpc_sysfs_client_namespace(struct kobject *kobj)
 {
 	return container_of(kobj, struct rpc_sysfs_client, kobject)->net;
@@ -91,6 +99,12 @@ static const void *rpc_sysfs_xprt_switch_namespace(struct kobject *kobj)
 	return container_of(kobj, struct rpc_sysfs_xprt_switch, kobject)->net;
 }
 
+static const void *rpc_sysfs_xprt_switch_xprt_namespace(struct kobject *kobj)
+{
+	return container_of(kobj, struct rpc_sysfs_xprt_switch_xprt,
+			    kobject)->net;
+}
+
 static struct kobj_type rpc_sysfs_client_type = {
 	.release = rpc_sysfs_client_release,
 	.sysfs_ops = &kobj_sysfs_ops,
@@ -103,6 +117,12 @@ static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
 
+static struct kobj_type rpc_sysfs_xprt_switch_xprt_type = {
+	.release = rpc_sysfs_xprt_switch_xprt_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace = rpc_sysfs_xprt_switch_xprt_namespace,
+};
+
 void rpc_sysfs_exit(void)
 {
 	kobject_put(rpc_sunrpc_client_kobj);
@@ -150,6 +170,40 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
 	return NULL;
 }
 
+static struct rpc_sysfs_xprt_switch_xprt *
+rpc_sysfs_xprt_switch_xprt_alloc(struct kobject *parent,
+				 struct rpc_xprt *xprt,
+				 struct net *net,
+				 gfp_t gfp_flags)
+{
+	struct rpc_sysfs_xprt_switch_xprt *p;
+
+	p = kzalloc(sizeof(*p), gfp_flags);
+	if (p) {
+		char type[6];
+
+		p->net = net;
+		p->kobject.kset = rpc_sunrpc_kset;
+		if (xprt->xprt_class->ident == XPRT_TRANSPORT_RDMA)
+			snprintf(type, sizeof(type), "rdma");
+		else if (xprt->xprt_class->ident == XPRT_TRANSPORT_TCP)
+			snprintf(type, sizeof(type), "tcp");
+		else if (xprt->xprt_class->ident == XPRT_TRANSPORT_UDP)
+			snprintf(type, sizeof(type), "udp");
+		else if (xprt->xprt_class->ident == XPRT_TRANSPORT_LOCAL)
+			snprintf(type, sizeof(type), "local");
+		else if (xprt->xprt_class->ident == XPRT_TRANSPORT_BC_TCP)
+			snprintf(type, sizeof(type), "bc");
+		if (kobject_init_and_add(&p->kobject,
+					 &rpc_sysfs_xprt_switch_xprt_type,
+					 parent, "xprt-%d-%s", xprt->id,
+					 type) == 0)
+			return p;
+		kobject_put(&p->kobject);
+	}
+	return NULL;
+}
+
 void rpc_sysfs_client_setup(struct rpc_clnt *clnt,
 			    struct rpc_xprt_switch *xprt_switch,
 			    struct net *net)
@@ -199,6 +253,25 @@ void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
 	}
 }
 
+void rpc_sysfs_xprt_switch_xprt_setup(struct rpc_xprt_switch *xprt_switch,
+				      struct rpc_xprt *xprt,
+				      gfp_t gfp_flags)
+{
+	struct rpc_sysfs_xprt_switch_xprt *rpc_xprt_switch_xprt;
+	struct rpc_sysfs_xprt_switch *switch_obj =
+		(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
+
+	rpc_xprt_switch_xprt =
+		rpc_sysfs_xprt_switch_xprt_alloc(&switch_obj->kobject,
+						 xprt, xprt->xprt_net,
+						 gfp_flags);
+	if (rpc_xprt_switch_xprt) {
+		xprt->xprt_sysfs = rpc_xprt_switch_xprt;
+		rpc_xprt_switch_xprt->xprt = xprt;
+		kobject_uevent(&rpc_xprt_switch_xprt->kobject, KOBJ_ADD);
+	}
+}
+
 void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
 {
 	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
@@ -227,3 +300,16 @@ void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt_switch)
 		xprt_switch->xps_sysfs = NULL;
 	}
 }
+
+void rpc_sysfs_xprt_switch_xprt_destroy(struct rpc_xprt *xprt)
+{
+	struct rpc_sysfs_xprt_switch_xprt *rpc_xprt_switch_xprt =
+			xprt->xprt_sysfs;
+
+	if (rpc_xprt_switch_xprt) {
+		kobject_uevent(&rpc_xprt_switch_xprt->kobject, KOBJ_REMOVE);
+		kobject_del(&rpc_xprt_switch_xprt->kobject);
+		kobject_put(&rpc_xprt_switch_xprt->kobject);
+		xprt->xprt_sysfs = NULL;
+	}
+}
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 760f0582aee5..b2ede4a2a82b 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -19,6 +19,12 @@ struct rpc_sysfs_xprt_switch {
 	struct rpc_xprt *xprt;
 };
 
+struct rpc_sysfs_xprt_switch_xprt {
+	struct kobject kobject;
+	struct net *net;
+	struct rpc_xprt *xprt;
+};
+
 int rpc_sysfs_init(void);
 void rpc_sysfs_exit(void);
 
@@ -29,5 +35,8 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt);
 void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
 				 struct rpc_xprt *xprt, gfp_t gfp_flags);
 void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt);
+void rpc_sysfs_xprt_switch_xprt_setup(struct rpc_xprt_switch *xprt_switch,
+				      struct rpc_xprt *xprt, gfp_t gfp_flags);
+void rpc_sysfs_xprt_switch_xprt_destroy(struct rpc_xprt *xprt);
 
 #endif
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 2d73a35df9ee..839b20e72ffd 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -57,6 +57,11 @@ void rpc_xprt_switch_add_xprt(struct rpc_xprt_switch *xps,
 	if (xps->xps_net == xprt->xprt_net || xps->xps_net == NULL)
 		xprt_switch_add_xprt_locked(xps, xprt);
 	spin_unlock(&xps->xps_lock);
+	xprt_switch_get(xps);
+	xprt_get(xprt);
+	rpc_sysfs_xprt_switch_xprt_setup(xps, xprt, GFP_KERNEL);
+	xprt_switch_put(xps);
+	xprt_put(xprt);
 }
 
 static void xprt_switch_remove_xprt_locked(struct rpc_xprt_switch *xps,
@@ -85,6 +90,7 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
 	spin_lock(&xps->xps_lock);
 	xprt_switch_remove_xprt_locked(xps, xprt);
 	spin_unlock(&xps->xps_lock);
+	rpc_sysfs_xprt_switch_xprt_destroy(xprt);
 	xprt_put(xprt);
 }
 
@@ -137,6 +143,9 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 		xps->xps_iter_ops = &rpc_xprt_iter_singular;
 		rpc_sysfs_xprt_switch_setup(xps, xprt, gfp_flags);
 		xprt_switch_add_xprt_locked(xps, xprt);
+		xprt_get(xprt);
+		rpc_sysfs_xprt_switch_xprt_setup(xps, xprt, gfp_flags);
+		xprt_put(xprt);
 	}
 
 	return xps;
@@ -152,6 +161,7 @@ static void xprt_switch_free_entries(struct rpc_xprt_switch *xps)
 				struct rpc_xprt, xprt_switch);
 		xprt_switch_remove_xprt_locked(xps, xprt);
 		spin_unlock(&xps->xps_lock);
+		rpc_sysfs_xprt_switch_xprt_destroy(xprt);
 		xprt_put(xprt);
 		spin_lock(&xps->xps_lock);
 	}
-- 
2.27.0

