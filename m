Return-Path: <linux-nfs+bounces-15935-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B079C2D478
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CB0188E0C1
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19226ED48;
	Mon,  3 Nov 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSwBLf7r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87283305068
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188835; cv=none; b=jFwWlaozZgAAjJof40iKovlMRcyoME2zLPvZKnrSph6oMSv+T4b5wt3YLM2MnjBt0vzsUcHt0JwqLPN8swCd8BmkGGuJf7NCFRq4yhZ9R/QoakvYi10ybSAnz6yO/Qv9x9KPEJLbsUSTN+2i17jfZNzQWx8UJtN+Kkh6ughQ/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188835; c=relaxed/simple;
	bh=IeJk6dGpG4xVCHwt0EFWT6QDrXnjwqvt+6J/WeBZAeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRyPPv/HJN+zRkv6heX0Azb1yRmY+IKLqMP2IeF2ZeksT0O+dE156jJESBCoWJz9aEGDMvJ9LPxtLnMzHZtDrb0X9exyyQWa8uaWlCPk9Yqar4anu4TLl1S/4jXwTaJSp/IdwPQHF26sHJfV95gbtEZXJkSezGUn6AM2o1VW5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSwBLf7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56894C4CEFD;
	Mon,  3 Nov 2025 16:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188835;
	bh=IeJk6dGpG4xVCHwt0EFWT6QDrXnjwqvt+6J/WeBZAeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSwBLf7r36HXNpl1mB4UsmOp6RUDcB207/Vm4UhZBy45N+UjQsZCiZCd6bQSZ1fN7
	 j5tr0Z2PqZFFmuDfGm8Q/cthdIRYE+iT4kSjClwNEAvSlvN4HILNdjSuZJXmPoAhYA
	 /0TjaIsg6kxzSeZ8JQXxegGGpCbHX13pf3qTAUxA+F2XGTDJvNtDLIOWRs7Y6haUTa
	 1oH49maGSGMJTXCvLokCBrJtEB+Xqsh1fmDcsQ2Iw9yAp+aNeuloealmPN7r7h5oCD
	 F5VpLy4nQsAndesXGQrYlNRWDXLgRKvftvGeFQdHO5vyyOzWaKLdsu9ERomF4Xn7f1
	 MhREGZTk/hSWQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v9 01/12] NFSD: Make FILE_SYNC WRITEs comply with spec
Date: Mon,  3 Nov 2025 11:53:40 -0500
Message-ID: <20251103165351.10261-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103165351.10261-1-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
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

For many years, NFSD has used a "data sync only" optimization for
FILE_SYNC WRITEs, in violation of the above text (and previous
incarnations of the NFS standard). File time stamps haven't been
forced to be persisted as the mandate above requires.

For many in-tree Linux file systems, time stamps, as well as other
metadata not needed to find the data on disk, are piggy-backed on
fdatasync-mandatory metadata updates. Thus, this change should
affect only the case where previously fully-allocated file data
is overwritten.

Reported-by: Mike Snitzer <snitzer@kernel.org>
Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.org/T/#t
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


