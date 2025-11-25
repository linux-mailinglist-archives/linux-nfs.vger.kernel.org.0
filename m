Return-Path: <linux-nfs+bounces-16707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20963C82EA7
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 01:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A7BF348643
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 00:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05FA17A2E8;
	Tue, 25 Nov 2025 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9ZAtVXP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13818EFD1
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764029753; cv=none; b=ZukRUg+HhJOtgPSh8a7gwQjnpPMq/lmudkWGHThWgBbFPmykjCSIEL7EkD18674GHWbExKwn2Rw+Jyo72JDFXN+FxR9vqFgxbiqEa3NcH31LFe49WW4vswc7VWc4t/nAZM/daILdCh7a8mCxaMvFKiRbEZvu1w0SxSv5dmxpRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764029753; c=relaxed/simple;
	bh=1KYMfjoGNbFP2tZXhq2+6/8PLkGd1xd6VCY0p+uWX/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONXlxflJJXc2j/LkqohDnhOObWVUyIEIjbI6Ar8yxtM3kVxkB5zURnlCSPtkQLPBIkW8/tDIoVrvxdD/pKki2cYYY3tVFqZvLX7OawG/RHptj8mEPmFGbtmmrpVQ5fQOQpAdxlgEmKa/lFaxyXj2D2QYcLqtW23D3XCr/UhZig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9ZAtVXP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764029750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzvK5geIwDJR6cEZc5soyNUgefYYIlNkSWn8uGawaqA=;
	b=K9ZAtVXPnO9gdBwWClxCjhaGpasI12YayXJNEKXL22N5DlTA0JL6jDmSbyH+9rdhKTfjJS
	HFaw3vAQFwjn64QR86z4CvwJQ+psoSOJg8XTqTCrmS2sgHEd621l6/EOqYRGsKw2Hoxl/f
	eMSW0Ee6hBf5v6ytpuTPXIW+xO6QvMc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-LdVvytxVOy-qocq7uGcxvw-1; Mon,
 24 Nov 2025 19:15:47 -0500
X-MC-Unique: LdVvytxVOy-qocq7uGcxvw-1
X-Mimecast-MFC-AGG-ID: LdVvytxVOy-qocq7uGcxvw_1764029746
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 377E41800451;
	Tue, 25 Nov 2025 00:15:46 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCF2C3003761;
	Tue, 25 Nov 2025 00:15:45 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 5BA8A50F7B7;
	Mon, 24 Nov 2025 19:15:44 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH RFC] NFS: Add some knobs for disabling delegations in sysfs
Date: Mon, 24 Nov 2025 19:15:44 -0500
Message-ID: <20251125001544.18584-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There's occasionally a need to disable delegations, whether it be due to
known bugs or simply to give support staff some breathing room to
troubleshoot issues.  Currently the only real method for disabling
delegations in Linux NFS is via /proc/sys/fs/leases-enable, which has
some major drawbacks in that 1) it's only applicable to knfsd, and 2) it
affects all clients using that server.

Technically it's not really possible to disable delegations from the
client side since it's ultimately up to the server whether grants a
delegation or not, but we can achieve a similar affect in NFSv4.1+ by
manipulating the OPEN4_SHARE_ACCESS_WANT* flags.

Rather than proliferating a bunch of new mount options, add some sysfs
knobs to allow some of the nfs_server->caps flags related to delegations
to be adjusted.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4proc.c         |  8 ++++++
 fs/nfs/sysfs.c            | 55 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 64 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 93c6ce04332b..42810260f7d8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1396,6 +1396,11 @@ nfs4_map_atomic_open_share(struct nfs_server *server,
 		res |= NFS4_SHARE_WANT_NO_DELEG;
 		goto out;
 	}
+	/* open delegation disabled in sysfs */
+	if (!(server->caps & NFS_CAP_DELEGATION)) {
+		res |= NFS4_SHARE_WANT_NO_DELEG;
+		goto out;
+	}
 	/* res |= NFS4_SHARE_WANT_NO_PREFERENCE; */
 	if (server->caps & NFS_CAP_DELEGTIME)
 		res |= NFS4_SHARE_WANT_DELEG_TIMESTAMPS;
@@ -10796,6 +10801,7 @@ static const struct nfs4_minor_version_ops nfs_v4_0_minor_ops = {
 	.minor_version = 0,
 	.init_caps = NFS_CAP_READDIRPLUS
 		| NFS_CAP_ATOMIC_OPEN
+		| NFS_CAP_DELEGATION
 		| NFS_CAP_POSIX_LOCK,
 	.init_client = nfs40_init_client,
 	.shutdown_client = nfs40_shutdown_client,
@@ -10822,6 +10828,7 @@ static const struct nfs4_minor_version_ops nfs_v4_1_minor_ops = {
 	.minor_version = 1,
 	.init_caps = NFS_CAP_READDIRPLUS
 		| NFS_CAP_ATOMIC_OPEN
+		| NFS_CAP_DELEGATION
 		| NFS_CAP_POSIX_LOCK
 		| NFS_CAP_STATEID_NFSV41
 		| NFS_CAP_ATOMIC_OPEN_V1
@@ -10848,6 +10855,7 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 	.minor_version = 2,
 	.init_caps = NFS_CAP_READDIRPLUS
 		| NFS_CAP_ATOMIC_OPEN
+		| NFS_CAP_DELEGATION
 		| NFS_CAP_POSIX_LOCK
 		| NFS_CAP_STATEID_NFSV41
 		| NFS_CAP_ATOMIC_OPEN_V1
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index ea6e6168092b..cce2b7f594d5 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -323,6 +323,43 @@ implid_name_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute nfs_sysfs_attr_implid_name = __ATTR_RO(implid_name);
 
+#define DEFINE_NFS_SYSFS_DELEG_KNOB(name, capname)			\
+	static ssize_t							\
+	name##_show(struct kobject *kobj, struct kobj_attribute *attr,	\
+					char *buf)			\
+	{								\
+		struct nfs_server *server = container_of(kobj, struct nfs_server, kobj); \
+		bool val = server->caps & NFS_CAP_##capname;		\
+									\
+		return sysfs_emit(buf, "%d\n", val);			\
+	}								\
+									\
+	static ssize_t							\
+	name##_store(struct kobject *kobj, struct kobj_attribute *attr,	\
+					const char *buf, size_t count)	\
+	{								\
+		struct nfs_server *server = container_of(kobj, struct nfs_server, kobj); \
+		bool val;						\
+		int ret;						\
+									\
+		ret = kstrtobool(buf, &val);				\
+		if (ret < 0)						\
+			return ret;					\
+									\
+		if (val == true)					\
+			server->caps |= NFS_CAP_##capname;		\
+		else							\
+			server->caps &= ~NFS_CAP_##capname;		\
+									\
+		return count;						\
+	}								\
+									\
+	static struct kobj_attribute nfs_sysfs_attr_##name = __ATTR_RW(name); \
+
+DEFINE_NFS_SYSFS_DELEG_KNOB(open_deleg, DELEGATION)
+DEFINE_NFS_SYSFS_DELEG_KNOB(open_xor_deleg, OPEN_XOR)
+DEFINE_NFS_SYSFS_DELEG_KNOB(timestamp_deleg, DELEGTIME)
+
 #endif /* IS_ENABLED(CONFIG_NFS_V4_1) */
 
 #define RPC_CLIENT_NAME_SIZE 64
@@ -381,6 +418,24 @@ static void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
 	if (ret < 0)
 		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
 			server->s_sysfs_id, ret);
+
+	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_open_deleg.attr,
+				   nfs_netns_server_namespace(&server->kobj));
+	if (ret < 0)
+		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+			server->s_sysfs_id, ret);
+
+	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_open_xor_deleg.attr,
+				   nfs_netns_server_namespace(&server->kobj));
+	if (ret < 0)
+		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+			server->s_sysfs_id, ret);
+
+	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_timestamp_deleg.attr,
+				   nfs_netns_server_namespace(&server->kobj));
+	if (ret < 0)
+		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+			server->s_sysfs_id, ret);
 }
 #else /* CONFIG_NFS_V4_1 */
 static inline void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d30c0245031c..dcbb4ce6b3fd 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -305,6 +305,7 @@ struct nfs_server {
 #define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
 #define NFS_CAP_OFFLOAD_STATUS	(1U << 9)
 #define NFS_CAP_ZERO_RANGE	(1U << 10)
+#define NFS_CAP_DELEGATION	(1U << 11)
 #define NFS_CAP_OPEN_XOR	(1U << 12)
 #define NFS_CAP_DELEGTIME	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
-- 
2.51.0


