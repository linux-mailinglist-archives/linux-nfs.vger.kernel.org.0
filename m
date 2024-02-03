Return-Path: <linux-nfs+bounces-1730-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A940847FFD
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 04:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02043B26FEE
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 03:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDAB10A22;
	Sat,  3 Feb 2024 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJo5F010"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853410A1B
	for <linux-nfs@vger.kernel.org>; Sat,  3 Feb 2024 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932535; cv=none; b=EofEBRH1BVJx0S77Yz2hIW+PoRoF+HrUnfS9WThJN3BA9oubbP2suIE36Kzb9OiyawjJ1i+GK89a+MmJBIf6SlKc6uZVzkFvucVPHhP5hlC3YoaCLPgnz76bhUebSPDudIdv8pzKYKUe9IAd+CMeMAJJnVixSr/EYlHKLYqBQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932535; c=relaxed/simple;
	bh=3JhWXnXAyIBC3cBayV1jU6/VwT31A3lf3zsffcB2WPQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBcZ/CNCaefQo5+wd8jnnxLl0mbEBQ3jIpZ8bmB16yhAN4LDpueekV15ciJR/kXafVspPxpg/l8514s8vWICMCD+HmltvcKO3YA/6kX6Ldz4wm8vzH7B80S99i8F/f3hDSEW9ZGBUi6hxKvVytjFhHDg5k0ZKEYf1C0NhzU+s9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJo5F010; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ADBC433F1;
	Sat,  3 Feb 2024 03:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706932535;
	bh=3JhWXnXAyIBC3cBayV1jU6/VwT31A3lf3zsffcB2WPQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KJo5F0101gMovfI1zQ08hfswUsJ05jf3j4lXszlJEUc9zCsgye82LPemDrY+3S/hB
	 /4aTLhXCHj1iRVXY0FIljV6qxzjYcToA8W8ldPNBjs3LWPyxdq96zSLms2fQeBVfE3
	 QXgbJNfGU33jN9ZhIzPRsuKOJ+pn2baJm913bqUBeuqhijlcSmg39Twau97Jw32vHv
	 +R1xGGsaRSn7BvjuXBkt2/Y4Fn0PG61owA51UOkboyPrsZXg9q9ap49B0p7huuXe09
	 FPt2HuihjnN3EQaUD3TpYo9WLlj+27xJ1AIzXj/AbFwS+BC3miy02pbNbE3VwawzYO
	 4CO058zwJ0ypw==
Subject: [PATCH v2 3/4] NFSD: Add documenting comment for
 nfsd4_release_lockowner()
From: Chuck Lever <cel@kernel.org>
To: neilb@suse.de
Cc: linux-nfs@vger.kernel.org
Date: Fri, 02 Feb 2024 22:55:33 -0500
Message-ID: 
 <170693253396.20619.10448760567426451218.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170693220850.20619.2532987152854323295.stgit@klimt.1015granger.net>
References: 
 <170693220850.20619.2532987152854323295.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 043862b09cc00273e35e6c3a6389957953a34207 ]

And return explicit nfserr values that match what is documented in the
new comment / API contract.

Stable-dep-of: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index af8665ad6af3..0475b483c421 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7303,6 +7303,23 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 	return status;
 }
 
+/**
+ * nfsd4_release_lockowner - process NFSv4.0 RELEASE_LOCKOWNER operations
+ * @rqstp: RPC transaction
+ * @cstate: NFSv4 COMPOUND state
+ * @u: RELEASE_LOCKOWNER arguments
+ *
+ * The lockowner's so_count is bumped when a lock record is added
+ * or when copying a conflicting lock. The latter case is brief,
+ * but can lead to fleeting false positives when looking for
+ * locks-in-use.
+ *
+ * Return values:
+ *   %nfs_ok: lockowner released or not found
+ *   %nfserr_locks_held: lockowner still in use
+ *   %nfserr_stale_clientid: clientid no longer active
+ *   %nfserr_expired: clientid not recognized
+ */
 __be32
 nfsd4_release_lockowner(struct svc_rqst *rqstp,
 			struct nfsd4_compound_state *cstate,
@@ -7329,7 +7346,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	lo = find_lockowner_str_locked(clp, &rlockowner->rl_owner);
 	if (!lo) {
 		spin_unlock(&clp->cl_lock);
-		return status;
+		return nfs_ok;
 	}
 	if (atomic_read(&lo->lo_owner.so_count) != 2) {
 		spin_unlock(&clp->cl_lock);
@@ -7345,11 +7362,11 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		put_ol_stateid_locked(stp, &reaplist);
 	}
 	spin_unlock(&clp->cl_lock);
+
 	free_ol_stateid_reaplist(&reaplist);
 	remove_blocked_locks(lo);
 	nfs4_put_stateowner(&lo->lo_owner);
-
-	return status;
+	return nfs_ok;
 }
 
 static inline struct nfs4_client_reclaim *



