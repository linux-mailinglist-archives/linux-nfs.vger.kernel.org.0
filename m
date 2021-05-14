Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648DE380B46
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhENOOs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhENOOr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:47 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D4C061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:35 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d24so18319196ios.2
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fM7wwEt6t+WCER14PqTuRtucqv9V4Kms6u28XvA0QF4=;
        b=ae6xyMML96XzdHAjvvI2QTKeSH9GmCkWfYWyQjhRC2f5kh6UAy9Nq/ydnpqIcQrzti
         4OID2fAr52m7nHHZqJsnqI9UBuuW40+u7yRTVy5i4Tjjocd0c1UW7Faf3ufTjcASiSaj
         J5iHtzZ0vCh2IkWLYSfF+1WZSLZj1pTFtkkI8PitNMMaDtnBnPmiljctS1sR64PXtd0w
         kcNkdu+kGuEOVidws4RF4fY/nGd6saNuqn+09IQ7GxaaU954tJGuEzr7E4hq5P9E0wRO
         w4+wxfXGC7713JzrxqYJg6roJpoym7ttC8T8bJtf/QC5NB3dmyaDSX2tZcrpRQssX8Zg
         YPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fM7wwEt6t+WCER14PqTuRtucqv9V4Kms6u28XvA0QF4=;
        b=Xh/smYz13dk9PE7BdbVXyZoYUhZKq9i9/7LwbfzkVRG/z86NlKFR2EnT/aDjqsPOOW
         XHg9h/SrdfQ7fsSW5Vw/EKeiGMtzZM+CPZj/rPzn/1gW4B3g2yxZB6RJpe+yYzNQtT3f
         ks1ycw5Hyk4uLKSyhlJtnwoKQ977/Hana8EjH6EPjofP3dTsfS4JpFB0fTcP1BoXEXJE
         9W8kN05eH+iYDxrJ43gvVJZEaRrnaSHBqNYDvYi5aNqKWf4LMSPCeGByAIHoozAcTlRq
         MwEgFp3t76DSCChniDRFa9TOnHgckJMYGrWXGdZeTFsBf8XNWuyB5uiFxb/dyzSEWbMj
         7WwQ==
X-Gm-Message-State: AOAM5318DKsxd2dDKZHpxVbCDn1ljdU0wqpYCza5gevZNLf7KloKJ+d0
        MA6leBQXZV9XeBJUHSk73ts=
X-Google-Smtp-Source: ABdhPJyuFC1L4X7+a0s6Kx02a/nVflyzrPRKZCDvckRYUb/D2eq1LDCHF+vNEH9zeY2aA83W3hOubA==
X-Received: by 2002:a05:6638:2a1:: with SMTP id d1mr43640719jaq.52.1621001615215;
        Fri, 14 May 2021 07:13:35 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:34 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 09/12] sunrpc: add add sysfs directory per xprt under each xprt_switch
Date:   Fri, 14 May 2021 10:13:20 -0400
Message-Id: <20210514141323.67922-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
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
index a2edcc42e6c4..823663c6380a 100644
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

