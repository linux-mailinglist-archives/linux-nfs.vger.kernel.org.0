Return-Path: <linux-nfs+bounces-6848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8726A98F717
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 21:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5013F282399
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08951AC885;
	Thu,  3 Oct 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOcXfJQk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117A1AAE0C
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984113; cv=none; b=CIfXHb5I4BMqQujUV14Fj2cYTGvh0kM+a0r1PkrP2q8g6Ej+31mD2Esi7yp0/3v8za5flyw5+b7mzmngo61E9ENHMZ17wiTYAQRQSYAEIRrCLyL549RoOir1h9SOg3KTZ65yGKFu4eVkC6sCjanjXMALrlYi6V7HJGN3CcnaWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984113; c=relaxed/simple;
	bh=g4o1E9ZHJpVvV8UBqlxcay2i9cSQlVEOIAKY8yV+YOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxIfoef4mPNuqMti2V89bvkGcsGiUGLwk/rEo0Ii3U+nbV+A98S5F4K6oAxtZIMBCbanV3kNcGi8fw6mHkMuGM0QTNy9YuUg9SVqKS9zig7dzdnoJheLp2QGxE7hHdyvni8sCToPgqysohoFOUY/Qpgl+92yyQrKr2eFyL4D1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOcXfJQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583BAC4CEC5;
	Thu,  3 Oct 2024 19:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727984113;
	bh=g4o1E9ZHJpVvV8UBqlxcay2i9cSQlVEOIAKY8yV+YOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOcXfJQkets+DhcYTXeBR/OFX66irKPQUycBGCjhWNw5ixoux8DPPf3bJzr/I1xo2
	 8CoTEGPFI2ypy3IbEKTl7dT0tDUoTPw9L6rW0bfYV4+7y0uEsugozdey2pQ2hEQHNt
	 YnbJsCFofXo0/PMN2y+EJIjDKstiQEAZ7GvEkFmxdmOHOgs8d1JDESgCujQZsFnUYK
	 /MEvI3P/1+rvrvnX/XokKRXtj2sB7qgzIFrj13WeDV2O2dhVXGuwHadgoe7muTAFXP
	 LSLKuVAKBfuXYDZq1UM/0YAjBXADG7NVC5TOfjXC7ar/xbZiQoqM+/9HH2gF/6Faxc
	 injEAVczAz86A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [6.12-rc2 v2 PATCH 6/7] nfs/localio: remove extra indirect nfs_to call to check {read,write}_iter
Date: Thu,  3 Oct 2024 15:35:03 -0400
Message-ID: <20241003193504.34640-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241003193504.34640-1-snitzer@kernel.org>
References: <20241003193504.34640-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Push the read_iter and write_iter availability checks down to
nfs_do_local_read and nfs_do_local_write respectively.

This eliminates a redundant nfs_to->nfsd_file_file() call.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 2f302b03b253..12d3e200156c 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -273,7 +273,7 @@ nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
 
 static struct nfs_local_kiocb *
 nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
-		     struct nfsd_file *localio, gfp_t flags)
+		     struct file *file, gfp_t flags)
 {
 	struct nfs_local_kiocb *iocb;
 
@@ -286,9 +286,8 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 		kfree(iocb);
 		return NULL;
 	}
-	init_sync_kiocb(&iocb->kiocb, nfs_to->nfsd_file_file(localio));
+	init_sync_kiocb(&iocb->kiocb, file);
 	iocb->kiocb.ki_pos = hdr->args.offset;
-	iocb->localio = localio;
 	iocb->hdr = hdr;
 	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
 	return iocb;
@@ -389,13 +388,19 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 		  const struct rpc_call_ops *call_ops)
 {
 	struct nfs_local_kiocb *iocb;
+	struct file *file = nfs_to->nfsd_file_file(localio);
+
+	/* Don't support filesystems without read_iter */
+	if (!file->f_op->read_iter)
+		return -EAGAIN;
 
 	dprintk("%s: vfs_read count=%u pos=%llu\n",
 		__func__, hdr->args.count, hdr->args.offset);
 
-	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_KERNEL);
+	iocb = nfs_local_iocb_alloc(hdr, file, GFP_KERNEL);
 	if (iocb == NULL)
 		return -ENOMEM;
+	iocb->localio = localio;
 
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
@@ -558,14 +563,20 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 		   const struct rpc_call_ops *call_ops)
 {
 	struct nfs_local_kiocb *iocb;
+	struct file *file = nfs_to->nfsd_file_file(localio);
+
+	/* Don't support filesystems without write_iter */
+	if (!file->f_op->write_iter)
+		return -EAGAIN;
 
 	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
 
-	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_NOIO);
+	iocb = nfs_local_iocb_alloc(hdr, file, GFP_NOIO);
 	if (iocb == NULL)
 		return -ENOMEM;
+	iocb->localio = localio;
 
 	switch (hdr->args.stable) {
 	default:
@@ -591,16 +602,9 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 		   const struct rpc_call_ops *call_ops)
 {
 	int status = 0;
-	struct file *filp = nfs_to->nfsd_file_file(localio);
 
 	if (!hdr->args.count)
 		return 0;
-	/* Don't support filesystems without read_iter/write_iter */
-	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
-		nfs_local_disable(clp);
-		status = -EAGAIN;
-		goto out;
-	}
 
 	switch (hdr->rw_mode) {
 	case FMODE_READ:
@@ -614,8 +618,10 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 			hdr->rw_mode);
 		status = -EINVAL;
 	}
-out:
+
 	if (status != 0) {
+		if (status == -EAGAIN)
+			nfs_local_disable(clp);
 		nfs_to_nfsd_file_put_local(localio);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
-- 
2.44.0


