Return-Path: <linux-nfs+bounces-19196-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GqHHUL7nWmeSwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19196-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634C18C0BA
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E537830763DB
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6513EBF1F;
	Tue, 24 Feb 2026 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVAArOVz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC062E5418
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961092; cv=none; b=UwA5maROusbG48ZSTnie9CBw7sbpGrU+3IVbIuAz/SenlYV8XWUNMyOeTR3lvBnIs0DBvVNFC4TEcMuEC7+tK4HMJYoUBfnmdYriUzXGOe8hqCpCxcHEYl0e43pUPo3PmeTT68FsF/LgPZ9r2nnnAVUHZF0XuNgtilwX9iB8Acw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961092; c=relaxed/simple;
	bh=+jJGotUIlZ52+cK0jJnTFrnhkLrzKyj8zSCPPrU40sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv5CIqG3zZHGoAOtb/9KhTrP9vPh2KOK0PMq+mxezmIuIrTdwo380cUppJ8S8q51+DJ9GU/9Zi1hGyhdVEQGmHHXvKQ54gFuUxhZgafrpUkvwO9bpIHQ8Zj6qLnN7cynUfJ3g87J6rCuEyvsgrtTksrL4WUlwnWDtkQUTUK6QJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVAArOVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01A9C19423;
	Tue, 24 Feb 2026 19:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961091;
	bh=+jJGotUIlZ52+cK0jJnTFrnhkLrzKyj8zSCPPrU40sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVAArOVzYYGGezmRQq2zy2B9sofoy45lAMTZzYRABJnu6MrsdwBQUXDYllnQnyuJF
	 t599Ub9qdJsFfrJY84MeohOPwC+fDBOFnVsjSQM1+UU/CTETQ3pK9QApGY1dJDiJhr
	 BFllArffkBu5Ty0lo2/ecbVLrxHO4A4A2/1iONZqux9dCaWHyCHLISW0qZwhZQAlcU
	 Rc7usHQ2FcV/0imFgrGvoeDsCrpV2ZFoqbePit8Sly1c+vYSxRmRCmaF0UK6keoXIj
	 4rOTTnc9Z99m2uRsUhlbKtf+R4fkFT0jnfvB27fBTeZbi8gVlivhu/bZ7gAsUMWYMP
	 ashmyXycMnZeA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 09/11] NFSv4: add reexport support for SETACL nfs4_acl passthru
Date: Tue, 24 Feb 2026 14:24:36 -0500
Message-ID: <20260224192438.25351-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260224192438.25351-1-snitzer@kernel.org>
References: <20260224192438.25351-1-snitzer@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19196-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 1634C18C0BA
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Wire up the export_operations .setacl hook and use the upper layer
provided nfs4_acl's pages in the call to NFSPROC4_CLNT_SETACL.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/export.c         | 10 ++++++++++
 fs/nfs/nfs4proc.c       | 33 +++++++++++++++++++++++++++------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  3 +++
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index a10dd5f9d078..9a90eee3e433 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -152,10 +152,20 @@ nfs_get_parent(struct dentry *dentry)
 	return parent;
 }
 
+static int nfs_set_nfs4_acl(struct inode *inode, struct nfs4_acl *acl)
+{
+	const struct nfs_rpc_ops *rpc_ops = NFS_SERVER(inode)->nfs_client->rpc_ops;
+
+	if (rpc_ops->set_nfs4_acl == NULL)
+		return -EOPNOTSUPP;
+	return rpc_ops->set_nfs4_acl(inode, acl);
+}
+
 const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
+	.setacl = nfs_set_nfs4_acl,
 	.flags = EXPORT_OP_NOWCC		|
 		 EXPORT_OP_NOSUBTREECHK		|
 		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91bcf67bd743..a71be8fcc893 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6165,7 +6165,8 @@ static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen,
 }
 
 static int __nfs4_proc_set_acl(struct inode *inode, const void *buf,
-			       size_t buflen, enum nfs4_acl_type type)
+			       size_t buflen, enum nfs4_acl_type type,
+			       struct nfs4_acl *acl)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct page *pages[NFS4ACL_MAXPAGES];
@@ -6173,6 +6174,7 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf,
 		.fh = NFS_FH(inode),
 		.acl_type = type,
 		.acl_len = buflen,
+		.acl_pgbase = 0,
 		.acl_pages = pages,
 	};
 	struct nfs_setaclres res;
@@ -6184,6 +6186,15 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf,
 	unsigned int npages = DIV_ROUND_UP(buflen, PAGE_SIZE);
 	int ret, i;
 
+	if (acl != NULL) {
+		arg.acl_len = acl->len;
+		arg.acl_pgbase = acl->pgbase;
+		arg.acl_pages = acl->pages;
+		nfs4_inode_make_writeable(inode);
+		ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
+		goto out;
+	}
+
 	/* You can't remove system.nfs4_acl: */
 	if (buflen == 0)
 		return -EINVAL;
@@ -6208,6 +6219,7 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf,
 	 * Acl update can result in inode attribute update.
 	 * so mark the attribute cache invalid.
 	 */
+out:
 	spin_lock(&inode->i_lock);
 	nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
 					     NFS_INO_INVALID_CTIME |
@@ -6219,7 +6231,8 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf,
 }
 
 static int nfs4_proc_set_acl(struct inode *inode, const void *buf,
-			     size_t buflen, enum nfs4_acl_type type)
+			     size_t buflen, enum nfs4_acl_type type,
+			     struct nfs4_acl *acl)
 {
 	struct nfs4_exception exception = { };
 	int err;
@@ -6227,7 +6240,7 @@ static int nfs4_proc_set_acl(struct inode *inode, const void *buf,
 	if (unlikely(NFS_FH(inode)->size == 0))
 		return -ENODATA;
 	do {
-		err = __nfs4_proc_set_acl(inode, buf, buflen, type);
+		err = __nfs4_proc_set_acl(inode, buf, buflen, type, acl);
 		trace_nfs4_set_acl(inode, err);
 		if (err == -NFS4ERR_BADOWNER || err == -NFS4ERR_BADNAME) {
 			/*
@@ -6243,6 +6256,13 @@ static int nfs4_proc_set_acl(struct inode *inode, const void *buf,
 	return err;
 }
 
+static int nfs4_set_nfs4_acl(struct inode *inode, struct nfs4_acl *acl)
+{
+	if (!nfs4_server_supports_acls(NFS_SERVER(inode), acl->type))
+		return -EOPNOTSUPP;
+	return nfs4_proc_set_acl(inode, NULL, 0, acl->type, acl);
+}
+
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 static int _nfs4_get_security_label(struct inode *inode, void *buf,
 					size_t buflen)
@@ -7804,7 +7824,7 @@ static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
 				   const char *key, const void *buf,
 				   size_t buflen, int flags)
 {
-	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_ACL);
+	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_ACL, NULL);
 }
 
 static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *handler,
@@ -7827,7 +7847,7 @@ static int nfs4_xattr_set_nfs4_dacl(const struct xattr_handler *handler,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
 {
-	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_DACL);
+	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_DACL, NULL);
 }
 
 static int nfs4_xattr_get_nfs4_dacl(const struct xattr_handler *handler,
@@ -7850,7 +7870,7 @@ static int nfs4_xattr_set_nfs4_sacl(const struct xattr_handler *handler,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
 {
-	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_SACL);
+	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_SACL, NULL);
 }
 
 static int nfs4_xattr_get_nfs4_sacl(const struct xattr_handler *handler,
@@ -10683,6 +10703,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.discover_trunking = nfs4_discover_trunking,
 	.enable_swap	= nfs4_enable_swap,
 	.disable_swap	= nfs4_disable_swap,
+	.set_nfs4_acl	= nfs4_set_nfs4_acl,
 };
 
 static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c23c2eee1b5c..cd01b1c6610a 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1722,7 +1722,7 @@ static void encode_setacl(struct xdr_stream *xdr,
 	encode_nfs4_stateid(xdr, &zero_stateid);
 	xdr_encode_bitmap4(xdr, bitmap, ARRAY_SIZE(bitmap));
 	encode_uint32(xdr, arg->acl_len);
-	xdr_write_pages(xdr, arg->acl_pages, 0, arg->acl_len);
+	xdr_write_pages(xdr, arg->acl_pages, arg->acl_pgbase, arg->acl_len);
 }
 
 static void
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 3260d3116127..a86ed4532465 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -833,6 +833,7 @@ struct nfs_setaclargs {
 	struct nfs_fh *			fh;
 	enum nfs4_acl_type		acl_type;
 	size_t				acl_len;
+	unsigned int			acl_pgbase;
 	struct page **			acl_pages;
 };
 
@@ -1763,6 +1764,7 @@ struct nfs_mount_info;
 struct nfs_client_initdata;
 struct nfs_pageio_descriptor;
 struct fs_context;
+struct nfs4_acl;
 
 /*
  * RPC procedure vector for NFSv2/NFSv3 demuxing
@@ -1850,6 +1852,7 @@ struct nfs_rpc_ops {
 	int	(*discover_trunking)(struct nfs_server *, struct nfs_fh *);
 	void	(*enable_swap)(struct inode *inode);
 	void	(*disable_swap)(struct inode *inode);
+	int	(*set_nfs4_acl)(struct inode *, struct nfs4_acl *);
 };
 
 /*
-- 
2.44.0


