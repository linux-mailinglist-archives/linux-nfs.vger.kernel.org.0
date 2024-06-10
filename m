Return-Path: <linux-nfs+bounces-3632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3F9024E3
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 17:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A867A289E0F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5D0823DD;
	Mon, 10 Jun 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DavDyoRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A081745
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031903; cv=none; b=G3l0EJiHBmUzV8dw/5mLn9FLcreBjf34fMGZgV9/SdLzhi45EGW0J8wZhCQ/9Y2Y4oHqO/tz07I+Iz0RdJhkpbWJ3qCOQP3Xuu7TsIoLV53+vLesgwsd/ufecW0KN7vl34B2qSddNXjZR4NEELAtgorp8dPnLNFYE2OV83M1Igw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031903; c=relaxed/simple;
	bh=kq3K7LcD1BoPr2eSNzt/cYDuk42K5+3aVzq+8f3oqDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2Tpexddw6J9Fu1ZvcV29La8Ya0suCRha+a97qBJznNEVPRx0rIhZOgbjDidzjPXy5w6JgBH/jBOIG1MNr6UOBNndhPvyQQOHxCR2NPlkpYqjfwkmGKTQolLgxGwnZtQEAavNAwCNZhbtOrYd2kwLXgAmuvgbzpwujdXHd86aF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DavDyoRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1551AC4AF1C;
	Mon, 10 Jun 2024 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718031902;
	bh=kq3K7LcD1BoPr2eSNzt/cYDuk42K5+3aVzq+8f3oqDA=;
	h=From:To:Cc:Subject:Date:From;
	b=DavDyoRqyxHBpVMjBBV0UrLMe0C8+3LWeiNlfMWjAeoUGOym7qxWswTqsFX1C+0vT
	 4rjk8x3GbCRsgGGigjV/ZnP1WTzZK/cTlz8k37qOGPlPXF3Q+xQ2Zfq90M49qkvqNp
	 P4Y+CLGixitLuYLt3xhLM4Oc5Ja/tsVf4vqrDfqQRPE6ueUoKCFk5QmPhtup05YQl8
	 +3+bwVP9sYVtQ4zyGI2Amnga9DfF+cdUupsXs3KS6WWinWbR6egZH0+mGXWGTzCFzw
	 hFd3BYoqeD/Iw+0TpiwZ/i8tHWoalrLnilrikZvEwOvPKEA7smnfzldxBGxgLwBsR+
	 15xkaMfExuZhQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Dai Ngo <dai.ngo@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>,
	Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT operations
Date: Mon, 10 Jun 2024 11:04:49 -0400
Message-ID: <20240610150448.2377-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2635; i=chuck.lever@oracle.com; h=from:subject; bh=QE9KSot7taHKrSYc7yBZKf0MP+x9YMZ0sTze2y7lsNw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmZxYQQDKdL6Ehap2DAJpIZm6DKhmaO3kWcIoTq l7M+cr5nA2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZmcWEAAKCRAzarMzb2Z/ l81rD/43iUqKr8uIpD/JjAooAwAD/LWxP0Z/QLlQsQDcz3sBo0uwHMvEfn2hzdOmqGBLJP5rS5X 3KEWoblrOGGzmFoFEgCGhiq0rvTxfXCZw4BV/UyiFrAwitgkXg/YFeKQM2nu+QWxz7pYe7fpUho K1ckRzbrPECvfJubT6quhWT51OxRqhKt2BUalm5h+EvQ9Twer2cWZr2mLiR1+nO8ud5MoFrLC8D 9wV8f2IsIYlu4X6j6X6iA9xuFL4esd99KNtdTCh06pKhNMIN/5ph02iH3KS7BaZ82bJBE0Ev7Ot FOjySW5dgd9J6F08EHRH3GkOPPW18l6yUv++RL64B+dtkWzpB7JJbg1Bw/jL3V0wLLXZZRcGRNM 1GSYemA21GJB4tvw/+hZJd5LUbtwa4j74YTHgKmiaSRKCQwKU3ziUT42PHbo+BgMXqxO04lOp9k 9mMgE9xuMjhyMUI+rOc+/NnVKExdxcxUZpUWxbD5ttoh2MoWkkMrNE7AEKk4NR6xoMCAT8jVoGQ l2q3VacEDJD2Cr9UHdrolztqk6wLn6OpCNc09ljl/wGUNs4eScWCR+tafV/+4VRbLjw/y5DIe/h +AiUQizVx0tXyyo2N5TNNDJ4rWXj1qkrmuzXaK1MJCzZnbQbS3h9eLxKbpfHu+p1yLMsKG2RHOb CbR04EnkNkFsexg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I noticed LAYOUTGET(LAYOUTIOMODE4_RW) returning NFS4ERR_ACCESS
unexpectedly. The NFS client had created a file with mode 0444, and
the server had returned a write delegation on the OPEN(CREATE). The
client was requesting a RW layout using the write delegation stateid
so that it could flush file modifications.

This client behavior was permitted for NFSv4.1 without pNFS, so I
began looking at NFSD's implementation of LAYOUTGET.

The failure was because fh_verify() was doing a permission check as
part of verifying the FH. It uses the loga_iomode value to specify
the @accmode argument. fh_verify(MAY_WRITE) on a file whose mode is
0444 fails with -EACCES.

RFC 8881 Section 18.43.3 states:
> The use of the loga_iomode field depends upon the layout type, but
> should reflect the client's data access intent.

Further discussion of iomode values focuses on how the server is
permitted to change returned the iomode when coalescing layouts.
It says nothing about mandating the denial of LAYOUTGET requests
due to file permission settings.

Appropriate permission checking is done when the client acquires the
stateid used in the LAYOUTGET operation, so remove the permission
check from LAYOUTGET and LAYOUTCOMMIT, and rely on layout stateid
checking instead.

Cc: Christoph Hellwig <hch@lst.de>
X-Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 46bd20fe5c0f..c24f45870b28 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2269,23 +2269,17 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_ops *ops;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
-	int accmode = NFSD_MAY_READ_IF_EXEC;
 
+	nfserr = nfserr_badiomode;
 	switch (lgp->lg_seg.iomode) {
 	case IOMODE_READ:
-		accmode |= NFSD_MAY_READ;
-		break;
 	case IOMODE_RW:
-		accmode |= NFSD_MAY_READ | NFSD_MAY_WRITE;
 		break;
 	default:
-		dprintk("%s: invalid iomode %d\n",
-			__func__, lgp->lg_seg.iomode);
-		nfserr = nfserr_badiomode;
 		goto out;
 	}
 
-	nfserr = fh_verify(rqstp, current_fh, 0, accmode);
+	nfserr = fh_verify(rqstp, current_fh, 0, NFSD_MAY_NOP);
 	if (nfserr)
 		goto out;
 
@@ -2359,7 +2353,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
 
-	nfserr = fh_verify(rqstp, current_fh, 0, NFSD_MAY_WRITE);
+	nfserr = fh_verify(rqstp, current_fh, 0, NFSD_MAY_NOP);
 	if (nfserr)
 		goto out;
 
-- 
2.45.1


