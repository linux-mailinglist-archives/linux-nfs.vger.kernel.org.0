Return-Path: <linux-nfs+bounces-3600-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6212190068D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639B51C221B5
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209FD195999;
	Fri,  7 Jun 2024 14:27:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5019922E
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770434; cv=none; b=IQCqoAo0jgA9RzHAzKHH1eTpuAz8Pt6JgZFdqZASP4fluRYw6eGCuHuRxd/G7I6akTpunpxSY3+nLW6VNVfCkaHF2XVpAp3A+lL4Apr9st08FyvZnyKUFkWRyYhpeVRIGtR3DPSDYQEGI8omTCoecbETgOvsrnYhxwk9tLTB7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770434; c=relaxed/simple;
	bh=4MOPHAwicAAQNHM5RLyhGhvAxC+GTtMyEpHKDsIdBiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFHbFuIcZX1C2ukOxlN80PncHFEFrZP9tZvo1ExBLJIAvkUrkzvAGpKnaXofExvU1804V3ooNo/Nan0g36+MCIMkOxYqMTZ9xN3UMQ3J8g1DsF8sm1NrUZjinR2Rvl8X4MLMqipIMWfPnJCNFCRY2DSWPpbtx6zQNb1GpIYlBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79525719d8dso243219285a.1
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770431; x=1718375231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQGpqNbUhOqUz1IUWhuUIKP0CWooSjEVO3t8zzTIj8M=;
        b=vpCuormmKgda6MVSf+z7oghi08hloMzyBIbUZqY3ZQCIRRGaPCbHUPjV1OTWNoJv/X
         uM8QGDbyZwdoQmOLYENmTk4XasoZbxqIdkAtGMjfuDo9p2wN5e/T+va/l0fnCcIxZzAk
         xwdQqvUvf7SI2I7vEFuLfguLENwxETsgKhctWVlc/D+7oN51XFFRMJ0IaEn/NHxotkvQ
         wm3h6I3eKiYinULmBHhi29HPCKVaIpL1j/rnKH62GUGbICLp6muyv4ROzeV96DMetrv5
         vCOQP3zGP4QA8UvDbAEq8nwQNXLpQ5V2CYOewYUJQlgEmwxOxxe9rcl5GmEE6fhR0w0m
         Gt4Q==
X-Gm-Message-State: AOJu0YxMTrX1CZZC/VK0v+zcGgBUJKDzyJDUOB5zJVAHeke1Izs1oLe5
	64w7eeKMOsoep2oB0GSs2MsxqJgtMP+O08RS5DPawtpNv8wxMTvu8viUdbRenc+rzcRI4T3/ToM
	HRFwNIQ==
X-Google-Smtp-Source: AGHT+IEwXed2C3w7On1UpvrM/JBE8K9cG/Du3Xe2GJfxZXCcqbFhzAkrnpyVAnntNiTmhUDaq8bVEw==
X-Received: by 2002:a05:620a:318c:b0:795:2d5c:2a4e with SMTP id af79cd13be357-7952f0d63e7mr1046799185a.13.1717770431255;
        Fri, 07 Jun 2024 07:27:11 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532846bcbsm171059485a.31.2024.06.07.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:10 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 15/29] NFS: Don't call filesystem write() routines directly
Date: Fri,  7 Jun 2024 10:26:32 -0400
Message-ID: <20240607142646.20924-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Some filesystem writeback routines can end up taking up a lot of stack
space (particularly xfs). Instead of risking running over due to the
extra overhead from the NFS stack, we should just call these routines
from a workqueue job.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 51 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 5939ca2216be..2c6811b20dcf 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -63,6 +63,12 @@ struct nfs_local_fsync_ctx {
 };
 static void nfs_local_fsync_work(struct work_struct *work);
 
+struct nfs_local_io_args {
+	struct nfs_local_kiocb *iocb;
+	struct work_struct work;
+	struct completion *done;
+};
+
 /*
  * We need to translate between nfs status return values and
  * the local errno values which may not be the same.
@@ -597,14 +603,35 @@ nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
 	nfs_local_pgio_complete(iocb);
 }
 
-static int
-nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
-		const struct rpc_call_ops *call_ops)
+static void nfs_local_call_write(struct work_struct *work)
 {
-	struct nfs_local_kiocb *iocb;
+	struct nfs_local_io_args *args =
+		container_of(work, struct nfs_local_io_args, work);
+	struct nfs_local_kiocb *iocb = args->iocb;
+	struct file *filp = iocb->kiocb.ki_filp;
 	struct iov_iter iter;
 	ssize_t status;
 
+	nfs_local_iter_init(&iter, iocb, WRITE);
+
+	file_start_write(filp);
+	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
+	file_end_write(filp);
+	if (status != -EIOCBQUEUED) {
+		nfs_local_write_done(iocb, status);
+		nfs_get_vfs_attr(filp, iocb->hdr->res.fattr);
+		nfs_local_pgio_release(iocb);
+	}
+	complete(args->done);
+}
+
+static int nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
+			      const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_io_args args;
+	DECLARE_COMPLETION_ONSTACK(done);
+	struct nfs_local_kiocb *iocb;
+
 	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
@@ -612,7 +639,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
 	if (iocb == NULL)
 		return -ENOMEM;
-	nfs_local_iter_init(&iter, iocb, WRITE);
 
 	switch (hdr->args.stable) {
 	default:
@@ -632,14 +658,13 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 
 	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
 
-	file_start_write(filp);
-	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
-	file_end_write(filp);
-	if (status != -EIOCBQUEUED) {
-		nfs_local_write_done(iocb, status);
-		nfs_get_vfs_attr(filp, hdr->res.fattr);
-		nfs_local_pgio_release(iocb);
-	}
+	args.iocb = iocb;
+	args.done = &done;
+	INIT_WORK_ONSTACK(&args.work, nfs_local_call_write);
+
+	queue_work(nfsiod_workqueue, &args.work);
+	wait_for_completion(&done);
+	destroy_work_on_stack(&args.work);
 	return 0;
 }
 
-- 
2.44.0


