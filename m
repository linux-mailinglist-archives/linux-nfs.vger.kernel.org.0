Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF1397C3C
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 00:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhFAWLS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 18:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhFAWLP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 18:11:15 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7515C061574
        for <linux-nfs@vger.kernel.org>; Tue,  1 Jun 2021 15:09:31 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c10so409106qtx.10
        for <linux-nfs@vger.kernel.org>; Tue, 01 Jun 2021 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xh8YD1h4jEJTMPL/eZU+PJKfx8xJoHmKgCA8iRzN8/k=;
        b=lw3aRWOOkgPAEXr0hke9snHmSxlj/Wu6qA/CFin3BHXp7BDLK+qMsNe6+Z6G5eXq4u
         aebyyjGCD28HaoLJMSjOpvv5t9nRNkZZlH22I0/XtrHdzvz+6igYoWlchOlo0G6640v2
         SOq5UPBTH4eiJJ69yA5yJjflBDTI7V70V20+bNh/1/INqfcO1xKCcEfi2eRQYtMcCuIb
         AQ0sBiJ8H+zWJhYNcd6wg7Ms98D+ediksc0bRnfh471fE4a4G0g6AlVOP3WlI1W6spUf
         cjUdFQOvOUSOYSEMy3rB+WZ2FoFojmjEaYu67xM79VW3ZmS15DDvA9HgKOvnA+LEc9rh
         0MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xh8YD1h4jEJTMPL/eZU+PJKfx8xJoHmKgCA8iRzN8/k=;
        b=noWnW/Azzn1UgZcIEF+l3xrbnVgMoqHi+A2YsJs70lUmaLMnteeND1zxVGa/JVTXaD
         wxDX5DbO5tQGIsv/TdZHFz5+pGAAdvT24jeazmfv30FhyVE3c82wOqa0451TEU7mKB1Q
         uCyHQBD8+GnpqnP6ffufwQpPlA7KGOw/8Pg8A7q62cgcmMry5Gatg0EFg/35iIWTJ/bE
         1nZV1NDjys+/2vjEN0INpIBSbEPWMAKYXULPgYkN1LOhWjA6tGdWohsR185wWS19hTX5
         pCZftSqoc+730PqWn1Fc1X9PUor23tGYwxcLMPNf8T29r+3KMFIcw+zOHl2eDRJGzc3P
         zCzQ==
X-Gm-Message-State: AOAM530y0B/foHu2gldI/SphIv8W0TbzQ6wbFu2gJ7gDdjPCrA+KQTem
        xCh27YwG+L4dIcD9cnmw5dxMWIz1GUM=
X-Google-Smtp-Source: ABdhPJwH09eNfylx/p6ahJAG7i5jIpIagvwUmLYLmQhuwnpCwX+Q+/Tw5t9dK2v6+jz8BYH+M8Veww==
X-Received: by 2002:ac8:7f83:: with SMTP id z3mr21212907qtj.239.1622585370934;
        Tue, 01 Jun 2021 15:09:30 -0700 (PDT)
Received: from kolga-mac-1.lan (50-124-240-218.alma.mi.frontiernet.net. [50.124.240.218])
        by smtp.gmail.com with ESMTPSA id q13sm12419789qkn.10.2021.06.01.15.09.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 15:09:30 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 03/13] sunrpc: Create per-rpc_clnt sysfs kobjects
Date:   Tue,  1 Jun 2021 18:09:05 -0400
Message-Id: <20210601220915.18975-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
References: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
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
index 42623d6b8f0e..6f3f840a2ea3 100644
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

