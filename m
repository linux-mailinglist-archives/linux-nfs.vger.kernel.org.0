Return-Path: <linux-nfs+bounces-22918-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uPrKFgx8RWq+AwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22918-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:43:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D86F18C8
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=SfEHEgWm;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22918-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22918-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C39D3058B26
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186263B3C0D;
	Wed,  1 Jul 2026 20:43:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5E38F259
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2026 20:43:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938627; cv=none; b=BzBuqoNBLG4uLC7CSp4/s/dv8cI8vJkTvfuHUlQLBdBAcwW1r9VK8l0uMCVEsT17sLjtMCrbnlDqMu/wzYaaS5PcK3NrzKs/Im/k7zYABXa46t3730iP0FpZBa5x5/yWZDpRmSh2XbMvsFXedKv1EIeivf+lrlKIjBNRvGxDVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938627; c=relaxed/simple;
	bh=dLW3O5wXkGcEbNP+7hQgtSeQhGL49fmUNquhEwB+Q3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbpM+HNgAFO3sLjbtcYvnUoX4FQYEKt57RfM527gQdhnO8w1s/03qjoHzY4JY00gFAl7nyzaBie/gCcImbJ1bYCEZ0qh8Ghaupd/7AngMmQUh9Ijjyu3mAtHr0QOgDk3eA0hh08rIbfo7TG8QS1MQ2laenSB/SfnoQZXevlTUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=SfEHEgWm; arc=none smtp.client-ip=209.85.222.182
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9159951f05aso81141185a.0
        for <linux-nfs@vger.kernel.org>; Wed, 01 Jul 2026 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782938624; x=1783543424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RmIEjXrt0D4fWreSjPFU1auSTMLj89+w0dafv7p9e8=;
        b=SfEHEgWm02rzAJGyz2OHDeeQThZMostwlBylt0fM2XSKGtdrmmZuWeQdenZFBsIT6U
         CnzeZ2IeFuu8oC3F+1S+hFKEfvLbufRp3DYUfrvCxHoxoh/5SPEHrEC4kQkjr0m91bLc
         B7kE4Tp3xsbCiRsd/EJog0/AIJCkzo+U0f+bweUbNgYblJuaT2W5KnQvIpNzEfNx7haN
         uRlMWY7tkcOoXTNeL5utC8ZEh1CyZBPJjCF5Ep32R4HNfeLlS+NuLgRETJUGKJtVTfSV
         fdmKGaCd3fa4Ni38synGwIzzISOcj3qjd8nBdqEzFd6YyWvmb87h8USlzb0Zemjxzh2/
         xmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938624; x=1783543424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RmIEjXrt0D4fWreSjPFU1auSTMLj89+w0dafv7p9e8=;
        b=cRRLwnvWPRjVY7vTjJ8CUydnyHIfk/airQVHJvThi6uu4rJaVO9lRbZ3At7HWZo+yc
         Ynjxkgg41oTr6gxleJrtbgQ2i19dpLzQkgKXe/oq99y3XZFuwMZwMWJxoHSb+jBKRkNp
         ZNnm0M4pKtCx8zqpskaXwqYpaWcAjZ1wJTP/0IMPis5Ln5onGC+zC0J5vhKW6SONrXgg
         1FC9TmRcwaNfch9ECLgk2kHaewBQN5Qxl8cSQAQTcRk+VnkMtSwZoPbcFvfCSx7n+CJG
         t5O3dBSwxTzH27CEpfBvTKTU63u3QrRfbGaLYL4wck8ZXPj9WEdjtq2invRvGNT760mC
         vIzg==
X-Forwarded-Encrypted: i=1; AFNElJ9yv1xuN7LDjpFUDGGt3s82w3QhPlsnPs/SadUckr7T7zSIztFbs/irmIeJD9fsDbfyTjtnI1kf5ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM59VdhayVsZP/c3r1in6hD4EjVsDsNYOcg+WBp67WJ55orZe5
	WKbBiBbz4oJTl5cdb49vu4WweeKhbh4TYm7efY6sVf/yeHyrHXQ1Y9UnnQs6c1EtBiI=
X-Gm-Gg: AfdE7cmwOqpuYOEEMA5DZgisdmJVSLZkd2kROmqKeWCPWeWcZ0R2JTAJJuRZg081hux
	JEOb3kvcjSNMr/2zUT+x71sJTY4JtwVGbqojUGITS7bmUNCg6iOgUp9X6JGv7clpQoPGcuh5U9R
	2FgA6lr8pAca3vnHLXqCu2Jb5tw8XYKWqolOWVjHfAPnL6+m4j8wMkDAlQNtkbG+cqsz6ORA5VE
	PDKkQ6GbdqtZxZZhLSPpisa0IzCXSE6reBkeo5F1q5UYJB4EsnjNmjrIruGEm++ADlPr3Vf1lKG
	eeLb47eEB7fOhskGKRPOxocBhgoRUuziXOFnYfzELxxX7o7L7ClU759FGlNG287hZBU8CaxaZs2
	cQDUxvlU8NEDkCTfPo+k3eJQCx5sU+SKqZ8BTZM/DnCgV4HXEtDp9UlLRwn7zGLMqJ0EEEJbzF9
	vBDTkPHNvUM3qFDXAU+62lSv/tQJlAH/WU/ZQw3oR52J5KWrd8pXjLKE2GJh9wzsgVhBiKsLMop
	ks9hg==
X-Received: by 2002:a05:620a:298a:b0:92e:683f:48e2 with SMTP id af79cd13be357-92e78257ad5mr452587285a.32.1782938623856;
        Wed, 01 Jul 2026 13:43:43 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e7ffdeefasm42047785a.6.2026.07.01.13.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:43:43 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 4/6] nfs4.2: add UNCACHEABLE_DIRENT_METADATA attribute support
Date: Wed,  1 Jul 2026 16:43:35 -0400
Message-ID: <20260701204337.54314-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260701204337.54314-1-snitzer@kernel.org>
References: <20260701204337.54314-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22918-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A1D86F18C8

Recognize the NFSv4.2 per-directory UNCACHEABLE_DIRENT_METADATA attribute
(attr 88, draft-ietf-nfsv4-uncacheable-directories): decode it via
GETATTR, track per-exported-filesystem support, and record on the inode
whether a directory's directory-entry metadata must not be cached.
Honoring the attribute (refetching directory-entry metadata from the
server on each READDIR) is done by a subsequent change.

If the NFSv4 server reports a directory's UNCACHEABLE_DIRENT_METADATA as
true, it indicates the directory's directory-entry metadata must not be
cached; the client records this in
NFS_I(inode)->uncacheable_dirent_metadata for use by the readdir path.

The UNCACHEABLE_DIRENT_METADATA attribute applies only to directory
objects (NF4DIR) and is independent of the companion
UNCACHEABLE_FILE_DATA attribute (attr 87); the two govern different
aspects of client caching and may be used separately.  A subsequent
commit gates the client accordingly so the attribute is requested only
for directories.

Unlike the per-file UNCACHEABLE_FILE_DATA attribute, this directory
attribute is deliberately not tied to the cache_validity / file-delegation
machinery (nfs4_bitmap_copy_adjust()'s delegation block, nfs4_bitmask_set()):
a directory cannot hold an NFSv4 read/write (file) delegation, and per the
draft a server must recall or withhold a directory delegation while the
attribute is set, so there is never an authoritative cached state to
optimize against.  The attribute is simply requested on every directory
GETATTR and recorded on receipt.

See: https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-directories/

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 fs/nfs/inode.c          |  8 ++++++++
 fs/nfs/nfs4proc.c       |  6 +++++-
 fs/nfs/nfs4trace.h      |  3 ++-
 fs/nfs/nfs4xdr.c        | 31 ++++++++++++++++++++++++++++++-
 include/linux/nfs4.h    |  9 +++++++++
 include/linux/nfs_fs.h  |  1 +
 include/linux/nfs_xdr.h |  5 ++++-
 7 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bb6e58123341..080a9fed99ba 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -508,6 +508,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		nfsi->write_io = 0;
 		nfsi->read_io = 0;
 		nfsi->uncacheable_file_data = false;
+		nfsi->uncacheable_dirent_metadata = false;
 
 		nfsi->read_cache_jiffies = fattr->time_start;
 		nfsi->attr_gencount = fattr->gencount;
@@ -568,6 +569,9 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		else if (S_ISREG(inode->i_mode) &&
 			 (fattr_supported & NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_UNCACHEABLE_FILE_DATA);
+		if (fattr->valid & NFS_ATTR_FATTR_UNCACHEABLE_DIRENT_METADATA)
+			nfsi->uncacheable_dirent_metadata =
+				fattr->aux_flags & NFS_AUX_UNCACHEABLE_DIRENT_METADATA;
 
 		nfs_setsecurity(inode, fattr);
 
@@ -2479,6 +2483,10 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_UNCACHEABLE_FILE_DATA;
 
+	if (fattr->valid & NFS_ATTR_FATTR_UNCACHEABLE_DIRENT_METADATA)
+		nfsi->uncacheable_dirent_metadata =
+				fattr->aux_flags & NFS_AUX_UNCACHEABLE_DIRENT_METADATA;
+
 	/* Update attrtimeo value if we're out of the unstable period */
 	if (attr_changed) {
 		nfs_inc_stats(inode, NFSIOS_ATTRINVALIDATE);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3903d613f3eb..4c8436ac5cfc 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -226,6 +226,7 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD1_TIME_MODIFY
 	| FATTR4_WORD1_MOUNTED_ON_FILEID,
 	FATTR4_WORD2_UNCACHEABLE_FILE_DATA
+	| FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	| FATTR4_WORD2_SECURITY_LABEL
 #endif
@@ -252,6 +253,7 @@ static const u32 nfs4_pnfs_open_bitmap[3] = {
 	| FATTR4_WORD2_SECURITY_LABEL
 #endif
 	| FATTR4_WORD2_UNCACHEABLE_FILE_DATA
+	| FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA
 };
 
 static const u32 nfs4_open_noattr_bitmap[3] = {
@@ -3881,7 +3883,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 
 #define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
-#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_UNCACHEABLE_FILE_DATA - 1UL)
+#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA - 1UL)
 
 #define FATTR4_WORD2_NFS42_TIME_DELEG_MASK \
 	(FATTR4_WORD2_TIME_DELEG_MODIFY|FATTR4_WORD2_TIME_DELEG_ACCESS)
@@ -4007,6 +4009,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 		if (!(res.attr_bitmask[2] & FATTR4_WORD2_UNCACHEABLE_FILE_DATA))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA;
+		if (!(res.attr_bitmask[2] & FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_UNCACHEABLE_DIRENT_METADATA;
 
 		if (res.open_caps.oa_share_access_want[0] &
 		    NFS4_SHARE_WANT_OPEN_XOR_DELEGATION)
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 3298dab34a78..868c201d024f 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -34,7 +34,8 @@
 		{ NFS_ATTR_FATTR_OWNER_NAME, "OWNER_NAME" }, \
 		{ NFS_ATTR_FATTR_GROUP_NAME, "GROUP_NAME" }, \
 		{ NFS_ATTR_FATTR_BTIME, "BTIME" }, \
-		{ NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA, "UNCACHEABLE_FILE_DATA" })
+		{ NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA, "UNCACHEABLE_FILE_DATA" }, \
+		{ NFS_ATTR_FATTR_UNCACHEABLE_DIRENT_METADATA, "UNCACHEABLE_DIRENT_METADATA" })
 
 DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_PROTO(
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index fc049ce4ba8a..8329d5baf90e 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -121,7 +121,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				nfs4_owner_maxsz + \
 				nfs4_group_maxsz + nfs4_label_maxsz + \
 				 decode_mdsthreshold_maxsz + \
-				 1)) /* uncacheable_file_data */
+				 1)) /* uncacheable_file_data / dirent_metadata */
 #define nfs4_fattr_maxsz	(nfs4_fattr_bitmap_maxsz + \
 				nfs4_fattr_value_maxsz)
 #define decode_getattr_maxsz    (op_decode_hdr_maxsz + nfs4_fattr_maxsz)
@@ -4405,6 +4405,30 @@ static int decode_attr_uncacheable_file_data(struct xdr_stream *xdr, uint32_t *b
 	return status;
 }
 
+static int decode_attr_uncacheable_dirent_metadata(struct xdr_stream *xdr, uint32_t *bitmap,
+				   uint32_t *res, uint64_t *flags)
+{
+	int status = 0;
+	__be32 *p;
+
+	if (unlikely(bitmap[2] & (FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA - 1U)))
+		return -EIO;
+	if (likely(bitmap[2] & FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		if (be32_to_cpup(p))
+			*res |= NFS_AUX_UNCACHEABLE_DIRENT_METADATA;
+		else
+			*res &= ~NFS_AUX_UNCACHEABLE_DIRENT_METADATA;
+		bitmap[2] &= ~FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA;
+		*flags |= NFS_ATTR_FATTR_UNCACHEABLE_DIRENT_METADATA;
+	}
+	dprintk("%s: uncacheable_dirent_metadata: =%s\n", __func__,
+		(*res & NFS_AUX_UNCACHEABLE_DIRENT_METADATA) == 0 ? "false" : "true");
+	return status;
+}
+
 static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -4875,6 +4899,11 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 	if (status < 0)
 		goto xdr_error;
 
+	status = decode_attr_uncacheable_dirent_metadata(xdr, bitmap, &fattr->aux_flags,
+					 &fattr->valid);
+	if (status < 0)
+		goto xdr_error;
+
 	status = 0;
 xdr_error:
 	dprintk("%s: xdr returned %d\n", __func__, -status);
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 1a3981c26b23..a30905cb4118 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -397,6 +397,14 @@ enum {
 	FATTR4_UNCACHEABLE_FILE_DATA	= 87,
 };
 
+/*
+ * Symbol name and value are from draft-ietf-nfsv4-uncacheable-directories
+ * Section 8.  "XDR for Uncacheable Dirents Attribute"
+ */
+enum {
+	FATTR4_UNCACHEABLE_DIRENT_METADATA	= 88,
+};
+
 /*
  * The following internal definitions enable processing the above
  * attribute bits within 32-bit word boundaries.
@@ -484,6 +492,7 @@ enum {
 #define FATTR4_WORD2_POSIX_DEFAULT_ACL	BIT(FATTR4_POSIX_DEFAULT_ACL - 64)
 #define FATTR4_WORD2_POSIX_ACCESS_ACL	BIT(FATTR4_POSIX_ACCESS_ACL - 64)
 #define FATTR4_WORD2_UNCACHEABLE_FILE_DATA	BIT(FATTR4_UNCACHEABLE_FILE_DATA - 64)
+#define FATTR4_WORD2_UNCACHEABLE_DIRENT_METADATA	BIT(FATTR4_UNCACHEABLE_DIRENT_METADATA - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 48b806aa3a2f..887b76c2a5dd 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -164,6 +164,7 @@ struct nfs_inode {
 	struct timespec64	btime;
 
 	bool			uncacheable_file_data : 1;
+	bool			uncacheable_dirent_metadata : 1;
 
 	/*
 	 * read_cache_jiffies is when we started read-caching this inode.
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 2e1987ac403d..2018cc3c9c31 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -19,6 +19,7 @@
 
 /* aux_flags in nfs_fattr */
 #define NFS_AUX_UNCACHEABLE_FILE_DATA	BIT(0)
+#define NFS_AUX_UNCACHEABLE_DIRENT_METADATA	BIT(1)
 
 struct nfs4_string {
 	unsigned int len;
@@ -113,6 +114,7 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_V4_SECURITY_LABEL BIT_ULL(25)
 #define NFS_ATTR_FATTR_BTIME		BIT_ULL(26)
 #define NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA	BIT_ULL(27)
+#define NFS_ATTR_FATTR_UNCACHEABLE_DIRENT_METADATA	BIT_ULL(28)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
@@ -135,7 +137,8 @@ struct nfs_fattr {
 		| NFS_ATTR_FATTR_SPACE_USED \
 		| NFS_ATTR_FATTR_BTIME \
 		| NFS_ATTR_FATTR_V4_SECURITY_LABEL \
-		| NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA)
+		| NFS_ATTR_FATTR_UNCACHEABLE_FILE_DATA \
+		| NFS_ATTR_FATTR_UNCACHEABLE_DIRENT_METADATA)
 
 /*
  * Maximal number of supported layout drivers.
-- 
2.47.3


