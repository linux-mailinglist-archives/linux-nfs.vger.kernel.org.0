Return-Path: <linux-nfs+bounces-5770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5595F496
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92251F22789
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E72188CA5;
	Mon, 26 Aug 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADOaHtMe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4971E892;
	Mon, 26 Aug 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684886; cv=none; b=tIpeFNBzjgvPVN8b3iWFErhgyKReSbnAgXUIDAkja/FVyFLo4kDcZ3PfCXEHx5sX7mJT+d4iQdtgnQCXe/nxZ2dU2ptTy3wXy0OfejpsZAMR+rQ1oE786LnM4VyBPsuqjJcVu/E2E3fvmhjRWWwjG9UrKKXEc0NwLxla8ufc9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684886; c=relaxed/simple;
	bh=cwXr5ZywFkrGFxSrYN5eRjdXXpMEQkmsJUMAF4W6IUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/dTst59QYX8Y64i610pVx+iGw6EFsQD2JE/vuCPLtKDrXaDVtD3yvUh1S2a/YBuDdHGqJVa4zRmK15Xm4zYFnelemupzmm2XrBZnXf9vBCmpknwutNRlCFaoZID7eUP9EIWeRQWhc3SFT9i+QPAShZPnV0sywz4bU68QjdiIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADOaHtMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752B6C4FF61;
	Mon, 26 Aug 2024 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684885;
	bh=cwXr5ZywFkrGFxSrYN5eRjdXXpMEQkmsJUMAF4W6IUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADOaHtMenhSD5L8yGvpw0I26JaVFIcn7wIWB3HzvIZvMy+/OtH2dAuNtzJwcMoFnw
	 zE9EpUrs8HAR3wDXblTgyaIQQXdxX9lTgLp3g+h36gQW6Msu+Eb5pR6VlTeeKdHQbX
	 J4iBgcVMIVUZLBDVhKwWXHkCCBT6+00dYOywM6b6HUBgZG0fK1KizF8mMRRiYz9aHC
	 XPf53+XR4eqjmcdInfzo39BvDVXnjUT1l/Rw8oEmx7++EpiRR2gKXe7aXhePV4KmvU
	 k5mwf53aJP4ZQ3BuQ0nolMuocP0RX7Y46GsKQENgg2thiV2h5epdH1TVjwujl7yKY4
	 5e6efXzUiSrAA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	NeilBrown <neilb@suse.de>
Subject: [PATCH 6.1.y 6/7] nfsd: don't call locks_release_private() twice concurrently
Date: Mon, 26 Aug 2024 11:07:02 -0400
Message-ID: <20240826150703.13987-7-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240826150703.13987-1-cel@kernel.org>
References: <20240826150703.13987-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit 05eda6e75773592760285e10ac86c56d683be17f ]

It is possible for free_blocked_lock() to be called twice concurrently,
once from nfsd4_lock() and once from nfsd4_release_lockowner() calling
remove_blocked_locks().  This is why a kref was added.

It is perfectly safe for locks_delete_block() and kref_put() to be
called in parallel as they use locking or atomicity respectively as
protection.  However locks_release_private() has no locking.  It is
safe for it to be called twice sequentially, but not concurrently.

This patch moves that call from free_blocked_lock() where it could race
with itself, to free_nbl() where it cannot.  This will slightly delay
the freeing of private info or release of the owner - but not by much.
It is arguably more natural for this freeing to happen in free_nbl()
where the structure itself is freed.

This bug was found by code inspection - it has not been seen in practice.

Fixes: 47446d74f170 ("nfsd4: add refcount for nfsd4_blocked_lock")
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8d15959004ad..f04de2553c90 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -318,6 +318,7 @@ free_nbl(struct kref *kref)
 	struct nfsd4_blocked_lock *nbl;
 
 	nbl = container_of(kref, struct nfsd4_blocked_lock, nbl_kref);
+	locks_release_private(&nbl->nbl_lock);
 	kfree(nbl);
 }
 
@@ -325,7 +326,6 @@ static void
 free_blocked_lock(struct nfsd4_blocked_lock *nbl)
 {
 	locks_delete_block(&nbl->nbl_lock);
-	locks_release_private(&nbl->nbl_lock);
 	kref_put(&nbl->nbl_kref, free_nbl);
 }
 
-- 
2.45.1


