Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB11731FBA
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjFOSJS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbjFOSJL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42693295B
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23OEJxZvap55OrVGZ1+D0uiZz91ozkQu0KYarPovCzY=;
        b=ev2vIJ4drMAbNhv44Y5Z+xsY5WBUYh8B1IqPbtwAs/uHrYeBpfM6WV+fTIJUJ72NVKojZE
        eGkW01gNU6qXAo6Luh1PAMWHm8VMxSQPdSWsl0bM6cs8vGexlVTcDQoRf6CrdDbbiHHjtG
        V2lVkH0wqlsz0hJY5qkITM7pIvRlyU0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-NqOypHcVOXCAN1_J2mdK1A-1; Thu, 15 Jun 2023 14:07:35 -0400
X-MC-Unique: NqOypHcVOXCAN1_J2mdK1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A71F929A9D37
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:35 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68ACB2166B25
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:35 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 06/11] NFS: Add sysfs links to sunrpc clients for nfs_clients
Date:   Thu, 15 Jun 2023 14:07:27 -0400
Message-Id: <02b39f585ec889b11bb4819ee5c50d6057715f21.1686851158.git.bcodding@redhat.com>
In-Reply-To: <cover.1686851158.git.bcodding@redhat.com>
References: <cover.1686851158.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For the general and state management nfs_client under each mount, create
symlinks to their respective rpc_client sysfs entries.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/client.c             |  5 +++++
 fs/nfs/nfs4client.c         |  1 +
 fs/nfs/sysfs.c              | 20 ++++++++++++++++++++
 fs/nfs/sysfs.h              |  2 ++
 include/linux/sunrpc/clnt.h |  8 +++++++-
 net/sunrpc/sysfs.h          |  7 -------
 6 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 9aea938e4bf2..82a37565d73a 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -621,6 +621,7 @@ int nfs_init_server_rpcclient(struct nfs_server *server,
 	if (server->flags & NFS_MOUNT_SOFT)
 		server->client->cl_softrtry = 1;
 
+	nfs_sysfs_link_rpc_client(server, server->client, NULL);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_init_server_rpcclient);
@@ -691,6 +692,7 @@ static int nfs_init_server(struct nfs_server *server,
 
 	server->nfs_client = clp;
 	nfs_sysfs_add_server(server);
+	nfs_sysfs_link_rpc_client(server, clp->cl_rpcclient, "_state");
 
 	/* Initialise the client representation from the mount data */
 	server->flags = ctx->flags;
@@ -1117,6 +1119,9 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 
 	nfs_sysfs_add_server(server);
 
+	nfs_sysfs_link_rpc_client(server,
+		server->nfs_client->cl_rpcclient, "_state");
+
 	error = nfs_init_server_rpcclient(server,
 			source->client->cl_timeout,
 			flavor);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 41c75602ff76..7f31fabd27d3 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -949,6 +949,7 @@ static int nfs4_set_client(struct nfs_server *server,
 
 	server->nfs_client = clp;
 	nfs_sysfs_add_server(server);
+	nfs_sysfs_link_rpc_client(server, clp->cl_rpcclient, "_state");
 
 	return 0;
 }
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 0ff24f133a02..7009de149158 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -216,6 +216,26 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 	}
 }
 
+#define RPC_CLIENT_NAME_SIZE 64
+
+void nfs_sysfs_link_rpc_client(struct nfs_server *server,
+			struct rpc_clnt *clnt, const char *uniq)
+{
+	char name[RPC_CLIENT_NAME_SIZE];
+	int ret;
+
+	strcpy(name, clnt->cl_program->name);
+	strcat(name, uniq ? uniq : "");
+	strcat(name, "_client");
+
+	ret = sysfs_create_link_nowarn(&server->kobj,
+						&clnt->cl_sysfs->kobject, name);
+	if (ret < 0)
+		pr_warn("NFS: can't create link to %s in sysfs (%d)\n",
+			name, ret);
+}
+EXPORT_SYMBOL_GPL(nfs_sysfs_link_rpc_client);
+
 static void nfs_sysfs_sb_release(struct kobject *kobj)
 {
 	/* no-op: why? see lib/kobject.c kobject_cleanup() */
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index c9f5e3677eb5..c5d1990cade5 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -23,6 +23,8 @@ extern void nfs_sysfs_exit(void);
 void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net);
 void nfs_netns_sysfs_destroy(struct nfs_net *netns);
 
+void nfs_sysfs_link_rpc_client(struct nfs_server *server,
+			struct rpc_clnt *clnt, const char *sysfs_prefix);
 void nfs_sysfs_add_server(struct nfs_server *s);
 void nfs_sysfs_move_server_to_sb(struct super_block *s);
 void nfs_sysfs_move_sb_to_server(struct nfs_server *s);
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 770ef2cb5775..4ec718aa91f5 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -30,7 +30,13 @@
 #include <linux/sunrpc/xprtmultipath.h>
 
 struct rpc_inode;
-struct rpc_sysfs_client;
+struct rpc_sysfs_client {
+	struct kobject kobject;
+	struct net *net;
+	struct rpc_clnt *clnt;
+	struct rpc_xprt_switch *xprt_switch;
+};
+
 
 /*
  * The high-level client handle
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 6620cebd1037..d2dd77a0a0e9 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -5,13 +5,6 @@
 #ifndef __SUNRPC_SYSFS_H
 #define __SUNRPC_SYSFS_H
 
-struct rpc_sysfs_client {
-	struct kobject kobject;
-	struct net *net;
-	struct rpc_clnt *clnt;
-	struct rpc_xprt_switch *xprt_switch;
-};
-
 struct rpc_sysfs_xprt_switch {
 	struct kobject kobject;
 	struct net *net;
-- 
2.40.1

