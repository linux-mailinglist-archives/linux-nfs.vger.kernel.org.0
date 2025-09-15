Return-Path: <linux-nfs+bounces-14448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B8B58127
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC48C1882F5F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94834202F7B;
	Mon, 15 Sep 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwXo2OzR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015F2DC786
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950887; cv=none; b=XZ+8Q5GmmSitcGG/N/q+cnXyKF8r1lGkGeQEOzOjHC8aq2NGR/YMws7tE8Zbzf1EBr6ZAkc6vMcsoYXNdik4LHGmc+wgoVkB6v95JpjovG0sOQIi0cBMBSCbsWrWG7N7+186COWduY202iFTQ9O0FvO2/plmCQtajrUDSXSzEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950887; c=relaxed/simple;
	bh=/1Vw5YoQjOKjMuhpjdlLUjh/2t/6sgQX6HCxbk+GB2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoDhuzooXwelYT8IbrjUyD64+dvtMnh8nGmDSjOsLSPHUD/hf7S6bwmpo5QTDuXNcYmTrXVFr17oQ2Afj8Z47FeIkNQHAAR57vYhvw22nwyBpr9YG5T9JRDmTfkQZCtiRVWpKm/eo2L1F/RJyrzOz7BFaV7McRc5OrORtJ2F73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwXo2OzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D137C4CEF7;
	Mon, 15 Sep 2025 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757950887;
	bh=/1Vw5YoQjOKjMuhpjdlLUjh/2t/6sgQX6HCxbk+GB2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwXo2OzR3ANTo7jJUmWSSpTjEa77At/OQ0fNUGxTCyueaVJiOuqNWYBguYMg5wN7O
	 FsqpPbdGMVldvfXchGodt/czomqMhsJ4zjoZR9B9h0WNNmAFuNoLcCbMgaTC1qgHG3
	 wxSJ5f2+1CL0hD8lMBcNpoKpX/yAWHIF5thBPD5P3wm5uxh28r5NrXG0w6HY6zjkgd
	 GUd719BQKUC/WYzxR7pPI5lSUHAVnzug0ksChYZ1uaTIP2eI1UNHwwZ9fHMavTo/vc
	 tE5EMDSpug1z1ACbibqBOm/THnW5iN7kU0rW/9TnvM7/dvjXiMz16O5I5VKjEJ4vLG
	 PHgIS8a9A4ZAg==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 7/7] NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Mon, 15 Sep 2025 11:41:15 -0400
Message-ID: <20250915154115.19579-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250915154115.19579-1-snitzer@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
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


