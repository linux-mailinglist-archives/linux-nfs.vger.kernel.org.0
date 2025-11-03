Return-Path: <linux-nfs+bounces-15938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB50C2D449
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78EA34E6743
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2159B31A54F;
	Mon,  3 Nov 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSeX/Vep"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A0231A54A
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188838; cv=none; b=MsQ32LvzMFLi4XVuS60NaBtj8fm40AQ83DV5dV0pe3eiif/t+3eLAVvNkSbpEksspctC0aOJn9TQ2r3ggAY7wSsYzVHmR2I192X8reUjWX6LkReJuhHrjM9dwdVaxCGX9XC6QiMLT2YwsY62j64o5AarP6HNGkEEjIRR7FFmNqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188838; c=relaxed/simple;
	bh=ndAkp/n0zyFKNlYRhqkl6aLV6PNQgX208UDBf6ShZYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlC9XdAETGDDVl/b5XvVzUAI98V7I1GhIXnVdiXT17itkQp+A+vjNQ+mrxhhS5YCqOmksxuU1rhWFe/5vFWF9fBzBYj6LXraABxKq6SUg1Lbzurf+Cy2NoOASLRY9W5vUwyr8Gl6EJiZHYIw1kP19GXkYJKTEkYaFjX+7c49yZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSeX/Vep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DC9C113D0;
	Mon,  3 Nov 2025 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188837;
	bh=ndAkp/n0zyFKNlYRhqkl6aLV6PNQgX208UDBf6ShZYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSeX/VepjdvVxcBWPRT8fMSjvns3TUcEGy8rUZc/OGGuT4AxssEiPZ5Vy6ci7VlXU
	 m47sQlo6MOSowm13eQtLdi3WdK/yTiRK2P5wYht1pQHCj2vG509NZqHoG+I9rWX0NM
	 4A8UsG3Z7ugx94ISEvdpbppyikmkSf++65+CtFPQkHAnWS/PckzvTxfMABu1RiZ2Qd
	 hzP2L9K45kLK1tyDh4QQBmzciTNHHKGEWokriRDCuLnvT9Zq6FS0tHLMgdHd4bCwFW
	 Ot0F5YOfYH1HCZG3E4g6gnIWdeLVK0lgIqXzIwpv5E2SMvm+WF9rCD9VV3ylnpk0s4
	 jppKZCaRdcqhw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 04/12] NFSD: Remove specific error handling
Date: Mon,  3 Nov 2025 11:53:43 -0500
Message-ID: <20251103165351.10261-5-cel@kernel.org>
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

1. Christoph notes that ENOTBLK is not supposed to leak out of file
   systems, so it's unlikely or impossible to see that error code
   here.

2. There are several ways to get EINVAL on a write. The least likely
   of those is a dio alignment problem. The warning here would be
   misleading in those more common cases.

It's unlikely that an administrator can do anything about either
of these cases, should they appear on a production system.

The trace_nfsd_write_done event will record these errnos when they
occur.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6cb0efd8ecdd..30094d8f489e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1408,26 +1408,8 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_fil
 			kiocb->ki_flags &= ~IOCB_DIRECT;
 
 		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
-		if (host_err < 0) {
-			/*
-			 * VFS will return -ENOTBLK if DIO WRITE fails to
-			 * invalidate the page cache. Retry using buffered IO.
-			 */
-			if (unlikely(host_err == -ENOTBLK)) {
-				kiocb->ki_flags &= ~IOCB_DIRECT;
-				*cnt = in_count;
-				kiocb->ki_pos = in_offset;
-				return nfsd_buffered_write(rqstp, file,
-							   nvecs, cnt, kiocb);
-			} else if (unlikely(host_err == -EINVAL)) {
-				struct inode *inode = d_inode(fhp->fh_dentry);
-
-				pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
-						    inode->i_sb->s_id, inode->i_ino);
-				host_err = -ESERVERFAULT;
-			}
+		if (host_err < 0)
 			return host_err;
-		}
 		*cnt += host_err;
 		if (host_err < iter[i].count) /* partial write? */
 			break;
-- 
2.51.0


