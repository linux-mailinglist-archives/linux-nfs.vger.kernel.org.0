Return-Path: <linux-nfs+bounces-17450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 742AECF4F69
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 18:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95886301D953
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6733ADAC;
	Mon,  5 Jan 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzbclifW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1771338939
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633563; cv=none; b=vFL0i80ZVOOJQxOBHBr5Eh43P7fTFhimGMucux0NJiXihCdxJQRstYEL9I7HHXOdZC7agXasAcXopdxXuLiIHk3BCTLt6hFYDt4IszlHcjrwOJHiZ22TfsGeYmShSUeF2P+Kke7wyXKzDyOrhyY8Bthi6/xp68pEeepYXXQLQEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633563; c=relaxed/simple;
	bh=p/67lIYhAEK+7x5UY/L2TVYHOmaObGCqXvvBBf0XioE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pufRWqI5uflxtGheZTNETiUEWPSOzlfJaH8cOsqNCIX/ZcBm7qzIRKczuuFSvTx9Qt3OeeaVlJWNZ7y7H9snsTgOd7su9yJOf4tIKuFfRQVu2EVu+U/u4qetvRJwC2ntjX5SKZoO66oxSp4e2gAb5QTl/fZhOj8BKtSWnMBxqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzbclifW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3609BC116D0;
	Mon,  5 Jan 2026 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767633560;
	bh=p/67lIYhAEK+7x5UY/L2TVYHOmaObGCqXvvBBf0XioE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzbclifW+Kve2Vgt6UVj2vqtwdA2TmCngxmMc0sAvpul2i/P/8f6xxetu8TdVmpZc
	 lwsf3NzP2c6F42LqdT+M/GyScJauIUyCFR9E5w5DXBt+p+bs+A23wfCchtzEvw+zqQ
	 5bBBVX9N0YCX/6DTJCIJKlIBaJB7WcirFTFxHwUlC1PL79EGoxMm/DELJJJgLv3HYl
	 z0sigmsCPxdrsK8aMOh+CH3uoLIPtqn0I+UqkBOShW5rqCVidGCTDCRnYRcLI1hEwQ
	 4dGGg3Q9Vq3L23n1GEeQTtal+Hc6d+UOPPrBhGWHUSboSDat0jZNK7Uj1gA1JWOVXG
	 RE2FDYwux6xGA==
Date: Mon, 5 Jan 2026 12:19:19 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/4] NFS/localio: Stop further I/O upon hitting an error
Message-ID: <aVvyl52wfhyeNGvp@kernel.org>
References: <cover.1767459435.git.trond.myklebust@hammerspace.com>
 <d0d1748668398cd6adfb079fed60409b29167ff2.1767459435.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d1748668398cd6adfb079fed60409b29167ff2.1767459435.git.trond.myklebust@hammerspace.com>

On Sat, Jan 03, 2026 at 12:14:57PM -0500, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If the call into the filesystem results in an I/O error, then the next
> chunk of data won't be contiguous with the end of the last successful
> chunk. So break out of the I/O loop and report the results.
> Currently the localio code will do this for a short read/write, but not
> for an error.
> 
> Fixes: 6a218b9c3183 ("nfs/localio: do not issue misaligned DIO out-of-order")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Thanks, definitely cleaner to not have the awkward force_done flag,
sorry for that nastiness.

But this one needs to be rebased on tip of linus' master due to commit
3af870aedbff ("nfs/localio: fix regression due to out-of-order
__put_cred") which landed after the 6.19 merge.

Like so:

From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Sat, 3 Jan 2026 12:14:57 -0500
Subject: [PATCH] NFS/localio: Stop further I/O upon hitting an error

If the call into the filesystem results in an I/O error, then the next
chunk of data won't be contiguous with the end of the last successful
chunk. So break out of the I/O loop and report the results.
Currently the localio code will do this for a short read/write, but not
for an error.

Fixes: 6a218b9c3183 ("nfs/localio: do not issue misaligned DIO out-of-order")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index ed2a7efaf8f20..97e4733d04714 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -619,7 +619,6 @@ static void nfs_local_call_read(struct work_struct *work)
 		container_of(work, struct nfs_local_kiocb, work);
 	struct file *filp = iocb->kiocb.ki_filp;
 	const struct cred *save_cred;
-	bool force_done = false;
 	ssize_t status;
 	int n_iters;
 
@@ -639,13 +638,13 @@ static void nfs_local_call_read(struct work_struct *work)
 		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
 		revert_creds(save_cred);
 
-		if (status != -EIOCBQUEUED) {
-			if (unlikely(status >= 0 && status < iocb->iters[i].count))
-				force_done = true; /* Partial read */
-			if (nfs_local_pgio_done(iocb, status, force_done)) {
-				nfs_local_read_iocb_done(iocb);
-				break;
-			}
+		if (status == -EIOCBQUEUED)
+			continue;
+		/* Break on completion, errors, or short reads */
+		if (nfs_local_pgio_done(iocb, status, false) || status < 0 ||
+		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
+			nfs_local_read_iocb_done(iocb);
+			break;
 		}
 	}
 }
@@ -824,7 +823,6 @@ static void nfs_local_call_write(struct work_struct *work)
 	struct file *filp = iocb->kiocb.ki_filp;
 	unsigned long old_flags = current->flags;
 	const struct cred *save_cred;
-	bool force_done = false;
 	ssize_t status;
 	int n_iters;
 
@@ -847,13 +845,13 @@ static void nfs_local_call_write(struct work_struct *work)
 		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
 		revert_creds(save_cred);
 
-		if (status != -EIOCBQUEUED) {
-			if (unlikely(status >= 0 && status < iocb->iters[i].count))
-				force_done = true; /* Partial write */
-			if (nfs_local_pgio_done(iocb, status, force_done)) {
-				nfs_local_write_iocb_done(iocb);
-				break;
-			}
+		if (status == -EIOCBQUEUED)
+			continue;
+		/* Break on completion, errors, or short writes */
+		if (nfs_local_pgio_done(iocb, status, false) || status < 0 ||
+		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
+			nfs_local_write_iocb_done(iocb);
+			break;
 		}
 	}
 	file_end_write(filp);
-- 
2.44.0


