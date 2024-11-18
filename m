Return-Path: <linux-nfs+bounces-8052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73ED9D1A3C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEDBB21D7E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29091E7C1E;
	Mon, 18 Nov 2024 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjtGb1Tt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7AC17BA3;
	Mon, 18 Nov 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964459; cv=none; b=WDNBjpNEoKtH3bb4Oj2G7Dn1RL2ZInzSUNbnb6cVhOrDb1evO3TxmCgVX6DnoayY0UeB+JAd9hzx8wXNCN748NmWnXhdMgMv8umqQ+ZAjVJ99fh/XdT+d4wT3UhMrAokkmRZ+qD6DTYpv6jHgnbIuu76UEOjdlnHVsGEKioUqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964459; c=relaxed/simple;
	bh=fjth7eJ85x+57Dt8eoiP4qsUJ5JgoZqFh3BE5VLR67k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbBruIvVEncVRh/fRnvPrN9nIjXGBQJRTNsFMzYHxPhErcnusr0y8DLnVA1QMW8y7GllsiI0NKUKlfe/rYATtkqJ/U/mGmpwULtQXILP5OA3hXrayqHzp+tgBSc+5Hiq0wJWQvlaQm5HEOKXS0Xofsgl1iXVhZ4MMUtHO/wR8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjtGb1Tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D49C4CED7;
	Mon, 18 Nov 2024 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964458;
	bh=fjth7eJ85x+57Dt8eoiP4qsUJ5JgoZqFh3BE5VLR67k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjtGb1TtlI8Ne/e4k1+XSNz7R4/NmS7D4CPoMfU55bobeorDyf/t7wslTdxQZ6hHx
	 yxcECg2uLQu0LEOT7S9yh+IDqVlK7st3mUTGD8LAUTWZqsOmdvKtX3vpYWNuOV4oAi
	 D43BdY5zGlY55q8s5u3/WDarXHYtNOm6YT9qGZ8zEOtgzJndzFcWmolwgI8fgLJNrL
	 Iy3iG2+AHjfuN4I+DLB53FsgpmWZfZ85kXmD73a4wC2J2CYZeSjN5hfVtm613MbPi2
	 sr2Ti/+lQrtiQwpT9OLPMo1/Gf9hoYyOt44zHXAtT19+mTWdnHb45bN6CYQoR7iT8K
	 YWV3fugFIcjrw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6 3/5] NFSD: Limit the number of concurrent async COPY operations
Date: Mon, 18 Nov 2024 16:14:11 -0500
Message-ID: <20241118211413.3756-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118211413.3756-1-cel@kernel.org>
References: <20241118211413.3756-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit aadc3bbea163b6caaaebfdd2b6c4667fbc726752 ]

Nothing appears to limit the number of concurrent async COPY
operations that clients can start. In addition, AFAICT each async
COPY can copy an unlimited number of 4MB chunks, so can run for a
long time. Thus IMO async COPY can become a DoS vector.

Add a restriction mechanism that bounds the number of concurrent
background COPY operations. Start simple and try to be fair -- this
patch implements a per-namespace limit.

An async COPY request that occurs while this limit is exceeded gets
NFS4ERR_DELAY. The requesting client can choose to send the request
again after a delay or fall back to a traditional read/write style
copy.

If there is need to make the mechanism more sophisticated, we can
visit that in future patches.

Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49974
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4proc.c  | 11 +++++++++--
 fs/nfsd/nfs4state.c |  1 +
 fs/nfsd/xdr4.h      |  1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9bfca3dda63d..77d4f82096c9 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -153,6 +153,7 @@ struct nfsd_net {
 	u32		s2s_cp_cl_id;
 	struct idr	s2s_cp_stateids;
 	spinlock_t	s2s_cp_lock;
+	atomic_t	pending_async_copies;
 
 	/*
 	 * Version information
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3e35f8688426..e74462fb480f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1273,6 +1273,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	atomic_dec(&copy->cp_nn->pending_async_copies);
 	kfree(copy->cp_src);
 	kfree(copy);
 }
@@ -1811,10 +1812,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-		status = nfserrno(-ENOMEM);
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out_err;
+		async_copy->cp_nn = nn;
+		/* Arbitrary cap on number of pending async copy operations */
+		if (atomic_inc_return(&nn->pending_async_copies) >
+				(int)rqstp->rq_pool->sp_nrthreads) {
+			atomic_dec(&nn->pending_async_copies);
+			goto out_err;
+		}
 		INIT_LIST_HEAD(&async_copy->copies);
 		refcount_set(&async_copy->refcount, 1);
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
@@ -1853,7 +1860,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (async_copy)
 		cleanup_async_copy(async_copy);
-	status = nfserrno(-ENOMEM);
+	status = nfserr_jukebox;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 975dd74a7a4d..901fc68636cd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8142,6 +8142,7 @@ static int nfs4_state_create_net(struct net *net)
 	spin_lock_init(&nn->client_lock);
 	spin_lock_init(&nn->s2s_cp_lock);
 	idr_init(&nn->s2s_cp_stateids);
+	atomic_set(&nn->pending_async_copies, 0);
 
 	spin_lock_init(&nn->blocked_locks_lock);
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 9d918a79dc16..144e05efd14c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -574,6 +574,7 @@ struct nfsd4_copy {
 	struct nfsd4_ssc_umount_item *ss_nsui;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
+	struct nfsd_net		*cp_nn;
 };
 
 static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
-- 
2.47.0


