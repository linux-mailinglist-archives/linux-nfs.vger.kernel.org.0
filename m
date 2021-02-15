Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF6631C0CC
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 18:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBORkz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 12:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhBORks (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 12:40:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51882C061756
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:08 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y18so9034325edw.13
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=niMm2T2Ds/z5dELiVAItbXe2qBqmyEJ1FhyXGa6auzQ=;
        b=bfPc3KoKEpJsCeibzLgmJfNGtZ/wskMzK2b7wlQAeVoH9IUc5JrG0i4qQuJX2P0RM1
         QWBz7LJ+1pQMzp4/5xn88Hb2fxMVcJoo3O8lKL+4wxB02rI9CRi5clBjbrGWuLBW+YAp
         crZcNFDq1kUlRtRNNx+R8SyXqvcIPmIs+vpowbP0bkdcZ+TnT6mbba1dq6hBMd5xZhCm
         eWAo6r4dU/voZ9yfA+OINKbzz3x8Vslwc4l8I7hWYd390L3ehEQbayAHtH1EQsX+qtkG
         emGweGW2Rt1g1odANd5CvD4ETmsuc9aLWKacMhxRc9z8l3VYbNgtmMYdEO5J0XJas4ts
         upkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=niMm2T2Ds/z5dELiVAItbXe2qBqmyEJ1FhyXGa6auzQ=;
        b=HDhwzUMCBW7KTIXF6sH021LlId+d9/PDYcQbxgFVnZ/+LNj1HNpFDMabawSxhDh9pM
         kMJ9Mq24obki6X0Rk2z2ykGREnSmsZ1YVBLIFWgpSFHK3cN0QySPQUpX3QpE5rZEpn/f
         bCHa4cRklFeZ1DaU6WrchWNDeUv+UY4/6RvucfWIu7p+ZE828+Ci5OVyHIUdFa9nvWx/
         LnQbKmHzhL1eCyu4mjN8GZkFZ5ngYAkZzurG3uIl5k+X2feGlh0XM8JHlQgklR5YT+QO
         ICoipSgZtD1i4cue4/o1DkNP+kfcp5KXjmZADB4epDOdogEpI7biCClOGnhIoLrZ7q+V
         8Qrw==
X-Gm-Message-State: AOAM530iB1IBnlKKazBsJA9+oID57mMx79t86cKOpBhC2QJ4O+zzqh0e
        Wi/r/UlxkDqxISc/gcIyPBfVw5/SAdklGw==
X-Google-Smtp-Source: ABdhPJzc6iVX3aaPcHjDgERrkl5u5tk2AmZr6EgyGADtSmM7QvYtrJAsLy0v9pYLUNB3aKhRFqeZzw==
X-Received: by 2002:a05:6402:22b0:: with SMTP id cx16mr16627948edb.255.1613410806719;
        Mon, 15 Feb 2021 09:40:06 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e11sm11257485ejz.94.2021.02.15.09.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:40:06 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v1 1/8] sunrpc: rename 'net' to 'client'
Date:   Mon, 15 Feb 2021 19:39:55 +0200
Message-Id: <20210215174002.2376333-2-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215174002.2376333-1-dan@kernelim.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is in preparation to adding a second directory to keep track
of each transport.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/clnt.c  |  8 ++++----
 net/sunrpc/sysfs.c | 22 +++++++++++-----------
 net/sunrpc/sysfs.h |  4 ++--
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 02905eae5c0a..0a4811be01cd 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -301,7 +301,7 @@ static int rpc_client_register(struct rpc_clnt *clnt,
 	int err;
 
 	rpc_clnt_debugfs_register(clnt);
-	rpc_netns_sysfs_setup(clnt, net);
+	rpc_netns_client_sysfs_setup(clnt, net);
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
@@ -329,7 +329,7 @@ static int rpc_client_register(struct rpc_clnt *clnt,
 out:
 	if (pipefs_sb)
 		rpc_put_sb_net(net);
-	rpc_netns_sysfs_destroy(clnt);
+	rpc_netns_client_sysfs_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 	return err;
 }
@@ -736,7 +736,7 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 
 	rpc_unregister_client(clnt);
 	__rpc_clnt_remove_pipedir(clnt);
-	rpc_netns_sysfs_destroy(clnt);
+	rpc_netns_client_sysfs_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 
 	/*
@@ -883,7 +883,7 @@ static void rpc_free_client_work(struct work_struct *work)
 	 * so they cannot be called in rpciod, so they are handled separately
 	 * here.
 	 */
-	rpc_netns_sysfs_destroy(clnt);
+	rpc_netns_client_sysfs_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 	rpc_free_clid(clnt);
 	rpc_clnt_remove_pipedir(clnt);
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 8b01b4df64ee..3fe814795ed9 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -9,7 +9,7 @@
 #include "sysfs.h"
 
 struct kobject *rpc_client_kobj;
-static struct kset *rpc_client_kset;
+static struct kset *rpc_sunrpc_kset;
 
 static void rpc_netns_object_release(struct kobject *kobj)
 {
@@ -45,13 +45,13 @@ static struct kobject *rpc_netns_object_alloc(const char *name,
 
 int rpc_sysfs_init(void)
 {
-	rpc_client_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
-	if (!rpc_client_kset)
+	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
+	if (!rpc_sunrpc_kset)
 		return -ENOMEM;
-	rpc_client_kobj = rpc_netns_object_alloc("net", rpc_client_kset, NULL);
+	rpc_client_kobj = rpc_netns_object_alloc("client", rpc_sunrpc_kset, NULL);
 	if (!rpc_client_kobj) {
-		kset_unregister(rpc_client_kset);
-		rpc_client_kset = NULL;
+		kset_unregister(rpc_sunrpc_kset);
+		rpc_sunrpc_kset = NULL;
 		return -ENOMEM;
 	}
 	return 0;
@@ -119,18 +119,18 @@ static struct kobj_type rpc_netns_client_type = {
 void rpc_sysfs_exit(void)
 {
 	kobject_put(rpc_client_kobj);
-	kset_unregister(rpc_client_kset);
+	kset_unregister(rpc_sunrpc_kset);
 }
 
 static struct rpc_netns_client *rpc_netns_client_alloc(struct kobject *parent,
-						struct net *net, int clid)
+						       struct net *net, int clid)
 {
 	struct rpc_netns_client *p;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p) {
 		p->net = net;
-		p->kobject.kset = rpc_client_kset;
+		p->kobject.kset = rpc_sunrpc_kset;
 		if (kobject_init_and_add(&p->kobject, &rpc_netns_client_type,
 					parent, "%d", clid) == 0)
 			return p;
@@ -139,7 +139,7 @@ static struct rpc_netns_client *rpc_netns_client_alloc(struct kobject *parent,
 	return NULL;
 }
 
-void rpc_netns_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
+void rpc_netns_client_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
 {
 	struct rpc_netns_client *rpc_client;
 	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
@@ -155,7 +155,7 @@ void rpc_netns_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
 	}
 }
 
-void rpc_netns_sysfs_destroy(struct rpc_clnt *clnt)
+void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt)
 {
 	struct rpc_netns_client *rpc_client = clnt->cl_sysfs;
 
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 137a12c87954..ab75c3cc91b6 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -16,7 +16,7 @@ extern struct kobject *rpc_client_kobj;
 extern int rpc_sysfs_init(void);
 extern void rpc_sysfs_exit(void);
 
-void rpc_netns_sysfs_setup(struct rpc_clnt *clnt, struct net *net);
-void rpc_netns_sysfs_destroy(struct rpc_clnt *clnt);
+void rpc_netns_client_sysfs_setup(struct rpc_clnt *clnt, struct net *net);
+void rpc_netns_client_sysfs_destroy(struct rpc_clnt *clnt);
 
 #endif
-- 
2.26.2

