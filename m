Return-Path: <linux-nfs+bounces-17535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BCECFC5A0
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1CEC3082D06
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF72765F8;
	Wed,  7 Jan 2026 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TwAoasac"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DF27C162
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770893; cv=none; b=PVTEuW/jwcQoV8ydvdHL2Mk5SkxP3lB5UiRlUBHC622DlnzEXt79ABvTVr/nLBwOQtv2LcTN8BAnfQhMcRDjLmSVP3/WNwvS9hDukb/UGy+I8F4ZF816O3yJy/yZfRC8GNLBUr25UPBPgEnMKPrXXVO+MAMHpkllhijvZ8o2JZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770893; c=relaxed/simple;
	bh=k3+19SG2VYcqni1VP6BYrzHvBF0WVrcZU2zgiHcNDAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFF/R07YjfVEQNw2ukESPZaxICr1JXipAsGil6lr1JbQ79YJ76G1CE/qox18P3PgB2q3yoHlvlyIqecRCAaI/1n8Lupf+Ye37UaAFnjhZ6Y5rC7l9+seGbYpsT8pQ7lT+LC9DuTboBp0TA2lMUKwXQit6vIidmJ7bK5x6mjfCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TwAoasac; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3asxI+gFl1gMSxE22oNIY9XgyJADEY/5BV3nZO569ng=; b=TwAoasac3u4BCWeKPxmVzMxxeM
	OpSvdCpYtzDJPHOV3Fm44+SIk4kptdmm02Zn5omYK5dDryJb7Qvkvjsu3t9/Q55/+PO83ZuhXvidF
	Qhzt61vCXB41qWQTkuR06jR4HJmneql7/75kNKAFjI5pIrokFJ9NiznY3PcacVYZnFy2hEk+pbhs/
	jhgsCUQAxQoATafRPwuXSlQn4x01XzcGQ8mBLgLLStHUDA+eRLU8ETiBdhvCIPkzrAAdU4w6yGZnH
	EUVyMvUBy3j5pKPWASEw4LzYcZMwwHNzA38I+eajXfyWiTemQITTzHnQ+5JrDbYhI0OYNzp9hL0ja
	cSxYj5+g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNxj-0000000EHmx-115q;
	Wed, 07 Jan 2026 07:28:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 13/24] NFS: move delegation lookup into can_open_delegated
Date: Wed,  7 Jan 2026 08:27:04 +0100
Message-ID: <20260107072720.1744129-14-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107072720.1744129-1-hch@lst.de>
References: <20260107072720.1744129-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Keep the delegation handling in a single place, and just return the
stateid in an optional argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/nfs4proc.c | 65 ++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ec1ce593dea2..3b4758e887e4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1609,26 +1609,37 @@ static int can_open_cached(struct nfs4_state *state, fmode_t mode,
 	return ret;
 }
 
-static int can_open_delegated(struct nfs_delegation *delegation, fmode_t fmode,
-		enum open_claim_type4 claim)
+static bool can_open_delegated(const struct inode *inode, fmode_t fmode,
+		enum open_claim_type4 claim, nfs4_stateid *stateid)
 {
-	if (delegation == NULL)
-		return 0;
-	if ((delegation->type & fmode) != fmode)
-		return 0;
+	struct nfs_delegation *delegation;
+	bool ret = false;
+
+	rcu_read_lock();
+	delegation = nfs4_get_valid_delegation(inode);
+	if (!delegation || (delegation->type & fmode) != fmode)
+		goto out_unlock;
+
 	switch (claim) {
-	case NFS4_OPEN_CLAIM_NULL:
-	case NFS4_OPEN_CLAIM_FH:
-		break;
 	case NFS4_OPEN_CLAIM_PREVIOUS:
-		if (!test_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags))
+		if (test_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags))
 			break;
 		fallthrough;
+	case NFS4_OPEN_CLAIM_NULL:
+	case NFS4_OPEN_CLAIM_FH:
+		nfs_mark_delegation_referenced(delegation);
+		/* Save the delegation stateid */
+		if (stateid)
+			nfs4_stateid_copy(stateid, &delegation->stateid);
+		ret = true;
+		break;
 	default:
-		return 0;
+		break;
 	}
-	nfs_mark_delegation_referenced(delegation);
-	return 1;
+
+out_unlock:
+	rcu_read_unlock();
+	return ret;
 }
 
 static void update_open_stateflags(struct nfs4_state *state, fmode_t fmode)
@@ -1981,7 +1992,6 @@ static void nfs4_return_incompatible_delegation(struct inode *inode, fmode_t fmo
 static struct nfs4_state *nfs4_try_open_cached(struct nfs4_opendata *opendata)
 {
 	struct nfs4_state *state = opendata->state;
-	struct nfs_delegation *delegation;
 	int open_mode = opendata->o_arg.open_flags;
 	fmode_t fmode = opendata->o_arg.fmode;
 	enum open_claim_type4 claim = opendata->o_arg.claim;
@@ -1996,15 +2006,10 @@ static struct nfs4_state *nfs4_try_open_cached(struct nfs4_opendata *opendata)
 			goto out_return_state;
 		}
 		spin_unlock(&state->owner->so_lock);
-		rcu_read_lock();
-		delegation = nfs4_get_valid_delegation(state->inode);
-		if (!can_open_delegated(delegation, fmode, claim)) {
-			rcu_read_unlock();
+
+		if (!can_open_delegated(state->inode, fmode, claim, &stateid))
 			break;
-		}
-		/* Save the delegation */
-		nfs4_stateid_copy(&stateid, &delegation->stateid);
-		rcu_read_unlock();
+
 		nfs_release_seqid(opendata->o_arg.seqid);
 		if (!opendata->is_recover) {
 			ret = nfs_may_open(state->inode, state->owner->so_cred, open_mode);
@@ -2556,16 +2561,14 @@ static void nfs4_open_prepare(struct rpc_task *task, void *calldata)
 	 * a delegation instead.
 	 */
 	if (data->state != NULL) {
-		struct nfs_delegation *delegation;
-
 		if (can_open_cached(data->state, data->o_arg.fmode,
 					data->o_arg.open_flags, claim))
 			goto out_no_action;
-		rcu_read_lock();
-		delegation = nfs4_get_valid_delegation(data->state->inode);
-		if (can_open_delegated(delegation, data->o_arg.fmode, claim))
-			goto unlock_no_action;
-		rcu_read_unlock();
+		if (can_open_delegated(data->state->inode, data->o_arg.fmode,
+				claim, NULL)) {
+			trace_nfs4_cached_open(data->state);
+			goto out_no_action;
+		}
 	}
 	/* Update client id. */
 	data->o_arg.clientid = clp->cl_clientid;
@@ -2601,9 +2604,7 @@ static void nfs4_open_prepare(struct rpc_task *task, void *calldata)
 			data->o_arg.createmode = NFS4_CREATE_GUARDED;
 	}
 	return;
-unlock_no_action:
-	trace_nfs4_cached_open(data->state);
-	rcu_read_unlock();
+
 out_no_action:
 	task->tk_action = NULL;
 out_wait:
-- 
2.47.3


