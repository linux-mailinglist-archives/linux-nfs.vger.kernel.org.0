Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A03730CA54
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbhBBSpL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 13:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbhBBSnd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 13:43:33 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF2C06178B
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 10:42:50 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 19so20833444qkh.3
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 10:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBmHt1rrvqpyo6sP+0tgagNxOPtsPmr5NeaVYzWr5OQ=;
        b=diPocqqNWdJf6arYKvAIRrigl+iKp5QQSWHTs0L5HJ4g+IEX6JDGWlZdx5OBls5f7w
         HcRBGBfU89OKU6h1GWqEmy8M5Ry4vor8JRK9N8Ij3hQ7zDh4lhF+V6RvmgrcsAM/AT1f
         xDINMSt8dQ5vF9pvjB427gcoff3vcu9Euvzl+Il8KkrHlawDCpfrRUfsceYmrZGPx0s0
         0+5EUP0+FlhJjM3er+ISnbojPWH1kO7ImLdyy6kQqj5iXKTfGHUyJBKD+HBNHVDCYVZj
         PvQnayeu705BrZLr8nsCUgxCSgQReG3o8nd0JKhZRfhvkwsRtsVB7xzIPMA50d55OsHK
         qZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lBmHt1rrvqpyo6sP+0tgagNxOPtsPmr5NeaVYzWr5OQ=;
        b=q32WixW3rdUTcMWhXwSTt9oAUYk17inDnhruyNnvSMfKeP0V32tx1Rit+Ljosnj7Nb
         vkNBk+gd9+U2wMOr9W0ikSwZc2wRrgtuAvXZ2ifiWSp1ZbpE7t8v5iTGiAgHIRNAdlJG
         oRVrDWUMlg1CXQ2AzXqWvhyjC1Zbafxx83rEpYBKtEPoKgpcoS1OoaWsi0cjQsMLoCqP
         XBeXzm0/WNynKu/kkXWKQAgucT0HOkxphKfs//ekONGXKXtO6rFcBrIv5P62M+RUnMKa
         ygD7LgkqT3PMNBEuyaI9DxXmL7vz68ymhoqveWKlN4MIPcpNWYp804S35v9QfjPSRxjn
         C8JQ==
X-Gm-Message-State: AOAM530So7Rs2f5Pufroy47s/NBB7VmHu+qnqJfPRsN0fHLbwll7CJ5X
        moiYDa0inm0k8bbYblumbnqtKqEQxqWDiw==
X-Google-Smtp-Source: ABdhPJy7dpmNm5dXKQXHZSsw/vD6YiIG9bRZatX9kUdmFQVt3ze/CK+/9O1jN5me4qTCmft5nlKCzw==
X-Received: by 2002:a37:c03:: with SMTP id 3mr23193730qkm.367.1612291369858;
        Tue, 02 Feb 2021 10:42:49 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k4sm7415906qtq.13.2021.02.02.10.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:42:49 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 3/5] sunrpc: Create per-rpc_clnt sysfs kobjects
Date:   Tue,  2 Feb 2021 13:42:42 -0500
Message-Id: <20210202184244.288898-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These will eventually have files placed under them for sysfs operations.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
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
index 612f0a641f4c..02905eae5c0a 100644
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
+	rpc_netns_sysfs_setup(clnt, net);
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
@@ -327,6 +329,7 @@ static int rpc_client_register(struct rpc_clnt *clnt,
 out:
 	if (pipefs_sb)
 		rpc_put_sb_net(net);
+	rpc_netns_sysfs_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 	return err;
 }
@@ -733,6 +736,7 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 
 	rpc_unregister_client(clnt);
 	__rpc_clnt_remove_pipedir(clnt);
+	rpc_netns_sysfs_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 
 	/*
@@ -879,6 +883,7 @@ static void rpc_free_client_work(struct work_struct *work)
 	 * so they cannot be called in rpciod, so they are handled separately
 	 * here.
 	 */
+	rpc_netns_sysfs_destroy(clnt);
 	rpc_clnt_debugfs_unregister(clnt);
 	rpc_free_clid(clnt);
 	rpc_clnt_remove_pipedir(clnt);
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index ad6a5de5927c..42a690f8bb52 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
+#include "sysfs.h"
 
 struct kobject *rpc_client_kobj;
 static struct kset *rpc_client_kset;
@@ -54,8 +55,67 @@ int rpc_sysfs_init(void)
 	return 0;
 }
 
+static void rpc_netns_client_release(struct kobject *kobj)
+{
+	struct rpc_netns_client *c;
+
+	c = container_of(kobj, struct rpc_netns_client, kobject);
+	kfree(c);
+}
+
+static const void *rpc_netns_client_namespace(struct kobject *kobj)
+{
+	return container_of(kobj, struct rpc_netns_client, kobject)->net;
+}
+
+static struct kobj_type rpc_netns_client_type = {
+	.release = rpc_netns_client_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace = rpc_netns_client_namespace,
+};
+
 void rpc_sysfs_exit(void)
 {
 	kobject_put(rpc_client_kobj);
 	kset_unregister(rpc_client_kset);
 }
+
+static struct rpc_netns_client *rpc_netns_client_alloc(struct kobject *parent,
+						struct net *net, int clid)
+{
+	struct rpc_netns_client *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (p) {
+		p->net = net;
+		p->kobject.kset = rpc_client_kset;
+		if (kobject_init_and_add(&p->kobject, &rpc_netns_client_type,
+					parent, "%d", clid) == 0)
+			return p;
+		kobject_put(&p->kobject);
+	}
+	return NULL;
+}
+
+void rpc_netns_sysfs_setup(struct rpc_clnt *clnt, struct net *net)
+{
+	struct rpc_netns_client *rpc_client;
+
+	rpc_client = rpc_netns_client_alloc(rpc_client_kobj, net, clnt->cl_clid);
+	if (rpc_client) {
+		clnt->cl_sysfs = rpc_client;
+		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
+	}
+}
+
+void rpc_netns_sysfs_destroy(struct rpc_clnt *clnt)
+{
+	struct rpc_netns_client *rpc_client = clnt->cl_sysfs;
+
+	if (rpc_client) {
+		kobject_uevent(&rpc_client->kobject, KOBJ_REMOVE);
+		kobject_del(&rpc_client->kobject);
+		kobject_put(&rpc_client->kobject);
+		clnt->cl_sysfs = NULL;
+	}
+}
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 93c3cd220506..279a836594e7 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -5,9 +5,17 @@
 #ifndef __SUNRPC_SYSFS_H
 #define __SUNRPC_SYSFS_H
 
+struct rpc_netns_client {
+	struct kobject kobject;
+	struct net *net;
+};
+
 extern struct kobject *rpc_client_kobj;
 
 extern int rpc_sysfs_init(void);
 extern void rpc_sysfs_exit(void);
 
+void rpc_netns_sysfs_setup(struct rpc_clnt *clnt, struct net *net);
+void rpc_netns_sysfs_destroy(struct rpc_clnt *clnt);
+
 #endif
-- 
2.29.2

