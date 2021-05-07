Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E84C3768A8
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbhEGQ00 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbhEGQ0Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC09C061761
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p11so8438464iob.9
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzEOeQ8uxLAvSORSwpAmvrg7YRMau3GKaNMcBzma4aI=;
        b=Rw2I+vy+E3IjdNjhHLn5KY9TBraVgkmDJLkVczFHPBzi4lgoPGLiAu7qzW3KBZMmQ6
         gavProqbTqZKdLZwN+yMzMp/ee6Z9vIVw1mirJPWRWJr/i/ei+GmVp3lPVCmdZEpES7G
         Tu3njFqIjFclzyZqK4rad5xEbeMEqB2Sb6o+7/JSqt665P4gRSWER+Eaq2Z0WSqcQIyZ
         78XDw076BbxEJTrYdGXJPLFxiDAPwJ+fjDfmfOFBAaNePi1p5lJe/vcFvP13/t0zQ0DU
         g0/jm4eYF1S0e33ASf6uFVTT9qOOUl6BTrsQ2DsTzm7woGvPbh3aqS/HBbiuPXUsil9C
         L9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzEOeQ8uxLAvSORSwpAmvrg7YRMau3GKaNMcBzma4aI=;
        b=peDrYPplrEIxvPsXF01BbXTifih1t7mRdpLDOBJJMUoQCK1Nrdr3uCCyS8v3J/PgBf
         jguvCpDcWDTsJOM7mLH1cHJEQqorLhtkI8tAB0RJUnb0MxUJ2zJrNhr13As8lbgOIihO
         BY1OXE/VQSRkUrhglVUjlJRy5w2bFfcp2gGPV6oCjJV32IM2UVMa/y0+avo2imr9HTyn
         KIkf6Lgmqpg5ozl22+K78gwKeNizoInoocHUoCfhfEJmLyD5W9f+hxLWZ//5drWIdN/r
         xYxinnYb01Cdb0/tzUEa2U5GIY2cpLoVp+ZiOn+dUR756sHGhJQpktr2kmC6ue5CHV88
         VVxQ==
X-Gm-Message-State: AOAM532I93p3zeUIbi1Um9PcXLsPeur7e+ypQB8hXm9bh9qWTZoEcTXt
        SeI+i8JqMCpwLybHk3eR8s/IvlaOIIT5kw==
X-Google-Smtp-Source: ABdhPJxYQv9RcxE4tMcj0rzKnmPq4nFxZ/K6b1kARnNOa/XQfWeVk5G/+nLHOOITbkxgjP4F9udVxw==
X-Received: by 2002:a02:ca4e:: with SMTP id i14mr9471439jal.101.1620404723333;
        Fri, 07 May 2021 09:25:23 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:22 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 03/12] sunrpc: Create per-rpc_clnt sysfs kobjects
Date:   Fri,  7 May 2021 12:25:09 -0400
Message-Id: <20210507162518.51520-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

These will eventually have files placed under them for sysfs operations.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h |  2 ++
 net/sunrpc/clnt.c           |  5 +++
 net/sunrpc/sysfs.c          | 61 +++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  8 +++++
 4 files changed, 76 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 02e7a5863d28..8b5d5c97553e 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -29,6 +29,7 @@
 #include <linux/sunrpc/xprtmultipath.h>
 
 struct rpc_inode;
+struct rpc_sysfs_client;
 
 /*
  * The high-level client handle
@@ -71,6 +72,7 @@ struct rpc_clnt {
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct dentry		*cl_debugfs;	/* debugfs directory */
 #endif
+	struct rpc_sysfs_client *cl_sysfs;	/* sysfs directory */
 	/* cl_work is only needed after cl_xpi is no longer used,
 	 * and that are of similar size
 	 */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index c2a01125be1a..dab1abfef5cd 100644
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
index fa03e2ef836a..f3b7547ee218 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
+#include "sysfs.h"
 
 static struct kset *rpc_sunrpc_kset;
 static struct kobject *rpc_sunrpc_client_kobj;
@@ -56,8 +57,68 @@ int rpc_sysfs_init(void)
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
+						       struct net *net,
+						       int clid)
+{
+	struct rpc_sysfs_client *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (p) {
+		p->net = net;
+		p->kobject.kset = rpc_sunrpc_kset;
+		if (kobject_init_and_add(&p->kobject, &rpc_sysfs_client_type,
+					 parent, "clnt-%d", clid) == 0)
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
index f181c650aab8..c46afc848993 100644
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
 int rpc_sysfs_init(void);
 void rpc_sysfs_exit(void);
 
+void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net);
+void rpc_sysfs_client_destroy(struct rpc_clnt *clnt);
+
 #endif
-- 
2.27.0

