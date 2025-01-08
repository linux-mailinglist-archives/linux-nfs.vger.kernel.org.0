Return-Path: <linux-nfs+bounces-8985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BB4A0673E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836EB1659BE
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C653920409E;
	Wed,  8 Jan 2025 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obw3nYns"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121718D626
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372195; cv=none; b=l/JR4AbwEunDd7fulBb0bMaKB3Xa/NkEKB64CEQPVaQ4X5kvAisxxxq8grikA24bT74Im558M7B4T/5iH6Ln+9nViSwxx4IFj3TPbSUaHt4CCwrHmOwLJU6l6hv/C56zD5MMkkISzNjhuccyN/7njHa+vNmLYNPlhbLVylrzY3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372195; c=relaxed/simple;
	bh=L1eoayPBshlg653c5PNqUwjEenOxg4wjaADCiBWmjBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1EvQW23c9kxVEgxYepozaU/jBdeN5MdqXyTUzcafikUuadKoV4W3mFw3Su+LQ0fkzzG9kUA58mLYNTP39Kn/Pz9FoPjV/xPyRSm7XQnvPTntb3A1jam445jFMP0qqJR6CIcXIr86gAxbkCAE64wOXWJU8Dby6VSF1HnKOwS6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obw3nYns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2649C4CEE1;
	Wed,  8 Jan 2025 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372194;
	bh=L1eoayPBshlg653c5PNqUwjEenOxg4wjaADCiBWmjBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Obw3nYnssGJmdUy98+hIqYk1Ew9zArn7IhMhn3KUtE8fz7ffsSfRyOzS9wS0HigpS
	 sqsyjwcourXXwC++BjBkgkoNdAyaUfLgykCqFkbLOafV7nI2Lsk3Qf30L1LhLcvyRZ
	 UGm2zqdsUIYyFfxwCsTUCtl/ypdLZOaCgKOeAICItcvj9eQjh5v6ezO6hZdEXo0aYl
	 XtwFnr893XSPBiy2RVMVyK/8dKD8PEr+Q4TacLDCHlCXKtjaV/rxx+gNzw9+oeOvdQ
	 R0i8K4ANIXCH91Am3colFmtgVXJi5rPtIjc3xp42he4pjKGT8WGN82jyePv+a8pSwU
	 E4H4nTvM2cLWA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 1/3] NFS: Add implid to sysfs
Date: Wed,  8 Jan 2025 16:36:30 -0500
Message-ID: <20250108213632.260498-2-anna@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108213632.260498-1-anna@kernel.org>
References: <20250108213632.260498-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

The Linux NFS server added support for returning this information during
an EXCHANGE_ID in Linux v6.13. This is something and admin might want to
query, so let's add it to sysfs.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/sysfs.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 7b59a40d40c0..6b82c92c45bf 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -272,6 +272,32 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute nfs_sysfs_attr_shutdown = __ATTR_RW(shutdown);
 
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+static ssize_t
+implid_domain_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
+{
+	struct nfs_server *server = container_of(kobj, struct nfs_server, kobj);
+	struct nfs41_impl_id *impl_id = server->nfs_client->cl_implid;
+	return sysfs_emit(buf, "%s\n", impl_id->domain);
+}
+
+static struct kobj_attribute nfs_sysfs_attr_implid_domain = __ATTR_RO(implid_domain);
+
+
+static ssize_t
+implid_name_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
+{
+	struct nfs_server *server = container_of(kobj, struct nfs_server, kobj);
+	struct nfs41_impl_id *impl_id = server->nfs_client->cl_implid;
+	return sysfs_emit(buf, "%s\n", impl_id->name);
+}
+
+static struct kobj_attribute nfs_sysfs_attr_implid_name = __ATTR_RO(implid_name);
+
+#endif /* IS_ENABLED(CONFIG_NFS_V4_1) */
+
 #define RPC_CLIENT_NAME_SIZE 64
 
 void nfs_sysfs_link_rpc_client(struct nfs_server *server,
@@ -309,6 +335,33 @@ static struct kobj_type nfs_sb_ktype = {
 	.child_ns_type = nfs_netns_object_child_ns_type,
 };
 
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+static void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
+{
+	struct nfs_client *clp = server->nfs_client;
+	int ret;
+
+	if (clp->cl_implid && strlen(clp->cl_implid->domain) > 0) {
+		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid_domain.attr,
+					   nfs_netns_server_namespace(&server->kobj));
+		if (ret < 0)
+			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+				server->s_sysfs_id, ret);
+
+		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid_name.attr,
+					   nfs_netns_server_namespace(&server->kobj));
+		if (ret < 0)
+			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+				server->s_sysfs_id, ret);
+
+	}
+}
+#else /* CONFIG_NFS_V4_1 */
+static inline void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
+{
+}
+#endif /* CONFIG_NFS_V4_1 */
+
 void nfs_sysfs_add_server(struct nfs_server *server)
 {
 	int ret;
@@ -325,6 +378,32 @@ void nfs_sysfs_add_server(struct nfs_server *server)
 	if (ret < 0)
 		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
 			server->s_sysfs_id, ret);
+
+	nfs_sysfs_add_nfsv41_server(server);
+
+/*	if (server->nfs_client->cl_serverowner) {
+		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_serverowner.attr,
+					nfs_netns_server_namespace(&server->kobj));
+		if (ret < 0)
+			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+				server->s_sysfs_id, ret);
+	}
+
+	if (server->nfs_client->cl_serverscope) {
+		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_serverscope.attr,
+					nfs_netns_server_namespace(&server->kobj));
+		if (ret < 0)
+			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+				server->s_sysfs_id, ret);
+	}
+
+	if (server->nfs_client->cl_implid) {
+		ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid.attr,
+					nfs_netns_server_namespace(&server->kobj));
+		if (ret < 0)
+			pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+				server->s_sysfs_id, ret);
+	}*/
 }
 EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
 
-- 
2.47.1


