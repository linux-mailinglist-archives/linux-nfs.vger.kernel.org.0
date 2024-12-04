Return-Path: <linux-nfs+bounces-8340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E6E9E31A9
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 03:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B8B283E30
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 02:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCB44AEE0;
	Wed,  4 Dec 2024 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vEASpN0D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ks8prsWx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vEASpN0D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ks8prsWx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AAF1FA4
	for <linux-nfs@vger.kernel.org>; Wed,  4 Dec 2024 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281107; cv=none; b=OGR3K7KTH6C06n0MtXO0VME0oR3XejSZW5bh1112MUt8aVnlzoZCqAed4Xq0ts3H5C0IPMD0ZCnc77Hri+lh8VG9J53tBIk8XjuidwQfRjZYhqkBr2fCD3FluDQ4Gok0/Xl8Gs30hndY5O7yDb9PG1lwzd1zF1DYukWlYjU+UXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281107; c=relaxed/simple;
	bh=AxhDN30fdp6qPksxI1F8yjP5GpG0ASoaZ2NpJ3lmycA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Utn0FZXaG/qrSBhAEhKwS5mUF4wxkhSSq1wvQ7MYEacNB6WnYJ8fuE7VioM2YiLQa2+xco495kWHLh4nSmomdyw2ccsWopGXVo8G5GnQcjrbQoirNcO0+XNYWGty9G3AnBvW01arvBDcksqgmPdvLuLPyqYptuMC1JdwhHL75z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vEASpN0D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ks8prsWx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vEASpN0D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ks8prsWx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCAB9210F8;
	Wed,  4 Dec 2024 02:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733281103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrsImjWzxHbd1/61YI8Hs2FvYEECvZSWuAhiTlAsxK8=;
	b=vEASpN0Dd1qrrO3zkavMFOI79BKM/PU2Y3NZCPKRUh597B3t/l1NQIViiLvS9ky5kQxq1s
	ghqefWIb+Gt64q8utBCzYSSSNCmC2lhfNVCZNQCAqUKDWA11bZM7XSjhhkWC5rcozJXGaD
	iLvJK2Lx7UlM0sta3vSf/WA0eXckpQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733281103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrsImjWzxHbd1/61YI8Hs2FvYEECvZSWuAhiTlAsxK8=;
	b=ks8prsWxlrdjpoCihi7APVXQxcLza8FyRUW6Y1tf6NqmBkoI2mIdWPeo9LTmS/XlM09Yx7
	/cEHKQ2B2RIMAICw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733281103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrsImjWzxHbd1/61YI8Hs2FvYEECvZSWuAhiTlAsxK8=;
	b=vEASpN0Dd1qrrO3zkavMFOI79BKM/PU2Y3NZCPKRUh597B3t/l1NQIViiLvS9ky5kQxq1s
	ghqefWIb+Gt64q8utBCzYSSSNCmC2lhfNVCZNQCAqUKDWA11bZM7XSjhhkWC5rcozJXGaD
	iLvJK2Lx7UlM0sta3vSf/WA0eXckpQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733281103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrsImjWzxHbd1/61YI8Hs2FvYEECvZSWuAhiTlAsxK8=;
	b=ks8prsWxlrdjpoCihi7APVXQxcLza8FyRUW6Y1tf6NqmBkoI2mIdWPeo9LTmS/XlM09Yx7
	/cEHKQ2B2RIMAICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C81C139C2;
	Wed,  4 Dec 2024 02:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pyjPAE7FT2dzBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 04 Dec 2024 02:58:22 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: David Disseldorp <ddiss@suse.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: fix open_owner_id_maxsz and related fields.
Date: Wed,  4 Dec 2024 13:53:09 +1100
Message-ID: <20241204025703.2662394-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204025703.2662394-1-neilb@suse.de>
References: <20241204025703.2662394-1-neilb@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

A recent change increased the size of an NFSv4 open owner, but didn't
increase the corresponding max_sz defines.  This is not know to have
caused failure, but should be fixed.

This patch also fixes some relates _maxsz fields that are wrong.

Note that the XXX_owner_id_maxsz values now are only the size of the id
and do NOT include the len field that will always preceed the id in xdr
encoding.  I think this is clearer.

Reported-by: David Disseldorp <ddiss@suse.com>
Fixes: d98f72272500 ("nfs: simplify and guarantee owner uniqueness.")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/nfs4xdr.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e8ac3f615f93..71f45cc0ca74 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -82,9 +82,8 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
  * we currently use size 2 (u64) out of (NFS4_OPAQUE_LIMIT  >> 2)
  */
 #define pagepad_maxsz		(1)
-#define open_owner_id_maxsz	(1 + 2 + 1 + 1 + 2)
-#define lock_owner_id_maxsz	(1 + 1 + 4)
-#define decode_lockowner_maxsz	(1 + XDR_QUADLEN(IDMAP_NAMESZ))
+#define open_owner_id_maxsz	(2 + 1 + 2 + 2)
+#define lock_owner_id_maxsz	(2 + 1 + 2)
 #define compound_encode_hdr_maxsz	(3 + (NFS4_MAXTAGLEN >> 2))
 #define compound_decode_hdr_maxsz	(3 + (NFS4_MAXTAGLEN >> 2))
 #define op_encode_hdr_maxsz	(1)
@@ -185,7 +184,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define encode_claim_null_maxsz	(1 + nfs4_name_maxsz)
 #define encode_open_maxsz	(op_encode_hdr_maxsz + \
 				2 + encode_share_access_maxsz + 2 + \
-				open_owner_id_maxsz + \
+				1 + open_owner_id_maxsz + \
 				encode_opentype_maxsz + \
 				encode_claim_null_maxsz)
 #define decode_space_limit_maxsz	(3)
@@ -255,13 +254,14 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define encode_link_maxsz	(op_encode_hdr_maxsz + \
 				nfs4_name_maxsz)
 #define decode_link_maxsz	(op_decode_hdr_maxsz + decode_change_info_maxsz)
-#define encode_lockowner_maxsz	(7)
+#define encode_lockowner_maxsz	(2 + 1 + lock_owner_id_maxsz)
+
 #define encode_lock_maxsz	(op_encode_hdr_maxsz + \
 				 7 + \
 				 1 + encode_stateid_maxsz + 1 + \
 				 encode_lockowner_maxsz)
 #define decode_lock_denied_maxsz \
-				(8 + decode_lockowner_maxsz)
+				(2 + 2 + 1 + 2 + 1 + lock_owner_id_maxsz)
 #define decode_lock_maxsz	(op_decode_hdr_maxsz + \
 				 decode_lock_denied_maxsz)
 #define encode_lockt_maxsz	(op_encode_hdr_maxsz + 5 + \
@@ -617,7 +617,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				 encode_lockowner_maxsz)
 #define NFS4_dec_release_lockowner_sz \
 				(compound_decode_hdr_maxsz + \
-				 decode_lockowner_maxsz)
+				 decode_release_lockowner_maxsz)
 #define NFS4_enc_access_sz	(compound_encode_hdr_maxsz + \
 				encode_sequence_maxsz + \
 				encode_putfh_maxsz + \
@@ -1412,7 +1412,7 @@ static inline void encode_openhdr(struct xdr_stream *xdr, const struct nfs_opena
 	__be32 *p;
  /*
  * opcode 4, seqid 4, share_access 4, share_deny 4, clientid 8, ownerlen 4,
- * owner 4 = 32
+ * owner 28
  */
 	encode_nfs4_seqid(xdr, arg->seqid);
 	encode_share_access(xdr, arg->share_access);
@@ -5077,7 +5077,7 @@ static int decode_link(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
 /*
  * We create the owner, so we know a proper owner.id length is 4.
  */
-static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
+static int decode_lock_denied(struct xdr_stream *xdr, struct file_lock *fl)
 {
 	uint64_t offset, length, clientid;
 	__be32 *p;
-- 
2.47.0


