Return-Path: <linux-nfs+bounces-15591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851BC06BFC
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA0134F3449
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF51B319866;
	Fri, 24 Oct 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFOAaKoQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A131D757
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316994; cv=none; b=Lrl+T4Ieh/1tmTM6V9PyvK+4ZUJWbBkl+TSbT72xh3UGR9mAs2hV4CWQRGiHuwtXZTikyvMzUynBQ+5WNDDwKzWojqs7wFSnE7zYsQKz89joN6W/eXUVdj1TWA1W6lPLzSK9THNfAJuf7xxQlAT2KCFDu8UnWvsV7FCHzVTJuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316994; c=relaxed/simple;
	bh=LRPEXm6wqsKbe2cUx02uyzsXclhPhV6LLtJYCDqeZVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a070Onz8aPKKwFQSl1Fue0WIb0h5VdF0SqZsSMTc8mFnxKottm+HfLdZjzdeUCjr3P0IAy/Q/7GLQJKz/FjD6Lq/6VdcDNyuXmpDK4tfH41v2QAdG8KoMoVl3s+W8PCyCFCU8SE0QwwWO4one1lr3kokysf/P4JWvKpdWMD2QLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFOAaKoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61FAC4CEFF;
	Fri, 24 Oct 2025 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316994;
	bh=LRPEXm6wqsKbe2cUx02uyzsXclhPhV6LLtJYCDqeZVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFOAaKoQf8xRqmMMWCtgDz5Ly5UG7nk0DSWpBXJ/OwdNPPAhbAd+4k1zgxY/tbuMX
	 Yjn10qKYOwzO4WgLColyESeaXUCam/aNawyVJnSPYYqPhuAkjpikfC/bnTita0bQ85
	 eL7rxQnejprXsVCRPiy497lX1hTd2S3QAPzbmpy8r+n1IpXYBB3o3nPvn6/W2Rfu+B
	 qOax92+QOiKCd6apO1WuixNpexyjLkWs1epCZwdzkfZ1JY7cVMZ9fiCy/4QWGPFhd8
	 cBGQ9nxRvIwyquKaevAe+dozJ8zC6HLAngKRJk87Knvwo6Iuk628Za6WpSZ69fFLTS
	 DlwTawN5UCsFQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 07/14] NFSD: Remove specific error handling
Date: Fri, 24 Oct 2025 10:42:59 -0400
Message-ID: <20251024144306.35652-8-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024144306.35652-1-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

1. Christoph notes that ENOTBLK is not supposed to leak out of
   file systems, so it's unlikely or impossible to see that error
   code here.

2. There are several ways to get EINVAL on a write, and the least
   likely of those is a dio alignment problem. The warning here
   would be misleading in those more common cases.

It's unlikely that an administrator can do anything about either
of these cases, should they appear on a production system.

The trace_nfsd_write_done event will be able to record these errnos.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 74fcb12bf19c..b50be92343e3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1405,26 +1405,8 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
-				return nfsd_iocb_write(file, rqstp->rq_bvec,
-						       nvecs, cnt, kiocb);
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


