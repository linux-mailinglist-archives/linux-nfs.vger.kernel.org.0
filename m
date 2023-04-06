Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5356D9938
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 16:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbjDFOLb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 10:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbjDFOLG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 10:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A80A265
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCVKK18gTbYyC+A6P0JOmylzlRzsVQIa4vWk63362qs=;
        b=VCClOdXAoMLYT+E6WauW8hC8cxvX6OYny9tfaDrFlqDQRvG5l3PkPXXEZwflLDhuNcNyFn
        nkEZBEm9wwlb75t79771jpW10XTtqgWkpFxBN+/bCfo8urczNuJh9pJmJMjboUfrJ+JwtN
        +MJnl/CoIUuh2/uH7uVlTwkM5ckLdwQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-MO9YrXf4P_2DbzmO0J9aSA-1; Thu, 06 Apr 2023 10:10:07 -0400
X-MC-Unique: MO9YrXf4P_2DbzmO0J9aSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E12D88B7B1;
        Thu,  6 Apr 2023 14:10:07 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.10.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5C282166B29;
        Thu,  6 Apr 2023 14:10:06 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@netapp.com, Olga.Kornievskaia@netapp.com
Subject: [PATCH 3/6] NFS: add superblock sysfs entries
Date:   Thu,  6 Apr 2023 10:10:01 -0400
Message-Id: <706fb7c1e5bfd869165a61a51663427104567c49.1680786859.git.bcodding@redhat.com>
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

Create a sysfs directory for each mount that corresponds to the mount's
nfs_server struct.  As the mount is being constructed, use the name
"server-n", but rename it to the "MAJOR:MINOR" of the mount after assigning
a device_id. The rename approach allows us to populate the mount's directory
with links to the various rpc_client objects during the mount's
construction.  The naming convention (MAJOR:MINOR) can be used to reference
a particular NFS mount's sysfs tree.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/client.c           | 15 +++++++++++
 fs/nfs/super.c            |  6 ++++-
 fs/nfs/sysfs.c            | 54 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/sysfs.h            |  5 ++++
 include/linux/nfs_fs_sb.h |  2 ++
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index f50e025ae406..72da715fc617 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -944,6 +944,8 @@ void nfs_server_remove_lists(struct nfs_server *server)
 }
 EXPORT_SYMBOL_GPL(nfs_server_remove_lists);
 
+static DEFINE_IDA(s_sysfs_ids);
+
 /*
  * Allocate and initialise a server record
  */
@@ -955,6 +957,13 @@ struct nfs_server *nfs_alloc_server(void)
 	if (!server)
 		return NULL;
 
+	server->s_sysfs_id = ida_simple_get(
+		&s_sysfs_ids, 0, 0, GFP_KERNEL);
+	if (server->s_sysfs_id < 0) {
+		kfree(server);
+		return NULL;
+	}
+
 	server->client = server->client_acl = ERR_PTR(-EINVAL);
 
 	/* Zero out the NFS state stuff */
@@ -979,6 +988,7 @@ struct nfs_server *nfs_alloc_server(void)
 	ida_init(&server->lockowner_id);
 	pnfs_init_server(server);
 	rpc_init_wait_queue(&server->uoc_rpcwaitq, "NFS UOC");
+	nfs_sysfs_add_server(server);
 
 	return server;
 }
@@ -1001,6 +1011,10 @@ void nfs_free_server(struct nfs_server *server)
 
 	nfs_put_client(server->nfs_client);
 
+	nfs_sysfs_remove_server(server);
+	kobject_put(&server->kobj);
+	ida_simple_remove(&s_sysfs_ids, server->s_sysfs_id);
+
 	ida_destroy(&server->lockowner_id);
 	ida_destroy(&server->openowner_id);
 	nfs_free_iostats(server->io_stats);
@@ -1385,6 +1399,7 @@ int __init nfs_fs_proc_init(void)
 void nfs_fs_proc_exit(void)
 {
 	remove_proc_subtree("fs/nfsfs", NULL);
+	ida_destroy(&s_sysfs_ids);
 }
 
 #endif /* CONFIG_PROC_FS */
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
index a496e26fcfb7..9eb9fbbf606e 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -190,3 +190,57 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 		netns->nfs_client = NULL;
 	}
 }
+
+static void nfs_sysfs_sb_release(struct kobject *kobj)
+{
+	/* no-op: why? see lib/kobject.c kobject_cleanup() */
+}
+
+static struct attribute *nfs_mp_attrs[] = {
+        NULL,
+};
+
+ATTRIBUTE_GROUPS(nfs_mp);
+
+static struct kobj_type nfs_sb_ktype = {
+	.release = nfs_sysfs_sb_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = nfs_mp_groups,
+};
+
+void nfs_sysfs_add_server(struct nfs_server *server)
+{
+	int ret;
+	ret = kobject_init_and_add(&server->kobj, &nfs_sb_ktype,
+				&nfs_kset->kobj, "server-%d", server->s_sysfs_id);
+}
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
index 5501ef573c32..ca2373fc76cf 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -22,4 +22,9 @@ extern void nfs_sysfs_exit(void);
 void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net);
 void nfs_netns_sysfs_destroy(struct nfs_net *netns);
 
+void nfs_sysfs_add_server(struct nfs_server *s);
+void nfs_sysfs_move_server_to_sb(struct super_block *s);
+void nfs_sysfs_move_sb_to_server(struct nfs_server *s);
+void nfs_sysfs_remove_server(struct nfs_server *s);
+
 #endif
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ea2f7e6b1b0b..dee1664abca8 100644
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
+	struct kobject	kobj;
 };
 
 /* Server capabilities */
-- 
2.39.2

