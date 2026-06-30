Return-Path: <linux-nfs+bounces-22897-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CKP5JZBURGr0swoAu9opvQ
	(envelope-from <linux-nfs+bounces-22897-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 01:43:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCEB6E8B05
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 01:43:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UVUwXD9F;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22897-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22897-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD4A4307D2F6
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D8E334695;
	Tue, 30 Jun 2026 23:43:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525931715B
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 23:43:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862982; cv=none; b=vC6exIt4MXfEkQ1KeT40cIh7MuPODGC4AKkh/YkNrvN7vHc4h3rKBNccBsmheheTeSA2L5AbiL79SmkY5uEZ2McJKCdFWmjoPtOeZw2QB86rGPDID9JECpyzn65h/e+2lt/Co5LTdtPmvEj0cdp5VNzi0xwYozOP5xcSjikYJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862982; c=relaxed/simple;
	bh=a26TnWSEzoKMS1Ri1k3nDvRVpoNIJ4uSQLCp7LMBMUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2J0hgBidEk0NJ9LG9ANSBHqHS2k1ArGUmFOXBc+RrY7oc9s1q7HVTCYxw/tGs5/gGIY9MptBbAAS1QOignwZvxJ4SkWQM0MkanYkAvEPXfxw9WDJaf1Nea4vHnzXcQQAKa1tdHQ3Gp/tRokwXVf35nQWaR599/kcGlTvGdu4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVUwXD9F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022E41F000E9;
	Tue, 30 Jun 2026 23:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862981;
	bh=wdtWkEb5zOKpJYpARHtxNjMnpU5W+YUDgFbn2KdKMK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVUwXD9FdKV6MkJMRi2iCnB3/Pux2lbbrofVi4e5SfOKkH4qwAXLKGaV9X1U3L+91
	 JfoRaV1KRgdlxnQfIroyBaKBrP1TSHQj2yJVqZ7fFfaogPrUQSRFgjytzZg//P+5Ps
	 1poyRagJIf/QrMrFQO9B1Psbw1tJqxmfgFPRLAlOmvUx+scxs7n23KAFXhlR9KHeJt
	 PXMZn1ZERZsh8nOA+B0KdmxJ0Rui7a7bzVobsler9RuEfzEvoJATNDQSdpmnrpAzkd
	 OBDCTB0S15hqNvJ/HAtj33/V+tAPb+XHr+jiaHgQ5E04fLyScehqDqr9q3dvMweUm+
	 GN+R09ZRR86Tg==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/6] nfs4.2: request UNCACHEABLE_FILE_DATA only for regular files
Date: Tue, 30 Jun 2026 19:42:53 -0400
Message-ID: <20260630234257.5615-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260630234257.5615-1-snitzer@kernel.org>
References: <20260630234257.5615-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22897-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,vger.kernel.org:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECCEB6E8B05

The UNCACHEABLE_FILE_DATA attribute applies only to regular files
(NF4REG); per draft-ietf-nfsv4-uncacheable-files a server MUST reject a
query of it on any other object type with NFS4ERR_INVAL.  The previous
commit decodes and tracks the attribute but does not gate it: the bit
rides in the per-server attribute bitmask (server->attr_bitmask) and in
the generic getattr request bitmap (nfs4_fattr_bitmap), so it would be
requested for non-regular objects too -- e.g. a plain directory GETATTR,
a LOOKUP that resolves to a directory, or a CREATE (which only ever makes
non-regular objects).  A strict server would fail those compounds.

Gate the client accordingly:

 - Only set NFS_INO_INVALID_UNCACHEABLE_FILE_DATA on regular-file inodes,
   so the attribute is never (re)requested for directories or other
   non-regular objects via the delegation GETATTR or nfs4_bitmask_set()
   refresh paths.

 - Gate the request by object type at the single choke point
   nfs4_bitmap_copy_adjust(), which clears
   FATTR4_WORD2_UNCACHEABLE_FILE_DATA unless the target inode is a
   regular file (a NULL inode -- unknown object type -- clears it too).
   This already covers GETATTR, SETATTR and LINK; route LOOKUP, LOOKUPP
   and CREATE through it as well.

The bit is kept in server->attr_bitmask (it is server-supported, and OPEN
still requests it via its regular-file-only open_bitmap), so no bespoke
per-data-file bitmask plumbing is needed.  The remaining getattr-bearing
compounds are already safe: ACCESS, DELEGRETURN, WRITE, CLOSE and
LAYOUTCOMMIT use server->cache_consistency_bitmask (no word2 attributes)
or operate on regular files; READDIR does not encode the bit; and
LOOKUP_ROOT, FSINFO, STATFS and PATHCONF use fixed bitmaps without it.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 fs/nfs/inode.c    |  6 ++++--
 fs/nfs/nfs4proc.c | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 68a1d97d9560..bb6e58123341 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -565,7 +565,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		if (fattr->valid & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
 			nfsi->uncacheable_file_data =
 				fattr->aux_flags & NFS_AUX_UNCACHEABLE_FILE_DATA;
-		else if (fattr_supported & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
+		else if (S_ISREG(inode->i_mode) &&
+			 (fattr_supported & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_UNCACHEABLE_FILE_DATA);
 
 		nfs_setsecurity(inode, fattr);
@@ -2473,7 +2474,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	if (fattr->valid & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
 		nfsi->uncacheable_file_data =
 				fattr->aux_flags & NFS_AUX_UNCACHEABLE_FILE_DATA;
-	else if (fattr_supported & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
+	else if (S_ISREG(inode->i_mode) &&
+		 (fattr_supported & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA))
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_UNCACHEABLE_FILE_DATA;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2c1775f458a1..c8b777465ded 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -308,6 +308,15 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	unsigned long cache_validity;
 
 	memcpy(dst, src, NFS4_BITMASK_SZ*sizeof(*dst));
+	/*
+	 * The uncacheable_file_data attribute applies only to regular files
+	 * (NF4REG); a server must reject a query of it on any other object
+	 * type with NFS4ERR_INVAL.  Never request it unless the target is
+	 * known to be a regular file (callers with an unknown object type,
+	 * e.g. LOOKUP, pass a NULL inode).
+	 */
+	if (!inode || !S_ISREG(inode->i_mode))
+		dst[2] &= ~FATTR4_WORD2_UNCACHEABLE_FILE_DATA;
 	if (!inode || !nfs_have_read_or_write_delegation(inode))
 		return;
 
@@ -4598,6 +4607,7 @@ static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 		.rpc_resp = &res,
 	};
 	unsigned short task_flags = 0;
+	__u32 bitmask[NFS4_BITMASK_SZ];
 
 	if (nfs_server_capable(dir, NFS_CAP_MOVEABLE))
 		task_flags = RPC_TASK_MOVEABLE;
@@ -4606,7 +4616,13 @@ static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 	if (nfs_lookup_is_soft_revalidate(dentry))
 		task_flags |= RPC_TASK_TIMEOUT;
 
-	args.bitmask = nfs4_bitmask(server, fattr->label);
+	/*
+	 * The looked-up object's type is unknown here, so gate out the
+	 * regular-file-only uncacheable_file_data attribute (NULL inode).
+	 */
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, fattr->label),
+				NULL, 0);
+	args.bitmask = bitmask;
 
 	nfs_fattr_init(fattr);
 
@@ -4720,13 +4736,20 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 		.rpc_resp = &res,
 	};
 	unsigned short task_flags = 0;
+	__u32 bitmask[NFS4_BITMASK_SZ];
 
 	if (server->flags & NFS_MOUNT_SOFTREVAL)
 		task_flags |= RPC_TASK_TIMEOUT;
 	if (server->caps & NFS_CAP_MOVEABLE)
 		task_flags |= RPC_TASK_MOVEABLE;
 
-	args.bitmask = nfs4_bitmask(server, fattr->label);
+	/*
+	 * The looked-up object's type is unknown here, so gate out the
+	 * regular-file-only uncacheable_file_data attribute (NULL inode).
+	 */
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, fattr->label),
+				NULL, 0);
+	args.bitmask = bitmask;
 
 	nfs_fattr_init(fattr);
 	nfs4_init_sequence(server->nfs_client, &args.seq_args, &res.seq_res, 0, 0);
@@ -5141,6 +5164,7 @@ struct nfs4_createdata {
 	struct nfs4_create_res res;
 	struct nfs_fh fh;
 	struct nfs_fattr fattr;
+	u32 bitmask[NFS4_BITMASK_SZ];
 };
 
 static struct nfs4_createdata *nfs4_alloc_createdata(struct inode *dir,
@@ -5164,7 +5188,14 @@ static struct nfs4_createdata *nfs4_alloc_createdata(struct inode *dir,
 		data->arg.name = name;
 		data->arg.attrs = sattr;
 		data->arg.ftype = ftype;
-		data->arg.bitmask = nfs4_bitmask(server, data->fattr.label);
+		/*
+		 * CREATE only makes non-regular objects, so gate out the
+		 * regular-file-only uncacheable_file_data attribute (NULL inode).
+		 */
+		nfs4_bitmap_copy_adjust(data->bitmask,
+					nfs4_bitmask(server, data->fattr.label),
+					NULL, 0);
+		data->arg.bitmask = data->bitmask;
 		data->arg.umask = current_umask();
 		data->res.server = server;
 		data->res.fh = &data->fh;
-- 
2.47.3


