Return-Path: <linux-nfs+bounces-7726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647189BF3C6
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 17:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D72283255
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23998202F6C;
	Wed,  6 Nov 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK6zQrv4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A284039
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912242; cv=none; b=oO3mtwJROjG/IBuctjktt5u2uc5OJt6rxHY5rx7yFEqScSGZi5NNBivjuSBo/mUOqaprhPj8xDVZdjW7wGL0V9UfKoOi2i1BE0kPk3XKX0FvKez096Utv2mDi9A6VqazuN6zi/Qpd8CZfdErCqD4u8Tlaa3bWcwocL5SKioX0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912242; c=relaxed/simple;
	bh=lb0eT0vICMnOrHkqYKJc+CV0/hIb9gUPhINRR84b1jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc/Bg/LYRwSX0A0dENUyJ7DUvS38GQ90m634/BhsO5wB69keuyEil6llAaYpdN1P0Ekrwh1QOvu0diLpsZiWkjv6h0xzxNGnn+04dIgHj98sK+eclnRslaw+VEN0L3UREk8JYbTYU8k7OkIKKn9bI/k8QnWeANLtNaVYZEq6BtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK6zQrv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1D6C4CECD;
	Wed,  6 Nov 2024 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912241;
	bh=lb0eT0vICMnOrHkqYKJc+CV0/hIb9gUPhINRR84b1jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BK6zQrv4xCcHAlrCP9BreE4GP611HcuvJarG8apYGOUL1o7kZEoj9Y9BATW535wEI
	 pNd7o9HabP/1QBKBa/q5wDzTvvFzJRBe8tEVWW+rYD1ZTvHUvlZl9JBgUHgGl7NSYV
	 FTUHfSO19WztqCVyue7PQyrX19Y9yRSeMXZzOIlrSaIdWbtCWmh/SsirpfuVk/wyjt
	 kJUPQKXwiAwaVgEoZ5fMfrDm+kLjD0k/xcDHnnqlrEhqgQ7H9nBiknrVFnCe4oH6R3
	 UXlWZGg0S4VPgjEs9cvPyWrmPLm3uTzbIH2a62QLIR9XFBDwamCV3p4m4aWxUWXHdL
	 qCACxZn71DskA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/2] NFSD: Add a "file_sync" export option
Date: Wed,  6 Nov 2024 11:57:16 -0500
Message-ID: <20241106165716.109681-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106165716.109681-1-cel@kernel.org>
References: <20241106165716.109681-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Introduce the kernel pieces for a "file_sync" export option. This
option would make all NFS WRITE operations on one export a
FILE_SYNC WRITE.

There are two primary use cases for this new export option:

1. The exported file system is not backed by persistent storage.
   Thus a subsequent COMMIT will be a no-op. To prevent the client
   from wasting the extra round-trip on a COMMIT operation, convert
   all WRITEs to files on that export to FILE_SYNC.

2. The exported file system is backed by persistent storage that is
   faster than the mean network round trip with the client. Waiting
   for a separate COMMIT operation would cost more time than just
   committing the data during the WRITE operation.

   Either the underlying persistent storage is faster than most any
   network fabric (eg, NVMe); or the network connection to the
   client is very high latency (eg, a WAN link).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c                 | 1 +
 fs/nfsd/nfs4proc.c               | 1 +
 fs/nfsd/vfs.c                    | 5 +++--
 include/uapi/linux/nfsd/export.h | 3 ++-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index c82d8e3e0d4f..11b5337dd0ea 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1297,6 +1297,7 @@ static struct flags {
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
 	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_FILE_SYNC, {"file_sync", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 51bae11d5d23..7a4ded3ff7c2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1269,6 +1269,7 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = nfsd4_clone_file_range(rqstp, src, clone->cl_src_pos,
 			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
+	/* cel: check the "file_sync" export option as well */
 
 	nfsd_file_put(dst);
 	nfsd_file_put(src);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cd00d95c997f..ffa6db6851bd 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1205,9 +1205,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
 	exp = fhp->fh_export;
 
-	if (!EX_ISSYNC(exp))
+	if (exp->ex_flags & NFSEXP_FILE_SYNC)
+		*stable = NFS_FILE_SYNC;
+	else if (!EX_ISSYNC(exp))
 		*stable = NFS_UNSTABLE;
-
 	if (*stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index a73ca3703abb..45afec454a37 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -53,9 +53,10 @@
  */
 #define	NFSEXP_V4ROOT		0x10000
 #define NFSEXP_PNFS		0x20000
+#define NFSEXP_FILE_SYNC	0x40000
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS		0x3FEFF
+#define NFSEXP_ALLFLAGS		0x7FEFF
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.47.0


