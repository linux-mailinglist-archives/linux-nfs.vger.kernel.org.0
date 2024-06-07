Return-Path: <linux-nfs+bounces-3606-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC8E900693
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1741C228FC
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E88197541;
	Fri,  7 Jun 2024 14:27:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B6197528
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770444; cv=none; b=NwLD60ozMjuK7MgdGckDQnUoG6om7j1bMk9sNwchoTIANKZ/p97AWKdoJX2NpK/PgwYoV+54rLpHDUh0sL9I20qRGRaS+N1iB4ZRTmi184nL5DHjyr2/N5GaxFPqe7IeIKBet9wniSnvpSLgiC/Oux23uFWobBsX9CsEXMh5uWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770444; c=relaxed/simple;
	bh=qjqeVZA6taspmRh8348vs1DZQuc77cnAdIp3Rru8JQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpnA5mXZuN7FgiAwSIeQuqmNdazURjx38jvWd9Rdkr9knsQGEYL7fe+nFc+JXZph7pCKam4i2ns2hn5CoDkU2NP3Qny7dOrG2WqT54p7MO8QIVFzW2WECFz7CQEswyYY2F8HaERNk9X+UOje/g6v79LrhhqjnfcIcM2fdkmWo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9b94951cfso1180761b6e.3
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770441; x=1718375241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkP4AfHFMoH4bZfdIMl3YslxDhcTTbYki1m8sCPuG3M=;
        b=FltD3w8/DcUThMsfF7Hy9aIqJbOQR3Dzy3omGZQ9a9A6bwbztM+UntB6dJmL6UheEh
         gSib67zzXc9jsaY0zJ+RGQZDco7039BfnNB0/6FcVBgTS6zoNVM525cuNhi3I4I8SELS
         E1e0W7olg71ityLqGUTRdtI1OUmYglA6f7W+U9tPsYkGjt9uysrDAPqZJklOWlBMW7uI
         B1M7/TJfJLw59/VU+dpvjh7y6aD5rui1xZNntgKFuxZPFrUF/xfPmoDHSR1QAM7sf/mw
         +vBS+eS9J2LDp+4fVso+KKeMlmIsdT7qbNxs3Baa1/F5CiyScuiCPZK2IACtXQpf5A7M
         4IFg==
X-Gm-Message-State: AOJu0YwBmuvqTtIH2O4zuDOsBqtlamVxZpsEf0DA6Wq+OOOCZf0ZlZMB
	SIo73s/GXkM1lcD6qTzqypqiByBI+0FHfi+95RZrbBhi+MG2UkItCR4kGwkeKUYxxf2SOcUXU51
	bFVA=
X-Google-Smtp-Source: AGHT+IGWHLTzmX33KwHj6qIBJ+xhIn1mFeZdd+cyvJCeyo3RudoupmPd2tFWgVyU3qn7ODDUOOEB2g==
X-Received: by 2002:a05:6808:1386:b0:3d2:1839:a5bb with SMTP id 5614622812f47-3d21839a793mr1024723b6e.24.1717770441264;
        Fri, 07 Jun 2024 07:27:21 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f626224sm17593356d6.6.2024.06.07.07.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:20 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 21/29] nfs_common: add NFS v3 LOCALIO protocol extension enablement
Date: Fri,  7 Jun 2024 10:26:38 -0400
Message-ID: <20240607142646.20924-22-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
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
NFS_V3_LOCALIO and/or NFSD_V3_LOCALIO are enabled.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/Kconfig                 |  3 +++
 fs/nfs/Kconfig             | 13 ++++++++++++
 fs/nfs/Makefile            |  3 ++-
 fs/nfs/internal.h          | 38 ++++++++++++++++++++++++++++++++++
 fs/nfs_common/Makefile     |  3 +++
 fs/nfs_common/nfslocalio.c | 42 ++++++++++++++++++++++++++++++++++++++
 fs/nfsd/Kconfig            | 13 ++++++++++++
 fs/nfsd/Makefile           |  3 ++-
 fs/nfsd/netns.h            |  4 ++++
 fs/nfsd/nfssvc.c           | 11 ++++++++++
 include/linux/nfslocalio.h | 29 ++++++++++++++++++++++++++
 11 files changed, 160 insertions(+), 2 deletions(-)
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
index 57249f040dfc..db8c9d6edcea 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -5,6 +5,7 @@ config NFS_FS
 	select LOCKD
 	select SUNRPC
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
+	select NFS_LOCALIO_SUPPORT if NFS_V3_LOCALIO
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
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index af64cf5ea420..7fed1ce375da 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -9,10 +9,11 @@ CFLAGS_nfstrace.o += -I$(src)
 nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
 			   io.o direct.o pagelist.o read.o symlink.o unlink.o \
 			   write.o namespace.o mount_clnt.o nfstrace.o \
-			   export.o sysfs.o fs_context.o localio.o
+			   export.o sysfs.o fs_context.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
+nfs-$(CONFIG_NFS_V3_LOCALIO) += localio.o
 
 obj-$(CONFIG_NFS_V2) += nfsv2.o
 nfsv2-y := nfs2super.o proc.o nfs2xdr.o
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6d75466ad356..9f81a94e798c 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -452,6 +452,7 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
+#if defined(CONFIG_NFS_V3_LOCALIO)
 /* localio.c */
 extern void nfs_local_init(void);
 extern void nfs_local_enable(struct nfs_client *);
@@ -471,6 +472,43 @@ extern int nfs_local_commit(struct nfs_client *, struct file *,
 			    const struct rpc_call_ops *, int);
 extern bool nfs_server_is_local(const struct nfs_client *clp);
 
+#else
+static inline void nfs_local_init(void) {}
+static inline void nfs_local_enable(struct nfs_client *clp) {}
+static inline void nfs_local_disable(struct nfs_client *clp) {}
+static inline void nfs_local_probe(struct nfs_client *clp) {}
+static inline struct file *nfs_local_open_fh(struct nfs_client *clp,
+					const struct cred *cred,
+					struct nfs_fh *fh,
+					const fmode_t mode)
+{
+	return ERR_PTR(-EINVAL);
+}
+static inline struct file *nfs_local_file_open(struct nfs_client *clp,
+					const struct cred *cred,
+					struct nfs_fh *fh,
+					struct nfs_open_context *ctx)
+{
+	return NULL;
+}
+static inline int nfs_local_doio(struct nfs_client *clp, struct file *filep,
+				struct nfs_pgio_header *hdr,
+				const struct rpc_call_ops *call_ops)
+{
+	return -EINVAL;
+}
+static inline int nfs_local_commit(struct nfs_client *clp, struct file *filep,
+				struct nfs_commit_data *data,
+				const struct rpc_call_ops *call_ops, int how)
+{
+	return -EINVAL;
+}
+static inline bool nfs_server_is_local(const struct nfs_client *clp)
+{
+	return false;
+}
+#endif /* CONFIG_NFS_V3_LOCALIO */
+
 /* super.c */
 extern const struct super_operations nfs_sops;
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
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
index 272ab8d5c4d7..c8eb7e2d4006 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -9,6 +9,7 @@ config NFSD
 	select EXPORTFS
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
 	select NFS_ACL_SUPPORT if NFSD_V3_ACL
+	select NFS_LOCALIO_SUPPORT if NFSD_V3_LOCALIO
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
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 702f277394f1..0e01749f6153 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -13,7 +13,7 @@ nfsd-y			+= trace.o
 nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
 			   export.o auth.o lockd.o nfscache.o \
 			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
-			   netlink.o localio.o
+			   netlink.o
 nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
@@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
 nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
+nfsd-$(CONFIG_NFSD_V3_LOCALIO) += localio.o
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 14ec15656320..5c5f7030ad87 100644
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
 
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+	nfsd_uuid_t		nfsd_uuid;
+#endif
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index cd9a6a1a9fc8..122cfa184805 100644
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
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
+	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
 #endif
 	nn->nfsd_net_up = true;
 	return 0;
@@ -457,6 +462,9 @@ static void nfsd_shutdown_net(struct net *net)
 		nn->lockd_up = false;
 	}
 	nn->nfsd_net_up = false;
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+	list_del_rcu(&nn->nfsd_uuid.list);
+#endif
 	nfsd_shutdown_generic();
 }
 
@@ -787,6 +795,9 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 
 	strscpy(nn->nfsd_name, scope ? scope : utsname()->nodename,
 		sizeof(nn->nfsd_name));
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+	uuid_gen(&nn->nfsd_uuid.uuid);
+#endif
 
 	error = nfsd_create_serv(net);
 	if (error)
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


