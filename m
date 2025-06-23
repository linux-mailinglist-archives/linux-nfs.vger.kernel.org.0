Return-Path: <linux-nfs+bounces-12665-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B8AAE4136
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 14:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1EF1882220
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23C624887A;
	Mon, 23 Jun 2025 12:53:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D224C1A8412;
	Mon, 23 Jun 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683195; cv=none; b=LqT2OBAOiNQoVYBoxGPandtlWCLpqiPp+H156oSrYX6bEKG2DaCFEh5li088kHOERIZut0YsLBvPXne6WjDByiKpbrSjvj5sUtEbk58VeZj+bwfdqKiQ7bGe5nYSNoMEYdktsYdE+V/kK90U0sCdkvxh8+H5vGQs4EmBHRrB/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683195; c=relaxed/simple;
	bh=0g50SqWc5g3rJvoZPAxV4yQCt2rJxE4bYMCSo9EOwwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkEOJvLeB+Zrfpr02/cN6OtpOK2RHns/DzSaSGfIKF38swlUj+ELBPgaKvfhPO+WZfMJ+CXDNP/dQtYlWa6n0W8uSCghQ2mk/9cVQnAIjVa+JPKCreAfZ4+lpk90634qHJoX+inIPlPZB6kDRBJLOiApf+fIebKPYd+ic8tAWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 81B0F60307155;
	Mon, 23 Jun 2025 20:52:59 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] NFS: Using guard() to simplify lock/unlock code
Date: Mon, 23 Jun 2025 20:52:53 +0800
Message-Id: <20250623125253.3797131-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using guard() to replace *unlock* label. guard() is better than goto
unlock patterns and is more clear. No functional changes.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/nfs/callback_proc.c | 169 ++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 87 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 8397c43358bd..ae7635f88f35 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -264,47 +264,43 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 
 	pnfs_layoutcommit_inode(ino, false);
 
+	scoped_guard(spinlock, &ino->i_lock) {
+		lo = NFS_I(ino)->layout;
+		if (!lo)
+			goto out;
+		pnfs_get_layout_hdr(lo);
+		rv = pnfs_check_callback_stateid(lo, &args->cbl_stateid, cps);
+		if (rv != NFS_OK)
+			break;
 
-	spin_lock(&ino->i_lock);
-	lo = NFS_I(ino)->layout;
-	if (!lo) {
-		spin_unlock(&ino->i_lock);
-		goto out;
-	}
-	pnfs_get_layout_hdr(lo);
-	rv = pnfs_check_callback_stateid(lo, &args->cbl_stateid, cps);
-	if (rv != NFS_OK)
-		goto unlock;
-
-	/*
-	 * Enforce RFC5661 Section 12.5.5.2.1.5 (Bulk Recall and Return)
-	 */
-	if (test_bit(NFS_LAYOUT_BULK_RECALL, &lo->plh_flags)) {
-		rv = NFS4ERR_DELAY;
-		goto unlock;
-	}
-
-	pnfs_set_layout_stateid(lo, &args->cbl_stateid, NULL, true);
-	switch (pnfs_mark_matching_lsegs_return(lo, &free_me_list,
-				&args->cbl_range,
-				be32_to_cpu(args->cbl_stateid.seqid))) {
-	case 0:
-	case -EBUSY:
-		/* There are layout segments that need to be returned */
-		rv = NFS4_OK;
-		break;
-	case -ENOENT:
-		set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
-		/* Embrace your forgetfulness! */
-		rv = NFS4ERR_NOMATCHING_LAYOUT;
+		/*
+		 * Enforce RFC5661 Section 12.5.5.2.1.5 (Bulk Recall and Return)
+		 */
+		if (test_bit(NFS_LAYOUT_BULK_RECALL, &lo->plh_flags)) {
+			rv = NFS4ERR_DELAY;
+			break;
+		}
 
-		if (NFS_SERVER(ino)->pnfs_curr_ld->return_range) {
-			NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo,
-				&args->cbl_range);
+		pnfs_set_layout_stateid(lo, &args->cbl_stateid, NULL, true);
+		switch (pnfs_mark_matching_lsegs_return(lo, &free_me_list,
+					&args->cbl_range,
+					be32_to_cpu(args->cbl_stateid.seqid))) {
+		case 0:
+		case -EBUSY:
+			/* There are layout segments that need to be returned */
+			rv = NFS4_OK;
+			break;
+		case -ENOENT:
+			set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
+			/* Embrace your forgetfulness! */
+			rv = NFS4ERR_NOMATCHING_LAYOUT;
+
+			if (NFS_SERVER(ino)->pnfs_curr_ld->return_range) {
+				NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo,
+					&args->cbl_range);
+			}
 		}
 	}
-unlock:
-	spin_unlock(&ino->i_lock);
 	pnfs_free_lseg_list(&free_me_list);
 	/* Free all lsegs that are attached to commit buckets */
 	nfs_commit_inode(ino, 0);
@@ -524,62 +520,61 @@ __be32 nfs4_callback_sequence(void *argp, void *resp,
 	res->csr_sequenceid = args->csa_sequenceid;
 	res->csr_slotid = args->csa_slotid;
 
-	spin_lock(&tbl->slot_tbl_lock);
-	/* state manager is resetting the session */
-	if (test_bit(NFS4_SLOT_TBL_DRAINING, &tbl->slot_tbl_state)) {
-		status = htonl(NFS4ERR_DELAY);
-		/* Return NFS4ERR_BADSESSION if we're draining the session
-		 * in order to reset it.
-		 */
-		if (test_bit(NFS4CLNT_SESSION_RESET, &clp->cl_state))
-			status = htonl(NFS4ERR_BADSESSION);
-		goto out_unlock;
-	}
+	scoped_guard(spinlock, &tbl->slot_tbl_lock) {
+		/* state manager is resetting the session */
+		if (test_bit(NFS4_SLOT_TBL_DRAINING, &tbl->slot_tbl_state)) {
+			status = htonl(NFS4ERR_DELAY);
+			/* Return NFS4ERR_BADSESSION if we're draining the session
+			 * in order to reset it.
+			 */
+			if (test_bit(NFS4CLNT_SESSION_RESET, &clp->cl_state))
+				status = htonl(NFS4ERR_BADSESSION);
+			break;
+		}
 
-	status = htonl(NFS4ERR_BADSLOT);
-	slot = nfs4_lookup_slot(tbl, args->csa_slotid);
-	if (IS_ERR(slot))
-		goto out_unlock;
+		status = htonl(NFS4ERR_BADSLOT);
+		slot = nfs4_lookup_slot(tbl, args->csa_slotid);
+		if (IS_ERR(slot))
+			break;
 
-	res->csr_highestslotid = tbl->server_highest_slotid;
-	res->csr_target_highestslotid = tbl->target_highest_slotid;
+		res->csr_highestslotid = tbl->server_highest_slotid;
+		res->csr_target_highestslotid = tbl->target_highest_slotid;
 
-	status = validate_seqid(tbl, slot, args);
-	if (status)
-		goto out_unlock;
-	if (!nfs4_try_to_lock_slot(tbl, slot)) {
-		status = htonl(NFS4ERR_DELAY);
-		goto out_unlock;
-	}
-	cps->slot = slot;
+		status = validate_seqid(tbl, slot, args);
+		if (status)
+			break;
+		if (!nfs4_try_to_lock_slot(tbl, slot)) {
+			status = htonl(NFS4ERR_DELAY);
+			break;
+		}
+		cps->slot = slot;
 
-	/* The ca_maxresponsesize_cached is 0 with no DRC */
-	if (args->csa_cachethis != 0) {
-		status = htonl(NFS4ERR_REP_TOO_BIG_TO_CACHE);
-		goto out_unlock;
-	}
+		/* The ca_maxresponsesize_cached is 0 with no DRC */
+		if (args->csa_cachethis != 0) {
+			status = htonl(NFS4ERR_REP_TOO_BIG_TO_CACHE);
+			break;
+		}
 
-	/*
-	 * Check for pending referring calls.  If a match is found, a
-	 * related callback was received before the response to the original
-	 * call.
-	 */
-	ret = referring_call_exists(clp, args->csa_nrclists, args->csa_rclists,
-				    &tbl->slot_tbl_lock);
-	if (ret < 0) {
-		status = htonl(NFS4ERR_DELAY);
-		goto out_unlock;
-	}
-	cps->referring_calls = ret;
+		/*
+		 * Check for pending referring calls.  If a match is found, a
+		 * related callback was received before the response to the original
+		 * call.
+		 */
+		ret = referring_call_exists(clp, args->csa_nrclists, args->csa_rclists,
+					    &tbl->slot_tbl_lock);
+		if (ret < 0) {
+			status = htonl(NFS4ERR_DELAY);
+			break;
+		}
+		cps->referring_calls = ret;
 
-	/*
-	 * RFC5661 20.9.3
-	 * If CB_SEQUENCE returns an error, then the state of the slot
-	 * (sequence ID, cached reply) MUST NOT change.
-	 */
-	slot->seq_nr = args->csa_sequenceid;
-out_unlock:
-	spin_unlock(&tbl->slot_tbl_lock);
+		/*
+		 * RFC5661 20.9.3
+		 * If CB_SEQUENCE returns an error, then the state of the slot
+		 * (sequence ID, cached reply) MUST NOT change.
+		 */
+		slot->seq_nr = args->csa_sequenceid;
+	}
 
 out:
 	cps->clp = clp; /* put in nfs4_callback_compound */
-- 
2.30.2


