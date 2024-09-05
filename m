Return-Path: <linux-nfs+bounces-6273-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5415096E2D3
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCBC1F22793
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87A18CC0A;
	Thu,  5 Sep 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5kz8R/R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687A18C354
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563432; cv=none; b=e6O6iS1InBrBeSoU3nV3cYU5URjxOr6eI30actefR4+7+uVEXNNEfQPtPlwXJZ467SaN2Qk87CkCCUg3M73g0JFGumRN5ACCjkjip/hVeW9qL7lQ44DiOZcO3R8l2Hky6flwnFNGJyXVL8YKrV5RdW8LLD2lLlq76BBB8L98SlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563432; c=relaxed/simple;
	bh=AZj0fZA4J5lPq/rnFVveLvPRfeKmjvEB5vxeylQ2Qgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj8ZWV2RjyxCWJhUiVn8tqk5IWBfcD++JZnxSLfcQVSm9UMwkYDLJxU98x1c/MCgFwf7OwZ8t94ouU4XHZcf2a7q0kzuAOEr2jNSqE1i9x8vuBMb0Ieu6fujagQsThaA/mQlEgxduu3BO8Viev+3pjGjPDuy9n07lnqa7zsM2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5kz8R/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0128C4CEC6;
	Thu,  5 Sep 2024 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563432;
	bh=AZj0fZA4J5lPq/rnFVveLvPRfeKmjvEB5vxeylQ2Qgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5kz8R/R4mAw137elKE3b3+PUal3fD6a/L0O73Q1KscSPqForTo5AzKH7a5vX5anx
	 7C6W5RDdtXF0lxMI/gE7xHS0rqMjLRoTopMWBO1xY/JadsXMrj5rL43NjJH8igoBD8
	 i1X8n9WHtf99fiGYAUsQ3lY1MvM6xtRlt5dezcInQEAfE+aa3pej3/YVjoR64DjrmO
	 tIz1bBiMm4ZcPBq/yHkWVs77AYbAYDYVwoaBiWfswBf/Gu8WWK0R92MuIB2q3DzBHZ
	 6wNalpw3VqtN5lZP37dMxsz4t/Th8+8ksosdmvEE/bwWkwVuCi5UJmp44DVpYA6g5P
	 I7o96gfOOnk6A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 14/26] nfs_common: add NFS LOCALIO auxiliary protocol enablement
Date: Thu,  5 Sep 2024 15:09:48 -0400
Message-ID: <20240905191011.41650-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS
client to generate a nonce (single-use UUID) and associated nfs_uuid_t
struct, register it with nfs_common for subsequent lookup and
verification by the NFS server and if matched the NFS server populates
members in the nfs_uuid_t struct.

nfs_common's nfs_uuids list is the basis for localio enablement, as
such it has members that point to nfsd memory for direct use by the
client (e.g. 'net' is the server's network namespace, through it the
client can access nn->nfsd_serv).

This commit also provides the base nfs_uuid_t interfaces to allow
proper net namespace refcounting for the LOCALIO use case.

CONFIG_NFS_LOCALIO controls the nfs_common, NFS server and NFS client
enablement for LOCALIO. If both NFS_FS=m and NFSD=m then
NFS_COMMON_LOCALIO_SUPPORT=m and nfs_localio.ko is built (and provides
nfs_common's LOCALIO support).

  # lsmod | grep nfs_localio
  nfs_localio            12288  2 nfsd,nfs
  sunrpc                745472  35 nfs_localio,nfsd,auth_rpcgss,lockd,nfsv3,nfs

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Co-developed-by: NeilBrown <neilb@suse.de>
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/Kconfig                 |  23 ++++++++
 fs/nfs_common/Makefile     |   3 +
 fs/nfs_common/nfslocalio.c | 116 +++++++++++++++++++++++++++++++++++++
 include/linux/nfslocalio.h |  36 ++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 include/linux/nfslocalio.h

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..24d4e4b419d1 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -382,6 +382,29 @@ config NFS_COMMON
 	depends on NFSD || NFS_FS || LOCKD
 	default y
 
+config NFS_COMMON_LOCALIO_SUPPORT
+	tristate
+	default n
+	default y if NFSD=y || NFS_FS=y
+	default m if NFSD=m && NFS_FS=m
+	select SUNRPC
+
+config NFS_LOCALIO
+	bool "NFS client and server support for LOCALIO auxiliary protocol"
+	depends on NFSD && NFS_FS
+	select NFS_COMMON_LOCALIO_SUPPORT
+	default n
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS server and client. Enable this to permit local
+	  NFS clients to bypass the network when issuing reads and
+	  writes to the local NFS server.
+
+	  If unsure, say N.
+
 config NFS_V4_2_SSC_HELPER
 	bool
 	default y if NFS_V4_2
diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
index e58b01bb8dda..a5e54809701e 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -6,6 +6,9 @@
 obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
 nfs_acl-objs := nfsacl.o
 
+obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) += nfs_localio.o
+nfs_localio-objs := nfslocalio.o
+
 obj-$(CONFIG_GRACE_PERIOD) += grace.o
 obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
 
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
new file mode 100644
index 000000000000..f0bff023bb5e
--- /dev/null
+++ b/fs/nfs_common/nfslocalio.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ * Copyright (C) 2024 NeilBrown <neilb@suse.de>
+ */
+
+#include <linux/module.h>
+#include <linux/rculist.h>
+#include <linux/nfslocalio.h>
+#include <net/netns/generic.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NFS localio protocol bypass support");
+
+static DEFINE_SPINLOCK(nfs_uuid_lock);
+
+/*
+ * Global list of nfs_uuid_t instances
+ * that is protected by nfs_uuid_lock.
+ */
+static LIST_HEAD(nfs_uuids);
+
+void nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
+{
+	nfs_uuid->net = NULL;
+	nfs_uuid->dom = NULL;
+	uuid_gen(&nfs_uuid->uuid);
+
+	spin_lock(&nfs_uuid_lock);
+	list_add_tail_rcu(&nfs_uuid->list, &nfs_uuids);
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_begin);
+
+void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net == NULL) {
+		spin_lock(&nfs_uuid_lock);
+		list_del_init(&nfs_uuid->list);
+		spin_unlock(&nfs_uuid_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_end);
+
+static nfs_uuid_t * nfs_uuid_lookup_locked(const uuid_t *uuid)
+{
+	nfs_uuid_t *nfs_uuid;
+
+	list_for_each_entry(nfs_uuid, &nfs_uuids, list)
+		if (uuid_equal(&nfs_uuid->uuid, uuid))
+			return nfs_uuid;
+
+	return NULL;
+}
+
+static struct module *nfsd_mod;
+
+void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
+		       struct net *net, struct auth_domain *dom,
+		       struct module *mod)
+{
+	nfs_uuid_t *nfs_uuid;
+
+	spin_lock(&nfs_uuid_lock);
+	nfs_uuid = nfs_uuid_lookup_locked(uuid);
+	if (nfs_uuid) {
+		kref_get(&dom->ref);
+		nfs_uuid->dom = dom;
+		/*
+		 * We don't hold a ref on the net, but instead put
+		 * ourselves on a list so the net pointer can be
+		 * invalidated.
+		 */
+		list_move(&nfs_uuid->list, list);
+		nfs_uuid->net = net;
+
+		__module_get(mod);
+		nfsd_mod = mod;
+	}
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
+
+static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net) {
+		module_put(nfsd_mod);
+		nfs_uuid->net = NULL;
+	}
+	if (nfs_uuid->dom) {
+		auth_domain_put(nfs_uuid->dom);
+		nfs_uuid->dom = NULL;
+	}
+	list_del_init(&nfs_uuid->list);
+}
+
+void nfs_uuid_invalidate_clients(struct list_head *list)
+{
+	nfs_uuid_t *nfs_uuid, *tmp;
+
+	spin_lock(&nfs_uuid_lock);
+	list_for_each_entry_safe(nfs_uuid, tmp, list, list)
+		nfs_uuid_put_locked(nfs_uuid);
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_clients);
+
+void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net) {
+		spin_lock(&nfs_uuid_lock);
+		nfs_uuid_put_locked(nfs_uuid);
+		spin_unlock(&nfs_uuid_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
new file mode 100644
index 000000000000..4165ff8390c1
--- /dev/null
+++ b/include/linux/nfslocalio.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ * Copyright (C) 2024 NeilBrown <neilb@suse.de>
+ */
+#ifndef __LINUX_NFSLOCALIO_H
+#define __LINUX_NFSLOCALIO_H
+
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/uuid.h>
+#include <linux/sunrpc/svcauth.h>
+#include <linux/nfs.h>
+#include <net/net_namespace.h>
+
+/*
+ * Useful to allow a client to negotiate if localio
+ * possible with its server.
+ *
+ * See Documentation/filesystems/nfs/localio.rst for more detail.
+ */
+typedef struct {
+	uuid_t uuid;
+	struct list_head list;
+	struct net *net; /* nfsd's network namespace */
+	struct auth_domain *dom; /* auth_domain for localio */
+} nfs_uuid_t;
+
+void nfs_uuid_begin(nfs_uuid_t *);
+void nfs_uuid_end(nfs_uuid_t *);
+void nfs_uuid_is_local(const uuid_t *, struct list_head *,
+		       struct net *, struct auth_domain *, struct module *);
+void nfs_uuid_invalidate_clients(struct list_head *list);
+void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
+
+#endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


