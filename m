Return-Path: <linux-nfs+bounces-15664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B34C0DE25
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06F41897A11
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01C257AD1;
	Mon, 27 Oct 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me0FueWX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811A25785E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570516; cv=none; b=hdDLHk1t9cs4lrHQswMAhtxOufFEBPri+NpsecLdaaoS8XqGCzurBZBJmFGRt5/QlP/MJ3efZPh8F39DblHQn9BG4uM2kw02KEu4ruuAtnwIT8KmK4OyZ5NboiscEzPoXVtErl1bLEEs23LfhE15t0qCfZxwnPK4rT/6c1x2s5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570516; c=relaxed/simple;
	bh=5ynLfo+usv5Wt8Tyur+OojNzH3U9UnguJAK3V+ipe7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjkhvLOLhrrpds8TZTgGQNxXnsgIsfrWzblZ1xRoqaBoh6Z+FjdS6VGKOU8RwAdslP1u0LeAH6jrgXJbNdCotPPaQ1RSl9nwerrs17D9ySgi/i6AvrGCbznEBZpYaYhWvZFCYipTvzCEB6NCLY+shICPH5v8SmcqwkbdrMRaNzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me0FueWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C111C4CEF1;
	Mon, 27 Oct 2025 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570515;
	bh=5ynLfo+usv5Wt8Tyur+OojNzH3U9UnguJAK3V+ipe7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Me0FueWXSgwOTO9pNUlRtutOKu8DKC8ZvMpvC8CboZK06y73Qz9XcVfUhnLTI/37X
	 cGOMNsKX+dwcc/uaOlzTZwxuvIIC8ROnKbJi52UDIHmynsHJHoulMB1MvyPWYfwmyJ
	 IgphwROnoOhZi3kM5VGXh07Ek5nAOzGq68Nwymra7WRI3fnCpjg0L1QM+7GRG/iqO0
	 OOoKJG3yEGMHayo5xFJKSOMqt654fgMf2zlaa1PnKeZYipCbse8imIaDvRBDF6FOdK
	 xXddyjLaqn6qwS9eVR9gCbSxl/d81bbudxyA5Lz9mv8pDAUaJNsR+lwvzCWg+dFo9k
	 pDXqcmEnTvgSQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [v6.18-rcX PATCH 1/3] nfs/localio: remove unecessary ENOTBLK handling in DIO WRITE support
Date: Mon, 27 Oct 2025 09:08:31 -0400
Message-ID: <20251027130833.96571-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <aPZ-dIObXH8Z06la@kernel.org>
References: <aPZ-dIObXH8Z06la@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each filesystem is meant to fallback to retrying DIO in terms buffered
IO when it might encounter -ENOTBLK when issuing DIO (which can happen
if the VFS cannot invalidate the page cache).

So NFS doesn't need special handling for -ENOTBLK.

Also, explicitly initialize a couple DIO related iocb members rather
than simply rely on data structure zeroing.

Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index b575f0e6c7c8..7c97055bddb1 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -315,6 +315,7 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 
 	iocb->hdr = hdr;
 	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
+	iocb->kiocb.ki_complete = NULL;
 	iocb->aio_complete_work = NULL;
 
 	iocb->end_iter_index = -1;
@@ -484,6 +485,7 @@ nfs_local_iters_init(struct nfs_local_kiocb *iocb, int rw)
 	/* Use buffered IO */
 	iocb->offset[0] = hdr->args.offset;
 	iov_iter_bvec(&iocb->iters[0], rw, iocb->bvec, v, len);
+	iocb->iter_is_dio_aligned[0] = false;
 	iocb->n_iters = 1;
 }
 
@@ -803,7 +805,7 @@ static void nfs_local_call_write(struct work_struct *work)
 			iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
 			iocb->aio_complete_work = nfs_local_write_aio_complete_work;
 		}
-retry:
+
 		iocb->kiocb.ki_pos = iocb->offset[i];
 		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
 		if (status != -EIOCBQUEUED) {
@@ -823,15 +825,6 @@ static void nfs_local_call_write(struct work_struct *work)
 					nfs_local_pgio_done(iocb->hdr, status);
 					break;
 				}
-			} else if (unlikely(status == -ENOTBLK &&
-					    (iocb->kiocb.ki_flags & IOCB_DIRECT))) {
-				/* VFS will return -ENOTBLK if DIO WRITE fails to
-				 * invalidate the page cache. Retry using buffered IO.
-				 */
-				iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
-				iocb->kiocb.ki_complete = NULL;
-				iocb->aio_complete_work = NULL;
-				goto retry;
 			}
 			nfs_local_pgio_done(iocb->hdr, status);
 			if (iocb->hdr->task.tk_status)
-- 
2.44.0


