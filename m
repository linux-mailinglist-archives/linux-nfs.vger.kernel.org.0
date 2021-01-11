Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E12F2202
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbhAKVmb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbhAKVma (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:42:30 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16681C0617A2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:50 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o20so132148ilj.11
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUNYLDOQanXWj2FaqoPwuiC+IklKVygVPBiMLz2Mkrc=;
        b=EFoUYT4ntLu7LSg4L6ymBb6D2fMKQzoVjvtI4YzNMLR898P057f8OJ85afULjtiN6B
         cTUuETYnoMuggJHpp5v/cp2cBcFLehyjNXOncfMSMC1fpZ9fmu3go0fiw/tZtyEO3KDi
         bX6rzH12yTjaPS+tEDmUq7UCBoQYa/WmVYr9Oi2PaTriummNq+G2bUxnnv08LUYdxUql
         xVRBtXcZWPtAk+JaPAJkZOdTq9s2KxqhIg08skifdMewxEnAfhYZ7c3Ub4aJzwAID3+L
         mnrRY7mpLCmfUQYYW36XkTgzmbdQQ+pjo7oVHUemXHSkDQtoYlCWxGVl3WIf5caVUZay
         sH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DUNYLDOQanXWj2FaqoPwuiC+IklKVygVPBiMLz2Mkrc=;
        b=QQPqeUrVWjYwyd8E5tBcT3z67BA0Unf8aV2IilnYO4fv9nQJR2RbRqR/wlxEGEH2Tf
         ZpnXiYDw48oa+TsxWBF6iAK7pqToFKXJ51qZd0gEPuaevROd0U8G6wOR0d0N2TGkOnTI
         zcmYZh6YvlV8NmpJYncEO5cON1um/VHEoXAfxV/jWthCsbDq7t8c8PRdTjEFTB8rwug6
         CeH/k/4TJu0IZHoHsm/CIFNEyLNLxZhFEBWlLT0HlfLCasiiGKCJ0NVYR6WMj6FiwemQ
         zhbMDg6OafG721+VF8B7wEt8hxGdl9efGOJ0Th7/m+IXE5S/uC6oGS5mgwv4imicreYF
         C/Tg==
X-Gm-Message-State: AOAM532S5pcWkb7lBMoaustWWB4RjyZdt16v4AHsgfNYqwf9S5VBUv1x
        OIhqlU2Qgc9ZOMaVYtYeUDukB2tkphyzcA==
X-Google-Smtp-Source: ABdhPJxswfQDfMYwjeZeyCS0s35U5zPr1XmmZ4jVoFDLoBo8WPSznbPw1Weo8UJP7Ti8nJcKJ7LTog==
X-Received: by 2002:a92:40c4:: with SMTP id d65mr1068538ill.197.1610401309215;
        Mon, 11 Jan 2021 13:41:49 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 143sm681712ila.4.2021.01.11.13.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:41:48 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 4/7] sunrpc: Create per-rpc_clnt sysfs kobjects
Date:   Mon, 11 Jan 2021 16:41:40 -0500
Message-Id: <20210111214143.553479-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
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
 net/sunrpc/clnt.c           |  5 +++
 net/sunrpc/sysfs.c          | 61 +++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  8 +++++
 4 files changed, 75 insertions(+)

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
index afeaec79a9c7..dd298b9c13e8 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -2,7 +2,9 @@
 /*
  * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
  */
+#include <linux/sunrpc/clnt.h>
 #include <net/sock.h>
+#include "sysfs.h"
 
 struct kobject *rpc_client_kobj;
 static struct kset *rpc_client_kset;
@@ -53,8 +55,67 @@ int rpc_sysfs_init(void)
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

