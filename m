Return-Path: <linux-nfs+bounces-19053-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DpyDTSLl2n/0AIAu9opvQ
	(envelope-from <linux-nfs+bounces-19053-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F5F1630F0
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5677A300AB37
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1E92D7D47;
	Thu, 19 Feb 2026 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCvXkl/T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F61DE3B5
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539249; cv=none; b=lIwwAfz8TqSjrC7RJL1w2i+6SoeZ9FYajhisVLtf79B70JkR0BzP9ryCbT7qOfMA38oGlWWTFqOGgH/KFv5DBrVmtKxqCJssQENixaUv/zlR3vArUEXulnSi96zh5ROQm63ETN5BznYjQd5uKFiTT90RMjG6Mxf6L3ie/yOf0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539249; c=relaxed/simple;
	bh=8GMH5ZrLiWGgPpRZNenUSG2fmgULze3c8myrz+Uv8uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OESFseDfjQDEjBGWW3LNDwWmmQvHv1SvBpkJvgMNtHeiwKbLvi3cUSMa4vOv/lonft4s8mQcXc/AwaFpQQJNUW4mPwaOVMieYPvzE8bqa+oQNKOxEJg+DUTQrxnqj6eXTcOQ1vcmfur6w3HjhQISkWDIXs6wRVT5YyGPDOR6aJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCvXkl/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41429C116C6;
	Thu, 19 Feb 2026 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539248;
	bh=8GMH5ZrLiWGgPpRZNenUSG2fmgULze3c8myrz+Uv8uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCvXkl/Tm4twx4Hw+cfo4zBpksYvH4fTPA2aMs4EDre97Gyz191WWICCgHgjv0Lu+
	 CDPXtjLHYF88is/YT9hwr2XC7yAtJfYOLC/oXaeF2C3qPnvzranGKmK1NYYYxVucZq
	 Dxn3Rb6MORxF4WINFwEpWwOI9Wd4oqe4Agn1FU68GTf9LGYklP/3z9OnISu5EH/hoF
	 17ZBydcwP6c77XKcPJYdM8hCK4ccXFL9iLd8vtyJPoABx7yY3waOcBe7QtKQuZHx/G
	 jY73c6ItTPwZkMzHJ5gnd4xdHsasGWwCT9+QaAWRoZW/mHVjP9ArA+ZCgwGpfCiC+K
	 cRZ3Irr3xAdCA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 10/11] NFSv4: add reexport support for GETACL nfs4_acl passthru
Date: Thu, 19 Feb 2026 17:13:51 -0500
Message-ID: <20260219221352.40554-11-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260219221352.40554-1-snitzer@kernel.org>
References: <20260219221352.40554-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19053-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: E1F5F1630F0
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Wire up the export_operations .getacl hook and use the upper layer
provided nfs4_acl's pages in the call to NFSPROC4_CLNT_GETACL.

In this reexporting case (e.g. 4.1 reexporting 4.2),
__nfs4_get_acl_uncached() is always used because the NFSv4 client's
cache is designed to reply with the buffer that gets generated from
the ACL's pages. So the frontend client (4.1) will cache the ACL
returned by the backend (4.2) client.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/export.c         | 10 ++++++
 fs/nfs/nfs4proc.c       | 79 ++++++++++++++++++++++++++++-------------
 include/linux/nfs_xdr.h |  1 +
 3 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 9a90eee3e433..6623eb13f4e6 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -161,11 +161,21 @@ static int nfs_set_nfs4_acl(struct inode *inode, struct nfs4_acl *acl)
 	return rpc_ops->set_nfs4_acl(inode, acl);
 }
 
+static int nfs_get_nfs4_acl(struct inode *inode, struct nfs4_acl *acl)
+{
+	const struct nfs_rpc_ops *rpc_ops = NFS_SERVER(inode)->nfs_client->rpc_ops;
+
+	if (rpc_ops->get_nfs4_acl == NULL)
+		return -EOPNOTSUPP;
+	return rpc_ops->get_nfs4_acl(inode, acl);
+}
+
 const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
 	.setacl = nfs_set_nfs4_acl,
+	.getacl = nfs_get_nfs4_acl,
 	.flags = EXPORT_OP_NOWCC		|
 		 EXPORT_OP_NOSUBTREECHK		|
 		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f97ef2d41e35..480c06b69296 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6099,7 +6099,8 @@ static void nfs4_write_cached_acl(struct inode *inode, struct page **pages,
  * the server, this time with the input buf of the required size.
  */
 static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
-				       size_t buflen, enum nfs4_acl_type type)
+				       size_t buflen, enum nfs4_acl_type type,
+				       struct nfs4_acl *acl)
 {
 	struct page **pages;
 	struct nfs_getaclargs args = {
@@ -6123,26 +6124,29 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
 	if (buflen == 0)
 		buflen = server->rsize;
 
-	npages = DIV_ROUND_UP(buflen, PAGE_SIZE) + 1;
-	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	if (!acl) {
+		npages = DIV_ROUND_UP(buflen, PAGE_SIZE) + 1;
+		pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
+		if (!pages)
+			return -ENOMEM;
+		for (i = 0; i < npages; i++) {
+			pages[i] = alloc_page(GFP_KERNEL);
+			if (!pages[i])
+				goto out_free;
+		}
+		args.acl_len = npages * PAGE_SIZE;
+	} else {
+		npages = DIV_ROUND_UP(buflen, PAGE_SIZE);
+		pages = acl->pages;
+	}
 
 	args.acl_pages = pages;
 
-	for (i = 0; i < npages; i++) {
-		pages[i] = alloc_page(GFP_KERNEL);
-		if (!pages[i])
-			goto out_free;
-	}
-
 	/* for decoding across pages */
 	res.acl_scratch = folio_alloc(GFP_KERNEL, 0);
 	if (!res.acl_scratch)
 		goto out_free;
 
-	args.acl_len = npages * PAGE_SIZE;
-
 	dprintk("%s  buf %p buflen %zu npages %d args.acl_len %zu\n",
 		__func__, buf, buflen, npages, args.acl_len);
 	ret = nfs4_call_sync(NFS_SERVER(inode)->client, NFS_SERVER(inode),
@@ -6158,8 +6162,18 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
 		ret = -ERANGE;
 		goto out_free;
 	}
-	nfs4_write_cached_acl(inode, pages, res.acl_data_offset, res.acl_len,
-			      type);
+
+	if (!acl) {
+		nfs4_write_cached_acl(inode, pages, res.acl_data_offset,
+				      res.acl_len, type);
+	} else {
+		if (res.acl_len > buflen) {
+			ret = -ERANGE;
+			goto out_free;
+		}
+		acl->len = res.acl_len;
+		acl->pgbase = res.acl_data_offset;
+	}
 	if (buf) {
 		if (res.acl_len > buflen) {
 			ret = -ERANGE;
@@ -6170,23 +6184,26 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
 out_ok:
 	ret = res.acl_len;
 out_free:
-	while (--i >= 0)
-		__free_page(pages[i]);
+	if (!acl) {
+		while (--i >= 0)
+			__free_page(pages[i]);
+		kfree(pages);
+	}
 	if (res.acl_scratch)
 		folio_put(res.acl_scratch);
-	kfree(pages);
 	return ret;
 }
 
 static ssize_t nfs4_get_acl_uncached(struct inode *inode, void *buf,
-				     size_t buflen, enum nfs4_acl_type type)
+				     size_t buflen, enum nfs4_acl_type type,
+				     struct nfs4_acl *acl)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	ssize_t ret;
 	do {
-		ret = __nfs4_get_acl_uncached(inode, buf, buflen, type);
+		ret = __nfs4_get_acl_uncached(inode, buf, buflen, type, acl);
 		trace_nfs4_get_acl(inode, ret);
 		if (ret >= 0)
 			break;
@@ -6196,7 +6213,7 @@ static ssize_t nfs4_get_acl_uncached(struct inode *inode, void *buf,
 }
 
 static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen,
-				 enum nfs4_acl_type type)
+				 enum nfs4_acl_type type, struct nfs4_acl *acl)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	int ret;
@@ -6210,12 +6227,23 @@ static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen,
 		return ret;
 	if (NFS_I(inode)->cache_validity & NFS_INO_INVALID_ACL)
 		nfs_zap_acl_cache(inode);
+	/* Must get ACL if @acl != NULL, frontend NFS layer will cache it */
+	if (acl != NULL)
+		goto get_acl_uncached;
 	ret = nfs4_read_cached_acl(inode, buf, buflen, type);
 	if (ret != -ENOENT)
 		/* -ENOENT is returned if there is no ACL or if there is an ACL
 		 * but no cached acl data, just the acl length */
 		return ret;
-	return nfs4_get_acl_uncached(inode, buf, buflen, type);
+get_acl_uncached:
+	return nfs4_get_acl_uncached(inode, buf, buflen, type, acl);
+}
+
+static int nfs4_get_nfs4_acl(struct inode *inode, struct nfs4_acl *acl)
+{
+	if (!nfs4_server_supports_acls(NFS_SERVER(inode), acl->type))
+		return -EOPNOTSUPP;
+	return nfs4_proc_get_acl(inode, NULL, acl->len, acl->type, acl);
 }
 
 static int __nfs4_proc_set_acl(struct inode *inode, const void *buf,
@@ -7977,7 +8005,7 @@ static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
 				   const char *key, void *buf, size_t buflen)
 {
-	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_ACL);
+	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_ACL, NULL);
 }
 
 static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
@@ -8001,7 +8029,7 @@ static int nfs4_xattr_get_nfs4_dacl(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, void *buf, size_t buflen)
 {
-	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_DACL);
+	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_DACL, NULL);
 }
 
 static bool nfs4_xattr_list_nfs4_dacl(struct dentry *dentry)
@@ -8024,7 +8052,7 @@ static int nfs4_xattr_get_nfs4_sacl(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, void *buf, size_t buflen)
 {
-	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_SACL);
+	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_SACL, NULL);
 }
 
 static bool nfs4_xattr_list_nfs4_sacl(struct dentry *dentry)
@@ -11041,6 +11069,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.enable_swap	= nfs4_enable_swap,
 	.disable_swap	= nfs4_disable_swap,
 	.set_nfs4_acl	= nfs4_set_nfs4_acl,
+	.get_nfs4_acl	= nfs4_get_nfs4_acl,
 };
 
 static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 47cb3b140640..4be2a40c7fc5 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1848,6 +1848,7 @@ struct nfs_rpc_ops {
 	void	(*enable_swap)(struct inode *inode);
 	void	(*disable_swap)(struct inode *inode);
 	int	(*set_nfs4_acl)(struct inode *, struct nfs4_acl *);
+	int	(*get_nfs4_acl)(struct inode *, struct nfs4_acl *);
 };
 
 /*
-- 
2.44.0


