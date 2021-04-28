Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F077836E0FB
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhD1VdE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhD1VdD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:33:03 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1837DC06138C
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id o1so6177985qta.1
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/K6BjIw2y1W0AbLQSD0bBfb29FdYAs/XqpwUc9kuvk=;
        b=kkc9D+riYcf9Iks52lDoHCPKdLHFGclSBSx2ERtfXCf5sT5j3z0bIJk6vpiUiDv5D3
         UBZc9o4o0zF7jPG3EEbIs+3Um2hxEdjgRKAiGXOA8q5/v7DPaMs0Wd5NujbjjlQ58aCg
         Rx0kj2YB2EUHgXIclj04Q5VXTOxIty8JnChm8GKmfGUEW3l3aMkyjgbsGcP+KtKlUlqw
         iHGToZLyPS6Olze9gsmlW6gQuMCCfoxYgJLRKxuecsfhxkAd09yXKiKTCStUnqx9Sdo/
         QYOf++JF0XBc2nk9EBGnJNbhOBCrauvCV7XYeRZBgQqjibKW5wR24UcBIiwpLJ4ggIEz
         IOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/K6BjIw2y1W0AbLQSD0bBfb29FdYAs/XqpwUc9kuvk=;
        b=bh4Bf76rMdGpFRLOrgisktrfyeGbROG7URK09KRgRmKkqeq0q5OxGerFifZwWnUKKH
         5v9BvjFwBkqwV9hZUvp0a6utfWK5TZDUND5GkaeGQ8ZmHiEJRcnBtZc2zMWcVk7BcLFH
         22SN12+ffJcEm66ACJxCtezh66M6gflD5OGiYkaEexL8y/WtECfTVrSt1KXQeWYv+Tr8
         /SY/6J4o5MiyZIFISa3XHk/F4D7V+jjFMKwqsOvb8Jf+PSzuvtLy2IuVg/n/scFt1sZP
         GMg/joawIJByQWHqXSJfUB6lOEzL/k2xdj4mCEnExZkklilXeMO0/DaX5VPjMguIIIoZ
         yz1w==
X-Gm-Message-State: AOAM5309KM1HZvmvx5Ctd66PwO87X2s3dgVwGCgvFc2WdNVMlxQRb692
        lUZbF8uL28/9LTJ65XaI6h4=
X-Google-Smtp-Source: ABdhPJwfHDQTv8+MsCUoic9SWGGpVY33pC7iOTmIBj8delet9QEK8nnyro1+020z+CtVpbyV4gOJvQ==
X-Received: by 2002:ac8:4701:: with SMTP id f1mr26550326qtp.117.1619645537358;
        Wed, 28 Apr 2021 14:32:17 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:16 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 09/13] sunrpc: add a symlink from rpc-client directory to the xprt_switch
Date:   Wed, 28 Apr 2021 17:31:59 -0400
Message-Id: <20210428213203.40059-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c | 25 +++++++++++++++++++++++--
 net/sunrpc/sysfs.h |  6 +++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index dab1abfef5cd..2e195623c10d 100644
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
index ed9f7131543f..98d27273d988 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -151,14 +151,30 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
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
+		if (ret)
+			pr_warn("can't create link to %s in sysfs (%d)\n",
+				name, ret);
 	}
 }
 
@@ -189,6 +205,11 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
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
index 52ec472bd4a9..760f0582aee5 100644
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
 				 struct rpc_xprt *xprt, gfp_t gfp_flags);
-- 
2.27.0

