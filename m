Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6602360005
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhDOC2i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhDOC2h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:37 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C227CC061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:15 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c3so12778612ils.5
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raMDgmlchq+DKNX0qxvB0dsQ0FtPW2sX0aUw2dFGIAM=;
        b=XGwU1Qk+u058kCmimlN05A41qh1Rr5llkdp2gzxsZ+F3MZNTbGtxlC1A6fGy4jvfdh
         6e5XeUjxY1RJtJ1d9EW4l7sFnbjOlfBLq5FLs8bLw2/6bo8tT1KnRmLBUJrysWG966QX
         DHuH6VgiuPKI774jcZ1L3/5qProWzhqaK9qwc78+fVDQ43Box36qFSGLMJUY5oLDZKCc
         AGhhCsTa+aO1uWrEHCEGgV0A4m64Eygr+9FggqNLpoCGrXHJzLVMkK1sDimTOJ8PQJOe
         +N2UzKgZLfzVhRSrdjO2OT1XrlT+3RomvH133tyH+F2ZvW0MxOTQPYKsqNaf4sMBGqYz
         yAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raMDgmlchq+DKNX0qxvB0dsQ0FtPW2sX0aUw2dFGIAM=;
        b=EGWkU1bWT56949fYHwNORFAvk/IQcraqtk15rz4zJrvkWEV2RaVJMkomvy06E3x5ah
         OPtsviUi9xavpmQaoMpylo3/8RYnuMc7JGyd9TWGp/i/kqb+hWECotEYryx9be0MVayF
         559NcKJrJ55Og0eVBlVQylMsWU2dvYFvd+UexwaMbnlqei9jqrBtBDbrUUAkQj6Xtwqk
         QDSLdgE4866K5lwt4xzI+KrQ0Ol9wU0jgZpB1j+Bb3s8zx2kDoD/LQ2z3nLW4ddG18dm
         YV1C4TDxe8LNR/PdAYGUDmznxHB7T32HCJYnHNpZn+pu4jDDFX7RLfqpOO6ON3SJjc1E
         hrxA==
X-Gm-Message-State: AOAM531AyBJAvk0BCDz0jSzQAQsHUziqPgbc12MocF6bJ6dUReoSlswU
        1tP2dz6N4w0N/7yLQEhfJO8=
X-Google-Smtp-Source: ABdhPJyYCU67vqQieLZL/TNOcXxzYv9NKAJ00QEInKkjkOngCqG4GohcD+kAO7pdqMfymmyn55Eadw==
X-Received: by 2002:a05:6e02:120e:: with SMTP id a14mr989513ilq.273.1618453695211;
        Wed, 14 Apr 2021 19:28:15 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:14 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/13] sunrpc: add a symlink from rpc-client directory to the xprt_switch
Date:   Wed, 14 Apr 2021 22:27:58 -0400
Message-Id: <20210415022802.31692-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

An rpc client uses a transport switch and one ore more transports
associated with that switch. Since transports are shared among
rpc clients, create a symlink into the xprt_switch directory
instead of duplicating entries under each rpc client.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c  |  2 +-
 net/sunrpc/sysfs.c | 22 ++++++++++++++++++++--
 net/sunrpc/sysfs.h |  6 +++++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index ceb8d19d4cb4..fad87dba5114 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -301,7 +301,6 @@ static int rpc_client_register(struct rpc_clnt *clnt,
 	int err;
 
 	rpc_clnt_debugfs_register(clnt);
-	rpc_sysfs_client_setup(clnt, net);
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
@@ -426,6 +425,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	/* save the nodename */
 	rpc_clnt_set_nodename(clnt, nodename);
 
+	rpc_sysfs_client_setup(clnt, xps, rpc_net_ns(clnt));
 	err = rpc_client_register(clnt, args->authflavor, args->client_name);
 	if (err)
 		goto out_no_path;
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 0c34330714ab..6e91e271a37b 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -149,14 +149,27 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
 	return NULL;
 }
 
-void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net)
+void rpc_sysfs_client_setup(struct rpc_clnt *clnt,
+			    struct rpc_xprt_switch *xprt_switch,
+			    struct net *net)
 {
 	struct rpc_sysfs_client *rpc_client;
 
-	rpc_client = rpc_sysfs_client_alloc(rpc_sunrpc_client_kobj, net, clnt->cl_clid);
+	rpc_client = rpc_sysfs_client_alloc(rpc_sunrpc_client_kobj,
+					    net, clnt->cl_clid);
 	if (rpc_client) {
+		char name[23];
+		struct rpc_sysfs_xprt_switch *xswitch =
+			(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
+		int ret;
+
 		clnt->cl_sysfs = rpc_client;
+		rpc_client->clnt = clnt;
+		rpc_client->xprt_switch = xprt_switch;
 		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
+		snprintf(name, sizeof(name), "switch-%d", xprt_switch->xps_id);
+		ret = sysfs_create_link_nowarn(&rpc_client->kobject,
+					       &xswitch->kobject, name);
 	}
 }
 
@@ -186,6 +199,11 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
 	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
 
 	if (rpc_client) {
+		char name[23];
+
+		snprintf(name, sizeof(name), "switch-%d",
+			 rpc_client->xprt_switch->xps_id);
+		sysfs_remove_link(&rpc_client->kobject, name);
 		kobject_uevent(&rpc_client->kobject, KOBJ_REMOVE);
 		kobject_del(&rpc_client->kobject);
 		kobject_put(&rpc_client->kobject);
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 9b6acd3fd3dc..9a0625b1cd65 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -8,6 +8,8 @@
 struct rpc_sysfs_client {
 	struct kobject kobject;
 	struct net *net;
+	struct rpc_clnt *clnt;
+	struct rpc_xprt_switch *xprt_switch;
 };
 
 struct rpc_sysfs_xprt_switch {
@@ -20,7 +22,9 @@ struct rpc_sysfs_xprt_switch {
 int rpc_sysfs_init(void);
 void rpc_sysfs_exit(void);
 
-void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net);
+void rpc_sysfs_client_setup(struct rpc_clnt *clnt,
+			    struct rpc_xprt_switch *xprt_switch,
+			    struct net *net);
 void rpc_sysfs_client_destroy(struct rpc_clnt *clnt);
 void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
 				 struct rpc_xprt *xprt);
-- 
2.27.0

