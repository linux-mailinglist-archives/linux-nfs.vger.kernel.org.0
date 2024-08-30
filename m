Return-Path: <linux-nfs+bounces-6028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4982965553
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 04:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97E61C2265F
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B6380;
	Fri, 30 Aug 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XrJOieYh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qC9PbZEn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tXwxxVZP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ImsHkmer"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DB4D8CB
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985590; cv=none; b=IeGESK8T2jlv1O39Uzn5yjwvdmcfR5KC1tGvMza3yYVzvveHTNk5S+Yt5fkgClqugIMOkWwqpb/OPKYJfdwyS/4VZAj6fQzrvZVFEovfulwVwxnakuUy2nmb1fL1kSYrkT2GRAaSCpaMgLQpVNDyObNqQh5+MM86bBMfnF9gfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985590; c=relaxed/simple;
	bh=SGLwXmyoT5fLeADz5D68SnvTvv76eJZycgQy8QOmdJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRLVAIIpny4bnaBLOOu1U3ZcI01lxXVd3IUwgX07vdo/KgimksMhqFMcCPBk7heIsN0MY7yMs7Xg6ui3DDEY81qd2uSurvo6irZysT8hTVowNewIalbJ2w/tXbA24RwgyHJna6SDYoJe4mPa+dZyOJsTn4+bGKTC6sdfBeGNCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XrJOieYh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qC9PbZEn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tXwxxVZP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ImsHkmer; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D060E219F0;
	Fri, 30 Aug 2024 02:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BX3zZToWvuqnb8wskXEPFC6DLHM6WkTYTLIaR7BQGA0=;
	b=XrJOieYhhk/J2dpmRknPsKP9f+Kr6YlYAqDQG8GR8kHGClZHr0kWV6jz8VcZBRh2bwmU/s
	oRpTjIpjf9AHP2yns802POI0ijjM8YMBvrXPRX6bczf6/uuQzvq1np7lyknKJz4oWZA7z9
	JLRcXqO4Cnv7lLCPHWclL+RL5fLBZpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BX3zZToWvuqnb8wskXEPFC6DLHM6WkTYTLIaR7BQGA0=;
	b=qC9PbZEngKRuGvnF4IWKzbcHlysfxTraIwQxkmNP+DhT42koJBkldzSgg3LQ/Ql9a2qCzR
	i8+j52Jx1K8HhNCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BX3zZToWvuqnb8wskXEPFC6DLHM6WkTYTLIaR7BQGA0=;
	b=tXwxxVZPGKWlYSUH740Xd1A9znSmCNZTG53T8qqnIe6GW5eJ8dyjO3VgT4j2L5n8aqY1y9
	UWtrpxhRs2PyoFYscjf5U3dFwf1VfhJnANm/pNsUMCimiXb5VCXs3/W2WXcSJn8VNphjiv
	PCBHaWE7n6iLKB6Za64QoF9ozgMRujA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BX3zZToWvuqnb8wskXEPFC6DLHM6WkTYTLIaR7BQGA0=;
	b=ImsHkmernnQLV8i+h2PlDdg8adn9SpG37f1hZfumphGAKHzRT5eo1U47/hI5Khlb/x7CxL
	8YCB4FwVEcNXL5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B0EE136A4;
	Fri, 30 Aug 2024 02:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OGCYLO8w0WYAGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 02:39:43 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 19/25] nfs: add localio support
Date: Fri, 30 Aug 2024 12:20:32 +1000
Message-ID: <20240830023531.29421-20-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240830023531.29421-1-neilb@suse.de>
References: <20240830023531.29421-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

From: Weston Andros Adamson <dros@primarydata.com>

Add client support for bypassing NFS for localhost reads, writes, and
commits. This is only useful when the client and the server are
running on the same host.

nfs_local_probe() is stubbed out, later commits will enable client and
server handshake via a Linux-only LOCALIO auxiliary RPC protocol.

This has dynamic binding with the nfsd module (via nfs_localio module
which is part of nfs_common). Localio will only work if nfsd is
already loaded.

The "localio_enabled" nfs kernel module parameter can be used to
disable and enable the ability to use localio support.

CONFIG_NFS_LOCALIO controls the client enablement.

Lastly, localio uses an nfsd_file to initiate all IO.  To make proper
use of nfsd_file (and nfsd's filecache) its lifetime (duration before
nfsd_file_put is called) must extend until after commit, read and
write operations.  So rather than immediately call nfsd_file_put() in
nfs_local_open_fh(), nfsd_file_put() isn't called until
nfs_local_pgio_release() for read/write and not until
nfs_local_release_commit_data() for commit. The same applies to the
reference held on nfsd's nn->nfsd_serv. Both object lifetimes and
associated references are managed through calls to
nfs_localio_ctx_free().

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/Kconfig            |  16 +
 fs/nfs/Makefile           |   1 +
 fs/nfs/client.c           |  10 +
 fs/nfs/internal.h         |  45 +++
 fs/nfs/localio.c          | 605 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfstrace.h         |  61 ++++
 fs/nfs/pagelist.c         |   4 +
 fs/nfs/write.c            |   3 +
 include/linux/nfs.h       |   2 +
 include/linux/nfs_fs_sb.h |   9 +
 10 files changed, 756 insertions(+)
 create mode 100644 fs/nfs/localio.c

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 0eb20012792f..9fe3b2709666 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -87,6 +87,22 @@ config NFS_V4
 
 	  If unsure, say Y.
 
+config NFS_LOCALIO
+	bool "NFS client support for the LOCALIO auxiliary protocol"
+	depends on NFS_FS
+	select NFS_COMMON_LOCALIO_SUPPORT
+	default n
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS client.  Enable this to permit local NFS clients
+	  to bypass the network when issuing reads and writes to the
+	  local NFS server.
+
+	  If unsure, say N.
+
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 5f6db37f461e..9fb2f2cac87e 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -13,6 +13,7 @@ nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
+nfs-$(CONFIG_NFS_LOCALIO) += localio.o
 
 obj-$(CONFIG_NFS_V2) += nfsv2.o
 nfsv2-y := nfs2super.o proc.o nfs2xdr.o
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 8286edd6062d..a890319d4fab 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -178,6 +178,13 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
 	clp->cl_net = get_net(cl_init->net);
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	seqlock_init(&clp->cl_boot_lock);
+	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
+	clp->cl_uuid.net = NULL;
+	spin_lock_init(&clp->cl_localio_lock);
+#endif /* CONFIG_NFS_LOCALIO */
+
 	clp->cl_principal = "*";
 	clp->cl_xprtsec = cl_init->xprtsec;
 	return clp;
@@ -233,6 +240,8 @@ static void pnfs_init_server(struct nfs_server *server)
  */
 void nfs_free_client(struct nfs_client *clp)
 {
+	nfs_local_disable(clp);
+
 	/* -EIO all pending I/O */
 	if (!IS_ERR(clp->cl_rpcclient))
 		rpc_shutdown_client(clp->cl_rpcclient);
@@ -424,6 +433,7 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 			list_add_tail(&new->cl_share_link,
 					&nn->nfs_client_list);
 			spin_unlock(&nn->nfs_client_lock);
+			nfs_local_probe(new);
 			return rpc_ops->init_client(new, cl_init);
 		}
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index d4ab74a61668..0716c90eaf9c 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -451,6 +451,51 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+/* localio.c */
+extern void nfs_local_disable(struct nfs_client *);
+extern void nfs_local_probe(struct nfs_client *);
+extern struct nfs_localio_ctx *nfs_local_open_fh(struct nfs_client *,
+						 const struct cred *,
+						 struct nfs_fh *,
+						 const fmode_t);
+extern int nfs_local_doio(struct nfs_client *,
+			  struct nfs_localio_ctx *,
+			  struct nfs_pgio_header *,
+			  const struct rpc_call_ops *);
+extern int nfs_local_commit(struct nfs_localio_ctx *,
+			    struct nfs_commit_data *,
+			    const struct rpc_call_ops *, int);
+extern bool nfs_server_is_local(const struct nfs_client *clp);
+
+#else
+static inline void nfs_local_disable(struct nfs_client *clp) {}
+static inline void nfs_local_probe(struct nfs_client *clp) {}
+static inline struct nfs_localio_ctx *
+nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		  struct nfs_fh *fh, const fmode_t mode)
+{
+	return NULL;
+}
+static inline int nfs_local_doio(struct nfs_client *clp,
+				 struct nfs_localio_ctx *localio,
+				 struct nfs_pgio_header *hdr,
+				 const struct rpc_call_ops *call_ops)
+{
+	return -EINVAL;
+}
+static inline int nfs_local_commit(struct nfs_localio_ctx *localio,
+				struct nfs_commit_data *data,
+				const struct rpc_call_ops *call_ops, int how)
+{
+	return -EINVAL;
+}
+static inline bool nfs_server_is_local(const struct nfs_client *clp)
+{
+	return false;
+}
+#endif /* CONFIG_NFS_LOCALIO */
+
 /* super.c */
 extern const struct super_operations nfs_sops;
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
new file mode 100644
index 000000000000..f391badfb999
--- /dev/null
+++ b/fs/nfs/localio.c
@@ -0,0 +1,605 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NFS client support for local clients to bypass network stack
+ *
+ * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/vfs.h>
+#include <linux/file.h>
+#include <linux/inet.h>
+#include <linux/sunrpc/addr.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <linux/nfs_common.h>
+#include <linux/nfslocalio.h>
+#include <linux/module.h>
+#include <linux/bvec.h>
+
+#include <linux/nfs.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_xdr.h>
+
+#include "internal.h"
+#include "pnfs.h"
+#include "nfstrace.h"
+
+#define NFSDBG_FACILITY		NFSDBG_VFS
+
+struct nfs_local_kiocb {
+	struct kiocb		kiocb;
+	struct bio_vec		*bvec;
+	struct nfs_pgio_header	*hdr;
+	struct work_struct	work;
+	struct nfs_localio_ctx	*localio;
+};
+
+struct nfs_local_fsync_ctx {
+	struct nfs_localio_ctx	*localio;
+	struct nfs_commit_data	*data;
+	struct work_struct	work;
+	struct kref		kref;
+	struct completion	*done;
+};
+static void nfs_local_fsync_work(struct work_struct *work);
+
+static bool localio_enabled __read_mostly = true;
+module_param(localio_enabled, bool, 0644);
+
+bool nfs_server_is_local(const struct nfs_client *clp)
+{
+	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) != 0 &&
+		localio_enabled;
+}
+EXPORT_SYMBOL_GPL(nfs_server_is_local);
+
+/*
+ * nfs_local_enable - enable local i/o for an nfs_client
+ */
+static __maybe_unused void nfs_local_enable(struct nfs_client *clp)
+{
+	spin_lock(&clp->cl_localio_lock);
+
+	if (unlikely(!get_nfs_to_nfsd_symbols()))
+		goto out;
+	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+	trace_nfs_local_enable(clp);
+out:
+	spin_unlock(&clp->cl_localio_lock);
+}
+
+/*
+ * nfs_local_disable - disable local i/o for an nfs_client
+ */
+void nfs_local_disable(struct nfs_client *clp)
+{
+	spin_lock(&clp->cl_localio_lock);
+	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
+		trace_nfs_local_disable(clp);
+		put_nfs_to_nfsd_symbols();
+
+		nfs_uuid_invalidate_one_client(&clp->cl_uuid);
+	}
+	spin_unlock(&clp->cl_localio_lock);
+}
+
+/*
+ * nfs_local_probe - probe local i/o support for an nfs_server and nfs_client
+ */
+void nfs_local_probe(struct nfs_client *clp)
+{
+}
+EXPORT_SYMBOL_GPL(nfs_local_probe);
+
+/*
+ * nfs_local_open_fh - open a local filehandle in terms of nfsd_file
+ *
+ * Returns a pointer to a struct nfs_localio_ctx or NULL
+ */
+struct nfs_localio_ctx *
+nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		  struct nfs_fh *fh, const fmode_t mode)
+{
+	struct nfs_localio_ctx *localio;
+	int status;
+
+	if (!nfs_server_is_local(clp))
+		return NULL;
+	if (mode & ~(FMODE_READ | FMODE_WRITE))
+		return NULL;
+
+	localio = nfs_to.nfsd_open_local_fh(&clp->cl_uuid,
+					    clp->cl_rpcclient, cred, fh, mode);
+	if (IS_ERR(localio)) {
+		status = PTR_ERR(localio);
+		trace_nfs_local_open_fh(fh, mode, status);
+		switch (status) {
+		case -ENOMEM:
+		case -ENXIO:
+		case -ENOENT:
+			nfs_local_disable(clp);
+		}
+		return NULL;
+	}
+	return localio;
+}
+EXPORT_SYMBOL_GPL(nfs_local_open_fh);
+
+static struct bio_vec *
+nfs_bvec_alloc_and_import_pagevec(struct page **pagevec,
+		unsigned int npages, gfp_t flags)
+{
+	struct bio_vec *bvec, *p;
+
+	bvec = kmalloc_array(npages, sizeof(*bvec), flags);
+	if (bvec != NULL) {
+		for (p = bvec; npages > 0; p++, pagevec++, npages--) {
+			p->bv_page = *pagevec;
+			p->bv_len = PAGE_SIZE;
+			p->bv_offset = 0;
+		}
+	}
+	return bvec;
+}
+
+static void
+nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
+{
+	kfree(iocb->bvec);
+	kfree(iocb);
+}
+
+static struct nfs_local_kiocb *
+nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
+		     struct nfs_localio_ctx *localio, gfp_t flags)
+{
+	struct nfs_local_kiocb *iocb;
+
+	iocb = kmalloc(sizeof(*iocb), flags);
+	if (iocb == NULL)
+		return NULL;
+	iocb->bvec = nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pagevec,
+			hdr->page_array.npages, flags);
+	if (iocb->bvec == NULL) {
+		kfree(iocb);
+		return NULL;
+	}
+	init_sync_kiocb(&iocb->kiocb, nfs_to.nfsd_file_file(localio->nf));
+	iocb->kiocb.ki_pos = hdr->args.offset;
+	iocb->localio = localio;
+	iocb->hdr = hdr;
+	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
+	return iocb;
+}
+
+static void
+nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+
+	iov_iter_bvec(i, dir, iocb->bvec, hdr->page_array.npages,
+		      hdr->args.count + hdr->args.pgbase);
+	if (hdr->args.pgbase != 0)
+		iov_iter_advance(i, hdr->args.pgbase);
+}
+
+static void
+nfs_local_hdr_release(struct nfs_pgio_header *hdr,
+		const struct rpc_call_ops *call_ops)
+{
+	call_ops->rpc_call_done(&hdr->task, hdr);
+	call_ops->rpc_release(hdr);
+}
+
+static void
+nfs_local_pgio_init(struct nfs_pgio_header *hdr,
+		const struct rpc_call_ops *call_ops)
+{
+	hdr->task.tk_ops = call_ops;
+	if (!hdr->task.tk_start)
+		hdr->task.tk_start = ktime_get();
+}
+
+static void
+nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
+{
+	if (status >= 0) {
+		hdr->res.count = status;
+		hdr->res.op_status = NFS4_OK;
+		hdr->task.tk_status = 0;
+	} else {
+		hdr->res.op_status = nfs4_stat_to_errno(status);
+		hdr->task.tk_status = status;
+	}
+}
+
+static void
+nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+
+	nfs_localio_ctx_free(iocb->localio);
+	nfs_local_iocb_free(iocb);
+	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
+}
+
+static void
+nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct file *filp = iocb->kiocb.ki_filp;
+
+	nfs_local_pgio_done(hdr, status);
+
+	if (hdr->res.count != hdr->args.count ||
+	    hdr->args.offset + hdr->res.count >= i_size_read(file_inode(filp)))
+		hdr->res.eof = true;
+
+	dprintk("%s: read %ld bytes eof %d.\n", __func__,
+			status > 0 ? status : 0, hdr->res.eof);
+}
+
+static int
+nfs_do_local_read(struct nfs_pgio_header *hdr,
+		  struct nfs_localio_ctx *localio,
+		  const struct rpc_call_ops *call_ops)
+{
+	struct file *filp = nfs_to.nfsd_file_file(localio->nf);
+	struct nfs_local_kiocb *iocb;
+	struct iov_iter iter;
+	ssize_t status;
+
+	dprintk("%s: vfs_read count=%u pos=%llu\n",
+		__func__, hdr->args.count, hdr->args.offset);
+
+	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_KERNEL);
+	if (iocb == NULL)
+		return -ENOMEM;
+	nfs_local_iter_init(&iter, iocb, READ);
+
+	nfs_local_pgio_init(hdr, call_ops);
+	hdr->res.eof = false;
+
+	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
+	WARN_ON_ONCE(status == -EIOCBQUEUED);
+
+	nfs_local_read_done(iocb, status);
+	nfs_local_pgio_release(iocb);
+
+	return 0;
+}
+
+static void
+nfs_copy_boot_verifier(struct nfs_write_verifier *verifier, struct inode *inode)
+{
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+	u32 *verf = (u32 *)verifier->data;
+	int seq = 0;
+
+	do {
+		read_seqbegin_or_lock(&clp->cl_boot_lock, &seq);
+		verf[0] = (u32)clp->cl_nfssvc_boot.tv_sec;
+		verf[1] = (u32)clp->cl_nfssvc_boot.tv_nsec;
+	} while (need_seqretry(&clp->cl_boot_lock, seq));
+	done_seqretry(&clp->cl_boot_lock, seq);
+}
+
+static void
+nfs_reset_boot_verifier(struct inode *inode)
+{
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+
+	write_seqlock(&clp->cl_boot_lock);
+	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
+	write_sequnlock(&clp->cl_boot_lock);
+}
+
+static void
+nfs_set_local_verifier(struct inode *inode,
+		struct nfs_writeverf *verf,
+		enum nfs3_stable_how how)
+{
+	nfs_copy_boot_verifier(&verf->verifier, inode);
+	verf->committed = how;
+}
+
+/* Factored out from fs/nfsd/vfs.h:fh_getattr() */
+static int __vfs_getattr(struct path *p, struct kstat *stat, int version)
+{
+	u32 request_mask = STATX_BASIC_STATS;
+
+	if (version == 4)
+		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
+	return vfs_getattr(p, stat, request_mask, AT_STATX_SYNC_AS_STAT);
+}
+
+/* Copied from fs/nfsd/nfsfh.c:nfsd4_change_attribute() */
+static u64 __nfsd4_change_attribute(const struct kstat *stat,
+				    const struct inode *inode)
+{
+	u64 chattr;
+
+	if (stat->result_mask & STATX_CHANGE_COOKIE) {
+		chattr = stat->change_cookie;
+		if (S_ISREG(inode->i_mode) &&
+		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
+			chattr += (u64)stat->ctime.tv_sec << 30;
+			chattr += stat->ctime.tv_nsec;
+		}
+	} else {
+		chattr = time_to_chattr(&stat->ctime);
+	}
+	return chattr;
+}
+
+static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
+{
+	struct kstat stat;
+	struct file *filp = iocb->kiocb.ki_filp;
+	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct nfs_fattr *fattr = hdr->res.fattr;
+	int version = NFS_PROTO(hdr->inode)->version;
+
+	if (unlikely(!fattr) || __vfs_getattr(&filp->f_path, &stat, version))
+		return;
+
+	fattr->valid = (NFS_ATTR_FATTR_FILEID |
+			NFS_ATTR_FATTR_CHANGE |
+			NFS_ATTR_FATTR_SIZE |
+			NFS_ATTR_FATTR_ATIME |
+			NFS_ATTR_FATTR_MTIME |
+			NFS_ATTR_FATTR_CTIME |
+			NFS_ATTR_FATTR_SPACE_USED);
+
+	fattr->fileid = stat.ino;
+	fattr->size = stat.size;
+	fattr->atime = stat.atime;
+	fattr->mtime = stat.mtime;
+	fattr->ctime = stat.ctime;
+	if (version == 4) {
+		fattr->change_attr =
+			__nfsd4_change_attribute(&stat, file_inode(filp));
+	} else
+		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
+	fattr->du.nfs3.used = stat.blocks << 9;
+}
+
+static void
+nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct inode *inode = hdr->inode;
+
+	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
+
+	/* Handle short writes as if they are ENOSPC */
+	if (status > 0 && status < hdr->args.count) {
+		hdr->mds_offset += status;
+		hdr->args.offset += status;
+		hdr->args.pgbase += status;
+		hdr->args.count -= status;
+		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
+		status = -ENOSPC;
+	}
+	if (status < 0)
+		nfs_reset_boot_verifier(inode);
+	else if (nfs_should_remove_suid(inode)) {
+		/* Deal with the suid/sgid bit corner case */
+		spin_lock(&inode->i_lock);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+		spin_unlock(&inode->i_lock);
+	}
+	nfs_local_pgio_done(hdr, status);
+}
+
+static int
+nfs_do_local_write(struct nfs_pgio_header *hdr,
+		   struct nfs_localio_ctx *localio,
+		   const struct rpc_call_ops *call_ops)
+{
+	struct file *filp = nfs_to.nfsd_file_file(localio->nf);
+	struct nfs_local_kiocb *iocb;
+	struct iov_iter iter;
+	ssize_t status;
+
+	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
+		__func__, hdr->args.count, hdr->args.offset,
+		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
+
+	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_NOIO);
+	if (iocb == NULL)
+		return -ENOMEM;
+	nfs_local_iter_init(&iter, iocb, WRITE);
+
+	switch (hdr->args.stable) {
+	default:
+		break;
+	case NFS_DATA_SYNC:
+		iocb->kiocb.ki_flags |= IOCB_DSYNC;
+		break;
+	case NFS_FILE_SYNC:
+		iocb->kiocb.ki_flags |= IOCB_DSYNC|IOCB_SYNC;
+	}
+	nfs_local_pgio_init(hdr, call_ops);
+
+	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
+
+	file_start_write(filp);
+	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
+	file_end_write(filp);
+	WARN_ON_ONCE(status == -EIOCBQUEUED);
+
+	nfs_local_write_done(iocb, status);
+	nfs_local_vfs_getattr(iocb);
+	nfs_local_pgio_release(iocb);
+
+	return 0;
+}
+
+int nfs_local_doio(struct nfs_client *clp, struct nfs_localio_ctx *localio,
+		   struct nfs_pgio_header *hdr,
+		   const struct rpc_call_ops *call_ops)
+{
+	int status = 0;
+	struct file *filp = nfs_to.nfsd_file_file(localio->nf);
+
+	if (!hdr->args.count)
+		return 0;
+	/* Don't support filesystems without read_iter/write_iter */
+	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
+		nfs_local_disable(clp);
+		status = -EAGAIN;
+		goto out;
+	}
+
+	switch (hdr->rw_mode) {
+	case FMODE_READ:
+		status = nfs_do_local_read(hdr, localio, call_ops);
+		break;
+	case FMODE_WRITE:
+		status = nfs_do_local_write(hdr, localio, call_ops);
+		break;
+	default:
+		dprintk("%s: invalid mode: %d\n", __func__,
+			hdr->rw_mode);
+		status = -EINVAL;
+	}
+out:
+	if (status != 0) {
+		nfs_localio_ctx_free(localio);
+		hdr->task.tk_status = status;
+		nfs_local_hdr_release(hdr, call_ops);
+	}
+	return status;
+}
+
+static void
+nfs_local_init_commit(struct nfs_commit_data *data,
+		const struct rpc_call_ops *call_ops)
+{
+	data->task.tk_ops = call_ops;
+}
+
+static int
+nfs_local_run_commit(struct file *filp, struct nfs_commit_data *data)
+{
+	loff_t start = data->args.offset;
+	loff_t end = LLONG_MAX;
+
+	if (data->args.count > 0) {
+		end = start + data->args.count - 1;
+		if (end < start)
+			end = LLONG_MAX;
+	}
+
+	dprintk("%s: commit %llu - %llu\n", __func__, start, end);
+	return vfs_fsync_range(filp, start, end, 0);
+}
+
+static void
+nfs_local_commit_done(struct nfs_commit_data *data, int status)
+{
+	if (status >= 0) {
+		nfs_set_local_verifier(data->inode,
+				data->res.verf,
+				NFS_FILE_SYNC);
+		data->res.op_status = NFS4_OK;
+		data->task.tk_status = 0;
+	} else {
+		nfs_reset_boot_verifier(data->inode);
+		data->res.op_status = nfs4_stat_to_errno(status);
+		data->task.tk_status = status;
+	}
+}
+
+static void
+nfs_local_release_commit_data(struct nfs_localio_ctx *localio,
+		struct nfs_commit_data *data,
+		const struct rpc_call_ops *call_ops)
+{
+	nfs_localio_ctx_free(localio);
+	call_ops->rpc_call_done(&data->task, data);
+	call_ops->rpc_release(data);
+}
+
+static struct nfs_local_fsync_ctx *
+nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data,
+			  struct nfs_localio_ctx *localio, gfp_t flags)
+{
+	struct nfs_local_fsync_ctx *ctx = kmalloc(sizeof(*ctx), flags);
+
+	if (ctx != NULL) {
+		ctx->localio = localio;
+		ctx->data = data;
+		INIT_WORK(&ctx->work, nfs_local_fsync_work);
+		kref_init(&ctx->kref);
+		ctx->done = NULL;
+	}
+	return ctx;
+}
+
+static void
+nfs_local_fsync_ctx_kref_free(struct kref *kref)
+{
+	kfree(container_of(kref, struct nfs_local_fsync_ctx, kref));
+}
+
+static void
+nfs_local_fsync_ctx_put(struct nfs_local_fsync_ctx *ctx)
+{
+	kref_put(&ctx->kref, nfs_local_fsync_ctx_kref_free);
+}
+
+static void
+nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
+{
+	nfs_local_release_commit_data(ctx->localio, ctx->data,
+				      ctx->data->task.tk_ops);
+	nfs_local_fsync_ctx_put(ctx);
+}
+
+static void
+nfs_local_fsync_work(struct work_struct *work)
+{
+	struct nfs_local_fsync_ctx *ctx;
+	int status;
+
+	ctx = container_of(work, struct nfs_local_fsync_ctx, work);
+
+	status = nfs_local_run_commit(nfs_to.nfsd_file_file(ctx->localio->nf),
+				      ctx->data);
+	nfs_local_commit_done(ctx->data, status);
+	if (ctx->done != NULL)
+		complete(ctx->done);
+	nfs_local_fsync_ctx_free(ctx);
+}
+
+int nfs_local_commit(struct nfs_localio_ctx *localio,
+		     struct nfs_commit_data *data,
+		     const struct rpc_call_ops *call_ops, int how)
+{
+	struct nfs_local_fsync_ctx *ctx;
+
+	ctx = nfs_local_fsync_ctx_alloc(data, localio, GFP_KERNEL);
+	if (!ctx) {
+		nfs_local_commit_done(data, -ENOMEM);
+		nfs_local_release_commit_data(localio, data, call_ops);
+		return -ENOMEM;
+	}
+
+	nfs_local_init_commit(data, call_ops);
+	kref_get(&ctx->kref);
+	if (how & FLUSH_SYNC) {
+		DECLARE_COMPLETION_ONSTACK(done);
+		ctx->done = &done;
+		queue_work(nfsiod_workqueue, &ctx->work);
+		wait_for_completion(&done);
+	} else
+		queue_work(nfsiod_workqueue, &ctx->work);
+	nfs_local_fsync_ctx_put(ctx);
+	return 0;
+}
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 352fdaed4075..1eab98c277fa 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1685,6 +1685,67 @@ TRACE_EVENT(nfs_mount_path,
 	TP_printk("path='%s'", __get_str(path))
 );
 
+TRACE_EVENT(nfs_local_open_fh,
+		TP_PROTO(
+			const struct nfs_fh *fh,
+			fmode_t fmode,
+			int error
+		),
+
+		TP_ARGS(fh, fmode, error),
+
+		TP_STRUCT__entry(
+			__field(int, error)
+			__field(u32, fhandle)
+			__field(unsigned int, fmode)
+		),
+
+		TP_fast_assign(
+			__entry->error = error;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+			__entry->fmode = (__force unsigned int)fmode;
+		),
+
+		TP_printk(
+			"error=%d fhandle=0x%08x mode=%s",
+			__entry->error,
+			__entry->fhandle,
+			show_fs_fmode_flags(__entry->fmode)
+		)
+);
+
+DECLARE_EVENT_CLASS(nfs_local_client_event,
+		TP_PROTO(
+			const struct nfs_client *clp
+		),
+
+		TP_ARGS(clp),
+
+		TP_STRUCT__entry(
+			__field(unsigned int, protocol)
+			__string(server, clp->cl_hostname)
+		),
+
+		TP_fast_assign(
+			__entry->protocol = clp->rpc_ops->version;
+			__assign_str(server);
+		),
+
+		TP_printk(
+			"server=%s NFSv%u", __get_str(server), __entry->protocol
+		)
+);
+
+#define DEFINE_NFS_LOCAL_CLIENT_EVENT(name) \
+	DEFINE_EVENT(nfs_local_client_event, name, \
+			TP_PROTO( \
+				const struct nfs_client *clp \
+			), \
+			TP_ARGS(clp))
+
+DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_enable);
+DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_disable);
+
 DECLARE_EVENT_CLASS(nfs_xdr_event,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 849db19451ff..cf68c0a61b7d 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -762,6 +762,10 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		hdr->args.count,
 		(unsigned long long)hdr->args.offset);
 
+	if (localio)
+		return nfs_local_doio(NFS_SERVER(hdr->inode)->nfs_client,
+				      localio, hdr, call_ops);
+
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 4bd16473a953..8bbbe8dace3b 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1693,6 +1693,9 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
 
 	dprintk("NFS: initiated commit call\n");
 
+	if (localio)
+		return nfs_local_commit(localio, data, call_ops, how);
+
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 5ff1a5b3b00c..89ef8c5e98db 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_NFS_H
 #define _LINUX_NFS_H
 
+#include <linux/cred.h>
+#include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/string.h>
 #include <linux/crc32.h>
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 1df86ab98c77..b43e3e067e44 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -8,6 +8,7 @@
 #include <linux/wait.h>
 #include <linux/nfs_xdr.h>
 #include <linux/sunrpc/xprt.h>
+#include <linux/nfslocalio.h>
 
 #include <linux/atomic.h>
 #include <linux/refcount.h>
@@ -49,6 +50,7 @@ struct nfs_client {
 #define NFS_CS_DS		7		/* - Server is a DS */
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
 #define NFS_CS_PNFS		9		/* - Server used for pnfs */
+#define NFS_CS_LOCAL_IO		10		/* - client is local */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
@@ -125,6 +127,13 @@ struct nfs_client {
 	struct net		*cl_net;
 	struct list_head	pending_cb_stateids;
 	struct rcu_head		rcu;
+
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	struct timespec64	cl_nfssvc_boot;
+	seqlock_t		cl_boot_lock;
+	nfs_uuid_t		cl_uuid;
+	spinlock_t		cl_localio_lock;
+#endif /* CONFIG_NFS_LOCALIO */
 };
 
 /*
-- 
2.44.0


