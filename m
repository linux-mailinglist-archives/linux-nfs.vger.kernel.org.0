Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86DB339900
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhCLVSy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 16:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhCLVSc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 16:18:32 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1278EC061761
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:32 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c6so4945685qtc.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfkFeuznbyUeMLAdXzQfCMKQ7LUVIH0VFpprUP+sLXE=;
        b=BLvrj3KUQ9ZPewxE50/zk6aJ5RQFwaCVvN1umKwxmG6AkjvKPYVjsRGXoPhVAa2R0Q
         BNjNgi6g/1befK5si2SJJNMQotGaAaaCzGUHy8QRZqa2nmu2GxQIAgjiBECfNnqxznB6
         Shp0ETB1afnVlRn4gkKMBmf3fskQDnXQS5g6FBuN2BneVRyalIJJ14rbdCRKgen+2Di2
         wlP39uh4miS+04I6xOk3bE7KLfaLNrZ9KXn2D+xbBSRUClvi1a/64W9l4a6vnmaBCL68
         +cTkkdwO8LQRTa8Z98A8Nu1xGZaN2IW6wdL7yGR2IOTCuMgYPuot74eE8VxJihjS85bE
         7qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UfkFeuznbyUeMLAdXzQfCMKQ7LUVIH0VFpprUP+sLXE=;
        b=JOVsdG7sfFhDlFGkGsWT0gdfkKFndQE/H6dFs1FVtksSlHiUY/kBa4t1B2xno3/38A
         BOKqb/tSi/fiWxuCDLjgN126Uin3VRC9Iplsz33glKbKeb15dwuEBBfNEFxoFbPXmrZk
         OhfM2zGRpkoOxTJg/bDg+qIHYxcFttXxzdIJhA0csAc2gPshANI1+5ByeUgdZKx36Elu
         x17mozaQ7qkPhhgUBqRRDP9PSNABQ8h/1Zhwb51XxdyhaZo6bMHZtQHAipyyqXreqfGg
         rGFRpc+HLlDfSe+Ar0mxNsdBSaaR33ulZUWlb9hNMU1Z9d2/rlJCVyJC2vRfK5Fyf9VA
         OiCw==
X-Gm-Message-State: AOAM530GJ0IkTGohaBWSUHtqL5gMcL+SEqNu0wCOTkn/mFXGaIBfa/Po
        WvA9tGlsiNsI0mZjVJ6bNTJRF4ZpP5OKIQ==
X-Google-Smtp-Source: ABdhPJwhdsX2ItLn+yr26T6EXKhAWYFmueP51dS3QCsVG9zgN+hxBCvHVlnFYTTG2HYGJBvc8n1wVw==
X-Received: by 2002:ac8:7b23:: with SMTP id l3mr13631161qtu.165.1615583911028;
        Fri, 12 Mar 2021 13:18:31 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id d24sm5177490qko.54.2021.03.12.13.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:18:30 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 3/5] sunrpc: Create per-rpc_clnt sysfs kobjects
Date:   Fri, 12 Mar 2021 16:18:24 -0500
Message-Id: <20210312211826.360959-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
References: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These will eventually have files placed under them for sysfs operations.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v3: s/netns/sysfs/
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           |  5 ++++
 net/sunrpc/sysfs.c          | 60 +++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  8 +++++
 4 files changed, 74 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 02e7a5863d28..503653720e18 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -71,6 +71,7 @@ struct rpc_clnt {
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct dentry		*cl_debugfs;	/* debugfs directory */
 #endif
+	void			*cl_sysfs;	/* sysfs directory */
 	/* cl_work is only needed after cl_xpi is no longer used,
 	 * and that are of similar size
 	 */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 612f0a641f4c..ceb8d19d4cb4 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -41,6 +41,7 @@
 #include <trace/events/sunrpc.h>
 
 #include "sunrpc.h"
+#include "sysfs.h"
 #include "netns.h"
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
@@ -300,6 +301,7 @@ static int rpc_client_register(struct rpc_clnt *clnt,
 	int err;
 
 	rpc_clnt_debugfs_register(clnt);
+	rpc_sysfs_client_setup(clnt, net);
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
@@ -327,6 +329,7 @@ static int rpc_client_register(struct rpc_clnt *clnt,
 out:
 	if (pipefs_sb)
 		rpc_put_sb_net(net);
+	rpc_sysfs_client_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 	return err;
 }
@@ -733,6 +736,7 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 
 	rpc_unregister_client(clnt);
 	__rpc_clnt_remove_pipedir(clnt);
+	rpc_sysfs_client_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 
 	/*
@@ -879,6 +883,7 @@ static void rpc_free_client_work(struct work_struct *work)
 	 * so they cannot be called in rpciod, so they are handled separately
 	 * here.
 	 */
+	rpc_sysfs_client_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 	rpc_free_clid(clnt);
 	rpc_clnt_remove_pipedir(clnt);
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 350b2b1628e7..abfe8c0b3108 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
+#include "sysfs.h"
 
 static struct kset *rpc_sunrpc_kset;
 static struct kobject *rpc_sunrpc_client_kobj;
@@ -54,8 +55,67 @@ int rpc_sysfs_init(void)
 	return 0;
 }
 
+static void rpc_sysfs_client_release(struct kobject *kobj)
+{
+	struct rpc_sysfs_client *c;
+
+	c = container_of(kobj, struct rpc_sysfs_client, kobject);
+	kfree(c);
+}
+
+static const void *rpc_sysfs_client_namespace(struct kobject *kobj)
+{
+	return container_of(kobj, struct rpc_sysfs_client, kobject)->net;
+}
+
+static struct kobj_type rpc_sysfs_client_type = {
+	.release = rpc_sysfs_client_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace = rpc_sysfs_client_namespace,
+};
+
 void rpc_sysfs_exit(void)
 {
 	kobject_put(rpc_sunrpc_client_kobj);
 	kset_unregister(rpc_sunrpc_kset);
 }
+
+static struct rpc_sysfs_client *rpc_sysfs_client_alloc(struct kobject *parent,
+						struct net *net, int clid)
+{
+	struct rpc_sysfs_client *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (p) {
+		p->net = net;
+		p->kobject.kset = rpc_sunrpc_kset;
+		if (kobject_init_and_add(&p->kobject, &rpc_sysfs_client_type,
+					parent, "%d", clid) == 0)
+			return p;
+		kobject_put(&p->kobject);
+	}
+	return NULL;
+}
+
+void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net)
+{
+	struct rpc_sysfs_client *rpc_client;
+
+	rpc_client = rpc_sysfs_client_alloc(rpc_sunrpc_client_kobj, net, clnt->cl_clid);
+	if (rpc_client) {
+		clnt->cl_sysfs = rpc_client;
+		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
+	}
+}
+
+void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
+{
+	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
+
+	if (rpc_client) {
+		kobject_uevent(&rpc_client->kobject, KOBJ_REMOVE);
+		kobject_del(&rpc_client->kobject);
+		kobject_put(&rpc_client->kobject);
+		clnt->cl_sysfs = NULL;
+	}
+}
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index c9d9918e87ee..443679d71f38 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -5,7 +5,15 @@
 #ifndef __SUNRPC_SYSFS_H
 #define __SUNRPC_SYSFS_H
 
+struct rpc_sysfs_client {
+	struct kobject kobject;
+	struct net *net;
+};
+
 extern int rpc_sysfs_init(void);
 extern void rpc_sysfs_exit(void);
 
+void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net);
+void rpc_sysfs_client_destroy(struct rpc_clnt *clnt);
+
 #endif
-- 
2.29.2

