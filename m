Return-Path: <linux-nfs+bounces-9946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB74A2CE5B
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D5D16959A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90B71A5B94;
	Fri,  7 Feb 2025 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbe1H5wW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853121B395F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960947; cv=none; b=kYNIxDEicFuopUFK4sDHw2E3VqHeRkQnwX3PTuIZ1hZAqbDUQUymY9Y3kHHKgdXsc4vwah0C6czTsZKGX3m56CYbnYkbyxUXELeXmGs9nh/l+6ICgUz8Bjer/KkMeV81YFdOn/FRSkFDAmQjVy0Djog2U6RnNmujSIrixXYNihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960947; c=relaxed/simple;
	bh=xPLqPxgnf8Tp5b0hbqy0R+X3KoAGozCXiMNc1COgRrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg6Wv/hncxLxgpBaIAIK6nOvyzg8HoTU6tRKUWoyQcs3zb36WhWQu5UfMEIQCBPTIm73V3cBUWUp2sjtGQKD1TDHIuvC7qzA+BrZAcxwr07988OtOkTjjE3MdImBmGuyMIMuHVC9cUAXMKepJX316jtnGvnWTFufqqiSvNWNrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbe1H5wW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD665C4CEE5;
	Fri,  7 Feb 2025 20:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738960947;
	bh=xPLqPxgnf8Tp5b0hbqy0R+X3KoAGozCXiMNc1COgRrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nbe1H5wWjVVdcMbNPuImcJWqY4+ccWn/H0FdJy+kWttPYK8cGGyfrgL2UEE3j6vuF
	 Ik91fwW399tvxOQa5mpvFVXKbEG9kJ372DcynieINPi08zIy+2Zxe5ca0naPIol+DH
	 kEH1DMtaK7oDl0Tth5Lpiv9yCGjpWCmgqT1d2N/AqXcHpyLRs7v7ACIPqdnWWkQNwR
	 0EniDmaYvuY2NWc05H7lzFS5JKiEoNHcKhVXZteCRgLb3m22YhTebRWGsMf7kvgC6x
	 bSq+74BE4XiBbzYepFkIAFVLiZAtVqxpiB0uKdaU6h+xSvV5JEfoEjcqoqeNbjgAl4
	 hWoSbQHaTe8jw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v3 1/5] NFS: Add implid to sysfs
Date: Fri,  7 Feb 2025 15:42:21 -0500
Message-ID: <20250207204225.594002-2-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207204225.594002-1-anna@kernel.org>
References: <20250207204225.594002-1-anna@kernel.org>
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

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/sysfs.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 7b59a40d40c0..b30401b2c939 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -272,6 +272,38 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute nfs_sysfs_attr_shutdown = __ATTR_RW(shutdown);
 
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+static ssize_t
+implid_domain_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
+{
+	struct nfs_server *server = container_of(kobj, struct nfs_server, kobj);
+	struct nfs41_impl_id *impl_id = server->nfs_client->cl_implid;
+
+	if (!impl_id || strlen(impl_id->domain) == 0)
+		return 0; //sysfs_emit(buf, "");
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
+
+	if (!impl_id || strlen(impl_id->name) == 0)
+		return 0; //sysfs_emit(buf, "");
+	return sysfs_emit(buf, "%s\n", impl_id->name);
+}
+
+static struct kobj_attribute nfs_sysfs_attr_implid_name = __ATTR_RO(implid_name);
+
+#endif /* IS_ENABLED(CONFIG_NFS_V4_1) */
+
 #define RPC_CLIENT_NAME_SIZE 64
 
 void nfs_sysfs_link_rpc_client(struct nfs_server *server,
@@ -309,6 +341,32 @@ static struct kobj_type nfs_sb_ktype = {
 	.child_ns_type = nfs_netns_object_child_ns_type,
 };
 
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+static void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
+{
+	int ret;
+
+	if (!server->nfs_client->cl_implid)
+		return;
+
+	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid_domain.attr,
+					   nfs_netns_server_namespace(&server->kobj));
+	if (ret < 0)
+		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+			server->s_sysfs_id, ret);
+
+	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_implid_name.attr,
+				   nfs_netns_server_namespace(&server->kobj));
+	if (ret < 0)
+		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+			server->s_sysfs_id, ret);
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
@@ -325,6 +383,8 @@ void nfs_sysfs_add_server(struct nfs_server *server)
 	if (ret < 0)
 		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
 			server->s_sysfs_id, ret);
+
+	nfs_sysfs_add_nfsv41_server(server);
 }
 EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
 
-- 
2.48.1


