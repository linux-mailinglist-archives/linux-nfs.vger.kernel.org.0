Return-Path: <linux-nfs+bounces-5284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD2794DE5B
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A25B21B44
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8EC47A62;
	Sat, 10 Aug 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQCfwWyj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732A200A3;
	Sat, 10 Aug 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320044; cv=none; b=F7gHA4SEIR19gDKrFxbOoYw8eQeqxwQWir4k/mowScyhKooVp1iq+MCUjK6uNZj+27ODXYrRyECyv+tcQYU6bRyQdd4tIAsp2TJINMoy2KAZ9iXKYQ73A+o5xCAG10BtTPu4uqO3wDRh/vSX13ny6xYqULVmaXXnphZ9hFaVd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320044; c=relaxed/simple;
	bh=bYEaJWLj7WvO1gjmZkrqRMfvr47GaQ9woj3BIKqwm3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYVRPB7cOGNosGMl78JinELHIC7VlGscJxYzx7dvzzF3aVO0kTQbpaZrHKt8EzKl4JnsNWZsESm7DSRFaU6YkVmB7I/3A0/SoyeXRnpxuiW0eVbKk6qgEb8bC04WNf7K7FTRv5PivYjGRzhAwF6WUNJJBLxhsQ7D7xtSdOTJkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQCfwWyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FF3C32781;
	Sat, 10 Aug 2024 20:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320044;
	bh=bYEaJWLj7WvO1gjmZkrqRMfvr47GaQ9woj3BIKqwm3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQCfwWyj4+ZvPO+ooydqY9T2Ny5Ik/g2Hcv7ls3ACERCspAggDmHF6p/U48kuYOT/
	 1j7zWCRn3GxbJsbyr6TSuonZ2Ko6Pmm+jMF3ISp79wPjkvGPnpxUnSY7B4IDanjeCe
	 AsCQxaH3gfcbt4PeePFAa9quGC0fHC5PUC7uBQEDuiou/iS0+8iNMZGuw9YTiId6lc
	 qKt+E5AB7f+VN5XsL0czfxeY8XJu8o4dSLJ0O/h+bKAy5fpYfKqAcGveNnVqrUMuOv
	 n0843IDGgZc4oaXDTcfAsqz+ZwYh2eO4fLf3lmjM8iDqlKaKX0bVvCg6Kt4pvTiB77
	 C5EXtNoafcUBw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 04/18] NFSD: Rename nfsd_reply_cache_alloc()
Date: Sat, 10 Aug 2024 15:59:55 -0400
Message-ID: <20240810200009.9882-5-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit ff0d169329768c1102b7b07eebe5a9839aa1c143 ]

For readability, rename to match the other helpers.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: 4b14885411f7 ("nfsd: make all of the nfsd stats per-network namespace")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 11d00b2853ff..16e62e92964a 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -85,8 +85,8 @@ nfsd_hashsize(unsigned int limit)
 }
 
 static struct svc_cacherep *
-nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum,
-			struct nfsd_net *nn)
+nfsd_cacherep_alloc(struct svc_rqst *rqstp, __wsum csum,
+		    struct nfsd_net *nn)
 {
 	struct svc_cacherep	*rp;
 
@@ -481,7 +481,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 	 * preallocate an entry.
 	 */
 	nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	rp = nfsd_reply_cache_alloc(rqstp, csum, nn);
+	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
 	if (!rp)
 		goto out;
 
-- 
2.45.1


