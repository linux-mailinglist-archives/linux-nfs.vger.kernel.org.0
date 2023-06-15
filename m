Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C6B731FB0
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjFOSIZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFOSIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94252964
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NK4ZWcgGo1Enbrl+xBD/1eNiWRiHIXQEZjaeqNd1LE=;
        b=MmCPmNGmtMF3F21/QrImeokkgL2dpDM9OLnAm6WizrsD7gldc/lleVLRrfTBQ4M6xBXou6
        gEVVz6sc4VumWvtZaGwFlV/C4PpDvsaKZC4/ajDIEjfzbhcBD8EQGJR6BUxbDCgW+rb2Xw
        fqnl74OlKwqJxJucuYrwbACpLvsLY7E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-_nTdqpzLOBGCUOzAE6Tjbw-1; Thu, 15 Jun 2023 14:07:35 -0400
X-MC-Unique: _nTdqpzLOBGCUOzAE6Tjbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C3233C0D84B
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:35 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2E1B2166B26
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:34 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 05/11] NFS: add superblock sysfs entries
Date:   Thu, 15 Jun 2023 14:07:26 -0400
Message-Id: <095dda5e682c8367335b9fa448f2834b9435ee69.1686851158.git.bcodding@redhat.com>
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

Create a sysfs directory for each mount that corresponds to the mount's
nfs_server struct.  As the mount is being constructed, use the name
"server-n", but rename it to the "MAJOR:MINOR" of the mount after assigning
a device_id. The rename approach allows us to populate the mount's directory
with links to the various rpc_client objects during the mount's
construction.  The naming convention (MAJOR:MINOR) can be used to reference
a particular NFS mount's sysfs tree.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/client.c           | 16 +++++++++++
 fs/nfs/nfs4client.c       |  3 ++
 fs/nfs/super.c            |  6 +++-
 fs/nfs/sysfs.c            | 59 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/sysfs.h            |  5 ++++
 include/linux/nfs_fs_sb.h |  2 ++
 6 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index f50e025ae406..9aea938e4bf2 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -690,6 +690,7 @@ static int nfs_init_server(struct nfs_server *server,
 		return PTR_ERR(clp);
 
 	server->nfs_client = clp;
+	nfs_sysfs_add_server(server);
 
 	/* Initialise the client representation from the mount data */
 	server->flags = ctx->flags;
@@ -944,6 +945,8 @@ void nfs_server_remove_lists(struct nfs_server *server)
 }
 EXPORT_SYMBOL_GPL(nfs_server_remove_lists);
 
+static DEFINE_IDA(s_sysfs_ids);
+
 /*
  * Allocate and initialise a server record
  */
@@ -955,6 +958,12 @@ struct nfs_server *nfs_alloc_server(void)
 	if (!server)
 		return NULL;
 
+	server->s_sysfs_id = ida_alloc(&s_sysfs_ids, GFP_KERNEL);
+	if (server->s_sysfs_id < 0) {
+		kfree(server);
+		return NULL;
+	}
+
 	server->client = server->client_acl = ERR_PTR(-EINVAL);
 
 	/* Zero out the NFS state stuff */
@@ -1001,6 +1010,10 @@ void nfs_free_server(struct nfs_server *server)
 
 	nfs_put_client(server->nfs_client);
 
+	nfs_sysfs_remove_server(server);
+	kobject_put(&server->kobj);
+	ida_free(&s_sysfs_ids, server->s_sysfs_id);
+
 	ida_destroy(&server->lockowner_id);
 	ida_destroy(&server->openowner_id);
 	nfs_free_iostats(server->io_stats);
@@ -1102,6 +1115,8 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 
 	server->fsid = fattr->fsid;
 
+	nfs_sysfs_add_server(server);
+
 	error = nfs_init_server_rpcclient(server,
 			source->client->cl_timeout,
 			flavor);
@@ -1385,6 +1400,7 @@ int __init nfs_fs_proc_init(void)
 void nfs_fs_proc_exit(void)
 {
 	remove_proc_subtree("fs/nfsfs", NULL);
+	ida_destroy(&s_sysfs_ids);
 }
 
 #endif /* CONFIG_PROC_FS */
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d3051b051a56..41c75602ff76 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -18,6 +18,7 @@
 #include "nfs4idmap.h"
 #include "pnfs.h"
 #include "netns.h"
+#include "sysfs.h"
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
@@ -947,6 +948,8 @@ static int nfs4_set_client(struct nfs_server *server,
 	set_bit(NFS_CS_CHECK_LEASE_TIME, &clp->cl_res_state);
 
 	server->nfs_client = clp;
+	nfs_sysfs_add_server(server);
+
 	return 0;
 }
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 05ae23657527..40a866db7965 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -68,6 +68,8 @@
 #include "nfs4session.h"
 #include "pnfs.h"
 #include "nfs.h"
+#include "netns.h"
+#include "sysfs.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
@@ -1088,6 +1090,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 						 &sb->s_blocksize_bits);
 
 	nfs_super_set_maxbytes(sb, server->maxfilesize);
+	nfs_sysfs_move_server_to_sb(sb);
 	server->has_sec_mnt_opts = ctx->has_sec_mnt_opts;
 }
 
@@ -1333,13 +1336,14 @@ int nfs_get_tree_common(struct fs_context *fc)
 }
 
 /*
- * Destroy an NFS2/3 superblock
+ * Destroy an NFS superblock
  */
 void nfs_kill_super(struct super_block *s)
 {
 	struct nfs_server *server = NFS_SB(s);
 	dev_t dev = s->s_dev;
 
+	nfs_sysfs_move_sb_to_server(server);
 	generic_shutdown_super(s);
 
 	nfs_fscache_release_super_cookie(s);
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 90256a3a714e..0ff24f133a02 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -215,3 +215,62 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 		netns->nfs_client = NULL;
 	}
 }
+
+static void nfs_sysfs_sb_release(struct kobject *kobj)
+{
+	/* no-op: why? see lib/kobject.c kobject_cleanup() */
+}
+
+static const void *nfs_netns_server_namespace(const struct kobject *kobj)
+{
+	return container_of(kobj, struct nfs_server, kobj)->nfs_client->cl_net;
+}
+
+static struct kobj_type nfs_sb_ktype = {
+	.release = nfs_sysfs_sb_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.namespace = nfs_netns_server_namespace,
+	.child_ns_type = nfs_netns_object_child_ns_type,
+};
+
+void nfs_sysfs_add_server(struct nfs_server *server)
+{
+	int ret;
+
+	ret = kobject_init_and_add(&server->kobj, &nfs_sb_ktype,
+				&nfs_kset->kobj, "server-%d", server->s_sysfs_id);
+	if (ret < 0)
+		pr_warn("NFS: nfs sysfs add server-%d failed (%d)\n",
+					server->s_sysfs_id, ret);
+}
+EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
+
+void nfs_sysfs_move_server_to_sb(struct super_block *s)
+{
+	struct nfs_server *server = s->s_fs_info;
+	int ret;
+
+	ret = kobject_rename(&server->kobj, s->s_id);
+	if (ret < 0)
+		pr_warn("NFS: rename sysfs %s failed (%d)\n",
+					server->kobj.name, ret);
+}
+
+void nfs_sysfs_move_sb_to_server(struct nfs_server *server)
+{
+	const char *s;
+	int ret = -ENOMEM;
+
+	s = kasprintf(GFP_KERNEL, "server-%d", server->s_sysfs_id);
+	if (s)
+		ret = kobject_rename(&server->kobj, s);
+	if (ret < 0)
+		pr_warn("NFS: rename sysfs %s failed (%d)\n",
+					server->kobj.name, ret);
+}
+
+/* unlink, not dec-ref */
+void nfs_sysfs_remove_server(struct nfs_server *server)
+{
+	kobject_del(&server->kobj);
+}
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index dc4cc9809d1b..c9f5e3677eb5 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -23,4 +23,9 @@ extern void nfs_sysfs_exit(void);
 void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net);
 void nfs_netns_sysfs_destroy(struct nfs_net *netns);
 
+void nfs_sysfs_add_server(struct nfs_server *s);
+void nfs_sysfs_move_server_to_sb(struct super_block *s);
+void nfs_sysfs_move_sb_to_server(struct nfs_server *s);
+void nfs_sysfs_remove_server(struct nfs_server *s);
+
 #endif
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ea2f7e6b1b0b..9e71eb357e0b 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -183,6 +183,7 @@ struct nfs_server {
 				change_attr_type;/* Description of change attribute */
 
 	struct nfs_fsid		fsid;
+	int			s_sysfs_id;	/* sysfs dentry index */
 	__u64			maxfilesize;	/* maximum file size */
 	struct timespec64	time_delta;	/* smallest time granularity */
 	unsigned long		mount_time;	/* when this fs was mounted */
@@ -259,6 +260,7 @@ struct nfs_server {
 	/* User namespace info */
 	const struct cred	*cred;
 	bool			has_sec_mnt_opts;
+	struct kobject		kobj;
 };
 
 /* Server capabilities */
-- 
2.40.1

