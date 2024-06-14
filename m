Return-Path: <linux-nfs+bounces-3805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21104908294
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 05:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12151F23B5F
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 03:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04A11465BA;
	Fri, 14 Jun 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN8mU6sf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADE3ECC
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336674; cv=none; b=dl/2i8lb91M/MOlwPP6NmfanLWu06nqn2g+DiUVfc3+N8Nznb7HLQv6g45EvmiOXvFoFwj2h8maLbO2lBFm/S50sUs826WJFcWPXN5UZ5l7tmOuTpiyEuc9f22/SrES8RS/SBdWm2HSvW9/mLfn3RYALgwOav2fzIT5ceUJ6U4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336674; c=relaxed/simple;
	bh=bLWfk615WSIQlyOeksE7TdY9GJ3Ea2xpc+Ohb9wZ9Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHGj1lTTof1nMJ3KAz14GXvU1cShjMHdB1CCoSMotG4pCSHHHgs/ChU7SHRRDW3poTK2isw03vlZzEU1V3v4QUMBVwpryXGfivNd+P1lXz6J54ed28vJHZyi5wCPRJKnl+j6HhcmVkU/1nypnnPKHOp24MFSIKydhiN8wKN945c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN8mU6sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597A7C2BBFC;
	Fri, 14 Jun 2024 03:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718336674;
	bh=bLWfk615WSIQlyOeksE7TdY9GJ3Ea2xpc+Ohb9wZ9Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iN8mU6sf20otFGRsGfX+g0YJgEQYtRRryzF0Yv9Wsl3paVdl6p4nFbuI9aRFTrXcu
	 USq18duU1j0i/HMJkD5m6U6UApCJBnRCNC7TTfCY2X4dSh8Yje9hYDv/cs8bWlcQpe
	 U3Qc4AmIp6egQ4Bw0Ca6QF9nu1vMrvOVdPpJfSnRcCgqlXw+6JPBuKfScsZMWZz01Z
	 lofM/pNuhDCkO5Wu8XUF19watYRuQqwjWZx6WYS/BgnWYn1+PfYidtq9q5sgeNLARg
	 GyMUkZjSF3KfyIzZdugRGapULBEDOuhUP3CgqeibcpXp0NxmJNqETpxMgeWrI7808w
	 UmsIYv5AARn6g==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v3 05/18] nfs_common: add NFS LOCALIO protocol extension enablement
Date: Thu, 13 Jun 2024 23:44:13 -0400
Message-ID: <20240614034426.31043-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240614034426.31043-1-snitzer@kernel.org>
References: <20240614034426.31043-1-snitzer@kernel.org>
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

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/Kconfig                 |  3 +++
 fs/nfs/Kconfig             | 30 +++++++++++++++++++++++++++
 fs/nfs_common/Makefile     |  3 +++
 fs/nfs_common/nfslocalio.c | 42 ++++++++++++++++++++++++++++++++++++++
 fs/nfsd/Kconfig            | 30 +++++++++++++++++++++++++++
 fs/nfsd/netns.h            |  4 ++++
 fs/nfsd/nfssvc.c           | 12 ++++++++++-
 include/linux/nfslocalio.h | 29 ++++++++++++++++++++++++++
 8 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 include/linux/nfslocalio.h

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..170083ff2a51 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
 	tristate
 	select FS_POSIX_ACL
 
+config NFS_COMMON_LOCALIO_SUPPORT
+	tristate
+
 config NFS_COMMON
 	bool
 	depends on NFSD || NFS_FS || LOCKD
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 57249f040dfc..70ff4f7a1a22 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -1,10 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config NFS_LOCALIO
+	tristate
+
 config NFS_FS
 	tristate "NFS client support"
 	depends on INET && FILE_LOCKING && MULTIUSER
 	select LOCKD
 	select SUNRPC
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
+	select NFS_LOCALIO if NFS_V3_LOCALIO || NFS_V4_LOCALIO
+	select NFS_COMMON_LOCALIO_SUPPORT if NFS_LOCALIO
 	help
 	  Choose Y here if you want to access files residing on other
 	  computers using Sun's Network File System protocol.  To compile
@@ -72,6 +78,18 @@ config NFS_V3_ACL
 
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
@@ -86,6 +104,18 @@ config NFS_V4
 
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
index 119c75ab9fd0..d81623b76aba 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -6,5 +6,8 @@
 obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
 nfs_acl-objs := nfsacl.o
 
+obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) += nfs_localio.o
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
index 272ab8d5c4d7..93ea29c28aad 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config NFSD_LOCALIO
+	tristate
+
 config NFSD
 	tristate "NFS server support"
 	depends on INET
@@ -9,6 +13,8 @@ config NFSD
 	select EXPORTFS
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
 	select NFS_ACL_SUPPORT if NFSD_V3_ACL
+	select NFSD_LOCALIO if NFSD_V3_LOCALIO || NFSD_V4_LOCALIO
+	select NFS_COMMON_LOCALIO_SUPPORT if NFSD_LOCALIO
 	depends on MULTIUSER
 	help
 	  Choose Y here if you want to allow other computers to access
@@ -69,6 +75,18 @@ config NFSD_V3_ACL
 
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
@@ -89,6 +107,18 @@ config NFSD_V4
 
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
index 14ec15656320..0c5a1d97e4ac 100644
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
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	nfsd_uuid_t		nfsd_uuid;
+#endif
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index cd9a6a1a9fc8..7383dc10611c 100644
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
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
+	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
 #endif
 	nn->nfsd_net_up = true;
 	return 0;
@@ -456,6 +461,9 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	list_del_rcu(&nn->nfsd_uuid.list);
+#endif
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
 }
@@ -787,7 +795,9 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 
 	strscpy(nn->nfsd_name, scope ? scope : utsname()->nodename,
 		sizeof(nn->nfsd_name));
-
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
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


