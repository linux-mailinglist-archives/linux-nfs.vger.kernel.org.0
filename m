Return-Path: <linux-nfs+bounces-15696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE01C0F234
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C08424FCC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62A3168E0;
	Mon, 27 Oct 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcNY/JEL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F93126C5
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579999; cv=none; b=ILd6Ungof2hjD7IOVhTHxfNirCrN/ftLnIIEhN0yF738grOuO63zAyu8WY4OXCJs5P6vE/MQHfDAxxGq4XVMVcuJQwY9PAOn1/sbrFvFZe8gWeP5suKZiWMYn6oLZ+mfiXrjdpbvcqMjlaQe3f7nBs6lV/rc3WIwtbyBxvYf1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579999; c=relaxed/simple;
	bh=ndAkp/n0zyFKNlYRhqkl6aLV6PNQgX208UDBf6ShZYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3wQ2RKsHYsfVM5Bfq+b8dLzgYxMxArpUib58pXhEZKsC50f9T9WBw9mRLt1PQDxBGKoMZa4wYXn7WW1LmGy0R9bcJCJ+QkJ7jj6t3J8j+jrudFTG2JEbbj9TmczH+elrufP8TBYUN0wSK3KfuRVnqx9NNUIKa5xsBWKhqLfntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcNY/JEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DD1C116B1;
	Mon, 27 Oct 2025 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761579997;
	bh=ndAkp/n0zyFKNlYRhqkl6aLV6PNQgX208UDBf6ShZYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcNY/JELkzVeqk970uKp5ihg+w0aq2s1QqdaJ0yXOoWi5qasjGGo21L0FIvtJvwEU
	 CEpJAwthqhhf7P6usmPhQJwBBkaAxIpOB8QvUY8zA1u1xDy/0+iur67Uj+6v5pwpVG
	 QUwqikgacJFaR+4jkMZWNhryCVykngBKiIVaWOIV+D3YB9ju1zDaci00BzSDUccmuE
	 988ye3kxNMfwHyZK5xt+N15RhX91aPP5UhMz3cQUEkQOcyBvDrjW2V9dcJKZsE4uvS
	 RpgtBeG3oi3CUdaB0EDutkWyXTw1gzcP4WMzvqXOnV4utzXQQ8j1kUwJ+KXwIHGYtw
	 UP+ZJsjbBOhAA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v8 04/12] NFSD: Remove specific error handling
Date: Mon, 27 Oct 2025 11:46:22 -0400
Message-ID: <20251027154630.1774-5-cel@kernel.org>
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


