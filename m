Return-Path: <linux-nfs+bounces-3601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E5390068E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B201C233E0
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FA19922E;
	Fri,  7 Jun 2024 14:27:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F61991AF
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770435; cv=none; b=dPRrrdY0bOcFQUGqg8ADHNUP7Qok/TV1KpC9X/R2A72CDWj4Fu8B7p6zZJ+4BGHFUwjy7XoHd2A5SiH6LPu6N0GTjefIPtCtQWOB5v8xwGBzUjpHm9u2yvp6GVDcMfr1iET11hPKEDCPlGS8BGmfhviOZFtSt0aklj9knHSn2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770435; c=relaxed/simple;
	bh=CT+txxR2jJBUCEjaXzlRv3foLhhxqnXS58klHKjI+6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2aXtJSJp+TiERyO+Hjqtyzd9y48fnSJMrrYhcqGoFZ4wjc5yHgX30RJpF6sF3cxt+KEKZVnUAmvieobkprGN9Xav4Nes0XtGTPghp1kOfwrNoB/t8G5MdUSOqt7byI/OxAQoE1buz4i+np9xBa/sg3Wt7EFLnpePykWF/9PYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfab4375f94so2499747276.1
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770433; x=1718375233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT3T7k679xA6MBGkw5AbnN7uF8EnEOwa8JkM9hM9eqg=;
        b=IzRm+xYOfphJBd79mWhdJ203YoW1dLD+SrjsYaok9U5j1DZtJjdQ3qT5Q+CPNcErsg
         nuKzpgMtB7ONuDz98z4VZ5ppDNyDn9UB4QqyCAMm9E49RkqnpKbAGvZGVzMasTth57MD
         F0XHLjgwtyJ9GEweN6SjaMcMaI9VbLz3eq3IrSi77pbGI58TLAJDJtmOJ90/dUTsn0va
         bcvBpsjYaMQsZ6xWnfpk7U/71+n2lMabNDIdE0thxao3MArKZQAUxqQozr3NnO9TBQMk
         xm7m9b2NDcjiJvIFQ4JqL6goD7GYX2h8k24Tj9MavWZS1TDHJQx+JP5Sb6jv441P5yrt
         dxbg==
X-Gm-Message-State: AOJu0YyCyo3IjznN7jCLhGW0I9RR5busc2XV4jmR5CFfTKYhdZITreIp
	O42jF4yQsvO2vCwU+6dM93z8uLY9lq+yKSjZkY8AglIQwCnoq8vAufmRz7IFO1Jeatg1mgbLZCR
	MB9DnXA==
X-Google-Smtp-Source: AGHT+IGvtCEwLPN3SFZmQxM2oaBCyBrtkKU7pzeeTp8PluHsUy1Jry4zqBbqYFDbcYpo2dTtIKJD6Q==
X-Received: by 2002:a25:870a:0:b0:df7:7399:f98f with SMTP id 3f1490d57ef6-dfaf64eeb51mr2570399276.29.1717770432676;
        Fri, 07 Jun 2024 07:27:12 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038b3df10sm12562381cf.64.2024.06.07.07.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:12 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 16/29] NFS: Don't call filesystem read() routines directly
Date: Fri,  7 Jun 2024 10:26:33 -0400
Message-ID: <20240607142646.20924-17-snitzer@kernel.org>
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

In order to avoid issues with stack overflow, just call the read
routines from a workqueue job.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 2c6811b20dcf..d997f0a96627 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -465,21 +465,38 @@ nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
 	nfs_local_pgio_complete(iocb);
 }
 
-static int
-nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
-		const struct rpc_call_ops *call_ops)
+static void nfs_local_call_read(struct work_struct *work)
 {
-	struct nfs_local_kiocb *iocb;
+	struct nfs_local_io_args *args =
+		container_of(work, struct nfs_local_io_args, work);
+	struct nfs_local_kiocb *iocb = args->iocb;
+	struct file *filp = iocb->kiocb.ki_filp;
 	struct iov_iter iter;
 	ssize_t status;
 
+	nfs_local_iter_init(&iter, iocb, READ);
+
+	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
+	if (status != -EIOCBQUEUED) {
+		nfs_local_read_done(iocb, status);
+		nfs_local_pgio_release(iocb);
+	}
+	complete(args->done);
+}
+
+static int nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
+			     const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_io_args args;
+	DECLARE_COMPLETION_ONSTACK(done);
+	struct nfs_local_kiocb *iocb;
+
 	dprintk("%s: vfs_read count=%u pos=%llu\n",
 		__func__, hdr->args.count, hdr->args.offset);
 
 	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
 	if (iocb == NULL)
 		return -ENOMEM;
-	nfs_local_iter_init(&iter, iocb, READ);
 
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
@@ -489,11 +506,13 @@ nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
 		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
 	}
 
-	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
-	if (status != -EIOCBQUEUED) {
-		nfs_local_read_done(iocb, status);
-		nfs_local_pgio_release(iocb);
-	}
+	args.iocb = iocb;
+	args.done = &done;
+	INIT_WORK_ONSTACK(&args.work, nfs_local_call_read);
+
+	queue_work(nfsiod_workqueue, &args.work);
+	wait_for_completion(&done);
+	destroy_work_on_stack(&args.work);
 	return 0;
 }
 
-- 
2.44.0


