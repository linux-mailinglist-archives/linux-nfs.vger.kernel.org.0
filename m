Return-Path: <linux-nfs+bounces-10402-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C36A4AD5E
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440271896D1D
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66D23F37C;
	Sat,  1 Mar 2025 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmd/J74K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0863A1E5B8D
	for <linux-nfs@vger.kernel.org>; Sat,  1 Mar 2025 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853919; cv=none; b=emkRmikD2qj1aJ/MsP7pYLai6T/rwBiITZdbAz1zN/ivFvw0ItpG6iHtQxxA4ZBCIdZRLyobqHD0O7761NPNBdXw24mRYlSxdXIX3sQ5vFjuXJXktiRtXPB4g6I2ZFHTJZN2rRUm141w7HLFfb6LIOu3wNlObacNIu5Ihv8Qwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853919; c=relaxed/simple;
	bh=sbH0iu+irtMD+DgymbC19hFEl8PaJYnQxdIWE938u4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpHe4UVeRWZrLyeTsPRlwPYrDU1sf1EsSFDO5oco53haUWpbRC1oeHBotIEW8nniGFExd6PN2vCIhr4dbvgLHC0F+P/XyRhgubvB0SRIa9EtwrxNzswNo/VUdFq0e3ZvM+YPokleebu6lNqpyk6C3t74/CCggXUsKfc672dqeoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmd/J74K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF7AC4CEE9;
	Sat,  1 Mar 2025 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740853918;
	bh=sbH0iu+irtMD+DgymbC19hFEl8PaJYnQxdIWE938u4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pmd/J74KCXU5LrkRwRvXQJBZ0Up5DKtUwzruHoagE9U01LyAlFCpVjYC2832mgqHG
	 6vlJ32BWT/+vvNeYNJjHOCRzTCdeWh9WT/SVh4+EGJctSsfBFzkKvsvC4dXRGwCymh
	 o/UuSPfWhoLtAYI05Qd5FiVgM4bUo9aggVqJLzylZklw2Eqw/t0YL7StdR5Wwam/kS
	 mbLr/Vn1/xUCMPdKniFCNoCMPhzU4yS2J6r72dh02lswz9p92mYn5Hj4fCCZWnmu3G
	 iqp7vRoBvPd4F+74SySsMUNOIrA6hp3yMhv2tuUO3nnRX+4tgo6PBV/KCMLdtzUgRH
	 6XgmW49EvPRHg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/5] NFSD: Record each NFSv4 call's session slot index
Date: Sat,  1 Mar 2025 13:31:50 -0500
Message-ID: <20250301183151.11362-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250301183151.11362-1-cel@kernel.org>
References: <20250301183151.11362-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The slot index number of the current COMPOUND has, until now, not
been needed outside of nfsd4_sequence(). But to record the tuple
that represents a referring call, the slot number will be needed
when processing subsequent operations in the COMPOUND.

Refactor the code that allocates a new struct nfsd4_slot to ensure
that the new sl_index field is always correctly initialized.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++-----------------
 fs/nfsd/state.h     |  1 +
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 153eeea2c7c9..d25f2a65c2bc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1989,26 +1989,30 @@ reduce_session_slots(struct nfsd4_session *ses, int dec)
 	return ret;
 }
 
-/*
- * We don't actually need to cache the rpc and session headers, so we
- * can allocate a little less for each slot:
- */
-static inline u32 slot_bytes(struct nfsd4_channel_attrs *ca)
+static struct nfsd4_slot *nfsd4_alloc_slot(struct nfsd4_channel_attrs *fattrs,
+					   int index, gfp_t gfp)
 {
-	u32 size;
+	struct nfsd4_slot *slot;
+	size_t size;
 
-	if (ca->maxresp_cached < NFSD_MIN_HDR_SEQ_SZ)
-		size = 0;
-	else
-		size = ca->maxresp_cached - NFSD_MIN_HDR_SEQ_SZ;
-	return size + sizeof(struct nfsd4_slot);
+	/*
+	 * The RPC and NFS session headers are never saved in
+	 * the slot reply cache buffer.
+	 */
+	size = fattrs->maxresp_cached < NFSD_MIN_HDR_SEQ_SZ ?
+		0 : fattrs->maxresp_cached - NFSD_MIN_HDR_SEQ_SZ;
+
+	slot = kzalloc(struct_size(slot, sl_data, size), gfp);
+	if (!slot)
+		return NULL;
+	slot->sl_index = index;
+	return slot;
 }
 
 static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 					   struct nfsd4_channel_attrs *battrs)
 {
 	int numslots = fattrs->maxreqs;
-	int slotsize = slot_bytes(fattrs);
 	struct nfsd4_session *new;
 	struct nfsd4_slot *slot;
 	int i;
@@ -2017,14 +2021,14 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	if (!new)
 		return NULL;
 	xa_init(&new->se_slots);
-	/* allocate each struct nfsd4_slot and data cache in one piece */
-	slot = kzalloc(slotsize, GFP_KERNEL);
+
+	slot = nfsd4_alloc_slot(fattrs, 0, GFP_KERNEL);
 	if (!slot || xa_is_err(xa_store(&new->se_slots, 0, slot, GFP_KERNEL)))
 		goto out_free;
 
 	for (i = 1; i < numslots; i++) {
 		const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
-		slot = kzalloc(slotsize, gfp);
+		slot = nfsd4_alloc_slot(fattrs, i, gfp);
 		if (!slot)
 			break;
 		if (xa_is_err(xa_store(&new->se_slots, i, slot, gfp))) {
@@ -4438,8 +4442,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			 * spinlock, and only succeeds if there is
 			 * plenty of memory.
 			 */
-			slot = kzalloc(slot_bytes(&session->se_fchannel),
-				       GFP_NOWAIT);
+			slot = nfsd4_alloc_slot(&session->se_fchannel, s,
+						GFP_NOWAIT);
 			prev_slot = xa_load(&session->se_slots, s);
 			if (xa_is_value(prev_slot) && slot) {
 				slot->sl_seqid = xa_to_value(prev_slot);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index b4af840fc4f9..a971c8503c37 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -279,6 +279,7 @@ struct nfsd4_slot {
 	u32	sl_seqid;
 	__be32	sl_status;
 	struct svc_cred sl_cred;
+	u32	sl_index;
 	u32	sl_datalen;
 	u16	sl_opcnt;
 	u16	sl_generation;
-- 
2.47.0


