Return-Path: <linux-nfs+bounces-6233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AAC96DE42
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FBC28AFA4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955B419D89F;
	Thu,  5 Sep 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rerW2dBY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046B1990DB;
	Thu,  5 Sep 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550281; cv=none; b=F6ode3eJ+TvfHCr1qVXqLh8UVe6jownkuHPyWsTsPtbsm5wdf9xBJP/Oe5WiRINwKR6JDFbEolH/u/bTq2URoCaov9qqbBP5FywbSNyoZPtMJQUXPGYu7YZq44tprnKbQjoBhI2cIxJeNLXXTleRGVqtyPnW4iX9X3yV9RKE7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550281; c=relaxed/simple;
	bh=sC1/iL1dmpaemnuvjwrIrZ3UtzfQfiIOzCjvUzGrhMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3S5iUroF8VnAVGzNXDBMK49raIXCAyvzgedDKUateFOIHYRVgKqlititrpEYuf6cTayx3cNKlgTHSwuJaPSqXnAg6D3HD4buy/M1G0EGCLt2WGd92QojEQYFLHmKkmDUJLS1tf9W5IdVomIRseDqGirUXyc9PLPtCPDKXo4uuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rerW2dBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3060DC4CECA;
	Thu,  5 Sep 2024 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550280;
	bh=sC1/iL1dmpaemnuvjwrIrZ3UtzfQfiIOzCjvUzGrhMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rerW2dBY+knC5whO5CafwLA81S1cV4UZOaBQI4Ve36bVQe6hEjGEkWsh9YsQE+xvE
	 u5KMcax+kdK77v+jFsxd7yVMm6Yi6SElncoSOoa6WHstYsOeMFTSts0vWPsbI6hkjR
	 8vQyRwYmspaX+RRfAn1zHephvCzUHJIWOLVkZijsu5oAHDkWB/mZU9yZnL40v4E3nC
	 lGx6dbtEGJgCS5sNHW8niT1QqisMkIDlvZICKpDOhEzSoCVgtkIAHygq6/LNLUgytn
	 6XTr/Pdaxnn9D0DifMz0m/2ZeuMtlEOPHEhpyGd/GvgVNXTmtmWaYswMPYizx3rLcg
	 0OwVVTaBiCsAw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10.y 04/19] NFSD: Rename nfsd_reply_cache_alloc()
Date: Thu,  5 Sep 2024 11:30:46 -0400
Message-ID: <20240905153101.59927-5-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240905153101.59927-1-cel@kernel.org>
References: <20240905153101.59927-1-cel@kernel.org>
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
index d078366fd0f8..938b37dc1679 100644
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
 
@@ -457,7 +457,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	 * preallocate an entry.
 	 */
 	nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	rp = nfsd_reply_cache_alloc(rqstp, csum, nn);
+	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
 	if (!rp)
 		goto out;
 
-- 
2.45.1


