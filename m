Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6AF6D993A
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbjDFOLd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbjDFOLG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 10:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A73AD33
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Z+2y8K33oLj9LY/VSW5QrBnkCYvoIbDsU7VZTZXL5E=;
        b=Z23TnuNo0fHYz4QjEMJx0O6hILtRahoDAsSWlb+GyJIFhqZZY5g6mznvDXUuem/VACbVxA
        pKwzodCGRS9LEfS46RDAHRJRIfDhzmcOMkzo+xeDdX2B+rFyShuNrbgOkM3LJzM0wWf0PJ
        hznCs52oGvjK6JTzZD0RqhKxXvf3sjg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-3KXwZ4nTOE67to7zdvVMJA-1; Thu, 06 Apr 2023 10:10:08 -0400
X-MC-Unique: 3KXwZ4nTOE67to7zdvVMJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A11AC88B7A6;
        Thu,  6 Apr 2023 14:10:07 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.10.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41F472166B29;
        Thu,  6 Apr 2023 14:10:07 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@netapp.com, Olga.Kornievskaia@netapp.com
Subject: [PATCH 4/6] NFS: Add sysfs links to sunrpc clients for nfs_clients
Date:   Thu,  6 Apr 2023 10:10:02 -0400
Message-Id: <f9f2487171df81b880e3b28d984e2e64f5338955.1680786859.git.bcodding@redhat.com>
In-Reply-To: <cover.1680786859.git.bcodding@redhat.com>
References: <cover.1680786859.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
 fs/nfs/nfs4client.c         |  2 ++
 fs/nfs/sysfs.c              | 20 ++++++++++++++++++++
 fs/nfs/sysfs.h              |  2 ++
 include/linux/sunrpc/clnt.h |  8 +++++++-
 net/sunrpc/sysfs.h          |  7 -------
 6 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 72da715fc617..de275f1fde92 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -621,6 +621,7 @@ int nfs_init_server_rpcclient(struct nfs_server *server,
 	if (server->flags & NFS_MOUNT_SOFT)
 		server->client->cl_softrtry = 1;
 
+	nfs_sysfs_link_rpc_client(server, server->client, NULL);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_init_server_rpcclient);
@@ -690,6 +691,7 @@ static int nfs_init_server(struct nfs_server *server,
 		return PTR_ERR(clp);
 
 	server->nfs_client = clp;
+	nfs_sysfs_link_rpc_client(server, clp->cl_rpcclient, "_state");
 
 	/* Initialise the client representation from the mount data */
 	server->flags = ctx->flags;
@@ -1116,6 +1118,9 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 
 	server->fsid = fattr->fsid;
 
+	nfs_sysfs_link_rpc_client(server,
+		server->nfs_client->cl_rpcclient, "_state");
+
 	error = nfs_init_server_rpcclient(server,
 			source->client->cl_timeout,
 			flavor);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d3051b051a56..c7012f22a009 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -18,6 +18,7 @@
 #include "nfs4idmap.h"
 #include "pnfs.h"
 #include "netns.h"
+#include "sysfs.h"
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
@@ -947,6 +948,7 @@ static int nfs4_set_client(struct nfs_server *server,
 	set_bit(NFS_CS_CHECK_LEASE_TIME, &clp->cl_res_state);
 
 	server->nfs_client = clp;
+	nfs_sysfs_link_rpc_client(server, clp->cl_rpcclient, "_state");
 	return 0;
 }
 
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 9eb9fbbf606e..39bfcbcf916c 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -191,6 +191,26 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
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
index ca2373fc76cf..34e40f3a14cb 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -22,6 +22,8 @@ extern void nfs_sysfs_exit(void);
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
2.39.2

