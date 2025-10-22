Return-Path: <linux-nfs+bounces-15520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0DABFD563
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 18:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79D1C5826A9
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFD2C21E5;
	Wed, 22 Oct 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYChP11F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE022C15AE
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150160; cv=none; b=JeNlBqKjWjdXuomgRUGqAUknA2IYnOLgRulf2M0b9wvAiCpAMQP3gaJI3jy+NtyX2yfmdhwSqPYfcmwjmQinKwM5SwVSZKsovVMbsn+ohtp1vy52QuSTlkzjMqqRVIe879pXKFci9mE/z8hSCjRftPmiGFExaxaYO4MaN9j0nOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150160; c=relaxed/simple;
	bh=OkC3uCx1EL/ZUw1D6giJSfkAzJ7WIM65kGu2MF9lnRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+UEv6XeTU+25rgSPSUaV56h41ocYaEdpRzNG+4oRs2VUGsv0RdxpiiXu3zASjo7tYeJDAuo86bY5USP/YUgwLGv24tX41qahbdI32JatT4kD4Xax/v80NBIj8+u1GJ+lVZuIfagAdEgGl3Z9OSD+S2D8wTwDvDyP/SiKcyriXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYChP11F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F9FC4CEE7;
	Wed, 22 Oct 2025 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761150159;
	bh=OkC3uCx1EL/ZUw1D6giJSfkAzJ7WIM65kGu2MF9lnRs=;
	h=From:To:Cc:Subject:Date:From;
	b=RYChP11FWkmucN0g+E5kyrG/fMnsIZ33ASLdkrQ0TffPGWb4uKrUGqh/PF6D+WoKC
	 omhRmzZRoyDzVM4fE21Oo8GYjetnWVRVO5ar/nCByf0Xoc/izGKTxZn2ck1PXTgJrL
	 bajMHBs5fboUBeXyArIkQCl23aUltAeu0v8yyfAO/1z6Dx+ZGhePa0fzmuKe3GQ2sf
	 XNC5N/fZuRWPBiec0HxmY95dWRRB9svCruHGXVxDZTsgUWyh2QYUhKdtWxhRk94UAd
	 P2C5VziNBcqjFK2bbdJNxP6vEG2j6vIwLCimWHJ7O1BcsUAlLCfZV4GX4yrQVygwKK
	 DzT/PaF60+9jQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
Date: Wed, 22 Oct 2025 12:22:37 -0400
Message-ID: <20251022162237.26727-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
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
FILE_SYNC WRITEs, so file time stamps haven't been persisted as the
mandate above requires.

Reported-by: Mike Snitzer <snitzer@kernel.org>
Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.org/T/#t
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

This would need to be applied to nfsd-testing before the DIRECT
WRITE patches. I'm guessing a Cc: stable would be needed as well.

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f537a7b4ee01..2c5d38f38454 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1315,7 +1315,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = offset;
 	if (stable && !fhp->fh_use_wgather)
-		kiocb.ki_flags |= IOCB_DSYNC;
+		kiocb.ki_flags |=
+			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
-- 
2.51.0


