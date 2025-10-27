Return-Path: <linux-nfs+bounces-15693-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBDBC0F147
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B451884FF4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D103115A1;
	Mon, 27 Oct 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUzZYS1l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14D3112DC
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579995; cv=none; b=PLMlM5/MoTwJ5JNrLJuQ7syCTWvGHQ1In1KDVqTuE7xhKnAH6R9FJ6zL75rRonQIa+z0fatyw3eyLY5AULG+VgyLDVE74N1wOt5yMFtaQR5gBjGgclncdM65ljn4KyJZBW+8n9a5KhHOjRZR24B1F5rks3zEE10QN1SJnuCN1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579995; c=relaxed/simple;
	bh=IeJk6dGpG4xVCHwt0EFWT6QDrXnjwqvt+6J/WeBZAeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUG9sHBhl/QCi5rbWD25arN44LYfF7W5m4MvpUDtDjM8hXBfRXUgBa9KvDr0ZmKvUgAvFk4TygK5GMEne3umZJyjULaXzs+zsd5VZYfpVR2NPfjGDrhWQgJVcMI4oE3HLI7WgU+qEqifVw1r3pg31CvFewCPP6yNhYVPq6NXqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUzZYS1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F94C113D0;
	Mon, 27 Oct 2025 15:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761579994;
	bh=IeJk6dGpG4xVCHwt0EFWT6QDrXnjwqvt+6J/WeBZAeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUzZYS1laEyFEb5kWKLulmWsqZrZ/iST/VIPlmuBCU6pyCi1UGqdEzlmkO5461Y88
	 xVjmZ9bd9poye2mLYVrhdGRdCLptMwqEDnb89ky9hq3tukaf55c6HK6ZqbwF5W4mnj
	 8pulwLNozb/Q/Cp0J3x8YBQAyn1WULKE55cQYxOR4Spe4IPrjMM9CdVhvZBY2mi2et
	 azDUEB0Jes6NEN5j5h3u83RIMX9LAe00m4xz3ZaE7bk2IdSB1h6xXXqCNg3ZrCZiyQ
	 pJAmfitaUOBPI/W1+lwI1XJ16kE9VnGmqwi5ITUHpQODMSP4JJyf6L0iu6N5mw8uik
	 kPukmATqc/8SQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v8 01/12] NFSD: Make FILE_SYNC WRITEs comply with spec
Date: Mon, 27 Oct 2025 11:46:19 -0400
Message-ID: <20251027154630.1774-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027154630.1774-1-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
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


