Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4F39ADE6
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFCWXb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:23:31 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:35381 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFCWXb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:23:31 -0400
Received: by mail-qk1-f174.google.com with SMTP id j189so7590002qkf.2
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xh8YD1h4jEJTMPL/eZU+PJKfx8xJoHmKgCA8iRzN8/k=;
        b=N2aOV+CQd83LU2GayMK4tdIu6GndiuY1XkXkwUVKfCcb/FGMY3d9/wfbTMkxsAu2lV
         oF53C0ui0BCpydbP9S27v8Y4IJkgMvIliAX4q7/AWgRdh21chrEya+JYRKK3/Pqugw3O
         FGeFVyqd1BpA5prMMWD/MoTeexB4ffJswz2PCWt8AVgseq88TwlJChLOldhfb9HFCOuK
         xa/DTdWJ1PzwRLlVSQ8cQzMi0+IDAlPKnnD3DjvFZCX9RrFjQJpYGeCzD5faTMs4hUGf
         d7m4zqdEcIX0uuhsTsxjp5SCEZjtlh7AHDrYK+XaFIHWfQtc8V4pOJNfQ2v6bN13QpyF
         jlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xh8YD1h4jEJTMPL/eZU+PJKfx8xJoHmKgCA8iRzN8/k=;
        b=Q9gpFo8HvkOJFxG/Nxh9H/C6uVKEB3me5Xc8bwEE6vriECGJ/WboouOlmTFrzI5zcw
         m6dpeXIUXS/mF+wYGfqnb87dit2XmNkHFSTkY3pGvU12oU8R+LCGYOQRX+Fb0yaIKhs1
         4kWO0EQdGtQ9ZoV0uaHSA/HABknEGTQ0Blh+IlBnZIhxz8wPC/MZh8gin3rT1hKFGpPB
         iWmt5HjHwgv/pUNeab4n5HXMTG9DPKY6BeAVKM5UkWmFQk2o9lRFT2WjgHK7IgD80lsM
         Q4FaXfaGfy0LBzDyZvlIzsxwM1ZNPW2AP/I0JgylVQW4dbv1AYVm/oPcGQeeSxNxIZ2/
         44lA==
X-Gm-Message-State: AOAM531iPqj/0AU1vjTI2kHy9+R79kYNdnS0K+zmSXlt3QnWNhqci4MD
        ZIA0CdBV58YOTya2vJKMPQ4=
X-Google-Smtp-Source: ABdhPJzgs8AHLfIG2A8ZF0HzAxD2ZoouV1g0FyQRcIqUEmXxaRzoXjniMatb9IMbMhfJYFBewk6S9Q==
X-Received: by 2002:a37:9003:: with SMTP id s3mr1510224qkd.86.1622758845525;
        Thu, 03 Jun 2021 15:20:45 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:45 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 03/13] sunrpc: Create per-rpc_clnt sysfs kobjects
Date:   Thu,  3 Jun 2021 18:20:29 -0400
Message-Id: <20210603222039.19182-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
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

