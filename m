Return-Path: <linux-nfs+bounces-15791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1867C2022C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 14:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AA946828B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4941C2E5437;
	Thu, 30 Oct 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtQtCiLy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35634164A
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829002; cv=none; b=Vv8XBPbdxtUqmDLsQcHBgsHJtfwIfCxz0U9zy6sGZSG/VoJTSDuZzX12Lp241ww+swjX2U4Z87d+ZMDdnbC0DGMEcoH8Xc/lRmPKvoB05wdm77kPPoyUbbIvvOhCW8gRPBuUETV+1K1heDS3PNX9inESsFH7wrpQZ81K+rypfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829002; c=relaxed/simple;
	bh=SGcVKWhEpgHQRFVnt75+AN3YTI0G2KZ2KH7PQkDzTAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKRuYfnHU2xnKWHsU1sIII+Yw5PQzK5CUFj82gjRDAIKlXMsI2yM/38QJDbEgA8varac2bVZLPMZ0FPIV6ZMqu695kSO/0xIp8EhoyNHbX4Yxx98KEI7fIHerUB5cGj3Ut7gnyVif/JALDF6YSlhU9qJ3SnaVicegXCDW5lFFdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtQtCiLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42792C4CEF1;
	Thu, 30 Oct 2025 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761829001;
	bh=SGcVKWhEpgHQRFVnt75+AN3YTI0G2KZ2KH7PQkDzTAI=;
	h=From:To:Cc:Subject:Date:From;
	b=YtQtCiLyu54cC6MT+wLpajav/rXUu2MuNcRdLlgwWKcFks9VQZPz00TpG7lAFY3wk
	 a+R2gyMMkTfHVVjmOeHCMj5Iqb/XY/KZKgFYam/Y7+FT4mcCKkvvgzpJPTHdx5VEji
	 I9aAW2FBh8xU+FwCggkRJfPxmc2I34HknfGh8SsO1Sh193lolYXa937ZCol4cWmBOe
	 nSg0JAW4ANELqMgZ71ZKDc0/ilGbUxsuTGb1T5z7EjN5Iemuvz1Wsm0lSBVPCTRjhe
	 brqrs3W/FFm7gFCEjGHuqoH6Li/gfJ68o1jzbkw1N7M2xfLK2gAX0YO6C2BnbA9VBT
	 2oLX06O+kQSfw==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] NFSD: Add a "file_sync" export option
Date: Thu, 30 Oct 2025 08:56:38 -0400
Message-ID: <20251030125638.128306-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
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

This patch is a year old, so won't apply to current kernels. But
the idea is similar to Mike's suggestion that NFSD_IO_DIRECT
should promote all NFS WRITEs to durable writes, but is much
simpler in execution. Any interest in revisiting this approach?

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
2.51.0


