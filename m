Return-Path: <linux-nfs+bounces-16187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41939C4099B
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8E34CE54
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2B32A3C9;
	Fri,  7 Nov 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKSWX+Ff"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97C239E7F;
	Fri,  7 Nov 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529667; cv=none; b=A8iB66V1yiqYvJeDST4dQ6ZM/UNgH7owH7BN0omS8tIeYc+BMSbrHIFCjmjAIkZ2bBXm26cR40EBosLmESAENm6Xp/RgFhZZYTjxZ3KUHXHVP+9jWDb7wh5rF556nNg89JghPZGZvpNqRXHhhbokb8X6WC712JdmLm8QG5N23RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529667; c=relaxed/simple;
	bh=LxNetJZGDoMZFkpRGbsUFYiHX1dIJkPSJNhZIh7fWk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mioMD9bOgDDst19fxrjSLvVkLSu7M1NDxY4vPQ6wwvSu6XlzTYw0CZYfW/7nTUkLNUIM9irv47c2lwHL//BLdKEy55tpWsr0rk0ArY7GrcqoLtX89Tcs0JYR1fO2VwzEDiTCzuBIyKozPH1BrOfzyaxANtCDrhgXJqL/ksGyb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKSWX+Ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD15C116B1;
	Fri,  7 Nov 2025 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762529667;
	bh=LxNetJZGDoMZFkpRGbsUFYiHX1dIJkPSJNhZIh7fWk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKSWX+FfsMx27vKMdLnIXVhMQqCrPvpioKY188pQpJICpX1zPI77ADOc1aaYfI0mV
	 cxbkirMijskTZNQElzCjKRE04R3G3NZbHualo2FN+jgcAlbvt+uDU5qX/ldGyRkSFg
	 /Gz0AdUSmGJEsyMUqj4+j0kAYej55PNlMQIzLLfRKoT96y/8PXjrbqN0fcXgvtE2YT
	 wD5GZib4UO8AN4HkObf11wjhBSUBSGjtJVedIgkfY8LCiOQYzR8QUHwbJ0HO1XTyd5
	 dLyzTgSkdAdkxUoWx8loeEauPbnFuqUHnNCkjEehUbGRzdyWlz3Qk2o/A+e95BS+Up
	 8Hu/UmzQmPEKQ==
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
Subject: [PATCH v11 1/3] NFSD: Make FILE_SYNC WRITEs comply with spec
Date: Fri,  7 Nov 2025 10:34:20 -0500
Message-ID: <20251107153422.4373-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107153422.4373-1-cel@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
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


