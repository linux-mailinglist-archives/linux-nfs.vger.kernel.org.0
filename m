Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F182713195B
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgAFU1j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:39 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37765 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFU1j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:39 -0500
Received: by mail-yb1-f194.google.com with SMTP id x14so22618955ybr.4
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GI3T8qAguBQKMH8wg8hmwDj1iiJSqLnO7N2CvBnLEYg=;
        b=NhjQvWofVh1Fz5lMzdn6H/ZU0X9YXmYGg9XwAokqk7eYXICRSBDHLcw6CNtfV8Cdqr
         zhM/zDogDKgfgVnJ3kUb5FSsrNDJnJgP37L6uFIKiai4/DKCHokr6UZZq5S5J5DB9inK
         FPqJmSpqZI62+BxIcI3x1+LpRzctlY7y0fPei8qgHB08weuP6Ywi1TcOm6gK0YAvmDx5
         0KCytwNIoXr1X10tNpqxOu+NA3mkT5kqqJgz7Tlk7Mb8N2V/N8/tVGytnJpXQDqnDFfj
         NJsm6wNRs+Aew2Qy0NEoM0xDBbjzgqBRzXrgHtufIzwvRYrOdCXYUE8paFOGSNuTR88d
         118w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GI3T8qAguBQKMH8wg8hmwDj1iiJSqLnO7N2CvBnLEYg=;
        b=SNbeAXr3JOnN/lS5vqMJ+ohIT3byKCZPL1mzncdNdXQtNopS/0r5KfUFbThglE+OUW
         Lwsq5Fipn8aBEX/i7zy6XjIWTO4+eCATUIccdUtesExyIIqJkgw53PJrdf6VG1oVwb4c
         yOCuYKdwDuuPugn4rMJ/RtmeEgUB5Z9EFNwb/cb6uICe3bLBKdVACp6bNNNVmCDx/sqS
         sxWbWk9C1BDkYODovgvIYmd3X0h2SCwR50WyboCeA1H93sHm3ZItxztzCcWMpla8Qjpf
         8Hx4edw3u9sUCMYcMNb3mniBCjaYops8HlEcPuFZFGtlKXSeBdHtaM2dcJ1Zscf8CgCA
         a95g==
X-Gm-Message-State: APjAAAUHknd2jItEEJ90ZLPQ5OPHGO+JBgYeEnz9Cd2Xb7b/f5mm0vCD
        dWESOx37Psn9vyEf9xgL7A==
X-Google-Smtp-Source: APXvYqzr0Tfp3MM/5GG2jLDDbs1qoPkxEegl9zVDsKLPKjYv1JsoynFLpB9VLgt8y+nD3CQsx0hhKw==
X-Received: by 2002:a5b:14b:: with SMTP id c11mr75817849ybp.14.1578342457993;
        Mon, 06 Jan 2020 12:27:37 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:37 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/15] NFS: Clean up generic writeback tracepoints
Date:   Mon,  6 Jan 2020 15:25:09 -0500
Message-Id: <20200106202514.785483-11-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-10-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
 <20200106202514.785483-6-trond.myklebust@hammerspace.com>
 <20200106202514.785483-7-trond.myklebust@hammerspace.com>
 <20200106202514.785483-8-trond.myklebust@hammerspace.com>
 <20200106202514.785483-9-trond.myklebust@hammerspace.com>
 <20200106202514.785483-10-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up the generic writeback tracepoints so they do pass the
full structures as arguments. Also ensure we report the number
of bytes actually written.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h | 73 ++++++++++++++++++++++++++---------------------
 fs/nfs/write.c    |  6 ++--
 2 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index f0e869d21368..3d8d36fe7b6f 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -915,87 +915,96 @@ TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
 
 TRACE_EVENT(nfs_initiate_write,
 		TP_PROTO(
-			const struct inode *inode,
-			loff_t offset, unsigned long count,
-			enum nfs3_stable_how stable
+			const struct nfs_pgio_header *hdr
 		),
 
-		TP_ARGS(inode, offset, count, stable),
+		TP_ARGS(hdr),
 
 		TP_STRUCT__entry(
-			__field(loff_t, offset)
-			__field(unsigned long, count)
-			__field(enum nfs3_stable_how, stable)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(u32, count)
+			__field(enum nfs3_stable_how, stable)
 		),
 
 		TP_fast_assign(
+			const struct inode *inode = hdr->inode;
 			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = hdr->args.fh ?
+						  hdr->args.fh : &nfsi->fh;
 
-			__entry->offset = offset;
-			__entry->count = count;
-			__entry->stable = stable;
+			__entry->offset = hdr->args.offset;
+			__entry->count = hdr->args.count;
+			__entry->stable = hdr->args.stable;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
-			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
 		TP_printk(
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%lu stable=%s",
+			"offset=%lld count=%u stable=%s",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			__entry->offset, __entry->count,
+			(long long)__entry->offset, __entry->count,
 			nfs_show_stable(__entry->stable)
 		)
 );
 
 TRACE_EVENT(nfs_writeback_done,
 		TP_PROTO(
-			const struct inode *inode,
-			int status,
-			loff_t offset,
-			struct nfs_writeverf *writeverf
+			const struct rpc_task *task,
+			const struct nfs_pgio_header *hdr
 		),
 
-		TP_ARGS(inode, status, offset, writeverf),
+		TP_ARGS(task, hdr),
 
 		TP_STRUCT__entry(
-			__field(int, status)
-			__field(loff_t, offset)
-			__field(enum nfs3_stable_how, stable)
-			__field(unsigned long long, verifier)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(u32, arg_count)
+			__field(u32, res_count)
+			__field(int, status)
+			__field(enum nfs3_stable_how, stable)
+			__array(char, verifier, NFS4_VERIFIER_SIZE)
 		),
 
 		TP_fast_assign(
+			const struct inode *inode = hdr->inode;
 			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = hdr->args.fh ?
+						  hdr->args.fh : &nfsi->fh;
+			const struct nfs_writeverf *verf = hdr->res.verf;
 
-			__entry->status = status;
-			__entry->offset = offset;
-			__entry->stable = writeverf->committed;
-			memcpy(&__entry->verifier, &writeverf->verifier,
-			       sizeof(__entry->verifier));
+			__entry->status = task->tk_status;
+			__entry->offset = hdr->args.offset;
+			__entry->arg_count = hdr->args.count;
+			__entry->res_count = hdr->res.count;
+			__entry->stable = verf->committed;
+			memcpy(__entry->verifier,
+				&verf->verifier,
+				NFS4_VERIFIER_SIZE);
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
-			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
 		TP_printk(
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld status=%d stable=%s "
-			"verifier 0x%016llx",
+			"offset=%lld count=%u res=%u status=%d stable=%s "
+			"verifier=%s",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			__entry->offset, __entry->status,
+			(long long)__entry->offset, __entry->arg_count,
+			__entry->res_count, __entry->status,
 			nfs_show_stable(__entry->stable),
-			__entry->verifier
+			__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE)
 		)
 );
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ab3d4611f0aa..d0f62aef3489 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1412,8 +1412,7 @@ static void nfs_initiate_write(struct nfs_pgio_header *hdr,
 
 	task_setup_data->priority = priority;
 	rpc_ops->write_setup(hdr, msg, &task_setup_data->rpc_client);
-	trace_nfs_initiate_write(hdr->inode, hdr->io_start, hdr->good_bytes,
-				 hdr->args.stable);
+	trace_nfs_initiate_write(hdr);
 }
 
 /* If a nfs_flush_* function fails, it should remove reqs from @head and
@@ -1577,8 +1576,7 @@ static int nfs_writeback_done(struct rpc_task *task,
 		return status;
 
 	nfs_add_stats(inode, NFSIOS_SERVERWRITTENBYTES, hdr->res.count);
-	trace_nfs_writeback_done(inode, task->tk_status,
-				 hdr->args.offset, hdr->res.verf);
+	trace_nfs_writeback_done(task, hdr);
 
 	if (hdr->res.verf->committed < hdr->args.stable &&
 	    task->tk_status >= 0) {
-- 
2.24.1

