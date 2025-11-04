Return-Path: <linux-nfs+bounces-16014-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F4C321D9
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 17:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 046864EF12D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD0F33508F;
	Tue,  4 Nov 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYSJKqQV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CF3346A9
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274553; cv=none; b=lusS6Wvsoq1pNrGpc17hs58FtvXSsQA4900NSdbqg+8GcSLNm0b04SKKLWvrZE25WWDQuZ/zBcoZAKxVb1ILvH5JfNtURW8aiBYVBGK+ArLcjIbG+AXE4Fdgeb4JOKr9qRKA6caumDuMqexAXZ/qE8oeWhsy8RCHEWI/jzpsaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274553; c=relaxed/simple;
	bh=YswqB/SjxFW2KKAtzgJl7GxKyXA8wHZKUe+e2YytfAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwqyUvu86BAaaDszPIlm4h+maGbnlEa5msv+GJHs/1p+3ayl61KY6mxovDlwpJSPdM0y8qmTJ9NNvUv66HJ4kAv3eTs7q3UD2RKJIIcmKhWXdfkMbuGuWMwHw5TQPmd9/4Xz5GbWGL8vL6zFwUd0IZ5EL5qHnlEO2nFMkE79+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYSJKqQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FCFC4CEF7;
	Tue,  4 Nov 2025 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762274553;
	bh=YswqB/SjxFW2KKAtzgJl7GxKyXA8wHZKUe+e2YytfAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYSJKqQVlqjkOkht6vVwQDCREDWxo0Kap/H/DTV+jcPN8YKvIDpRe0UFa7mxB+UG9
	 m2HbRkHlCBwIZ+uqkbX/IotgC7Ax9f9hWL531zensbyvwEq9lqN7+l2+oWvQMy26Mf
	 AQz8mS7/B5WATaxjKyjhHMs0Z/+5dI+IxAgwzIgSuM9Kij2jD2d7l1cSCg50PxJ1Op
	 zn7sQqbcHwVr0nq+3aGy1pP/6HA3/L8bV9/a8jo1+9dv0WvVG0phsqeQRXN/pZPnUO
	 OBhpDaAMW6d7+Zvlft7KyFEYsabUnLEa3R/QRrqsBnnUbbdHae57mSgzTpX0Vgje38
	 SamWkl3OP43yw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSD: add new NFSD_IO_DIRECT variants that may override stable_how
Date: Tue,  4 Nov 2025 11:42:28 -0500
Message-ID: <20251104164229.43259-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251104164229.43259-1-snitzer@kernel.org>
References: <20251104164229.43259-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFSD_IO_DIRECT_WRITE_FILE_SYNC is direct IO with stable_how=NFS_FILE_SYNC.
NFSD_IO_DIRECT_WRITE_DATA_SYNC is direct IO with stable_how=NFS_DATA_SYNC.

The stable_how associated with each is a hint in the form of a "floor"
value for stable_how.  Meaning if the client provided stable_how is
already of higher value it will not be changed.

These permutations of NFSD_IO_DIRECT allow to experiment with also
elevating stable_how and sending it back to the client.  Which for
NFSD_IO_DIRECT_WRITE_FILE_SYNC will cause the client to elide its
COMMIT.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/debugfs.c |  7 ++++++-
 fs/nfsd/nfsd.h    |  2 ++
 fs/nfsd/vfs.c     | 46 ++++++++++++++++++++++++++++++++++------------
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 7f44689e0a53..8538e29ed2ab 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -68,7 +68,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
 	case NFSD_IO_DIRECT:
 		/*
 		 * Must disable splice_read when enabling
-		 * NFSD_IO_DONTCACHE.
+		 * NFSD_IO_DONTCACHE and NFSD_IO_DIRECT.
 		 */
 		nfsd_disable_splice_read = true;
 		nfsd_io_cache_read = val;
@@ -90,6 +90,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
  * Contents:
  *   %0: NFS WRITE will use buffered IO
  *   %1: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
+ *   %2: NFS WRITE will use direct IO with stable_how=NFS_UNSTABLE
+ *   %3: NFS WRITE will use direct IO with stable_how=NFS_DATA_SYNC
+ *   %4: NFS WRITE will use direct IO with stable_how=NFS_FILE_SYNC
  *
  * This setting takes immediate effect for all NFS versions,
  * all exports, and in all NFSD net namespaces.
@@ -109,6 +112,8 @@ static int nfsd_io_cache_write_set(void *data, u64 val)
 	case NFSD_IO_BUFFERED:
 	case NFSD_IO_DONTCACHE:
 	case NFSD_IO_DIRECT:
+	case NFSD_IO_DIRECT_WRITE_DATA_SYNC:
+	case NFSD_IO_DIRECT_WRITE_FILE_SYNC:
 		nfsd_io_cache_write = val;
 		break;
 	default:
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index e4263326ca4a..10eca169392b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -161,6 +161,8 @@ enum {
 	NFSD_IO_BUFFERED,
 	NFSD_IO_DONTCACHE,
 	NFSD_IO_DIRECT,
+	NFSD_IO_DIRECT_WRITE_DATA_SYNC,
+	NFSD_IO_DIRECT_WRITE_FILE_SYNC,
 };
 
 extern u64 nfsd_io_cache_read __read_mostly;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9403ec8bb2da..99c62340f58f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1407,15 +1407,45 @@ nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return 0;
 }
 
+static void
+nfsd_init_write_kiocb_from_stable(u32 stable_floor,
+				  struct kiocb *kiocb,
+				  u32 *stable_how)
+{
+	if (stable_floor < *stable_how)
+		return; /* stable_how already set higher */
+
+	*stable_how = stable_floor;
+
+	switch (stable_floor) {
+	case NFS_FILE_SYNC:
+		/* persist data and timestamps */
+		kiocb->ki_flags |= IOCB_DSYNC | IOCB_SYNC;
+		break;
+	case NFS_DATA_SYNC:
+		/* persist data only */
+		kiocb->ki_flags |= IOCB_DSYNC;
+		break;
+	}
+}
+
 static noinline_for_stack int
 nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
 		  unsigned long *cnt, struct kiocb *kiocb)
 {
 	struct nfsd_write_dio_args args;
+	u32 stable_floor = NFS_UNSTABLE;
 
 	args.nf = nf;
 
+	if (nfsd_io_cache_write == NFSD_IO_DIRECT_WRITE_FILE_SYNC)
+		stable_floor = NFS_FILE_SYNC;
+	else if (nfsd_io_cache_write == NFSD_IO_DIRECT_WRITE_DATA_SYNC)
+		stable_floor = NFS_DATA_SYNC;
+	if (stable_floor != NFS_UNSTABLE)
+		nfsd_init_write_kiocb_from_stable(stable_floor, kiocb,
+						  stable_how);
 	/*
 	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
 	 * falling back to buffered IO if entire WRITE is unaligned.
@@ -1490,18 +1520,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		stable = NFS_UNSTABLE;
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = offset;
-	if (likely(!fhp->fh_use_wgather)) {
-		switch (stable) {
-		case NFS_FILE_SYNC:
-			/* persist data and timestamps */
-			kiocb.ki_flags |= IOCB_DSYNC | IOCB_SYNC;
-			break;
-		case NFS_DATA_SYNC:
-			/* persist data only */
-			kiocb.ki_flags |= IOCB_DSYNC;
-			break;
-		}
-	}
+	if (likely(!fhp->fh_use_wgather))
+		nfsd_init_write_kiocb_from_stable(stable, &kiocb, stable_how);
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 
@@ -1511,6 +1531,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	switch (nfsd_io_cache_write) {
 	case NFSD_IO_DIRECT:
+	case NFSD_IO_DIRECT_WRITE_DATA_SYNC:
+	case NFSD_IO_DIRECT_WRITE_FILE_SYNC:
 		host_err = nfsd_direct_write(rqstp, fhp, nf, stable_how,
 					     nvecs, cnt, &kiocb);
 		stable = *stable_how;
-- 
2.44.0


