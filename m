Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B6360006
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhDOC2j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhDOC2j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:39 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1AC061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:16 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id x16so22744018iob.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxuhr6yv+e4YAQl2ln8omMyqcJzGoDRDt9S73WJ8pE8=;
        b=qKnvJPp66pNsCcYJd1j5EA8Xr/TMrQd5uWGmXERxe5nhAhzRr0Kg+T/sPejXXsRuzc
         d5EHhaVMDUxN2won/328ANKg3tJd+6JoHNAijMvXZ4Ur+U1BaDc+aEDAIJADPF//R4CR
         pZUDYwHqeJ3LOb8p0o/AN/lhY1HTGMheMZEJOUxTTK23YqOZk3hdYGgly2aowKXtBG1l
         w4jNS4FsPef5DZNF6wv8YPxfG4OOBdZBI4jDq/yFfSSWxi6docRhU79mUA5s6Br+j5N5
         6BFhR2k0esqXpsf7nSkDS2xaozahr8Or0OKpvcKdFE5Z3FHLza8Kgw38+bVMzZju/Rh8
         OJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxuhr6yv+e4YAQl2ln8omMyqcJzGoDRDt9S73WJ8pE8=;
        b=aZvVZhYybEpak8i2WJH4VB3PfzTrFi57skLMq1IjZko7twYUR5ha5b+M3GN/0JQKcQ
         PvjnK9N9CXOSuxiuyCopyoquvEvIwS/lNuf3vPuMzbvQEO/2WdqlRzX02YCvyGT+WkLu
         5GZ0ADn7zZ5Kw/KwEwh2mGIz9ZMbbrrvxFnIwKjWeNODrCsACOLlrOvOLQZx+ntGpc93
         +h/YmocSgdaeIaUIby1lB91vOZt8rh9gJxY80s7SDt8kvtpsDrAU7edUWicHJ8H2xSJJ
         LEA8KclGACkOOM+JFwHshHZ+QridBj/G9IWDhEFSV5SE+IpWmit+qNujbrbqQ24veo8+
         KS3Q==
X-Gm-Message-State: AOAM530h5sdaCak2QVWcHkHfH+X0mZniqcWZXZAZXic4f2WCSZ24pgx2
        +dumYiKrO7xTP80CG8uLF3o=
X-Google-Smtp-Source: ABdhPJwOTKk2hVBcnyk00oI+EyO08cfTIOf7SXFR//8wIirs7SrJEgjBWBU161YOraDbk293SVY9Bw==
X-Received: by 2002:a05:6602:1612:: with SMTP id x18mr817169iow.139.1618453696370;
        Wed, 14 Apr 2021 19:28:16 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:15 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/13] sunrpc: add add sysfs directory per xprt under each xprt_switch
Date:   Wed, 14 Apr 2021 22:27:59 -0400
Message-Id: <20210415022802.31692-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c          | 83 +++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  9 ++++
 net/sunrpc/xprtmultipath.c  |  2 +
 4 files changed, 95 insertions(+)

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
index 6e91e271a37b..897939184f11 100644
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
@@ -149,6 +169,39 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
 	return NULL;
 }
 
+static struct rpc_sysfs_xprt_switch_xprt *
+rpc_sysfs_xprt_switch_xprt_alloc(struct kobject *parent,
+				 struct rpc_xprt *xprt,
+				 struct net *net)
+{
+	struct rpc_sysfs_xprt_switch_xprt *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
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
@@ -194,6 +247,23 @@ void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
 	}
 }
 
+void rpc_sysfs_xprt_switch_xprt_setup(struct rpc_xprt_switch *xprt_switch,
+				      struct rpc_xprt *xprt)
+{
+	struct rpc_sysfs_xprt_switch_xprt *rpc_xprt_switch_xprt;
+	struct rpc_sysfs_xprt_switch *switch_obj =
+		(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
+
+	rpc_xprt_switch_xprt =
+		rpc_sysfs_xprt_switch_xprt_alloc(&switch_obj->kobject,
+						 xprt, xprt->xprt_net);
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
@@ -222,3 +292,16 @@ void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt_switch)
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
index 9a0625b1cd65..52abe443ee8d 100644
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
 				 struct rpc_xprt *xprt);
 void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt);
+void rpc_sysfs_xprt_switch_xprt_setup(struct rpc_xprt_switch *xprt_switch,
+				      struct rpc_xprt *xprt);
+void rpc_sysfs_xprt_switch_xprt_destroy(struct rpc_xprt *xprt);
 
 #endif
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 1ed16e4cc465..eba45cbf8448 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -33,6 +33,7 @@ static void xprt_switch_add_xprt_locked(struct rpc_xprt_switch *xps,
 {
 	if (unlikely(xprt_get(xprt) == NULL))
 		return;
+	rpc_sysfs_xprt_switch_xprt_setup(xps, xprt);
 	list_add_tail_rcu(&xprt->xprt_switch, &xps->xps_xprt_list);
 	smp_wmb();
 	if (xps->xps_nxprts == 0)
@@ -66,6 +67,7 @@ static void xprt_switch_remove_xprt_locked(struct rpc_xprt_switch *xps,
 		return;
 	xps->xps_nactive--;
 	xps->xps_nxprts--;
+	rpc_sysfs_xprt_switch_xprt_destroy(xprt);
 	if (xps->xps_nxprts == 0)
 		xps->xps_net = NULL;
 	smp_wmb();
-- 
2.27.0

