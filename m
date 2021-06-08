Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611523A04E0
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhFHUCi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:02:38 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34646 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhFHUCf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:02:35 -0400
Received: by mail-qt1-f170.google.com with SMTP id u20so7996480qtx.1
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xh8YD1h4jEJTMPL/eZU+PJKfx8xJoHmKgCA8iRzN8/k=;
        b=npCErfHeF3JWFBlsgL2e60IuYjU/5DuNMCfxi7tZ8n3U7T/9Z0HEbJmFs3OkcIVWGA
         Dq24Gdc+jNVutjJ8mobcab2EvUrIToyMNZi1TjYRGZoW7gYjJM6Ae251+genqJrOCK4/
         HPHyi2Yp0gnxGN4ZxMMzKWW35mUGxe2JYfm0cRmtbHogTEzJEQV2LYBqIICkEHn/02OW
         jl+WuETVYUexthyHQ8UGZC5bdf/85+TYsZJf5ydA42ryJkOe/S4ZndhxKhFu1E2sj/Dg
         bFMhQbUWHyLR3WDmEM0IcmqIRA46Dhw2C5CaPttpiUa4eZ2v2l6fX5/h1JPV+R14J29h
         GAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xh8YD1h4jEJTMPL/eZU+PJKfx8xJoHmKgCA8iRzN8/k=;
        b=HYk2YEmtfjZWXLsH8+BaTuiQN610wJXzl7JDGXTvPXnIX53Uja8bwoxRjLKzgoHUTF
         gYlju0Ucb6Mf6gRtPHhX1rGY4WUxortQPpaa31REnIa+ERb4qIsmhDIAYO4FF2m8CveW
         MqtGxpZJgzFwyudpXaMvc6ZwSjFYbOTTBaetDn6kpq6mLzoTIlhcyf0HRwe9N+/CWGfW
         y9Lovfxz9alQLKW5neQwfWzHD1TF98asxfDHTTPYBFdwKSn7SjnKHg+TzMdF9LxP3X3w
         QNLBK5B7fJyQU1hei+tPh0LUDfj6e1QGlkHOyWQ2M7QCRz0LhXv+x43/QbdYYS3PeuoO
         ezOw==
X-Gm-Message-State: AOAM531YgIiT2uBOMFZjxvFgLWW644odGCqGWFvpkBRwILd6Z2rbGvRU
        PJBNOe76jhM7lOAVVICbQHKnhv84Pqk=
X-Google-Smtp-Source: ABdhPJzhqS7x3C4OhSc7Kh/42qasqb6IRdMcONMlwgUuchn9ykUQT75MJCkWHFo7iq0+y9SYp4N2og==
X-Received: by 2002:a05:622a:4a:: with SMTP id y10mr5771219qtw.294.1623182370614;
        Tue, 08 Jun 2021 12:59:30 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:30 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 03/13] sunrpc: Create per-rpc_clnt sysfs kobjects
Date:   Tue,  8 Jun 2021 15:59:12 -0400
Message-Id: <20210608195922.88655-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
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

