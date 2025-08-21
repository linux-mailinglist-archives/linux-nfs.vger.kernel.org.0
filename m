Return-Path: <linux-nfs+bounces-13833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86CB2FD91
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B141BA2CD3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3492D8398;
	Thu, 21 Aug 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQoOOK+a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB90469D
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788005; cv=none; b=mcbzF3PEOMrHlSYu8oBOz1sXi4NdSuRXSpITr115bRwhXkGfUTcPR/0enhr2v8JxFK/pu3wB7m1EkP28H6Lft6u+RbgCaukzs/xdck+m6ZoO6ApXbOCoWg8NPH5xV7q41+Vg+DEwAKalhqvgmo7eU62qp27/HaM1raTKb9JlFoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788005; c=relaxed/simple;
	bh=6Ni0TEbzS3avfYawGb7je6L8Lknn9+Keoxs1X1RPopk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCZdvQ36flOhyP4Umf0Nw5HGYeac2gikiMnA36TkHjz+ISemanNFsGpjoYy3rLFf7m7sFfu8BgwHux57UuBWjt4BE5OlQTkKT4zYnfr5ptQDBn/9KCAVg2UoZuEyhrM/eSysbHC6XGpjwrfBUOO/AvLnWT+CD4SzRIFEesJFtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQoOOK+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426AAC113CF;
	Thu, 21 Aug 2025 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788004;
	bh=6Ni0TEbzS3avfYawGb7je6L8Lknn9+Keoxs1X1RPopk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQoOOK+aeowpLU1XLppPJ6LydYW/Am5d8FGvH33hHdXWipwqyPvbXhYfl3jqIt0xE
	 mGG46mUW0ZvJkQTMQ5hg0OR+LSbr+jLDe7v85D4fWSp5i0cqXCZ39CL5MtWrDJzTtO
	 169sa3+qVnhgmA5ryH7OcwK6Pjhz/CXSi3rWXC6c2vVhqi41ArYycsb/2PGgerB7n6
	 6XjGT7ar9eXT5mzfTzmHxy11xrIbWM9Xw6NVUS+VB95C5UatPPfh6qh79VHxJ2UZs8
	 Y62VzYpYnhgZkp3NZttef0WYMs5/KggDGmAsyRLNx5hPBCMJiS+UT15Oq4WFBG26UV
	 bSEyjNwRJ+eTQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/2] NFSD: Delay adding new entries to LRU
Date: Thu, 21 Aug 2025 10:53:20 -0400
Message-ID: <20250821145321.7662-2-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250821145321.7662-1-cel@kernel.org>
References: <20250821145321.7662-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Neil Brown observes:
> I would not include RC_INPROG entries in the lru at all - they are
> always ignored, and will be added when they are switched to
> RCU_DONE.

I also removed a stale comment.

Suggested-by: NeilBrown <neil@brown.name>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index ba9d326b3de6..d929c8c63bd9 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -237,10 +237,6 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 
 }
 
-/*
- * Move cache entry to end of LRU list, and queue the cleaner to run if it's
- * not already scheduled.
- */
 static void
 lru_put_end(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp)
 {
@@ -272,13 +268,6 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 
 	/* The bucket LRU is ordered oldest-first. */
 	list_for_each_entry_safe(rp, tmp, &b->lru_head, c_lru) {
-		/*
-		 * Don't free entries attached to calls that are still
-		 * in-progress, but do keep scanning the list.
-		 */
-		if (rp->c_state == RC_INPROG)
-			continue;
-
 		if (atomic_read(&nn->num_drc_entries) <= nn->max_drc_entries &&
 		    time_before(expiry, rp->c_timestamp))
 			break;
@@ -453,8 +442,6 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfsd_cacherep *key,
 				nn->longest_chain_cachesize,
 				atomic_read(&nn->num_drc_entries));
 	}
-
-	lru_put_end(b, ret);
 	return ret;
 }
 
-- 
2.50.0


