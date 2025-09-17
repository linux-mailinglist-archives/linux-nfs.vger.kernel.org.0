Return-Path: <linux-nfs+bounces-14524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CBCB8152F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB093A494F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C5F2FF66E;
	Wed, 17 Sep 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7FRg4dH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16102FF164
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133135; cv=none; b=m1Zv8BR4mq7rywPXgLro4nVJmsXaZK6Vga6xQQYzU0jGVPioqWfX5AlELMYs55S9/SREeuerNzy8os0AH6veSNY8rCTFSE8oRrw6AB66HyFXkkdzB3o+gczZeqZkCCp7kKTsExaBsjZoMihb4l+09OCelfzHCm386VpGJ56KgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133135; c=relaxed/simple;
	bh=/1Vw5YoQjOKjMuhpjdlLUjh/2t/6sgQX6HCxbk+GB2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSa+EMETXeuPSmbagUXnl2j6f4LUOVFKp9QvauVAGw/GMAKhpL/iL/wfUAuxaFtNpZ1b6ZAoS0+Nt8FvHQZsV2YGe7Px6hVaARLimxM1WQ6+6L3SmflXfgo50fbb07uuy0afk0sMF2sSy3/ypnuaG3yFZaEivf1hLG0d6rSPQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7FRg4dH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F8CC4CEF7;
	Wed, 17 Sep 2025 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758133134;
	bh=/1Vw5YoQjOKjMuhpjdlLUjh/2t/6sgQX6HCxbk+GB2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7FRg4dH63H5DSdJjXMQNemoIRP3QjI82kaWLhjYXf3Fr+iZQAwTwv4YC6BuV5wn+
	 mJtgw/XZEvdI87NTAXu+snnMwNk2f8R8B16sMRZTVVpQJc43a1lpMjl9EQS/wgAQ4n
	 2nTJVyPkAcaCTvG8BM+7aGjB2oAJLRAjIWpzPRFuz/JqVEdATPV5jrvtNxMm8YvlR+
	 cls4Dric46C0OpoPiSOcA/S0VnjoaTH6zuEZO4kqEDyUuIbpEUbTTdYlTKJ6gBlv+S
	 AH2A/YVnEIFzYv9OrPkyzxFQZD6E5aPQSj5zfnviBM8a1CRXfn1xjnlnLAj2fR8sW1
	 Nqj+yHp/RYaKA==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v10 7/7] NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Wed, 17 Sep 2025 14:18:43 -0400
Message-ID: <20250917181843.33865-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250917181843.33865-1-snitzer@kernel.org>
References: <20250917181843.33865-1-snitzer@kernel.org>
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


