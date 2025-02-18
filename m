Return-Path: <linux-nfs+bounces-10169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ED7A3A180
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD80616353C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6204626AA94;
	Tue, 18 Feb 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHLWLyTk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99F26D5B2
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893182; cv=none; b=mJdir9VmdRn3h8zgdP11QdjuPwgWAPDe+NacRYwhwxg3si8pNWflwEpKsLBMDp5AtKtmcLiABVInJFBQMVmQ8kFsiLa2Uul3xF6IqjEpORqTqVR/RlugVdaRBlT5Lg14oQiFpvYswBxpnlI0JXi34/kaMhfD1bqBUn1FPmR3rSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893182; c=relaxed/simple;
	bh=QIonkPUurTbbiJ99MOssvlx5xxbqsLxVStC/S947mHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/CthxFrrrMhlwvnqPqUJQ57A+tDCfwTcTQvEjBtXuIGVTUtU0f+/MSIFQ7WWSiJCJ3QcTJIaGICKQeJDzaXrYDWqH8DZDwi5IWJg/x4J5gKw5UoL9ustQf7Ru6Drq2B0a6MkBeCDd0eZowxynZ53M+Uam95daeqHqj8WtBCA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHLWLyTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09487C4CEE9;
	Tue, 18 Feb 2025 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893181;
	bh=QIonkPUurTbbiJ99MOssvlx5xxbqsLxVStC/S947mHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHLWLyTkf2qoRImxs60AF++smuiPhcHwaS7YBQopMTG4R2pmNuHGZOp8fHfXFHGmq
	 JqbUNtgG/KekXZ0qB8gXgbCqYxQxipJsxykTucZDif4zyzLBh0EN76ejmIcYRy8wDx
	 pFZ+dczJmyPab74fivnMRT2H9v/GGebcyUgd0GB01qTV9lYXaehvXqgRpFhYujl67b
	 1sFESUmyeoOFFrMmhkp0EUmzbfpUg2kd4KfZyPx1yqV3y1NvhE8urOrFdg81litj2/
	 QW2SZR9uKyH/PweZtbTBFgkgUNY7Kw1zMAkIP8Nfo2LotcfI5NIXB2t2Sz4BrIY1co
	 PRRGkGen0JA3w==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2 1/7] nfsd: filecache: remove race handling.
Date: Tue, 18 Feb 2025 10:39:31 -0500
Message-ID: <20250218153937.6125-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250218153937.6125-1-cel@kernel.org>
References: <20250218153937.6125-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

The race that this code tries to protect against is not interesting.
The code is problematic as we access the "nf" after we have given our
reference to the lru system.  While that takes 2+ seconds to free
things, it is still poor form.

The only interesting race I can find would be with
nfsd_file_close_inode_sync();
This is the only place that really doesn't want the file to stay on the
LRU when unhashed (which is the direct consequence of the race).

However for the race to happen, some other thread must own a reference
to a file and be putting it while nfsd_file_close_inode_sync() is trying
to close all files for an inode.  If this is possible, that other thread
could simply call nfsd_file_put() a little bit later and the result
would be the same: not all files are closed when
nfsd_file_close_inode_sync() completes.

If this was really a problem, we would need to wait in close_inode_sync
for the other references to be dropped.  We probably don't want to do
that.

So it is best to simply remove this code.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fb9b1656a287..909b5bc72bd3 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -370,22 +370,8 @@ nfsd_file_put(struct nfsd_file *nf)
 		if (refcount_dec_not_one(&nf->nf_ref))
 			return;
 
-		/* Try to add it to the LRU.  If that fails, decrement. */
-		if (nfsd_file_lru_add(nf)) {
-			/* If it's still hashed, we're done */
-			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-				nfsd_file_schedule_laundrette();
-				return;
-			}
-
-			/*
-			 * We're racing with unhashing, so try to remove it from
-			 * the LRU. If removal fails, then someone else already
-			 * has our reference.
-			 */
-			if (!nfsd_file_lru_remove(nf))
-				return;
-		}
+		if (nfsd_file_lru_add(nf))
+			return;
 	}
 	if (refcount_dec_and_test(&nf->nf_ref))
 		nfsd_file_free(nf);
-- 
2.47.0


