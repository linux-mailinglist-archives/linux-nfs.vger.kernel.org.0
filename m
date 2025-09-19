Return-Path: <linux-nfs+bounces-14604-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48866B8A01D
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55370189896D
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE472EC08F;
	Fri, 19 Sep 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVBmZN3p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3524DCEB
	for <linux-nfs@vger.kernel.org>; Fri, 19 Sep 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292602; cv=none; b=ao5u5l+hFCyNzZ3AKAmYnbqLa+FGTb3adroLySBJOl4Mb8OHWvZUPIj7a9Eo3Kh0nqzSu0BhrAodPCbFpvVzeFWxzxR6vJUcOElQM6xtiasIKorlLJJ4ZOP5QcbT8q3503vQOO7sBMDDg/pBCrRGNDpaIGjkDdEHcgJ6WWsNlJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292602; c=relaxed/simple;
	bh=/1Vw5YoQjOKjMuhpjdlLUjh/2t/6sgQX6HCxbk+GB2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzqvR0akhA+OvTSquaYy5p9dIUyFG3+4iHrYDlIKoAOrgdkuoZ09g4Is/lqKGAvud0RJZf1hKNBQv7jqFbkoCCst82Y2ceQGTW+RyWVyeI+RjdSUs5kt5SwPw5viadEHrXXfxJ30hlm1KzM0Gwzw3Tv+ZY4AfDQ/kUBB+6PB1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVBmZN3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFA1C4CEF0;
	Fri, 19 Sep 2025 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292602;
	bh=/1Vw5YoQjOKjMuhpjdlLUjh/2t/6sgQX6HCxbk+GB2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVBmZN3pCsxBWBqp74R//Q7f23Jrp9FIHWyGfJtPuDnMXYRPRhIHbpMwDNhqW52ht
	 vcHzGotppAZEJvmQFlQmZE965cCZGsJ9Nz4tn1AvrBTWrkUwd8TrOQAnmmBmQ6CZ6s
	 HNrEL1vc8vS6EjDGECUoFQ6Fs2T16Gw3Uisbg+0+ilSuRz4PI7gfosPxlUdav3LNiH
	 +2ScVVW1WtD6QGxl9JgDIrku7pAfcphzdl2sajyLzXcbNOmz6xliw9b3xvlHa8HwYI
	 lb2mevfdbCF2jG1XK8W7fSxpV/5SDEaIAO0dMUiGR7O0LgKf6ghCNQWT9R0R7/0knQ
	 cgXtJ5Cbo5Log==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v11 7/7] NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Fri, 19 Sep 2025 10:36:31 -0400
Message-ID: <20250919143631.44851-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250919143631.44851-1-snitzer@kernel.org>
References: <20250919143631.44851-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFS doesn't have DIO alignment constraints, so have NFS respond with
accommodating DIO alignment attributes (rather than plumb in GETATTR
support for STATX_DIOALIGN and STATX_DIO_READ_ALIGN).

The most coarse-grained dio_offset_align is the most accommodating
(e.g. PAGE_SIZE, in future larger may be supported).

Now that NFS has support, NFS reexport will now handle unaligned DIO
(NFSD's NFSD_IO_DIRECT support requires the underlying filesystem
support STATX_DIOALIGN and/or STATX_DIO_READ_ALIGN).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 49df9debb1a69..84bf3d21c25cc 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1073,6 +1073,21 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
 	stat->btime = NFS_I(inode)->btime;
+
+	/* Special handling for STATX_DIOALIGN and STATX_DIO_READ_ALIGN
+	 * - NFS doesn't have DIO alignment constraints, avoid getting
+	 *   these DIO attrs from remote and just respond with most
+	 *   accommodating limits (so client will issue supported DIO).
+	 * - this is unintuitive, but the most coarse-grained
+	 *   dio_offset_align is the most accommodating.
+	 */
+	if ((request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN)) &&
+	    S_ISREG(inode->i_mode)) {
+		stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
+		stat->dio_mem_align = 4; /* 4-byte alignment */
+		stat->dio_offset_align = PAGE_SIZE;
+		stat->dio_read_offset_align = stat->dio_offset_align;
+	}
 out:
 	trace_nfs_getattr_exit(inode, err);
 	return err;
-- 
2.44.0


