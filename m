Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8E77D753B
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjJYUMG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJYUMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 16:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BB512A
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698264679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRsL7GAZRghA+X4i8qL6QPZDq0Hh5HWBJdoxM35TzEY=;
        b=c2pS/tnFr9mgLY/AhclTMBhSS3OVR5MEvcucLS7u5WvatmlWRC+sy5cxjxCmsx2PzP6LFN
        eavi6CBxILX1Yt17iL/uyiKl0hDj1IGK2YWXq0U7W3FqLRT0gm5MwANnUmRAjvADsAxiOA
        AfFm1d2U91I+bBNJYCjBDy4ztvy8HoQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-35OLDohNNeSNUo1W21LP3g-1; Wed,
 25 Oct 2023 16:11:18 -0400
X-MC-Unique: 35OLDohNNeSNUo1W21LP3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D793C40C06;
        Wed, 25 Oct 2023 20:11:17 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 529051C060AE;
        Wed, 25 Oct 2023 20:11:17 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Date:   Wed, 25 Oct 2023 16:11:15 -0400
Message-ID: <4d6149dcf950ae922e657a7c3c22268add2fb0f6.1698262608.git.bcodding@redhat.com>
In-Reply-To: <cover.1698262608.git.bcodding@redhat.com>
References: <cover.1698262608.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Expose a per-mount knob in sysfs to set the READDIR requested attributes
for a non-plus READDIR request.

For example:

  echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs

.. will revert the client to only request rdattr_error and
mounted_on_fileid for any non "plus" READDIR, as before the patch
preceeding this one in this series.  This provides existing installations
an option to fix a potential performance regression that may occur after
NFS clients update to request additional default READDIR attributes.

Hide the functionality behind CONFIG_NFS_EXPERT_SYSFS.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/Kconfig            |  7 +++
 fs/nfs/client.c           |  4 ++
 fs/nfs/nfs4client.c       |  4 ++
 fs/nfs/nfs4proc.c         |  1 +
 fs/nfs/nfs4xdr.c          |  7 ++-
 fs/nfs/sysfs.c            | 91 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  1 +
 include/linux/nfs_xdr.h   |  1 +
 8 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 7df2503cef6c..667b1531889c 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -212,3 +212,10 @@ config NFS_V4_2_READ_PLUS
 	default y
 	help
 	 Choose Y here to enable use of the NFS v4.2 READ_PLUS operation.
+
+config NFS_EXPERT_SYSFS
+	bool "NFS: Enable the support for expert tuning of nfs behaviors"
+	default n
+	help
+	  This option allows potentially dangerous modifications to the default
+	  behaviors of the NFS client via files within sysfs.
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 44eca51b2808..981a2437b752 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -922,6 +922,10 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
 	target->options = source->options;
 	target->auth_info = source->auth_info;
 	target->port = source->port;
+#if IS_ENABLED(CONFIG_NFS_V4)
+	memcpy(target->readdir_attrs, source->readdir_attrs,
+			sizeof(target->readdir_attrs));
+#endif
 }
 EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
 
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 11e3a285594c..3bbfb4244c14 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1115,6 +1115,10 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 
 	nfs4_server_set_init_caps(server);
 
+	/* Default (non-plus) v4 readdir attributes */
+	server->readdir_attrs[0] = FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR;
+	server->readdir_attrs[1] = FATTR4_WORD1_MOUNTED_ON_FILEID;
+
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
 	if (error < 0)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7016eaadf555..0f0028de7941 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5113,6 +5113,7 @@ static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
 		.pgbase = 0,
 		.count = nr_arg->page_len,
 		.plus = nr_arg->plus,
+		.server = server,
 	};
 	struct nfs4_readdir_res res;
 	struct rpc_message msg = {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 7200d6f7cd7b..45a9b40b801e 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1601,16 +1601,15 @@ static void encode_read(struct xdr_stream *xdr, const struct nfs_pgio_args *args
 
 static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
 {
-	uint32_t attrs[3] = {
-		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
-		FATTR4_WORD1_MOUNTED_ON_FILEID,
-	};
+	uint32_t attrs[3];
 	uint32_t dircount = readdir->count;
 	uint32_t maxcount = readdir->count;
 	__be32 *p, verf[2];
 	uint32_t attrlen = 0;
 	unsigned int i;
 
+	memcpy(attrs, readdir->server->readdir_attrs, sizeof(attrs));
+
 	if (readdir->plus) {
 		attrs[0] |= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
 			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index bf378ecd5d9f..80936e8b5b80 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -272,6 +272,87 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute nfs_sysfs_attr_shutdown = __ATTR_RW(shutdown);
 
+#if IS_ENABLED(CONFIG_NFS_V4)
+#ifdef CONFIG_NFS_EXPERT_SYSFS
+static ssize_t
+v4_readdir_attrs_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
+{
+	struct nfs_server *server;
+
+	server = container_of(kobj, struct nfs_server, kobj);
+
+	return sysfs_emit(buf, "0x%x 0x%x 0x%x\n",
+			server->readdir_attrs[0],
+			server->readdir_attrs[1],
+			server->readdir_attrs[2]);
+}
+
+static ssize_t
+v4_readdir_attrs_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct nfs_server *server;
+	u32 attrs[3];
+	char p[36], *v;
+	size_t token = 0;
+	int i;
+
+	if (count > 36)
+		return -EINVAL;
+
+	v = strncpy(p, buf, count);
+
+	for (i = 0; i < 3; i++) {
+		token += strcspn(v, " ") + 1;
+		if (token > 34)
+			return -EINVAL;
+
+		p[token - 1] = '\0';
+		if (kstrtoint(v, 0, &attrs[i]))
+			return -EINVAL;
+		v = &p[token];
+	}
+
+	/* Allow only what we decode - see decode_getfattr_attrs() */
+	if (attrs[0] & ~(FATTR4_WORD0_TYPE |
+			FATTR4_WORD0_CHANGE |
+			FATTR4_WORD0_SIZE |
+			FATTR4_WORD0_FSID |
+			FATTR4_WORD0_RDATTR_ERROR |
+			FATTR4_WORD0_FILEHANDLE |
+			FATTR4_WORD0_FILEID |
+			FATTR4_WORD0_FS_LOCATIONS) ||
+		attrs[1] & ~(FATTR4_WORD1_MODE |
+			FATTR4_WORD1_NUMLINKS |
+			FATTR4_WORD1_OWNER |
+			FATTR4_WORD1_OWNER_GROUP |
+			FATTR4_WORD1_RAWDEV |
+			FATTR4_WORD1_SPACE_USED |
+			FATTR4_WORD1_TIME_ACCESS |
+			FATTR4_WORD1_TIME_METADATA |
+			FATTR4_WORD1_TIME_MODIFY |
+			FATTR4_WORD1_MOUNTED_ON_FILEID) ||
+		attrs[2] & ~(FATTR4_WORD2_MDSTHRESHOLD |
+			FATTR4_WORD2_SECURITY_LABEL))
+		return -EINVAL;
+
+	server = container_of(kobj, struct nfs_server, kobj);
+
+	if (attrs[0])
+		server->readdir_attrs[0] = attrs[0];
+	if (attrs[1])
+		server->readdir_attrs[1] = attrs[1];
+	if (attrs[2])
+		server->readdir_attrs[2] = attrs[2];
+
+	return count;
+}
+
+static struct kobj_attribute nfs_sysfs_attr_v4_readdir_attrs = __ATTR_RW(v4_readdir_attrs);
+#endif /* CONFIG_NFS_EXPERT_SYSFS */
+#endif /* CONFIG_NFS_V4 */
+
 #define RPC_CLIENT_NAME_SIZE 64
 
 void nfs_sysfs_link_rpc_client(struct nfs_server *server,
@@ -325,6 +406,16 @@ void nfs_sysfs_add_server(struct nfs_server *server)
 	if (ret < 0)
 		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
 			server->s_sysfs_id, ret);
+
+#if IS_ENABLED(CONFIG_NFS_V4)
+#ifdef CONFIG_NFS_EXPERT_SYSFS
+	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_v4_readdir_attrs.attr,
+				nfs_netns_server_namespace(&server->kobj));
+	if (ret < 0)
+		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+			server->s_sysfs_id, ret);
+#endif /* CONFIG_NFS_EXPERT_SYSFS */
+#endif /* IS_ENABLED(CONFIG_NFS_V4) */
 }
 EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index cd628c4b011e..db87261b7cd7 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -219,6 +219,7 @@ struct nfs_server {
 						   of change attribute, size, ctime
 						   and mtime attributes supported by
 						   the server */
+	u32			readdir_attrs[3]; /* V4 tuneable default readdir attrs */
 	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
 						   that are supported on this
 						   filesystem */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 12bbb5c63664..e05d861b1788 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1142,6 +1142,7 @@ struct nfs4_readdir_arg {
 	struct page **			pages;	/* zero-copy data */
 	unsigned int			pgbase;	/* zero-copy data */
 	const u32 *			bitmask;
+	const struct nfs_server		*server;
 	bool				plus;
 };
 
-- 
2.41.0

