Return-Path: <linux-nfs+bounces-8177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4611C9D4E24
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 14:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A9B2247C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C2D1D86CB;
	Thu, 21 Nov 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="X4FqLt0r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4351D7E50
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197241; cv=none; b=dHw/DTvLdXd/45qO/9xHVh0YW7OmaqnHf71eRdji/yJf19riIHuTO4ianBNB2SS1dQVrQ6BXbLqzWnurqoSyLnpJVF8JTkLPx3/grfCWYykSgMh/8uhCMGviKD3IGilk4mGTTetk98s5Bcd8P0aKlsG7JYalt//yN03Cq4x+jR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197241; c=relaxed/simple;
	bh=y0/IGuvkvrL5BG8LKCqBwE8XTo+VVlZlf9uewaGMH5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJ9zY2fB5gmlHbtflZMGq5R5ZrDR3cb6ShjQGOJmU6xlIF6mDK8F/SB3yq+e6gpIpPg7C5/Go0whG/jm884KthQQuNI27hLkLJ19uUUHB+jvdNC6tgU8ON4P6sRpCGy1iKAbZw4QcGfPXaltRlYo878vpLtF0zbGYyoZNS0A6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=X4FqLt0r; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso1208339a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 05:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732197236; x=1732802036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jl6e5D40Xi8ZKnUy8M68lwLmWTZ/IaWEGCI46p3eoW8=;
        b=X4FqLt0rRsqQv4F+I/5DOLrXZx37E8L5NldBY3+TFKfMcaKrU6wtiHZgDs81CtjMjr
         QIbGDg+DpxUvQrF+n5zPqvAek1hN0Sqs+2aWIaqdCqKJkcC89YwRVEF5S8T0tBnB1OEw
         lAb8qWrCmnPvToZ/eXj1N61STtLiNNFuML8UL1RoH9/s5dG55mY9myQZ1iA7UEKWWvMM
         Em/Kd8KzOvEhN3vJhA8K7dSllLPqvNjpIc0qU+VEvcV2Gi1rjLKY0gw7eCRSX4GgEkpc
         2PzZwIu0QZHMwbbxTIKi4pG7LdW7mWRngPe/6ory+ChejUs7IxYLl4cheVzs7MgtQWX4
         HUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197236; x=1732802036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl6e5D40Xi8ZKnUy8M68lwLmWTZ/IaWEGCI46p3eoW8=;
        b=Te81og3rdcmjbYgJTEJCbEeJOJYw9i1mnlHMnaQ7zhkcpJyEYTqyV9cWA3dCplfSm/
         J6VftPwMX1ZyB31VzYJZ7fRWHVb7srEsCqv0L2BE1qFeXEoWU7gxs/BSrkE9YTdb4WCD
         tTmpK7JB35n1AsXW3BpNGbqZMm38Kx2U0GqTB96AbS4G5wpOkBP8kn9tQXLJH318c/pX
         oh7bj5EA3ln5h6NUQEsrH6Mdi4S+8xSdCgrysPrQZbh6i3AS077yshj+UaNwKq5bQfgf
         NSdxTYohMQ5u/QjIwOcPaLhBpxVUQ6lYNw3HAWLkaogmznEiZkcSFxda/+XwCG/SOEU8
         sn8Q==
X-Gm-Message-State: AOJu0YyvfDTtCJBnqx1VRu1Ew2vevZ6V42yVmUdD5fTPw8a5eBIC2Lbg
	vIp+D2Rb9pIZucz3Z5EsA4I/6UPLXGNlfKJQ1v2EKob8HHQvCm5NK1boUTn+mltIiNHWd+OtusK
	hTJE=
X-Gm-Gg: ASbGncuSjqbw9EkjgDZkI1sP8oQVAPPoHBsd2VPgNyrVJW1/7eIWrjKSzF7sIN0TQN2
	jwGqtkJki/2EWwk1+JIVwQTN1WTQ1v+sCrCF1Pc/lQm1zTB1P9rDIP9wxzzH8dqfs3S7IiVfkAC
	iR/Y6r4atkoaK0C+8FVy83AgufeSolJABQRK2vWJSKNkQ7U7MthG892zE3gCzjGLm6SsUgfZvBa
	dzn1OLqRf6LufDe2C6TTeiPy+jJ8DxcS0q9DowTOifgFbHSkbH6ztBRlQhn70RemMJaSikI2ATK
	Y9Iw0kRn1rtjgEsUEtF4Cqs/J1hVodpDDOqAeDTZN4Ck0R+XNA==
X-Google-Smtp-Source: AGHT+IFoAAbFshrZHtWe+t4PCem5jQ17Z3g+kEtTC10nHfI8uPR+Ni9ppuZtyWEiRFHX7Y7EgF6KVQ==
X-Received: by 2002:a17:907:dac:b0:a99:8a5c:a357 with SMTP id a640c23a62f3a-aa4dd766d81mr642437166b.58.1732197236288;
        Thu, 21 Nov 2024 05:53:56 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f12b600023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f12:b600:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4153111sm82890366b.15.2024.11.21.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 05:53:56 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-nfs@vger.kernel.org,
	trondmy@kernel.org,
	anna@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/nfs/io: make nfs_start_io_*() killable
Date: Thu, 21 Nov 2024 14:53:51 +0100
Message-ID: <20241121135351.1230969-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows killing processes that wait for a lock when one process is
stuck waiting for the NFS server.  This aims to complete the coverage
of NFS operations being killable, like nfs_direct_wait() does, for
example.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/nfs/direct.c   | 21 ++++++++++++++++++---
 fs/nfs/file.c     | 14 +++++++++++---
 fs/nfs/internal.h |  7 ++++---
 fs/nfs/io.c       | 44 +++++++++++++++++++++++++++++++++-----------
 4 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 90079ca134dd..b08dbe96bc57 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -454,8 +454,16 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (user_backed_iter(iter))
 		dreq->flags = NFS_ODIRECT_SHOULD_DIRTY;
 
-	if (!swap)
-		nfs_start_io_direct(inode);
+	if (!swap) {
+		result = nfs_start_io_direct(inode);
+		if (result) {
+			/* release the reference that would usually be
+			 * consumed by nfs_direct_read_schedule_iovec()
+			 */
+			nfs_direct_req_release(dreq);
+			goto out_release;
+		}
+	}
 
 	NFS_I(inode)->read_io += count;
 	requested = nfs_direct_read_schedule_iovec(dreq, iter, iocb->ki_pos);
@@ -1007,7 +1015,14 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos,
 							    FLUSH_STABLE);
 	} else {
-		nfs_start_io_direct(inode);
+		result = nfs_start_io_direct(inode);
+		if (result) {
+			/* release the reference that would usually be
+			 * consumed by nfs_direct_write_schedule_iovec()
+			 */
+			nfs_direct_req_release(dreq);
+			goto out_release;
+		}
 
 		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos,
 							    FLUSH_COND_STABLE);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 6800ee92d742..1bb646752e46 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -166,7 +166,10 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 		iocb->ki_filp,
 		iov_iter_count(to), (unsigned long) iocb->ki_pos);
 
-	nfs_start_io_read(inode);
+	result = nfs_start_io_read(inode);
+	if (result)
+		return result;
+
 	result = nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
 	if (!result) {
 		result = generic_file_read_iter(iocb, to);
@@ -187,7 +190,10 @@ nfs_file_splice_read(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe
 
 	dprintk("NFS: splice_read(%pD2, %zu@%llu)\n", in, len, *ppos);
 
-	nfs_start_io_read(inode);
+	result = nfs_start_io_read(inode);
+	if (result)
+		return result;
+
 	result = nfs_revalidate_mapping(inode, in->f_mapping);
 	if (!result) {
 		result = filemap_splice_read(in, ppos, pipe, len, flags);
@@ -668,7 +674,9 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	nfs_clear_invalid_mapping(file->f_mapping);
 
 	since = filemap_sample_wb_err(file->f_mapping);
-	nfs_start_io_write(inode);
+	error = nfs_start_io_write(inode);
+	if (error)
+		return error;
 	result = generic_write_checks(iocb, from);
 	if (result > 0)
 		result = generic_perform_write(iocb, from);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 430733e3eff2..f0c9c7f51e77 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -6,6 +6,7 @@
 #include "nfs4_fs.h"
 #include <linux/fs_context.h>
 #include <linux/security.h>
+#include <linux/compiler_attributes.h>
 #include <linux/crc32.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
@@ -516,11 +517,11 @@ extern const struct netfs_request_ops nfs_netfs_ops;
 #endif
 
 /* io.c */
-extern void nfs_start_io_read(struct inode *inode);
+extern __must_check int nfs_start_io_read(struct inode *inode);
 extern void nfs_end_io_read(struct inode *inode);
-extern void nfs_start_io_write(struct inode *inode);
+extern  __must_check int nfs_start_io_write(struct inode *inode);
 extern void nfs_end_io_write(struct inode *inode);
-extern void nfs_start_io_direct(struct inode *inode);
+extern __must_check int nfs_start_io_direct(struct inode *inode);
 extern void nfs_end_io_direct(struct inode *inode);
 
 static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index b5551ed8f648..3388faf2acb9 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -39,19 +39,28 @@ static void nfs_block_o_direct(struct nfs_inode *nfsi, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. the reads.
  */
-void
+int
 nfs_start_io_read(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	int err;
+
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	err = down_read_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) == 0)
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
+
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	err = down_write_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	nfs_block_o_direct(nfsi, inode);
 	downgrade_write(&inode->i_rwsem);
+
+	return 0;
 }
 
 /**
@@ -74,11 +83,15 @@ nfs_end_io_read(struct inode *inode)
  * Declare that a buffered read operation is about to start, and ensure
  * that we block all direct I/O.
  */
-void
+int
 nfs_start_io_write(struct inode *inode)
 {
-	down_write(&inode->i_rwsem);
-	nfs_block_o_direct(NFS_I(inode), inode);
+	int err;
+
+	err = down_write_killable(&inode->i_rwsem);
+	if (!err)
+		nfs_block_o_direct(NFS_I(inode), inode);
+	return err;
 }
 
 /**
@@ -119,19 +132,28 @@ static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. O_DIRECT.
  */
-void
+int
 nfs_start_io_direct(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	int err;
+
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	err = down_read_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) != 0)
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
+
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	err = down_write_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	nfs_block_buffered(nfsi, inode);
 	downgrade_write(&inode->i_rwsem);
+
+	return 0;
 }
 
 /**
-- 
2.45.2


