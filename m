Return-Path: <linux-nfs+bounces-22896-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ywYHE4tURGruswoAu9opvQ
	(envelope-from <linux-nfs+bounces-22896-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 01:43:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A55606E8B00
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 01:43:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fDmXp+uz;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22896-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22896-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC303074696
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 23:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095A330B07;
	Tue, 30 Jun 2026 23:43:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100D334695
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 23:43:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862981; cv=none; b=ht5KLQ35Y11PN065BaRn57NxJUIFnIgPHay+nMC3ndBxQrZi+LePONes37tIaXpRwIJlObQm6uu5GK3KtMII6CNvnendun6OyWK8N3wQQnu2jieW75up4teKY6sORrNZcsofb6HZktqE3fGnyo5IbFcW08zVwy9tBuupQB5s4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862981; c=relaxed/simple;
	bh=epL/EAtXYU7QXgDdYJrfDm/MrDkGmYk3dhcP5CmYj4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRBcIW6L3upViNL+LH70zSLqMZ3sZ+jmHUUhqC8mqe5FxteapATPtWsnzZUr7SsXZVj2udcJwisDu0dtqoVtlpdA7zT1ca449H+Zkz9b2hm4w04rUrjl8nFkniNw9Qk64+dZL7s5GT6NCJ16cVu7VxOiw3eyc/+BB59GJwAxJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDmXp+uz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86F31F00A3A;
	Tue, 30 Jun 2026 23:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862979;
	bh=x+P9ej4zki9zxEVrNsAhJq5UQ5Z1GqKpA32rSzhJEPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fDmXp+uzsCew36zVXuHGw9BLD+/anqAibdhsOj/j1nasR115D8jNuqsjHzZzL56bF
	 +EPP3mBBx1VhkBYqUwchCynqjpsXBwaigDIUI+yqNEfcIFKKgWtn3YIA2kHtcresJA
	 LuPZETjeNSBnG1wGuzEAyOakGlAU5gqTk/4w9M7c7XfOM81NR3zjzqQusOTRc+FdrD
	 ZKe70E2k5UYp54KNDEOlm4r4+99KkkbOwGrWhw7JSfSwl7LHG5SgD4Ls+BZWlhPxXD
	 mYh5oHUiX1fXBDgZdedNkXc9Qo/b6SpRjdVTuQnGt0mSsq/gRlAXhWinLQfo2RqSLu
	 c8YonIzoad70w==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/6] nfs4.2: add UNCACHEABLE_FILE_DATA attribute support
Date: Tue, 30 Jun 2026 19:42:52 -0400
Message-ID: <20260630234257.5615-2-snitzer@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22896-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,vger.kernel.org:server fail,ietf.org:server fail,hammerspace.com:server fail];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ietf.org:url,hammerspace.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A55606E8B00

From: Tom Haynes <loghyr@hammerspace.com>

Recognize the NFSv4.2 per-file UNCACHEABLE_FILE_DATA attribute (attr 87,
draft-ietf-nfsv4-uncacheable-files): decode it via GETATTR, track per-
exported-filesystem support, and record on the inode whether a regular
file's data must not be cached.  Acting on the attribute (opening such
files O_DIRECT) is done by a subsequent change.

If the NFSv4 server reports a regular file's UNCACHEABLE_FILE_DATA as
true, it indicates the file's data must not be cached; the client records
this in NFS_I(inode)->uncacheable_file_data for use by the I/O paths.

The UNCACHEABLE_FILE_DATA attribute applies only to regular files
(NF4REG); per the draft a server MUST reject a query of it on any other
object type with NFS4ERR_INVAL.  A subsequent commit gates the client
accordingly.

See: https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-files/

Signed-off-by: Tom Haynes <loghyr@hammerspace.com>
[snitzer: adapt Tom's original code focused on metadata for ABE]
Co-developed-by: Mike Snitzer <snitzer@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 fs/nfs/inode.c          | 22 +++++++++++++++++++---
 fs/nfs/nfs4proc.c       | 13 +++++++++++--
 fs/nfs/nfs4trace.h      |  3 ++-
 fs/nfs/nfs4xdr.c        | 35 ++++++++++++++++++++++++++++++++++-
 fs/nfs/nfstrace.h       |  3 ++-
 include/linux/nfs4.h    |  9 +++++++++
 include/linux/nfs_fs.h  |  3 +++
 include/linux/nfs_xdr.h |  8 +++++++-
 8 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 5bcd4027d203..68a1d97d9560 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -507,6 +507,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		inode->i_blocks = 0;
 		nfsi->write_io = 0;
 		nfsi->read_io = 0;
+		nfsi->uncacheable_file_data = false;
 
 		nfsi->read_cache_jiffies = fattr->time_start;
 		nfsi->attr_gencount = fattr->gencount;
@@ -561,6 +562,11 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		} else if (fattr_supported & NFS_ATTR_FATTR_SPACE_USED &&
 			   fattr->size != 0)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
+		if (fattr->valid & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
+			nfsi->uncacheable_file_data =
+				fattr->aux_flags & NFS_AUX_UNCACHEABLE_FILE_DATA;
+		else if (fattr_supported & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_UNCACHEABLE_FILE_DATA);
 
 		nfs_setsecurity(inode, fattr);
 
@@ -1975,7 +1981,8 @@ static int nfs_inode_finish_partial_attr_update(const struct nfs_fattr *fattr,
 		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
 		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
 		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
-		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
+		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME |
+		NFS_INO_INVALID_UNCACHEABLE_FILE_DATA;
 	unsigned long cache_validity = NFS_I(inode)->cache_validity;
 	enum nfs4_change_attr_type ctype = NFS_SERVER(inode)->change_attr_type;
 
@@ -2297,7 +2304,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR
 			| NFS_INO_INVALID_ATIME
 			| NFS_INO_REVAL_FORCED
-			| NFS_INO_INVALID_BLOCKS);
+			| NFS_INO_INVALID_BLOCKS
+			| NFS_INO_INVALID_UNCACHEABLE_FILE_DATA);
 
 	/* Do atomic weak cache consistency updates */
 	nfs_wcc_update_inode(inode, fattr);
@@ -2337,7 +2345,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_NLINK
 					| NFS_INO_INVALID_MODE
 					| NFS_INO_INVALID_OTHER
-					| NFS_INO_INVALID_BTIME;
+					| NFS_INO_INVALID_BTIME
+					| NFS_INO_INVALID_UNCACHEABLE_FILE_DATA;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
 				attr_changed = true;
@@ -2461,6 +2470,13 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_BLOCKS;
 
+	if (fattr->valid & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
+		nfsi->uncacheable_file_data =
+				fattr->aux_flags & NFS_AUX_UNCACHEABLE_FILE_DATA;
+	else if (fattr_supported & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_UNCACHEABLE_FILE_DATA;
+
 	/* Update attrtimeo value if we're out of the unstable period */
 	if (attr_changed) {
 		nfs_inc_stats(inode, NFSIOS_ATTRINVALIDATE);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1360409d8de9..2c1775f458a1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -228,6 +228,7 @@ const u32 nfs4_fattr_bitmap[3] = {
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	FATTR4_WORD2_SECURITY_LABEL
 #endif
+	| FATTR4_WORD2_UNCACHEABLE_FILE_DATA
 };
 
 static const u32 nfs4_pnfs_open_bitmap[3] = {
@@ -250,6 +251,7 @@ static const u32 nfs4_pnfs_open_bitmap[3] = {
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	| FATTR4_WORD2_SECURITY_LABEL
 #endif
+	| FATTR4_WORD2_UNCACHEABLE_FILE_DATA
 };
 
 static const u32 nfs4_open_noattr_bitmap[3] = {
@@ -327,6 +329,9 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	if (!(cache_validity & NFS_INO_INVALID_BTIME))
 		dst[1] &= ~FATTR4_WORD1_TIME_CREATE;
 
+	if (!(cache_validity & NFS_INO_INVALID_UNCACHEABLE_FILE_DATA))
+		dst[2] &= ~FATTR4_WORD2_UNCACHEABLE_FILE_DATA;
+
 	if (nfs_have_delegated_mtime(inode)) {
 		if (!(cache_validity & NFS_INO_INVALID_ATIME))
 			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
@@ -1238,7 +1243,7 @@ nfs4_update_changeattr_locked(struct inode *inode,
 				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
 				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
 				NFS_INO_INVALID_MODE | NFS_INO_INVALID_BTIME |
-				NFS_INO_INVALID_XATTR;
+				NFS_INO_INVALID_XATTR | NFS_INO_INVALID_UNCACHEABLE_FILE_DATA;
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	}
 	nfsi->attrtimeo_timestamp = jiffies;
@@ -3857,7 +3862,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 
 #define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
-#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_OPEN_ARGUMENTS - 1UL)
+#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_UNCACHEABLE_FILE_DATA - 1UL)
 
 #define FATTR4_WORD2_NFS42_TIME_DELEG_MASK \
 	(FATTR4_WORD2_TIME_DELEG_MODIFY|FATTR4_WORD2_TIME_DELEG_ACCESS)
@@ -3981,6 +3986,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+		if (!(res.attr_bitmask[2] & FATTR4_WORD2_UNCACHEABLE_FILE_DATA))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA;
 
 		if (res.open_caps.oa_share_access_want[0] &
 		    NFS4_SHARE_WANT_OPEN_XOR_DELEGATION)
@@ -5809,6 +5816,8 @@ void nfs4_bitmask_set(__u32 bitmask[], const __u32 src[],
 		bitmask[1] |= FATTR4_WORD1_SPACE_USED;
 	if (cache_validity & NFS_INO_INVALID_BTIME)
 		bitmask[1] |= FATTR4_WORD1_TIME_CREATE;
+	if (cache_validity & NFS_INO_INVALID_UNCACHEABLE_FILE_DATA)
+		bitmask[2] |= FATTR4_WORD2_UNCACHEABLE_FILE_DATA;
 
 	if (cache_validity & NFS_INO_INVALID_SIZE)
 		bitmask[0] |= FATTR4_WORD0_SIZE;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 1ed677810d9d..3298dab34a78 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -33,7 +33,8 @@
 		{ NFS_ATTR_FATTR_CHANGE, "CHANGE" }, \
 		{ NFS_ATTR_FATTR_OWNER_NAME, "OWNER_NAME" }, \
 		{ NFS_ATTR_FATTR_GROUP_NAME, "GROUP_NAME" }, \
-		{ NFS_ATTR_FATTR_BTIME, "BTIME" })
+		{ NFS_ATTR_FATTR_BTIME, "BTIME" }, \
+		{ NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA, "UNCACHEABLE_FILE_DATA" })
 
 DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_PROTO(
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c23c2eee1b5c..fc049ce4ba8a 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -120,7 +120,8 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				3*nfstime4_maxsz + \
 				nfs4_owner_maxsz + \
 				nfs4_group_maxsz + nfs4_label_maxsz + \
-				 decode_mdsthreshold_maxsz))
+				 decode_mdsthreshold_maxsz + \
+				 1)) /* uncacheable_file_data */
 #define nfs4_fattr_maxsz	(nfs4_fattr_bitmap_maxsz + \
 				nfs4_fattr_value_maxsz)
 #define decode_getattr_maxsz    (op_decode_hdr_maxsz + nfs4_fattr_maxsz)
@@ -4380,6 +4381,30 @@ static int decode_attr_open_arguments(struct xdr_stream *xdr, uint32_t *bitmap,
 	return 0;
 }
 
+static int decode_attr_uncacheable_file_data(struct xdr_stream *xdr, uint32_t *bitmap,
+				   uint32_t *res, uint64_t *flags)
+{
+	int status = 0;
+	__be32 *p;
+
+	if (unlikely(bitmap[2] & (FATTR4_WORD2_UNCACHEABLE_FILE_DATA - 1U)))
+		return -EIO;
+	if (likely(bitmap[2] & FATTR4_WORD2_UNCACHEABLE_FILE_DATA)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		if (be32_to_cpup(p))
+			*res |= NFS_AUX_UNCACHEABLE_FILE_DATA;
+		else
+			*res &= ~NFS_AUX_UNCACHEABLE_FILE_DATA;
+		bitmap[2] &= ~FATTR4_WORD2_UNCACHEABLE_FILE_DATA;
+		*flags |= NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA;
+	}
+	dprintk("%s: uncacheable_file_data: =%s\n", __func__,
+		(*res & NFS_AUX_UNCACHEABLE_FILE_DATA) == 0 ? "false" : "true");
+	return status;
+}
+
 static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -4725,6 +4750,8 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 	uint32_t type;
 	int32_t err;
 
+	fattr->aux_flags = 0;
+
 	status = decode_attr_type(xdr, bitmap, &type);
 	if (status < 0)
 		goto xdr_error;
@@ -4843,6 +4870,12 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 		goto xdr_error;
 	fattr->valid |= status;
 
+	status = decode_attr_uncacheable_file_data(xdr, bitmap, &fattr->aux_flags,
+					 &fattr->valid);
+	if (status < 0)
+		goto xdr_error;
+
+	status = 0;
 xdr_error:
 	dprintk("%s: xdr returned %d\n", __func__, -status);
 	return status;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 4ada21f4eebd..b15c1732c869 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -33,7 +33,8 @@
 			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" }, \
 			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" }, \
 			{ NFS_INO_INVALID_MODE, "INVALID_MODE" }, \
-			{ NFS_INO_INVALID_BTIME, "INVALID_BTIME" })
+			{ NFS_INO_INVALID_BTIME, "INVALID_BTIME" }, \
+			{ NFS_INO_INVALID_UNCACHEABLE_FILE_DATA, "INVALID_UNCACHEABLE_FILE_DATA" })
 
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 44e5e9fa12e1..1a3981c26b23 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -389,6 +389,14 @@ enum {
 	FATTR4_XATTR_SUPPORT		= 82,
 };
 
+/*
+ * Symbol name and value are from draft-ietf-nfsv4-uncacheable-files
+ * Section 7.  "XDR for Uncacheable Attribute"
+ */
+enum {
+	FATTR4_UNCACHEABLE_FILE_DATA	= 87,
+};
+
 /*
  * The following internal definitions enable processing the above
  * attribute bits within 32-bit word boundaries.
@@ -475,6 +483,7 @@ enum {
 #define FATTR4_WORD2_ACL_TRUEFORM_SCOPE	BIT(FATTR4_ACL_TRUEFORM_SCOPE - 64)
 #define FATTR4_WORD2_POSIX_DEFAULT_ACL	BIT(FATTR4_POSIX_DEFAULT_ACL - 64)
 #define FATTR4_WORD2_POSIX_ACCESS_ACL	BIT(FATTR4_POSIX_ACCESS_ACL - 64)
+#define FATTR4_WORD2_UNCACHEABLE_FILE_DATA	BIT(FATTR4_UNCACHEABLE_FILE_DATA - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index ec17e602c979..8552a0d778d9 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -162,6 +162,8 @@ struct nfs_inode {
 
 	struct timespec64	btime;
 
+	bool			uncacheable_file_data : 1;
+
 	/*
 	 * read_cache_jiffies is when we started read-caching this inode.
 	 * attrtimeo is for how long the cached information is assumed
@@ -319,6 +321,7 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
 #define NFS_INO_INVALID_MODE	BIT(17)		/* cached mode is invalid */
 #define NFS_INO_INVALID_BTIME	BIT(18)		/* cached btime is invalid */
+#define NFS_INO_INVALID_UNCACHEABLE_FILE_DATA	BIT(19)		/* cached uncacheable_file_data is invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 11c5b31cfc7d..2e1987ac403d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -17,6 +17,9 @@
 
 #define NFS_BITMASK_SZ		3
 
+/* aux_flags in nfs_fattr */
+#define NFS_AUX_UNCACHEABLE_FILE_DATA	BIT(0)
+
 struct nfs4_string {
 	unsigned int len;
 	char *data;
@@ -68,6 +71,7 @@ struct nfs_fattr {
 	struct timespec64	mtime;
 	struct timespec64	ctime;
 	struct timespec64	btime;
+	__u32			aux_flags;	/* NFSv4 auxiliary flags bitfield */
 	__u64			change_attr;	/* NFSv4 change attribute */
 	__u64			pre_change_attr;/* pre-op NFSv4 change attribute */
 	__u64			pre_size;	/* pre_op_attr.size	  */
@@ -108,6 +112,7 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_GROUP_NAME	BIT_ULL(24)
 #define NFS_ATTR_FATTR_V4_SECURITY_LABEL BIT_ULL(25)
 #define NFS_ATTR_FATTR_BTIME		BIT_ULL(26)
+#define NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA	BIT_ULL(27)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
@@ -129,7 +134,8 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_V4 (NFS_ATTR_FATTR \
 		| NFS_ATTR_FATTR_SPACE_USED \
 		| NFS_ATTR_FATTR_BTIME \
-		| NFS_ATTR_FATTR_V4_SECURITY_LABEL)
+		| NFS_ATTR_FATTR_V4_SECURITY_LABEL \
+		| NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
 
 /*
  * Maximal number of supported layout drivers.
-- 
2.47.3


