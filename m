Return-Path: <linux-nfs+bounces-16269-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4893C4EB0C
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 16:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4D242136F
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8911933F36B;
	Tue, 11 Nov 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSMr5eqZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195D328250;
	Tue, 11 Nov 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873176; cv=none; b=a3p+N4tQg/nNHvfENtgdmmdT5xuRakswWwjM2glTt99Aary9l4sC+/sNWn+ipvqoAhEjmNXqd52689I/yiVYDv1zCPW3V9yVluk89uAfvXZ2VjgmGh0FqslTPlZrbN7xV2/rEV9iMGM70Sy6hSg+RSh6rMLxEa836lkOyBcmqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873176; c=relaxed/simple;
	bh=LxNetJZGDoMZFkpRGbsUFYiHX1dIJkPSJNhZIh7fWk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+mNLTBL6ngHiS7I8X3ad7Tbpw8sN6b5c9BG5fJ7Xa4atwmOM9T6stUWoIYrlJfNvw0Qu6zuiDyW44g6hdFi/F7EtOonRnU+dcK+YFs3wfOiAEz5xWyUEg6Zb4jEa4mfbrjTL9vxWByRtKkjyZcLc39lf0MhwIOQ3A9h3RvcE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSMr5eqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9ADC4CEFB;
	Tue, 11 Nov 2025 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762873176;
	bh=LxNetJZGDoMZFkpRGbsUFYiHX1dIJkPSJNhZIh7fWk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YSMr5eqZ8LK0w9kVtLdjPifCdbzJ+mutFed+j9n8kK44l7IXm0AKHuAJFG5lAFGqU
	 zjY5JtBE8ll/ifVz3G233aMhBUXiBNBXJxNhCucx10A1mdf5XvWslooD6Xj0AJow1v
	 YlgK5e/dVuXraSXhdgnR2VCIHCY50OnKfa+wOfTfw57tYf2Z0aFg5fgJCs5M+uGoH7
	 86jPh6wWw5b0xHDFqw+KZ9GPwIdE8D4OypkeZ03MOV/W0Lcxq/ICam8lKXKzcLB25u
	 CMqfZFdLwPGNNE+rlemV2ZFHrdG08hk92hwVxdUSAcbaKToXChe/f+HBks6zdmdTFF
	 oiN5/dEN+fVCQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 1/3] NFSD: Make FILE_SYNC WRITEs comply with spec
Date: Tue, 11 Nov 2025 09:59:30 -0500
Message-ID: <20251111145932.23784-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111145932.23784-1-cel@kernel.org>
References: <20251111145932.23784-1-cel@kernel.org>
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
Fixes: 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


