Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1486EB04C
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjDURJn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjDURJe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C809016
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682096898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ky7hEh8UFKmKbEdJezBP5vo8X4pt7JnwFNt3YjN+ZRU=;
        b=JcKr86lhAIket2JhRrgo1VyaZsfvMrRUEPwkZvC3XkHHwsjNaTBN21MoVKWNUrwvWY4yyf
        ezA2GSdd23+mvJMrq7Eb9/ydYKaHBCHg/WfSVQypC9FY94mzdlO24obEELUrupIs3VP7W6
        ujGhrBMGA4ES/duXLWM/tBlFlgxwHrU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-pbhK5B8_OBa4rfE3m-2tPw-1; Fri, 21 Apr 2023 13:08:16 -0400
X-MC-Unique: pbhK5B8_OBa4rfE3m-2tPw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E4BA3814585
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:16 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC07E492C13
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:15 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/9] NFS: Add sysfs links to sunrpc clients for nfs_clients
Date:   Fri, 21 Apr 2023 13:08:07 -0400
Message-Id: <3410afe4df8c49ba02cae07ef54048d896e99965.1682096307.git.bcodding@redhat.com>
In-Reply-To: <cover.1682096307.git.bcodding@redhat.com>
References: <cover.1682096307.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 534e2293a698..e1b5df7a3df5 100644
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
index 0fc80fb55b3e..51e0973f22d1 100644
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

