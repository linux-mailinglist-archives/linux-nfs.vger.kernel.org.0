Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5460213195A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgAFU1i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:38 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35137 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFU1h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:37 -0500
Received: by mail-yb1-f196.google.com with SMTP id a124so22628914ybg.2
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcZPSAaV+lXbnJO92q7MX1Hbs9Frrjeym3R6iqB+2CM=;
        b=aegktrfzz6S5Ccmwm8mjYyoc9Jy/oulwL22GZW2xvH1G5b2coKD3UdBndYOt41SJZD
         Kct8XtBmQX2m9j4Uk00SIqF1BchJYbs0YwfwEt04adR7g1ctHBKZpa55VC4N8AvEDHaQ
         U54ZUaYo68YRTJ7JtxNTFfCnk2GjEwxmj9xDVilmIdoTjKekeCMJM/0xB2YET6wKaZlp
         UH3ckVDagg56oPnCCjHCrtcFtqD4KJahXy9gDqOIloOo+I90ZfpJmsgSo3i5PBZe0+W2
         2B/c9yYwJwYVKcs3u1MD9vtGlP7DL18Pz2P/63u+j12+Y5cP9mSJ5ebAkJ73yGwIn0LH
         1b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcZPSAaV+lXbnJO92q7MX1Hbs9Frrjeym3R6iqB+2CM=;
        b=hvgyzgFFSizFekUrtFVBQbROT/f332JDqo0xtXmiJNdYx/CVWS6k2ElXEV9RpWhz9h
         pEc9okT3TJwT6NNCSMAYByfMp7IVKYHVxpXn2gSJLU+4FZc4Vvhrw/o/JVuH5MZCyL1m
         3ElGPc0fsxN6J2dXJ52IidLCOiZAYqnRZPdKdfOPv1NLjS0RKSat+VnFRY3TT6tsyPsJ
         G/MeXN9HmD6no6jhhEOB88fupCvUQWDhDGejH08Rvt40NBj1Z9InT5FG7mEKsrXqOHuc
         PXBbsGb+Li7EHoBfDf4b2ABNd37wvbMk5pXVIyI9cid/7S9iLEGurRXbn5r64FqNUS8p
         rh/w==
X-Gm-Message-State: APjAAAXIgDKg4Ryzvn0ckg99cih8RpmTa8X5gsZtDJSMdvCKJvSrmfZW
        Tb0dhkiKp0JnRmEmBMv54Q==
X-Google-Smtp-Source: APXvYqxUMN3NJ2q7WWGqoQTJIMbUNkDa/Dvqx/e3/MluhE/YWYJkF7itTaXyhyQubQnZ9OkZ4wq0lQ==
X-Received: by 2002:a25:7ac2:: with SMTP id v185mr44063169ybc.331.1578342456408;
        Mon, 06 Jan 2020 12:27:36 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:36 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/15] NFS: Clean up generic file read tracepoints
Date:   Mon,  6 Jan 2020 15:25:08 -0500
Message-Id: <20200106202514.785483-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-9-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
 <20200106202514.785483-6-trond.myklebust@hammerspace.com>
 <20200106202514.785483-7-trond.myklebust@hammerspace.com>
 <20200106202514.785483-8-trond.myklebust@hammerspace.com>
 <20200106202514.785483-9-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up the generic file read tracepoints so they do pass the
full structures as arguments. Also ensure we report the number
of bytes actually read.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h | 56 ++++++++++++++++++++++++++++-------------------
 fs/nfs/read.c     |  5 ++---
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index f64a33d2a1d1..f0e869d21368 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -820,75 +820,85 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 
 TRACE_EVENT(nfs_initiate_read,
 		TP_PROTO(
-			const struct inode *inode,
-			loff_t offset, unsigned long count
+			const struct nfs_pgio_header *hdr
 		),
 
-		TP_ARGS(inode, offset, count),
+		TP_ARGS(hdr),
 
 		TP_STRUCT__entry(
-			__field(loff_t, offset)
-			__field(unsigned long, count)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(u32, count)
 		),
 
 		TP_fast_assign(
+			const struct inode *inode = hdr->inode;
 			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = hdr->args.fh ?
+						  hdr->args.fh : &nfsi->fh;
 
-			__entry->offset = offset;
-			__entry->count = count;
+			__entry->offset = hdr->args.offset;
+			__entry->count = hdr->args.count;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
-			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
 		TP_printk(
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%lu",
+			"offset=%lld count=%u",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			__entry->offset, __entry->count
+			(long long)__entry->offset, __entry->count
 		)
 );
 
 TRACE_EVENT(nfs_readpage_done,
 		TP_PROTO(
-			const struct inode *inode,
-			int status, loff_t offset, bool eof
+			const struct rpc_task *task,
+			const struct nfs_pgio_header *hdr
 		),
 
-		TP_ARGS(inode, status, offset, eof),
+		TP_ARGS(task, hdr),
 
 		TP_STRUCT__entry(
-			__field(int, status)
-			__field(loff_t, offset)
-			__field(bool, eof)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(u32, arg_count)
+			__field(u32, res_count)
+			__field(bool, eof)
+			__field(int, status)
 		),
 
 		TP_fast_assign(
+			const struct inode *inode = hdr->inode;
 			const struct nfs_inode *nfsi = NFS_I(inode);
-
-			__entry->status = status;
-			__entry->offset = offset;
-			__entry->eof = eof;
+			const struct nfs_fh *fh = hdr->args.fh ?
+						  hdr->args.fh : &nfsi->fh;
+
+			__entry->status = task->tk_status;
+			__entry->offset = hdr->args.offset;
+			__entry->arg_count = hdr->args.count;
+			__entry->res_count = hdr->res.count;
+			__entry->eof = hdr->res.eof;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
-			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
 		TP_printk(
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld status=%d%s",
+			"offset=%lld count=%u res=%u status=%d%s",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			__entry->offset, __entry->status,
+			(long long)__entry->offset, __entry->arg_count,
+			__entry->res_count, __entry->status,
 			__entry->eof ? " eof" : ""
 		)
 );
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index cfe0b586eadd..12deb3bdb2a0 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -214,7 +214,7 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
 
 	task_setup_data->flags |= swap_flags;
 	rpc_ops->read_setup(hdr, msg);
-	trace_nfs_initiate_read(inode, hdr->io_start, hdr->good_bytes);
+	trace_nfs_initiate_read(hdr);
 }
 
 static void
@@ -247,8 +247,7 @@ static int nfs_readpage_done(struct rpc_task *task,
 		return status;
 
 	nfs_add_stats(inode, NFSIOS_SERVERREADBYTES, hdr->res.count);
-	trace_nfs_readpage_done(inode, task->tk_status,
-				hdr->args.offset, hdr->res.eof);
+	trace_nfs_readpage_done(task, hdr);
 
 	if (task->tk_status == -ESTALE) {
 		set_bit(NFS_INO_STALE, &NFS_I(inode)->flags);
-- 
2.24.1

