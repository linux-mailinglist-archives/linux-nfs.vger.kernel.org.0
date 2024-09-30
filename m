Return-Path: <linux-nfs+bounces-6726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F398AA44
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 18:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A79A2838CF
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 16:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A5195FD1;
	Mon, 30 Sep 2024 16:47:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5C1925B8
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714820; cv=none; b=EFeqQ/w7HjbCdzAEOlpTYfzU4iOZr0VtHVugUL/rtcRiknX23tubk7tYsfqilpN6aERdWgQ6MCQeofYHl+ET0yXX71/ue4iZxTV9KNtMZo7job/FpCSSmZ/gEvyHNTOfqa8vJX1ecNxeSVFPmloQbawTusFiiJ4I2KzXsWFOLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714820; c=relaxed/simple;
	bh=g4o1E9ZHJpVvV8UBqlxcay2i9cSQlVEOIAKY8yV+YOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er9eoN6non19uTQnDnM2sIg1z8tD+DQx8lGjkDw01LwNoPhvYXgqAhucHNb8ftEQTJDWj6tKi/AhDdJEz7xYblUYgwUFeDdTg6fds8xa+5+Ol4xpiI1XjA+44rU26w1pVnHO+iTdqjcI6gsIPODQBumYAimCu+26FmJs+CaBW3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e5a0519d00so1967388eaf.3
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 09:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714816; x=1728319616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuxEtvCgukHFh6jS8SFvx09qDMSBGl7szdlF1CL/XHs=;
        b=TpdrSEheoaHMQO0KP2tZwQjv+OWUK+oulrktMmmNkYjgBpZYbwaeZ8jkGObVBSJidJ
         JaA5yG8zddNmVWF+uXOCyqJsL3wCROeZpV+re3p716+qAG+/vJcTuS0F6T+0i1WBkFUG
         ckiv/Adow3zOCCtglbmIus+40I1D6ojhWOLnTq/9ZvQZ3mOUsLaEpcpNZ9jcAYG1mNmu
         BBxDfHI9IlMpDeoGUeyLZD86pPU+yC5yq3jNPSfrnuUY2XN2V94EGHTCgcUDQ+tFcyNd
         HgqQqakY0UaNe8tQxbx0isU5sF2Vem+57VGQs0hYuiSVcOP1mYZ90WAdO0iQyPeGF5Ll
         hqIQ==
X-Gm-Message-State: AOJu0YxuyWnLUa8RI08lszGfcbpKseJ4mTLF/g1yGkYVUQiM34eDhntC
	GFzBKB5SkGDhvPYGEIH0zSAfCWiRqIgtbcXB2dnRa8j/CFL4LXoUdsC12AGfDFtzO+pPceLZMrn
	h9HhFexJ+v8ERHiihW+8o7O7410FBS56x03l94FRsoz+SPOVocz2QvWBt5zSv3LauP5z4JlR0gX
	A5YLWBLgcPvwZDZqsklpcWcR3IlWpkg2yEWHtj4ZM=
X-Google-Smtp-Source: AGHT+IHWaD5jRZjbNuRnDtyZMrwEEULCWIT/oUkQp8k4yLe4yh7H5HeDalrNszt9N8t2foTJKEXyVQ==
X-Received: by 2002:a05:6358:54a6:b0:1af:7e6e:4bbc with SMTP id e5c5f4694b2df-1becbb67813mr354913355d.10.1727714816112;
        Mon, 30 Sep 2024 09:46:56 -0700 (PDT)
Received: from localhost (pool-68-160-145-92.bstnma.fios.verizon.net. [68.160.145.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2b6dabsm37745051cf.27.2024.09.30.09.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:46:54 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: [6.12-rc2 PATCH 4/5] nfs/localio: remove extra indirect nfs_to call to check {read,write}_iter
Date: Mon, 30 Sep 2024 12:46:36 -0400
Message-ID: <20240930164637.8300-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240930164637.8300-1-snitzer@kernel.org>
References: <20240930164637.8300-1-snitzer@kernel.org>
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


