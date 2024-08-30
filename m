Return-Path: <linux-nfs+bounces-6026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C293B965551
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 04:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E794A1C22674
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F12C18C;
	Fri, 30 Aug 2024 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pszK6c7s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4TKTpaJH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pszK6c7s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4TKTpaJH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D80380
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985564; cv=none; b=f1l2/tNFzJxytgLN179H497zmulszfHm5imK2t/VpAwCTQG/46oTzD4DAuZyYj5vBD/RBrXQcMrK78wvdYml8H1rqsNC/TZ+NC2tZ9D2K+c9UdbyktBa41UuV7zA5Lljvq1mAypHctmirrgSiRpam0Qb7Dq7XFwcm5eM8fZrTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985564; c=relaxed/simple;
	bh=SDvzwGzCfhJkpAXLsrRd0l3EsfEnfxbz3hpE2Q8HgH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2b8MUM5PZueZUXcykTPSaaVFui9sZJnNG2kxBtH35X3mjO7m5Q5qA+r6Yf1OVBMcwlk/o/Ar2FoxfMRraB16xZO/rDCXEVoBuJVzOessV7C8IwKpKJ+ZAVPSN8og/cLAKgt76DhCgstdHp3F+Ltu3eNmWhbx2A5GwmNQ6h/Rf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pszK6c7s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4TKTpaJH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pszK6c7s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4TKTpaJH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 853031F791;
	Fri, 30 Aug 2024 02:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hbqfkB6NmBxaH4zP97vUx+kPECMEqpAI3++Ag86qmw=;
	b=pszK6c7sNcLEHTheiC89sylRE20uvr8xle0WrS5+jz/EB4F23iMHKU5jvlgg7uZZyR2WhO
	PBIDAte/pb2Mlit4E1K+KrN4ATaydTrUyLpAW7TBEcQJI4h2en9xaxvKZkq5g2sjRID7dF
	SDTj4hMvfEY10bElcNlg8B2t0sreLkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hbqfkB6NmBxaH4zP97vUx+kPECMEqpAI3++Ag86qmw=;
	b=4TKTpaJHCC89FXAIzHVvje0jMt6cedjsXm+bnHPJSlUk8CDOFNidNFI7P3Bs3YI3NCW47s
	DkttuVwb9gqFMPAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pszK6c7s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4TKTpaJH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hbqfkB6NmBxaH4zP97vUx+kPECMEqpAI3++Ag86qmw=;
	b=pszK6c7sNcLEHTheiC89sylRE20uvr8xle0WrS5+jz/EB4F23iMHKU5jvlgg7uZZyR2WhO
	PBIDAte/pb2Mlit4E1K+KrN4ATaydTrUyLpAW7TBEcQJI4h2en9xaxvKZkq5g2sjRID7dF
	SDTj4hMvfEY10bElcNlg8B2t0sreLkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hbqfkB6NmBxaH4zP97vUx+kPECMEqpAI3++Ag86qmw=;
	b=4TKTpaJHCC89FXAIzHVvje0jMt6cedjsXm+bnHPJSlUk8CDOFNidNFI7P3Bs3YI3NCW47s
	DkttuVwb9gqFMPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF258136A4;
	Fri, 30 Aug 2024 02:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z14vGdYw0WbfFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 02:39:18 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 16/25] nfsd: add localio support
Date: Fri, 30 Aug 2024 12:20:29 +1000
Message-ID: <20240830023531.29421-17-neilb@suse.de>
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
X-Rspamd-Queue-Id: 853031F791
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Weston Andros Adamson <dros@primarydata.com>

Add server support for bypassing NFS for localhost reads, writes, and
commits. This is only useful when both the client and server are
running on the same host.

If nfsd_open_local_fh() fails then the NFS client will both retry and
fallback to normal network-based read, write and commit operations if
localio is no longer supported.

Care is taken to ensure the same NFS security mechanisms are used
(authentication, etc) regardless of whether localio or regular NFS
access is used.  The auth_domain established as part of the traditional
NFS client access to the NFS server is also used for localio.  Store
auth_domain for localio in nfsd_uuid_t and transfer it to the client
if it is local to the server.

Relative to containers, localio gives the client access to the network
namespace the server has.  This is required to allow the client to
access the server's per-namespace nfsd_net struct.

CONFIG_NFSD_LOCALIO controls the server enablement for localio.
A later commit will add CONFIG_NFS_LOCALIO to allow the client
enablement.

This commit also introduces the use of nfsd's percpu_ref to interlock
nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
not destroyed while in use by nfsd_open_local_fh, and warrants a more
detailed explanation:

nfsd_open_local_fh uses nfsd_serv_try_get before opening its file
handle and then the reference must be dropped by the caller using
nfsd_serv_put (via nfs_localio_ctx_free).

Verified to fix an easy to hit crash that would occur if an nfsd
instance running in a container, with a localio client mounted, is
shutdown. Upon restart of the container and associated nfsd the client
would go on to crash due to NULL pointer dereference that occurred due
to the nfs client's localio attempting to nfsd_open_local_fh(), using
nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/Kconfig          |   3 ++
 fs/nfsd/Kconfig     |  16 +++++++
 fs/nfsd/Makefile    |   1 +
 fs/nfsd/filecache.c |   2 +-
 fs/nfsd/localio.c   | 114 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/trace.h     |   3 +-
 fs/nfsd/vfs.h       |   8 ++++
 7 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 fs/nfsd/localio.c

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..1b8a5edbddff 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
 	tristate
 	select FS_POSIX_ACL
 
+config NFS_COMMON_LOCALIO_SUPPORT
+	bool
+
 config NFS_COMMON
 	bool
 	depends on NFSD || NFS_FS || LOCKD
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index c0bd1509ccd4..e6fa7eaa1db0 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -90,6 +90,22 @@ config NFSD_V4
 
 	  If unsure, say N.
 
+config NFSD_LOCALIO
+	bool "NFS server support for the LOCALIO auxiliary protocol"
+	depends on NFSD
+	select NFS_COMMON_LOCALIO_SUPPORT
+	default n
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS server.  Enable this to permit local NFS clients
+	  to bypass the network when issuing reads and writes to the
+	  local NFS server.
+
+	  If unsure, say N.
+
 config NFSD_PNFS
 	bool
 
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index b8736a82e57c..78b421778a79 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
 nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
+nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a83d469bca6b..49f4aab3208a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -53,7 +53,7 @@
 #define NFSD_FILE_CACHE_UP		     (0)
 
 /* We only care about NFSD_MAY_READ/WRITE for this cache */
-#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
+#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
 
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
new file mode 100644
index 000000000000..637402eecb61
--- /dev/null
+++ b/fs/nfsd/localio.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NFS server support for local clients to bypass network stack
+ *
+ * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+
+#include <linux/exportfs.h>
+#include <linux/sunrpc/svcauth.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/nfs.h>
+#include <linux/nfs_common.h>
+#include <linux/nfslocalio.h>
+#include <linux/string.h>
+
+#include "nfsd.h"
+#include "vfs.h"
+#include "netns.h"
+#include "filecache.h"
+
+/**
+ * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
+ *
+ * @cl_nfssvc_net: the 'struct net' to use to get the proper nfsd_net
+ * @cl_nfssvc_dom: the 'struct auth_domain' required for localio access
+ * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
+ * @cred: cred that the client established
+ * @nfs_fh: filehandle to lookup
+ * @fmode: fmode_t to use for open
+ *
+ * This function maps a local fh to a path on a local filesystem.
+ * This is useful when the nfs client has the local server mounted - it can
+ * avoid all the NFS overhead with reads, writes and commits.
+ *
+ * On successful return, returned nfs_localio_ctx will have its nfsd_file and
+ * nfsd_net members set. Caller is responsible for calling nfsd_file_put and
+ * nfsd_serv_put (via nfs_localio_ctx_free).
+ */
+struct nfs_localio_ctx *
+nfsd_open_local_fh(nfs_uuid_t *uuid,
+		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
+		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+{
+	int mayflags = NFSD_MAY_LOCALIO;
+	int status = 0;
+	struct nfsd_net *nn = NULL;
+	struct net *net;
+	struct svc_cred rq_cred;
+	struct svc_fh fh;
+	struct nfs_localio_ctx *localio;
+	__be32 beres;
+
+	if (nfs_fh->size > NFS4_FHSIZE)
+		return ERR_PTR(-EINVAL);
+
+	localio = nfs_localio_ctx_alloc();
+	if (!localio)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
+	 * But the server may already be shutting down, if so disallow new localio.
+	 * uuid->net is NOT a counted reference, but rcu_read_lock() ensures that if
+	 * uuid->net is not NULL, then nfsd_serv_try_get() is safe and if that succeeds
+	 * we will have an implied reference to the net.
+	 */
+	rcu_read_lock();
+	net = READ_ONCE(uuid->net);
+	if (net)
+		nn = net_generic(net, nfsd_net_id);
+	if (unlikely(!nn || !nfsd_serv_try_get(nn))) {
+		rcu_read_unlock();
+		status = -ENXIO;
+		goto out_nfsd_serv;
+	}
+	rcu_read_unlock();
+
+	/* nfs_fh -> svc_fh */
+	fh_init(&fh, NFS4_FHSIZE);
+	fh.fh_handle.fh_size = nfs_fh->size;
+	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
+
+	if (fmode & FMODE_READ)
+		mayflags |= NFSD_MAY_READ;
+	if (fmode & FMODE_WRITE)
+		mayflags |= NFSD_MAY_WRITE;
+
+	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
+
+	beres = nfsd_file_acquire_local(uuid->net, &rq_cred, uuid->dom,
+					&fh, mayflags, &localio->nf);
+	if (beres) {
+		status = nfs_stat_to_errno(be32_to_cpu(beres));
+		goto out_fh_put;
+	}
+	localio->nn = nn;
+
+out_fh_put:
+	fh_put(&fh);
+	if (rq_cred.cr_group_info)
+		put_group_info(rq_cred.cr_group_info);
+out_nfsd_serv:
+	if (status) {
+		nfs_localio_ctx_free(localio);
+		return ERR_PTR(status);
+	}
+	return localio;
+}
+EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d22027e23761..82bcefcd1f21 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
 		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
 		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
-		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
+		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
+		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
 
 TRACE_EVENT(nfsd_compound,
 	TP_PROTO(
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 01947561d375..2ecceb8b9d3d 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -8,6 +8,7 @@
 
 #include <linux/fs.h>
 #include <linux/posix_acl.h>
+#include <linux/nfslocalio.h>
 #include "nfsfh.h"
 #include "nfsd.h"
 
@@ -33,6 +34,8 @@
 
 #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
 
+#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used */
+
 #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
 #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
 
@@ -158,6 +161,11 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 void		nfsd_filp_close(struct file *fp);
 
+struct nfs_localio_ctx *
+nfsd_open_local_fh(nfs_uuid_t *,
+		   struct rpc_clnt *, const struct cred *,
+		   const struct nfs_fh *, const fmode_t);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
-- 
2.44.0


