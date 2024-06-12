Return-Path: <linux-nfs+bounces-3662-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF314904958
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B501C23058
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8299B208C4;
	Wed, 12 Jun 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fas/BL0X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBF208C3
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161682; cv=none; b=bCesYYTgf5yh48hkkQgg6b2YJYK0zVsYsGqSVaP9WZCtodrSAmpYtD/gpdQDSI3wI8KElVHH4tBiX83WvJwQldJ9EmoVOabkmQKRG9LKTanse4u08YBtolL+B7YV1/b2CbkHS20VP5Fym81l3kOTkrZFVxcIS3qIpTAnTFuhcPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161682; c=relaxed/simple;
	bh=qcxjmZFr7jmx3IKKSxQJowkxvZBOusbeOa/+EykgoRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ph7eb7nYFaHoTtfMYSAbXUaMDkbc8evzo5NcLRzbYMTgdrjOMCarTKQ60xuvp+DJGDYoo/9Wcv+QhB0oWKEcMJLRFouX0QlPOIj4R3hXGQe6lDcyw1i9n3f6Gp/r6rqvSFjC8x8wfMJWOME+1vQIEfziBdxABBVmUER4/ysprSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fas/BL0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DB7C32786;
	Wed, 12 Jun 2024 03:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161682;
	bh=qcxjmZFr7jmx3IKKSxQJowkxvZBOusbeOa/+EykgoRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fas/BL0XaIeHcFPwwHuTD7AI6zUSu0A6PiGgd4fFOM3swapBbOXYhD1o7kNTaTL/M
	 XzZPfEKemGugJ33yDm1CQxAYa2yWDz5xi8snlENUM665g9pBcTgUh9dIpsnT9B0DI1
	 aUowjIldhk8zGn+TmfvHHL+zvvlPcJsxT1byR3tlG1+2+hKoN35nKcJOvfDsCVpHE2
	 SSUZIFJ9/xpipFiQnCCctkYM+Tq9uTE40PVwHnhbvNCtpVjkwa89UGPXguhGr9OZLN
	 9HaVKiqEWwqOiadlo9Js6MFE/pvEAtabJH7w2lum5v+YAfu3R2CZU7ROB7UxLNHXZ8
	 EB4fSdUK00j1g==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [RFC PATCH v2 06/15] nfs_common: add NFS LOCALIO protocol extension enablement
Date: Tue, 11 Jun 2024 23:07:43 -0400
Message-ID: <20240612030752.31754-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240612030752.31754-1-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First use is in nfsd, to add access to a global nfsd_uuids list that
will be used to identify local nfsd instances.

nfsd_uuids is protected by nfsd_mutex or RCU read lock.  List is
composed of nfsd_uuid_t instances that are managed as nfsd creates
them (per network namespace).

nfsd_uuid_is_local() will be used to search all local nfsd for the
client specified nfsd uuid.

Also, nfs and nfsd will only build their respective localio.c if
NFS_V{3,4}_LOCALIO and/or NFSD_V{3,4}_LOCALIO are enabled.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/Kconfig                 |  3 +++
 fs/nfs/Kconfig             | 25 +++++++++++++++++++++++
 fs/nfs_common/Makefile     |  3 +++
 fs/nfs_common/nfslocalio.c | 42 ++++++++++++++++++++++++++++++++++++++
 fs/nfsd/Kconfig            | 25 +++++++++++++++++++++++
 fs/nfsd/netns.h            |  4 ++++
 fs/nfsd/nfssvc.c           | 12 ++++++++++-
 include/linux/nfslocalio.h | 29 ++++++++++++++++++++++++++
 8 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 include/linux/nfslocalio.h

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..9864a738ccae 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
 	tristate
 	select FS_POSIX_ACL
 
+config NFS_LOCALIO_SUPPORT
+	tristate
+
 config NFS_COMMON
 	bool
 	depends on NFSD || NFS_FS || LOCKD
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 57249f040dfc..453ec4903086 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -5,6 +5,7 @@ config NFS_FS
 	select LOCKD
 	select SUNRPC
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
+	select NFS_LOCALIO_SUPPORT if NFS_V3_LOCALIO || NFS_V4_LOCALIO
 	help
 	  Choose Y here if you want to access files residing on other
 	  computers using Sun's Network File System protocol.  To compile
@@ -72,6 +73,18 @@ config NFS_V3_ACL
 
 	  If unsure, say N.
 
+config NFS_V3_LOCALIO
+	bool "NFS client support for the NFSv3 LOCALIO protocol extension"
+	depends on NFS_V3
+	help
+	  Some NFS servers support an auxiliary NFSv3 LOCALIO protocol
+	  that is not an official part of the NFS version 3 protocol.
+
+	  This option enables support for version 3 of the LOCALIO
+	  protocol in the kernel's NFS client.
+
+	  If unsure, say N.
+
 config NFS_V4
 	tristate "NFS client support for NFS version 4"
 	depends on NFS_FS
@@ -86,6 +99,18 @@ config NFS_V4
 
 	  If unsure, say Y.
 
+config NFS_V4_LOCALIO
+	bool "NFS client support for the NFSv4 LOCALIO protocol extension"
+	depends on NFS_V4
+	help
+	  Some NFS servers support an auxiliary NFSv4 LOCALIO protocol
+	  that is not an official part of the NFS version 4 protocol.
+
+	  This option enables support for version 4 of the LOCALIO
+	  protocol in the kernel's NFS client.
+
+	  If unsure, say N.
+
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
index 119c75ab9fd0..c566cca92a1b 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -6,5 +6,8 @@
 obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
 nfs_acl-objs := nfsacl.o
 
+obj-$(CONFIG_NFS_LOCALIO_SUPPORT) += nfs_localio.o
+nfs_localio-objs := nfslocalio.o
+
 obj-$(CONFIG_GRACE_PERIOD) += grace.o
 obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
new file mode 100644
index 000000000000..f214cc6754a1
--- /dev/null
+++ b/fs/nfs_common/nfslocalio.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+
+#include <linux/module.h>
+#include <linux/rculist.h>
+#include <linux/nfslocalio.h>
+
+MODULE_LICENSE("GPL");
+
+/*
+ * Global list of nfsd_uuid_t instances, add/remove
+ * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
+ * Reads are protected RCU read lock (see below).
+ */
+LIST_HEAD(nfsd_uuids);
+EXPORT_SYMBOL(nfsd_uuids);
+
+/* Must be called with RCU read lock held. */
+static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid)
+{
+	nfsd_uuid_t *nfsd_uuid;
+
+	list_for_each_entry_rcu(nfsd_uuid, &nfsd_uuids, list)
+		if (uuid_equal(&nfsd_uuid->uuid, uuid))
+			return &nfsd_uuid->uuid;
+
+	return &uuid_null;
+}
+
+bool nfsd_uuid_is_local(const uuid_t *uuid)
+{
+	const uuid_t *nfsd_uuid;
+
+	rcu_read_lock();
+	nfsd_uuid = nfsd_uuid_lookup(uuid);
+	rcu_read_unlock();
+
+	return !uuid_is_null(nfsd_uuid);
+}
+EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 272ab8d5c4d7..34d540324dfa 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -9,6 +9,7 @@ config NFSD
 	select EXPORTFS
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
 	select NFS_ACL_SUPPORT if NFSD_V3_ACL
+	select NFS_LOCALIO_SUPPORT if NFSD_V3_LOCALIO || NFSD_V4_LOCALIO
 	depends on MULTIUSER
 	help
 	  Choose Y here if you want to allow other computers to access
@@ -69,6 +70,18 @@ config NFSD_V3_ACL
 
 	  If unsure, say N.
 
+config NFSD_V3_LOCALIO
+	bool "NFS server support for the NFSv3 LOCALIO protocol extension"
+	depends on NFSD
+	help
+	  Some NFS servers support an auxiliary NFSv3 LOCALIO protocol
+	  that is not an official part of the NFS version 3 protocol.
+
+	  This option enables support for version 3 of the LOCALIO
+	  protocol in the kernel's NFS server.
+
+	  If unsure, say N.
+
 config NFSD_V4
 	bool "NFS server support for NFS version 4"
 	depends on NFSD && PROC_FS
@@ -89,6 +102,18 @@ config NFSD_V4
 
 	  If unsure, say N.
 
+config NFSD_V4_LOCALIO
+	bool "NFS server support for the NFSv4 LOCALIO protocol extension"
+	depends on NFSD_V4
+	help
+	  Some NFS servers support an auxiliary NFSv4 LOCALIO protocol
+	  that is not an official part of the NFS version 4 protocol.
+
+	  This option enables support for version 4 of the LOCALIO
+	  protocol in the kernel's NFS server.
+
+	  If unsure, say N.
+
 config NFSD_PNFS
 	bool
 
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 14ec15656320..afeabe5c7613 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -15,6 +15,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
+#include <linux/nfslocalio.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -213,6 +214,9 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
 
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
+	nfsd_uuid_t		nfsd_uuid;
+#endif
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index cd9a6a1a9fc8..e67eb34a836b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/bind.h>
 #include <linux/nfsacl.h>
+#include <linux/nfslocalio.h>
 #include <linux/seq_file.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
@@ -427,6 +428,10 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_init_umount_work(nn);
+#endif
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
+	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
+	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
 #endif
 	nn->nfsd_net_up = true;
 	return 0;
@@ -456,6 +461,9 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
+	list_del_rcu(&nn->nfsd_uuid.list);
+#endif
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
 }
@@ -787,7 +795,9 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 
 	strscpy(nn->nfsd_name, scope ? scope : utsname()->nodename,
 		sizeof(nn->nfsd_name));
-
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
+	uuid_gen(&nn->nfsd_uuid.uuid);
+#endif
 	error = nfsd_create_serv(net);
 	if (error)
 		goto out;
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
new file mode 100644
index 000000000000..d0bbacd0adcf
--- /dev/null
+++ b/include/linux/nfslocalio.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+#ifndef __LINUX_NFSLOCALIO_H
+#define __LINUX_NFSLOCALIO_H
+
+#include <linux/list.h>
+#include <linux/uuid.h>
+
+/*
+ * Global list of nfsd_uuid_t instances, add/remove
+ * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
+ */
+extern struct list_head nfsd_uuids;
+
+/*
+ * Each nfsd instance has an nfsd_uuid_t that is accessible through the
+ * global nfsd_uuids list. Useful to allow a client to negotiate if localio
+ * possible with its server.
+ */
+typedef struct {
+	uuid_t uuid;
+	struct list_head list;
+} nfsd_uuid_t;
+
+bool nfsd_uuid_is_local(const uuid_t *uuid);
+
+#endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


