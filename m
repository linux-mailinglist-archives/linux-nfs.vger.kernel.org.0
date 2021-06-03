Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F084239ADE2
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFCWWu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFCWWu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:22:50 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64555C061760
        for <linux-nfs@vger.kernel.org>; Thu,  3 Jun 2021 15:20:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id u30so7541623qke.7
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdMdH1UktKMge22xTBEvqaZAkiiiSExhGbNUVUAcoMg=;
        b=WepAfucr7ezo2rayFGBxvYGUzck8bEBd/SB28ChFzIm7zMfs39/yCTKM5sNvBx+xn4
         TW6E5y1dcQzX8rIzKXk3z2hUWIBKo4eUxkCz+R34PA3y2Gm30ibxYQeHY6g2zL3fIUoA
         3khE4r4cMC00IUBq9eh5kL4KNFfFaRan8HQUBFqvjX3+u3aB3px83Dgl6lkPEdAp3q0q
         ZdAznHZ7EVnSn+vZI2GM8YXKMSECo7FVJPRK3EB1HFMN5+01wpZsk+UpytcQcXptQ4YS
         sIAx5LK1LgYSxK2/k96DEwlJi1EvMw8JtMvYDw9xjRq5whaIYPDOweEcE/pIspNclZdc
         1SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdMdH1UktKMge22xTBEvqaZAkiiiSExhGbNUVUAcoMg=;
        b=VPlmdE2J/Vt43tbw8QdMqdu7zPlFOdTrWrzfQqKA8IWFANn6pOb2Xa7H2KFu1zoen1
         WVVf4B9bZg8jBvKeJUkp2TFOjRoh64oUHW6Z8NEkaitau+AUpJ8Rvr5FbbFNX5SjpSYt
         fW51LusL8a5NItRd0halT6wDyheUd4N1nqmCCEP3DM9Zsf58m+KsLMMgcPG6wEMW9e7r
         qPrYjlqC6izDSIAkleCH7EyGBrS2C1ucI6YCZ+0VIxcy+Q1nlwZhhVAWk83aJhvv3o3w
         6hbIwTMrl/ZS33juEZ2NMmntrNSzwHR/x2jR1C5tPO9UsSvNp2/hB45Px2mXqhrXlc8X
         hsig==
X-Gm-Message-State: AOAM530RQR48VDEmWNBPLHvDTWTBI4kLpQet2Br/lOuQwUVNLBOxq6XH
        sZO7beyC5FcBrRLK/UfklL8=
X-Google-Smtp-Source: ABdhPJwGcLk1apPJLYQqFqGJf3dpnDG7t4VNXjowamZRGEHUSRWphkKSf9Ox6hZC1zOg0ISs2jIP4w==
X-Received: by 2002:a05:620a:1003:: with SMTP id z3mr1525721qkj.490.1622758852601;
        Thu, 03 Jun 2021 15:20:52 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:52 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 09/13] sunrpc: add add sysfs directory per xprt under each xprt_switch
Date:   Thu,  3 Jun 2021 18:20:35 -0400
Message-Id: <20210603222039.19182-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
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
 include/linux/sunrpc/xprt.h |  2 ++
 net/sunrpc/sysfs.c          | 67 +++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  8 +++++
 net/sunrpc/xprtmultipath.c  |  4 +++
 4 files changed, 81 insertions(+)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 7efc6c0a5455..8360db664e5f 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -183,6 +183,7 @@ enum xprt_transports {
 	XPRT_TRANSPORT_LOCAL	= 257,
 };
 
+struct rpc_sysfs_xprt;
 struct rpc_xprt {
 	struct kref		kref;		/* Reference count */
 	const struct rpc_xprt_ops *ops;		/* transport methods */
@@ -291,6 +292,7 @@ struct rpc_xprt {
 #endif
 	struct rcu_head		rcu;
 	const struct xprt_class	*xprt_class;
+	struct rpc_sysfs_xprt	*xprt_sysfs;
 };
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 0aa63747f496..20f75708594f 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -82,6 +82,14 @@ static void rpc_sysfs_xprt_switch_release(struct kobject *kobj)
 	kfree(xprt_switch);
 }
 
+static void rpc_sysfs_xprt_release(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt *xprt;
+
+	xprt = container_of(kobj, struct rpc_sysfs_xprt, kobject);
+	kfree(xprt);
+}
+
 static const void *rpc_sysfs_client_namespace(struct kobject *kobj)
 {
 	return container_of(kobj, struct rpc_sysfs_client, kobject)->net;
@@ -92,6 +100,12 @@ static const void *rpc_sysfs_xprt_switch_namespace(struct kobject *kobj)
 	return container_of(kobj, struct rpc_sysfs_xprt_switch, kobject)->net;
 }
 
+static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
+{
+	return container_of(kobj, struct rpc_sysfs_xprt,
+			    kobject)->xprt->xprt_net;
+}
+
 static struct kobj_type rpc_sysfs_client_type = {
 	.release = rpc_sysfs_client_release,
 	.sysfs_ops = &kobj_sysfs_ops,
@@ -104,6 +118,12 @@ static struct kobj_type rpc_sysfs_xprt_switch_type = {
 	.namespace = rpc_sysfs_xprt_switch_namespace,
 };
 
+static struct kobj_type rpc_sysfs_xprt_type = {
+	.release = rpc_sysfs_xprt_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace = rpc_sysfs_xprt_namespace,
+};
+
 void rpc_sysfs_exit(void)
 {
 	kobject_put(rpc_sunrpc_client_kobj);
@@ -151,6 +171,25 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
 	return NULL;
 }
 
+static struct rpc_sysfs_xprt *rpc_sysfs_xprt_alloc(struct kobject *parent,
+						   struct rpc_xprt *xprt,
+						   gfp_t gfp_flags)
+{
+	struct rpc_sysfs_xprt *p;
+
+	p = kzalloc(sizeof(*p), gfp_flags);
+	if (!p)
+		goto out;
+	p->kobject.kset = rpc_sunrpc_kset;
+	if (kobject_init_and_add(&p->kobject, &rpc_sysfs_xprt_type,
+				 parent, "xprt-%d-%s", xprt->id,
+				 xprt->address_strings[RPC_DISPLAY_PROTO]) == 0)
+		return p;
+	kobject_put(&p->kobject);
+out:
+	return NULL;
+}
+
 void rpc_sysfs_client_setup(struct rpc_clnt *clnt,
 			    struct rpc_xprt_switch *xprt_switch,
 			    struct net *net)
@@ -199,6 +238,22 @@ void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
 	}
 }
 
+void rpc_sysfs_xprt_setup(struct rpc_xprt_switch *xprt_switch,
+			  struct rpc_xprt *xprt,
+			  gfp_t gfp_flags)
+{
+	struct rpc_sysfs_xprt *rpc_xprt;
+	struct rpc_sysfs_xprt_switch *switch_obj =
+		(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
+
+	rpc_xprt = rpc_sysfs_xprt_alloc(&switch_obj->kobject, xprt, gfp_flags);
+	if (rpc_xprt) {
+		xprt->xprt_sysfs = rpc_xprt;
+		rpc_xprt->xprt = xprt;
+		kobject_uevent(&rpc_xprt->kobject, KOBJ_ADD);
+	}
+}
+
 void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
 {
 	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
@@ -225,3 +280,15 @@ void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt_switch)
 		xprt_switch->xps_sysfs = NULL;
 	}
 }
+
+void rpc_sysfs_xprt_destroy(struct rpc_xprt *xprt)
+{
+	struct rpc_sysfs_xprt *rpc_xprt = xprt->xprt_sysfs;
+
+	if (rpc_xprt) {
+		kobject_uevent(&rpc_xprt->kobject, KOBJ_REMOVE);
+		kobject_del(&rpc_xprt->kobject);
+		kobject_put(&rpc_xprt->kobject);
+		xprt->xprt_sysfs = NULL;
+	}
+}
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 760f0582aee5..ff10451de6fa 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -19,6 +19,11 @@ struct rpc_sysfs_xprt_switch {
 	struct rpc_xprt *xprt;
 };
 
+struct rpc_sysfs_xprt {
+	struct kobject kobject;
+	struct rpc_xprt *xprt;
+};
+
 int rpc_sysfs_init(void);
 void rpc_sysfs_exit(void);
 
@@ -29,5 +34,8 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt);
 void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
 				 struct rpc_xprt *xprt, gfp_t gfp_flags);
 void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt);
+void rpc_sysfs_xprt_setup(struct rpc_xprt_switch *xprt_switch,
+			  struct rpc_xprt *xprt, gfp_t gfp_flags);
+void rpc_sysfs_xprt_destroy(struct rpc_xprt *xprt);
 
 #endif
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 2d73a35df9ee..e7973c1ff70c 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -57,6 +57,7 @@ void rpc_xprt_switch_add_xprt(struct rpc_xprt_switch *xps,
 	if (xps->xps_net == xprt->xprt_net || xps->xps_net == NULL)
 		xprt_switch_add_xprt_locked(xps, xprt);
 	spin_unlock(&xps->xps_lock);
+	rpc_sysfs_xprt_setup(xps, xprt, GFP_KERNEL);
 }
 
 static void xprt_switch_remove_xprt_locked(struct rpc_xprt_switch *xps,
@@ -85,6 +86,7 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
 	spin_lock(&xps->xps_lock);
 	xprt_switch_remove_xprt_locked(xps, xprt);
 	spin_unlock(&xps->xps_lock);
+	rpc_sysfs_xprt_destroy(xprt);
 	xprt_put(xprt);
 }
 
@@ -137,6 +139,7 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 		xps->xps_iter_ops = &rpc_xprt_iter_singular;
 		rpc_sysfs_xprt_switch_setup(xps, xprt, gfp_flags);
 		xprt_switch_add_xprt_locked(xps, xprt);
+		rpc_sysfs_xprt_setup(xps, xprt, gfp_flags);
 	}
 
 	return xps;
@@ -152,6 +155,7 @@ static void xprt_switch_free_entries(struct rpc_xprt_switch *xps)
 				struct rpc_xprt, xprt_switch);
 		xprt_switch_remove_xprt_locked(xps, xprt);
 		spin_unlock(&xps->xps_lock);
+		rpc_sysfs_xprt_destroy(xprt);
 		xprt_put(xprt);
 		spin_lock(&xps->xps_lock);
 	}
-- 
2.27.0

