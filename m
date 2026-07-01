Return-Path: <linux-nfs+bounces-22915-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xhKAMgF8RWq6AwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22915-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:43:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD116F18B2
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:43:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b="dtc7t/WY";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22915-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22915-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C70B300F1A3
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 20:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294938332E;
	Wed,  1 Jul 2026 20:43:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C72349CC2
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2026 20:43:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938623; cv=none; b=G5qhEx7M75YAM4yHb14lE88hWy9JnvYvN6MCfz6PYIy6eLjBWhpKP6szXdh8JqpuBOoZpSqhYiGmKunkTJuMwd913wu9cJQp/8m+pf+i8bzXufkUB7qblv3rc9NMQt89rE0hqrgCmu98fjpe5X1WvwOJtcI0Ly+XrSL5dKP+u+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938623; c=relaxed/simple;
	bh=yPzdWISJxkF8ng2eniwa76fWdHeou90xF/DUEeIFwJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G60e8ujeyKNfCEq219sRMnyk/YF+0KqNCO9E4AzlO/WozPL+99sMVvwz2izqICKCSNYyG8+/KfhYFhkWexZoxuqqNwX6POoq1Aio8NJlx5FilN8dSz2l8abmMPC1rTu4Ny3BO2dxoNNZaAcEAe2+X2N3EAC4opAlCqpp1Fu8bzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=dtc7t/WY; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8e5be46f663so7341606d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 01 Jul 2026 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782938620; x=1783543420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2Ufs50nep5IUM8BPQQZj8EaAYdRNgQEVQWDmCkfb3g=;
        b=dtc7t/WYATOBn2fKzcXvQpFBmy1MkCZRPlt0MZvDgB3no+a0mzP8COgYGYdw4B8/2r
         qVGC5NpGW/EdnHHTF176nZg36mpXPRFdr/iQqnMSxgLKbovudn79gEC2wV9YhCh9u2qa
         QsIsFyFnPNJ+UTn+uIKP86SFYGOn1B//biQNJIi6k768t+bYFEd2YepoJchfSSO5zoB8
         Rkt8FmWC3qLFHiOL1H53bhr1IzxBiaUuj//y1b/L/h4E6E6SrnD8YOjylGQgSOtKBlRx
         ZETqGi16d3viYIYgzrhzxIDeB+rSE8eeSpI0jVA4EoHsCB2pI2n1Z/afatIjLBFEpP6g
         j/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938620; x=1783543420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2Ufs50nep5IUM8BPQQZj8EaAYdRNgQEVQWDmCkfb3g=;
        b=TWfNITS596UpXuEh3JddQaRdbPJ2/lM2g4Gyqm7AZr6U6b9YuKT0/XOgpg3IODAzTB
         c6IhHvjAmKMyI1kjcwmJyXAxWEtu/DBrkT6KnQ5pm/6CABbT/PE3RFbC4HP25feq7PbB
         j7SRVu6eWBI9op1Cb6GQXXl6I7VxnbU7OQPBbgOscZRqkTDIOZZJJWnxIijOT/Fdz1a0
         Ag7LAruLHWZu2VBU6MTW6PZmry8lQxelX9J0Gca4QQg2odITduKGPzY5D2cEzMMLzYfX
         XLVMZkgE2m7oon+TcvwVifFHCUFrJEeUGC+4FUhO9cRTJqQM1/1kJfKx9viZkMqqRK+o
         w1PQ==
X-Forwarded-Encrypted: i=1; AHgh+RosZhQDmbp4G1XhdTu/rsofAnmmhYy4YBwu9ehd/JZXcB+U1UxXW/38JI7J5QU7t12saPGBjxsjgQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/NJArPrwj6z70Sq/xMxMAjEe9kFcZWAwGBQE6vlbneSXZDQh
	2lY8bLoKw1Ic7h8yr71FA7dfRYQCMtJjevCRwnj40PdqZzkaiR7IlkLqz2aS0la+Guo=
X-Gm-Gg: AfdE7clW2a0s1k7xxFRI7EBthvd58v9jy9PjvS1ANuxJukB1ERgatylx1PdBGb7EV0d
	EDXOoRLdLuyWU8jQL7GkAe7jUKWHYjtc7NSH1ht175Jm4L8kqCehQtnUbPD+0pqxkf16B4JKzfx
	OMvT9L4cldeEOrD/BbmlDpr7wv7eDJHDGmaHUArm1Wwg0IOgAA7GRdkFPXc6gqGp+QXAMxefi7u
	sDAlpg0bC+Amf4iQimYFiXIEpnsnCIu8jEEQyeSA6DWYN528MxB7uQKe/Ua70y+txIp2mLPhTT7
	SJYXRjDDjaHlDYVPdL+32c1CWTu7ffhjG/7WQGimpwzbEvdVQ2AR9TVe7Re3hmwrpSq6OHpor3h
	RBNLVhFy/oLQIQ/JMxLUOSIsGsLeIOZ0LknxHHwlcPHnZ8fX/0Pev4O6eSCRCJR3HJtqnHjpoOm
	CmMWdYIvhlvpgrFxqoSxZl8e//AlVgVuKKve7G+/K5UXCP4moUslWsEEX5/gCeN+PZC0qORRBf9
	gpNsQ==
X-Received: by 2002:a05:6214:469c:b0:8cc:dfa6:3333 with SMTP id 6a1803df08f44-8f424101cb9mr32936146d6.32.1782938620179;
        Wed, 01 Jul 2026 13:43:40 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471814408sm7204456d6.23.2026.07.01.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:43:39 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/6] nfs4.2: add UNCACHEABLE_FILE_DATA attribute support
Date: Wed,  1 Jul 2026 16:43:32 -0400
Message-ID: <20260701204337.54314-2-snitzer@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22915-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DD116F18B2

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
 fs/nfs/nfs4proc.c       | 15 ++++++++++++---
 fs/nfs/nfs4trace.h      |  3 ++-
 fs/nfs/nfs4xdr.c        | 35 ++++++++++++++++++++++++++++++++++-
 fs/nfs/nfstrace.h       |  3 ++-
 include/linux/nfs4.h    |  9 +++++++++
 include/linux/nfs_fs.h  |  3 +++
 include/linux/nfs_xdr.h |  8 +++++++-
 8 files changed, 88 insertions(+), 10 deletions(-)

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
index 1360409d8de9..ad03b8518c14 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -225,8 +225,9 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY
 	| FATTR4_WORD1_MOUNTED_ON_FILEID,
+	FATTR4_WORD2_UNCACHEABLE_FILE_DATA
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
-	FATTR4_WORD2_SECURITY_LABEL
+	| FATTR4_WORD2_SECURITY_LABEL
 #endif
 };
 
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


