Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C4361866
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhDPDxH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbhDPDxG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:53:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57832C061574
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:41 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b139so22199871qkc.10
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kP6I/quQC0MoyLckln70H1z4WaIDdNq3WsoLMtt/Pj0=;
        b=UoZDgrU3Y0WvFilI/9WBEnJ+i41kH9DcZCg4NGJVaiJqmHFrizKPiJRrhQaNe7ryH6
         RXlifZtOLevvSDj3aSGYD3Pv/enGPxToehOGl3TbM7fPvtsjomilDUfxqnuSAFeyQCKM
         ibKhbpc5kU4ZPK/aG/NNHCluE9B2VtjZ7VRHUdUODZNweQ6PB/rtneKnPfGcDrVvuijC
         9fOp0kR8sR/+pPZPNKWiX9gzkA7+4iETLOaq95XiU/OGl+yfqt/WnnD7lGuNrgQjxLnM
         bHIr/BH5uQ/OuR8i0aNhtRq5r0qnMIsO1IuLZ/SAJalf4nnsfF2PhfF4l0Djfco8ayjz
         r5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kP6I/quQC0MoyLckln70H1z4WaIDdNq3WsoLMtt/Pj0=;
        b=eU6c4Z2raoj0KIC6MlsF8D+DQh0/wXNMdjFdOWuWntiif9W93ZARAGxDtE1yqx9tMu
         JIcSHmEOFkXE3yV6WSfNAvtY3e5+kfmJ5M+RpWdZEi0B1Nygjm0HcNK4slXgBp1zih1u
         X9uXtuJkSsJuE34gJlxGgSsqg1WUBZTjZ7VKCrCYa9bqFFClEcghOLoskYSCNe/BhZ++
         ZEiKZpqO2opSvk6tVYtcKvaRNoPMRfEHRul/QbfTQdDCEYUUOyuDm0HTJSyOH03lGUGS
         BT7W+n5OwbUxnCBmdYlH8fPQdmrZr8ToZmOxJgw1tO5VS2/DClYmeTkXvvCnLRrsqNIf
         UsJg==
X-Gm-Message-State: AOAM533RYS2W7P45aMu3McdEifqOP7WJu6lW4UdIOq9gl7cRSNtx7ys5
        vteduMX+pxi/H4OHTnxpsQ6wJ9X3NwU=
X-Google-Smtp-Source: ABdhPJzIdkIWu6vhE0518c7TcFYpHUG3xVtQXCj/MohBkVyYDkOtN2m8JaXQ4zNl6+rqzmcevaG8Mw==
X-Received: by 2002:a05:620a:cf4:: with SMTP id c20mr6779406qkj.134.1618545160527;
        Thu, 15 Apr 2021 20:52:40 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:40 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 10/13] sunrpc: add add sysfs directory per xprt under each xprt_switch
Date:   Thu, 15 Apr 2021 23:52:23 -0400
Message-Id: <20210416035226.53588-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
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
index ce2cad1b6aa6..5410d8fe1181 100644
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
@@ -197,6 +250,23 @@ void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
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
@@ -225,3 +295,16 @@ void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt_switch)
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

