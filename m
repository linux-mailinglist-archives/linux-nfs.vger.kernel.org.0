Return-Path: <linux-nfs+bounces-7797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082009C2829
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C2A283098
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3871E0E16;
	Fri,  8 Nov 2024 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOnu4rKY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE38F54
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109211; cv=none; b=bmkCngGcS652PZtG3m1SA61amNopIwFq94WtINqE0PphTAhSC0q+OWuoYJq47IGPhcEKqmUFywrmcT8hafwhmqJ1bg4dZwYEy03SmIjgbTzHWgB7x1wzLqzFMmrjvhgQXtE2+5w5+u/fjhBLRGud0SzPyu+sajtKUeAq07ojrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109211; c=relaxed/simple;
	bh=5BmG4OCg4OVD58XhXnViDbyH7/D/pzxz3ok8fBo9Qw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgTnIkcEeuEexYbhC4zdS5/uJkoJaQhRLpG/EQyx+EtyfvS8rl7rNfjsRAYcSF889P67HoloyS1RknpbBgylKjkWr2Jna5HBPL6kqoKPZ99YjNWfkkBd9xXbl7dKIEtlgpcHW0RONsZ/0ek3pJ5P7Z0EIPHba3JErRInNHfdDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOnu4rKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CA1C4CECE;
	Fri,  8 Nov 2024 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109211;
	bh=5BmG4OCg4OVD58XhXnViDbyH7/D/pzxz3ok8fBo9Qw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOnu4rKYN1umH7areacqmaVwSKbjZUNJByuAWchQ7IuREcVZODY07gUnyCwxsuSlc
	 hgo6F6gbE0YnODbO9ZBLYHhvKnMnlg0eOPDUF0PDOVd9nElCkHogElLhniDMyaSK3b
	 hnXtOqxYCwZgPbIMHKeqCZ+WoIUAhm0/ya2lXaqt4by8E9ZcLgwwpQSawd1yy4/jFV
	 +B2a1Hmfa/9em9WlNVkfYnW14n27q7+bAqVFIPLmSnk5ofV0v5sCWICGEaugFNQs4P
	 gId9St1hibUzvk/rWupVoY2IyyDkxaPrsE2hm6KBSsYbc2HCGt7mpOoA1ocHVczEXW
	 WDQ0U5Wnmq4vA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 05/19] nfs/localio: remove extra indirect nfs_to call to check {read,write}_iter
Date: Fri,  8 Nov 2024 18:39:48 -0500
Message-ID: <20241108234002.16392-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
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
index a7eb83a604d0..a77ac7e8a05c 100644
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
@@ -395,13 +394,19 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
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
@@ -564,14 +569,20 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
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
@@ -597,16 +608,9 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
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
@@ -620,8 +624,10 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
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


