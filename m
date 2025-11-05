Return-Path: <linux-nfs+bounces-16086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA56C3779B
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 20:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54DF34E2D83
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B633E34D;
	Wed,  5 Nov 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSBZwarw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1632D431;
	Wed,  5 Nov 2025 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370893; cv=none; b=YvB+iXVG27d+MrNhuqfR0s8Kr0k4eWk6YE9gITOd7MencC2glXER0VsSXPYd3aTZnCYEwN0XSaNWh9SuWHMHrMhxf8RvlHKJEY/4CCrwffVXay5vFcXibp5KKjhBFBAHt4NC2Ym4NsHaR+XdzFdxSgahE9EXVcvoop/0vGgLoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370893; c=relaxed/simple;
	bh=IHr11CVMUl96Wf7pB/+uXQyisnt8qEF1vZ/qiyhjdBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlBI1x/WSsVmltj2GCwXL1mjbhPZ4kjCeo5a3XCWjot7mkW6DOmQA3o8nuHGuJoMeBZmeW5I3FOBKxZWp/+hYP0UwyczIIcW1TC4Gxyt+VD4NAi5KvBh4Y0TmZ3x7m02Esf6lpeEwZbHuSWe5Bq2zowHkqJp7fZPoobUx84HGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSBZwarw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7438C2BC86;
	Wed,  5 Nov 2025 19:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762370891;
	bh=IHr11CVMUl96Wf7pB/+uXQyisnt8qEF1vZ/qiyhjdBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSBZwarwKq2oZpjqjSnq0/v1DlJZ7D6N0ijNqG/si0cLffaToSXpZy3xmbAirGbDv
	 uEy9dPkClf4RolqbU9iSnepmTVJB82JOkoNf2Rj8dafhmBNHlBdSkcUcfy+NQ95fel
	 zzpXxmHlSJtDEy5a72RWPxMTXYzMIDFuEAFb0EgkBjIbAEBGpvitzc3taKWXdnXmU6
	 7wY08FIrftJCTia4nz7TpFQCSi4hL85DwoDaSzXtrDOk0KSGXjfPIl+WurGTjIBgR4
	 QK3qa8/9rBMK0Y9UJ4ohmpcv2jgPAqpsHgkyb6eIIkoN3eUR347njWDGjZxcSZaBx9
	 y9zIJjvh7Hv7Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v10 2/5] NFSD: Make FILE_SYNC WRITEs comply with spec
Date: Wed,  5 Nov 2025 14:28:03 -0500
Message-ID: <20251105192806.77093-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105192806.77093-1-cel@kernel.org>
References: <20251105192806.77093-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Mike noted that when NFSD responds to an NFS_FILE_SYNC WRITE, it
does not also persist file time stamps. To wit, Section 18.32.3
of RFC 8881 mandates:

> The client specifies with the stable parameter the method of how
> the data is to be processed by the server. If stable is
> FILE_SYNC4, the server MUST commit the data written plus all file
> system metadata to stable storage before returning results. This
> corresponds to the NFSv2 protocol semantics. Any other behavior
> constitutes a protocol violation. If stable is DATA_SYNC4, then
> the server MUST commit all of the data to stable storage and
> enough of the metadata to retrieve the data before returning.

Commit 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()") replaced:

-		flags |= RWF_SYNC;

with:

+		kiocb.ki_flags |= IOCB_DSYNC;

which appears to be correct given:

	if (flags & RWF_SYNC)
		kiocb_flags |= IOCB_DSYNC;

in kiocb_set_rw_flags(). However the author of that commit did not
appreciate that the previous line in kiocb_set_rw_flags() results
in IOCB_SYNC also being set:

	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);

RWF_SUPPORTED contains RWF_SYNC, and RWF_SYNC is the same bit as
IOCB_SYNC. Reviewers at the time did not catch the omission.

Reported-by: Mike Snitzer <snitzer@kernel.org>
Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.org/T/#t
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Fixes: 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()")
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f537a7b4ee01..5333d49910d9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1314,8 +1314,18 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		stable = NFS_UNSTABLE;
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = offset;
-	if (stable && !fhp->fh_use_wgather)
-		kiocb.ki_flags |= IOCB_DSYNC;
+	if (likely(!fhp->fh_use_wgather)) {
+		switch (stable) {
+		case NFS_FILE_SYNC:
+			/* persist data and timestamps */
+			kiocb.ki_flags |= IOCB_DSYNC | IOCB_SYNC;
+			break;
+		case NFS_DATA_SYNC:
+			/* persist data only */
+			kiocb.ki_flags |= IOCB_DSYNC;
+			break;
+		}
+	}
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
-- 
2.51.0


