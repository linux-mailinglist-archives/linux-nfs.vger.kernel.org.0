Return-Path: <linux-nfs+bounces-9697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0801DA20019
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E8018857A9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B561DA4E;
	Mon, 27 Jan 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soNqyQNe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27B1C5F13
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014621; cv=none; b=KazUYR6lu2blkncaiCb25PcIZd/cM2pEADsCkLGpB27DF1VuFJ7n9MdRpJthTm8Q2Rv0JUcDq3NsOdYZMRERhvUeWEMWe5gALGTjlmKeHTzmSQus9Wc8OspYzOEbTBmm4VmpLUF6kMhwxAzQ4NktHu0+bqudnBhSwdSOMWDsqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014621; c=relaxed/simple;
	bh=V2zE9tB1Mo8K52AFDQE2/bkiWId9FRqyOcRK8qOur2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkJQMYQKFdLogmgY0/TNmBfXTl+8bJ3JZHdHzT0vCbC4FInhDEGudbomjy0FcIWFGtJ3l34obVS145qAlCxXzCR1dHg3c/E36veu0gDeK45T8xUw/Sih5iykj6bpOWSWy8Y67xDfRMavFPgYo9BlDCGWPvTc9ByfU+IZZanvbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soNqyQNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7CAC4CEE3;
	Mon, 27 Jan 2025 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014621;
	bh=V2zE9tB1Mo8K52AFDQE2/bkiWId9FRqyOcRK8qOur2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soNqyQNenW3eS8g6NfHcAOoLtgCiAcik9S4mIHt+fBbb83W+VUnjoUr7KV3s/qePB
	 yVdu9Z1zXjrQjrR7O9rlCEDdSOMz29/8RmBGIUbChXAAvYazWFn8oIZiImlgZ5UbQI
	 FO1PGJxBF2jbO1/fnZc4BrM61wDlN+Eo6MO7b9z1GI3oYF0Lc9YoO+yMx17nO9XBUb
	 CNXPbD17KdEsIMhdMd/8pOOvcxT3c5EO7jv6xUVT0v/GF6yJH81DTKO3rSl8/I6ptL
	 Z5eeADZA19kIrKfRASzEepxFuACyXKOfbyfM2p+CQAkcoCQwq5XzZ1UUVGNCTF7kWl
	 QYsNqfgNlaWZg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 1/5] NFS: Add implid to sysfs
Date: Mon, 27 Jan 2025 16:50:15 -0500
Message-ID: <20250127215019.352509-2-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127215019.352509-1-anna@kernel.org>
References: <20250127215019.352509-1-anna@kernel.org>
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
v2: * Removed accidentally included (but commented out) code block
    * Unconditionally display the files (with empty contents) for NFS v4.1,
      even if the server does not set these values.
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


