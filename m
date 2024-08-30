Return-Path: <linux-nfs+bounces-6025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A896554F
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 04:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BD01F23B44
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A624380;
	Fri, 30 Aug 2024 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vt5e6E08";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oZo6dmiV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vt5e6E08";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oZo6dmiV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921D2C18C
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985556; cv=none; b=YhxNUDk1wr0aVGtaU8nSfYMwqNIBrSWm6uz8Y5LxCq01OpOvymqaTHVOWfznmQWAhiVzomGLisaRZXeNutGzW9+cunsbCxyFYAVtb7VnUhYbmXhQfbQpc5aSwoWw9lvyVstgct6f/vIvGLvxeUQmKY68FQLPCNxEQmJwFbsEvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985556; c=relaxed/simple;
	bh=+UaMHfcUEn8ypL1Taw7TejrYKPBlAnfPhQA7vFQKPhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFrDPn3C66j2yHOVKQG1hPRYB3QWv5AZzYmOHZ5hvD3dPu9bn86Wb9aOttfQimbGO9MRlln3nh7mbUzQr7UiR3/VcFAm+HdR34lBU1YgJCZwvweKX3dC9s4d0O7TCCjJHbnjEm2DzN0tQScnDNcr1xleL/zgquE6gjsqTkU7cj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vt5e6E08; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oZo6dmiV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vt5e6E08; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oZo6dmiV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46B421F791;
	Fri, 30 Aug 2024 02:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6BMAzZPFarrZAC3bf1YLFQqK3ED6bthBWsIjEySO6o=;
	b=vt5e6E0822PrDZJ0bCy6k6TiyMXBj5lKrfY2a84VOn0GECXR8bziX6VFk4TW3h+CoTlUBM
	oxYW7bD57SMeZlNR0LhkbwmJ54dh49TtQhdgGtDHvJXxWWYu+f5sAIVCT1XXj7pj+BdJ2V
	k8tFIBvsFfoh+S9HuePb7nM3wmreEz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6BMAzZPFarrZAC3bf1YLFQqK3ED6bthBWsIjEySO6o=;
	b=oZo6dmiVA3rcupFQ+HH4tnZ4Nv2IYrAa+b3zLvsRwJuB8ERewAqwtDRoWxhgyYBebNCT+l
	9958z4NtBGKhqNBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6BMAzZPFarrZAC3bf1YLFQqK3ED6bthBWsIjEySO6o=;
	b=vt5e6E0822PrDZJ0bCy6k6TiyMXBj5lKrfY2a84VOn0GECXR8bziX6VFk4TW3h+CoTlUBM
	oxYW7bD57SMeZlNR0LhkbwmJ54dh49TtQhdgGtDHvJXxWWYu+f5sAIVCT1XXj7pj+BdJ2V
	k8tFIBvsFfoh+S9HuePb7nM3wmreEz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6BMAzZPFarrZAC3bf1YLFQqK3ED6bthBWsIjEySO6o=;
	b=oZo6dmiVA3rcupFQ+HH4tnZ4Nv2IYrAa+b3zLvsRwJuB8ERewAqwtDRoWxhgyYBebNCT+l
	9958z4NtBGKhqNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5664136A4;
	Fri, 30 Aug 2024 02:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PtW8Gs0w0WbZFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 02:39:09 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 15/25] nfs_common: introduce nfs_localio_ctx struct and interfaces
Date: Fri, 30 Aug 2024 12:20:28 +1000
Message-ID: <20240830023531.29421-16-neilb@suse.de>
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

From: Mike Snitzer <snitzer@kernel.org>

Introduce struct nfs_localio_ctx and the interfaces
nfs_localio_ctx_alloc() and nfs_localio_ctx_free().  The next commit
will introduce nfsd_open_local_fh() which returns a nfs_localio_ctx
structure.

Also, expose localio's required NFSD symbols to NFS client:
- Cache nfsd_open_local_fh symbol and other required NFSD symbols in a
  globally accessible 'nfs_to' nfs_to_nfsd_t struct.  Add interfaces
  get_nfs_to_nfsd_symbols() and put_nfs_to_nfsd_symbols() to allow
  each NFS client to take a reference on NFSD symbols.

- Apologies for the DEFINE_NFS_TO_NFSD_SYMBOL macro that makes
  defining get_##NFSD_SYMBOL() and put_##NFSD_SYMBOL() functions far
  simpler (and avoids cut-n-paste bugs, which is what motivated the
  development and use of a macro for this). But as C macros go it is a
  very simple one and there are many like it all over the kernel.

- Given the unique nature of NFS LOCALIO being an optional feature
  that when used requires NFS share access to NFSD memory: a unique
  bridging of NFSD resources to NFS (via nfs_common) is needed.  But
  that bridge must be dynamic, hence the use of symbol_request() and
  symbol_put().  Proposed ideas to accomolish the same without using
  symbol_{request,put} would be far more tedious to implement and
  very likely no easier to review.  Anyway: sorry NeilBrown...

- Despite the use of indirect function calls, caching these nfsd
  symbols for use by the client offers a ~10% performance win
  (compared to always doing get+call+put) for high IOPS workloads.

- Introduce nfsd_file_file() wrapper that provides access to
  nfsd_file's backing file.  Keeps nfsd_file structure opaque to NFS
  client (as suggested by Jeff Layton).

- The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
  symbols prepares for the NFS client to use nfsd_file for localio.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs_to
Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/nfslocalio.c | 159 +++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.c        |  25 ++++++
 fs/nfsd/filecache.h        |   1 +
 fs/nfsd/nfssvc.c           |   5 ++
 include/linux/nfslocalio.h |  38 +++++++++
 5 files changed, 228 insertions(+)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index f78cf99e2547..8545ee75f756 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -106,3 +106,162 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
 	}
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
+
+/*
+ * The nfs localio code needs to call into nfsd using various symbols (below),
+ * but cannot be statically linked, because that will make the nfs module
+ * depend on the nfsd module.
+ *
+ * Instead, do dynamic linking to the nfsd module (via nfs_common module). The
+ * nfs_common module will only hold a reference on nfsd when localio is in use.
+ * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
+ */
+static DEFINE_SPINLOCK(nfs_to_nfsd_lock);
+nfs_to_nfsd_t nfs_to;
+EXPORT_SYMBOL_GPL(nfs_to);
+
+/* Macro to define nfs_to get and put methods, avoids copy-n-paste bugs */
+#define DEFINE_NFS_TO_NFSD_SYMBOL(NFSD_SYMBOL)		\
+static nfs_to_##NFSD_SYMBOL##_t get_##NFSD_SYMBOL(void)	\
+{							\
+	return symbol_request(NFSD_SYMBOL);		\
+}							\
+static void put_##NFSD_SYMBOL(void)			\
+{							\
+	symbol_put(NFSD_SYMBOL);			\
+	nfs_to.NFSD_SYMBOL = NULL;			\
+}
+
+/* The nfs localio code needs to call into nfsd to map filehandle -> struct nfsd_file */
+extern struct nfs_localio_ctx *
+nfsd_open_local_fh(nfs_uuid_t *, struct rpc_clnt *,
+		   const struct cred *, const struct nfs_fh *, const fmode_t);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
+
+/* The nfs localio code needs to call into nfsd to acquire the nfsd_file */
+extern struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_get);
+
+/* The nfs localio code needs to call into nfsd to release the nfsd_file */
+extern void nfsd_file_put(struct nfsd_file *nf);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_put);
+
+/* The nfs localio code needs to call into nfsd to access the nf->nf_file */
+extern struct file * nfsd_file_file(struct nfsd_file *nf);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_file);
+
+/* The nfs localio code needs to call into nfsd to release nn->nfsd_serv */
+extern void nfsd_serv_put(struct nfsd_net *nn);
+DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_serv_put);
+#undef DEFINE_NFS_TO_NFSD_SYMBOL
+
+static struct kmem_cache *nfs_localio_ctx_cache;
+
+struct nfs_localio_ctx *nfs_localio_ctx_alloc(void)
+{
+	return kmem_cache_alloc(nfs_localio_ctx_cache,
+				GFP_KERNEL | __GFP_ZERO);
+}
+EXPORT_SYMBOL_GPL(nfs_localio_ctx_alloc);
+
+void nfs_localio_ctx_free(struct nfs_localio_ctx *localio)
+{
+	if (localio->nf)
+		nfs_to.nfsd_file_put(localio->nf);
+	if (localio->nn)
+		nfs_to.nfsd_serv_put(localio->nn);
+	kmem_cache_free(nfs_localio_ctx_cache, localio);
+}
+EXPORT_SYMBOL_GPL(nfs_localio_ctx_free);
+
+bool get_nfs_to_nfsd_symbols(void)
+{
+	spin_lock(&nfs_to_nfsd_lock);
+
+	/* Only get symbols on first reference */
+	if (refcount_read(&nfs_to.ref) == 0)
+		refcount_set(&nfs_to.ref, 1);
+	else {
+		refcount_inc(&nfs_to.ref);
+		spin_unlock(&nfs_to_nfsd_lock);
+		return true;
+	}
+
+	nfs_to.nfsd_open_local_fh = get_nfsd_open_local_fh();
+	if (!nfs_to.nfsd_open_local_fh)
+		goto out_nfsd_open_local_fh;
+
+	nfs_to.nfsd_file_get = get_nfsd_file_get();
+	if (!nfs_to.nfsd_file_get)
+		goto out_nfsd_file_get;
+
+	nfs_to.nfsd_file_put = get_nfsd_file_put();
+	if (!nfs_to.nfsd_file_put)
+		goto out_nfsd_file_put;
+
+	nfs_to.nfsd_file_file = get_nfsd_file_file();
+	if (!nfs_to.nfsd_file_file)
+		goto out_nfsd_file_file;
+
+	nfs_to.nfsd_serv_put = get_nfsd_serv_put();
+	if (!nfs_to.nfsd_serv_put)
+		goto out_nfsd_serv_put;
+
+	spin_unlock(&nfs_to_nfsd_lock);
+	return true;
+
+out_nfsd_serv_put:
+	put_nfsd_file_file();
+out_nfsd_file_file:
+	put_nfsd_file_put();
+out_nfsd_file_put:
+	put_nfsd_file_get();
+out_nfsd_file_get:
+	put_nfsd_open_local_fh();
+out_nfsd_open_local_fh:
+	spin_unlock(&nfs_to_nfsd_lock);
+	return false;
+}
+EXPORT_SYMBOL_GPL(get_nfs_to_nfsd_symbols);
+
+void put_nfs_to_nfsd_symbols(void)
+{
+	spin_lock(&nfs_to_nfsd_lock);
+
+	if (!refcount_dec_and_test(&nfs_to.ref))
+		goto out;
+
+	put_nfsd_open_local_fh();
+	put_nfsd_file_get();
+	put_nfsd_file_put();
+	put_nfsd_file_file();
+	put_nfsd_serv_put();
+out:
+	spin_unlock(&nfs_to_nfsd_lock);
+}
+EXPORT_SYMBOL_GPL(put_nfs_to_nfsd_symbols);
+
+static int __init nfslocalio_init(void)
+{
+	refcount_set(&nfs_to.ref, 0);
+
+	nfs_to.nfsd_open_local_fh = NULL;
+	nfs_to.nfsd_file_get = NULL;
+	nfs_to.nfsd_file_put = NULL;
+	nfs_to.nfsd_file_file = NULL;
+	nfs_to.nfsd_serv_put = NULL;
+
+	nfs_localio_ctx_cache = KMEM_CACHE(nfs_localio_ctx, 0);
+	if (!nfs_localio_ctx_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __exit nfslocalio_exit(void)
+{
+	kmem_cache_destroy(nfs_localio_ctx_cache);
+}
+
+module_init(nfslocalio_init);
+module_exit(nfslocalio_exit);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2dc72de31f61..a83d469bca6b 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -39,6 +39,7 @@
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
 #include <linux/rhashtable.h>
+#include <linux/nfslocalio.h>
 
 #include "vfs.h"
 #include "nfsd.h"
@@ -345,6 +346,10 @@ nfsd_file_get(struct nfsd_file *nf)
 		return nf;
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(nfsd_file_get);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_file_get_t __maybe_unused nfsd_file_get_typecheck = nfsd_file_get;
 
 /**
  * nfsd_file_put - put the reference to a nfsd_file
@@ -389,6 +394,26 @@ nfsd_file_put(struct nfsd_file *nf)
 	if (refcount_dec_and_test(&nf->nf_ref))
 		nfsd_file_free(nf);
 }
+EXPORT_SYMBOL_GPL(nfsd_file_put);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_file_put_t __maybe_unused nfsd_file_put_typecheck = nfsd_file_put;
+
+/**
+ * nfsd_file_file - get the backing file of an nfsd_file
+ * @nf: nfsd_file of which to access the backing file.
+ *
+ * Return backing file for @nf.
+ */
+struct file *
+nfsd_file_file(struct nfsd_file *nf)
+{
+	return nf->nf_file;
+}
+EXPORT_SYMBOL_GPL(nfsd_file_file);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_file_file_t __maybe_unused nfsd_file_file_typecheck = nfsd_file_file;
 
 static void
 nfsd_file_dispose_list(struct list_head *dispose)
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 26ada78b8c1e..6fbbb2e32e95 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -56,6 +56,7 @@ int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
+struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
 void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c639fbe4d8c2..13c69aa40d1c 100644
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
@@ -201,6 +202,10 @@ void nfsd_serv_put(struct nfsd_net *nn)
 {
 	percpu_ref_put(&nn->nfsd_serv_ref);
 }
+EXPORT_SYMBOL_GPL(nfsd_serv_put);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_serv_put_t __maybe_unused nfsd_serv_put_typecheck = nfsd_serv_put;
 
 static void nfsd_serv_done(struct percpu_ref *ref)
 {
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index a8216a777b40..e196f716a2f5 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -7,6 +7,8 @@
 
 #include <linux/list.h>
 #include <linux/uuid.h>
+#include <linux/refcount.h>
+#include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfs.h>
 #include <net/net_namespace.h>
@@ -31,4 +33,40 @@ void nfs_uuid_is_local(const uuid_t *, struct list_head *,
 void nfs_uuid_invalidate_clients(struct list_head *list);
 void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
 
+struct nfsd_file;
+struct nfsd_net;
+
+struct nfs_localio_ctx {
+	struct nfsd_file *nf;
+	struct nfsd_net *nn;
+};
+
+typedef struct nfs_localio_ctx *
+(*nfs_to_nfsd_open_local_fh_t)(nfs_uuid_t *,
+			       struct rpc_clnt *, const struct cred *,
+			       const struct nfs_fh *, const fmode_t);
+typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_file *);
+typedef void (*nfs_to_nfsd_file_put_t)(struct nfsd_file *);
+typedef struct file * (*nfs_to_nfsd_file_file_t)(struct nfsd_file *);
+typedef unsigned int (*nfs_to_nfsd_net_id_value_t)(void);
+typedef void (*nfs_to_nfsd_serv_put_t)(struct nfsd_net *);
+
+typedef struct {
+	refcount_t			ref;
+	nfs_to_nfsd_open_local_fh_t	nfsd_open_local_fh;
+	nfs_to_nfsd_file_get_t		nfsd_file_get;
+	nfs_to_nfsd_file_put_t		nfsd_file_put;
+	nfs_to_nfsd_file_file_t		nfsd_file_file;
+	nfs_to_nfsd_net_id_value_t	nfsd_net_id_value;
+	nfs_to_nfsd_serv_put_t		nfsd_serv_put;
+} nfs_to_nfsd_t;
+
+extern nfs_to_nfsd_t nfs_to;
+
+bool get_nfs_to_nfsd_symbols(void);
+void put_nfs_to_nfsd_symbols(void);
+
+struct nfs_localio_ctx *nfs_localio_ctx_alloc(void);
+void nfs_localio_ctx_free(struct nfs_localio_ctx *);
+
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


