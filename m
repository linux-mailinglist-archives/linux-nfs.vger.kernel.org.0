Return-Path: <linux-nfs+bounces-13458-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C37B1BD11
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480E9182A07
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0562951DD;
	Tue,  5 Aug 2025 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB+44xxM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F32BDC33
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436084; cv=none; b=i6exjE+lxWRf4BMbDNarnmNqm+eVTWPj7DKj0exlojLJB1tnUSdZgcXsDj26MgOKUGs0H6lTzJqbVQOxSoxfTRmjOC89L2uSLs6lR4ybwXISpKv/uizgePb4AxfUkqZVN8LYHlMCN2LCSRcRErMnhxumU0ti7UuRdF0JJup3QQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436084; c=relaxed/simple;
	bh=ohiDosnQE2pgiJf0R7I2Fw6r3awT4GQ8+Ao7ZnwLh6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYdm/fLtC+2H/m4lPjKKrQTHpZw/G10xAGJEZfEIvK7upGhPTF2GFEuqopUknxgvoDJOj/bxrxJqGdvalXt63INunncksozCqxE3oqxJocQ7BT1POZCq7s/3lFlMb2TVdFUxNUmXHv5veOoIGbxIDW8S9fDjeh/+f8e6morTSho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB+44xxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7440EC4CEF0;
	Tue,  5 Aug 2025 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436084;
	bh=ohiDosnQE2pgiJf0R7I2Fw6r3awT4GQ8+Ao7ZnwLh6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XB+44xxMKFYwdAyT8OVTlt+eFqN5jmKt3GDx25lkqNpcLJeJyVm4Svt7kAjyhIa4e
	 /y1/JKQtM5EkWZgm0LrRxYlS3imkJArZnu5AIqLHtA60PuTVV+spoDVFs5dQVlV/et
	 U55EM75M3EiMeTH/v56m+2WM2azoTsc+DDHF7cVd+vWzAxuEOF0rhaKYmzpVc7LrF+
	 4fVHGxAz8f9ixWvWuwBO2LAqjmtafau65KaFrYwIZcpa5DfpPxdE+ygLCGGt/nJnEf
	 MMVHmE/xxvzrgcvekX3KGKirL4k/nhPSTJzB1/45nbZxRzyY+XwA5p00DODhOXIyqM
	 oSK8slSHYnx2A==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 11/11] NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Tue,  5 Aug 2025 19:21:06 -0400
Message-ID: <20250805232106.8656-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

NFS doesn't have DIO alignment constraints, so have NFS respond with
accommodating DIO alignment attributes (rather than plumb in GETATTR
support for STATX_DIOALIGN and STATX_DIO_READ_ALIGN).

The most coarse-grained dio_offset_align is the most accommodating
(e.g. PAGE_SIZE, in future larger may be supported).

Now that NFS has support, NFS reexport will now handle unaligned DIO
(NFSD's NFSD_IO_DIRECT support requires the underlying filesystem
support STATX_DIOALIGN and/or STATX_DIO_READ_ALIGN).

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 338ef77ae4230..7866d60b18452 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1066,6 +1066,21 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
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


