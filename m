Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3EC78F00C
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHaPQU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbjHaPQT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 11:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530BEE4A
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693494930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EoXT+mr4Z76PG/x3KLYTNQwvcKzpGMnVtIli0LWIb1E=;
        b=PjEeuqCj7CpGNYUopRb11KX6Ai+uUr61jT1vAaVaBGBVeV7QfD1WfloFGxf2oIhHeq/SZV
        r8mWuoYxRl1WwGgO478wJr4J1u+U33vp4kNuFIAs8OND8QmIGw7sg0Am/ucSt6+7XUcLrw
        te/dTlfLnnsslB7ltyQTmqybKX3q+Ec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-VUYvvTiSNbq_VHeR5xZiEQ-1; Thu, 31 Aug 2023 11:15:20 -0400
X-MC-Unique: VUYvvTiSNbq_VHeR5xZiEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED1C53C0FCAB
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 15:15:19 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAD7EC15BB8
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 15:15:19 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH] NFSv4: add sysctl for setting READDIR attrs
Date:   Thu, 31 Aug 2023 11:15:19 -0400
Message-Id: <8f752f70daf73016e20c49508f825e8c2c94f5e7.1693494824.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Expose a knob in sysfs to set the READDIR requested attributes for a
non-plus READDIR request.  This allows installations another option for
tuning READDIR on v4.  Further work is needed to detect whether enough
attributes are being returned to also prime the dcache.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/client.c           |  2 ++
 fs/nfs/nfs4client.c       |  3 ++
 fs/nfs/nfs4proc.c         |  1 +
 fs/nfs/nfs4xdr.c          |  7 ++---
 fs/nfs/sysfs.c            | 58 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  1 +
 include/linux/nfs_xdr.h   |  1 +
 7 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index e4c5f193ed5e..cf23a7c54bf1 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -920,6 +920,8 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
 	target->options = source->options;
 	target->auth_info = source->auth_info;
 	target->port = source->port;
+	memcpy(target->readdir_attrs, source->readdir_attrs,
+			sizeof(target->readdir_attrs));
 }
 EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
 
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d9114a754db7..ba1dffdd25eb 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1108,6 +1108,9 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 
 	nfs4_server_set_init_caps(server);
 
+	server->readdir_attrs[0] = FATTR4_WORD0_RDATTR_ERROR;
+	server->readdir_attrs[1] = FATTR4_WORD1_MOUNTED_ON_FILEID;
+
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
 	if (error < 0)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 832fa226b8f2..12cc9e972f36 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5109,6 +5109,7 @@ static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
 		.pgbase = 0,
 		.count = nr_arg->page_len,
 		.plus = nr_arg->plus,
+		.server = server,
 	};
 	struct nfs4_readdir_res res;
 	struct rpc_message msg = {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afe..1825e3eeb34b 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1601,16 +1601,15 @@ static void encode_read(struct xdr_stream *xdr, const struct nfs_pgio_args *args
 
 static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
 {
-	uint32_t attrs[3] = {
-		FATTR4_WORD0_RDATTR_ERROR,
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
 		attrs[0] |= FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
 			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index bf378ecd5d9f..6bded395df18 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -270,7 +270,59 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
+static ssize_t
+v4_readdir_attrs_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
+{
+	struct nfs_server *server;
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
+	char p[24], *v;
+	size_t token = 0;
+	int i;
+
+	if (count > 24)
+		return -EINVAL;
+
+	v = strncpy(p, buf, count);
+
+	for (i = 0; i < 3; i++) {
+		token += strcspn(v, " ") + 1;
+		if (token > 22)
+			return -EINVAL;
+
+		p[token - 1] = '\0';
+		if (kstrtoint(v, 0, &attrs[i]))
+			return -EINVAL;
+		v = &p[token];
+	}
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
 static struct kobj_attribute nfs_sysfs_attr_shutdown = __ATTR_RW(shutdown);
+static struct kobj_attribute nfs_sysfs_attr_v4_readdir_attrs = __ATTR_RW(v4_readdir_attrs);
 
 #define RPC_CLIENT_NAME_SIZE 64
 
@@ -325,6 +377,12 @@ void nfs_sysfs_add_server(struct nfs_server *server)
 	if (ret < 0)
 		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
 			server->s_sysfs_id, ret);
+
+	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_v4_readdir_attrs.attr,
+				nfs_netns_server_namespace(&server->kobj));
+	if (ret < 0)
+		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+			server->s_sysfs_id, ret);
 }
 EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 20eeba8b009d..f37cc3fe140e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -218,6 +218,7 @@ struct nfs_server {
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
2.40.1

