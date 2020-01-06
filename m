Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3068513195C
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgAFU1l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:41 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35138 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFU1k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:40 -0500
Received: by mail-yb1-f195.google.com with SMTP id a124so22628969ybg.2
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dDw/+1yN2S9DNI7Ptfgv7hoaMcpBXLTyYaESgUv33U=;
        b=Y5ubT6K55dX6A0SsrIeVcJsx/zuyTaMCleiXpjfJAtlfSolac1LoZMo0DcKmJVj9Lh
         vhPelA2tqa+/Fg2W9fXYbjQw6mrnACbCoBh4snNZGav718HZ3RYUjwZDXF8Hf15KdGZQ
         TBqaLNAeoUOL8/QBPGchlDxh6TENOgFSipf01sDT/suc5u++MwPcmB+J8Q+JWjWXY9Cy
         RkyJpbMRffSU864gWvbRSzZPeaZZpyX/LfCbiVfFV/7FV4TpId5rwJb3S7jx8dY32cgH
         jMTV7jeiS3ztNfFWJgdkkiRnhTETA63GXx5j8TJ379PChW+a7s5ZIlWb4lzKgNmuzFMG
         yt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dDw/+1yN2S9DNI7Ptfgv7hoaMcpBXLTyYaESgUv33U=;
        b=UR0/ze2dEl5VvQ6MHWIQMLSGwGJTrvzZG3DIOXPjYEnsSJWxSVPLiAc6LEn9/tKJoP
         Ldzr6noKYQz7IfLhQBpT1BCSO2E6FMKNSyml7Y2Gkxsd120s/z9mtLWsSiqc7jf6cQFi
         jMA0QRzHH5Lr6NqZMbYE7ohSivTNBygFHqvJGG277a6+Lc/BzT4FVhskH+P1scqJ16dz
         1ifi/yLcNomFzvhHZMLuKU9WJ/HtHlRQILFLHCOdcyEP1yRrR7mE11y3a9WF+EOd4dTy
         nvpplVnPTaSWpuYOsGT+0OKIO7IS1f65Txh5yKzhTsucRBEJvUI2ZK1vMVg+cLGVkMGc
         CiuA==
X-Gm-Message-State: APjAAAVeqWFU8ae2jzapJ4wCLDTSluRj12G3BXQUw7oL++4A5MwLtvJu
        7aDSSTMgIbwCjcP/AZ4bQw==
X-Google-Smtp-Source: APXvYqw9RKlAiAZUF5wSTsS70EA2LdcnYVq7agMbRWPaLskk7UAHni8USzIP5o7QlJxE0Am0ajqhhQ==
X-Received: by 2002:a25:424b:: with SMTP id p72mr51294322yba.230.1578342459310;
        Mon, 06 Jan 2020 12:27:39 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:38 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 11/15] NFS: Clean up generic file commit tracepoint
Date:   Mon,  6 Jan 2020 15:25:10 -0500
Message-Id: <20200106202514.785483-12-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-11-trond.myklebust@hammerspace.com>
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
 <20200106202514.785483-11-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up the generic file commit tracepoints to use a 64-bit value
for the verifier, and to display the pNFS filehandle, if it exists.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h | 42 ++++++++++++++++++++++++++----------------
 fs/nfs/write.c    |  2 +-
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 3d8d36fe7b6f..51043f02e86f 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1016,71 +1016,81 @@ TRACE_EVENT(nfs_initiate_commit,
 		TP_ARGS(data),
 
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
 			const struct inode *inode = data->inode;
 			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = data->args.fh ?
+						  data->args.fh : &nfsi->fh;
 
 			__entry->offset = data->args.offset;
 			__entry->count = data->args.count;
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
 
 TRACE_EVENT(nfs_commit_done,
 		TP_PROTO(
+			const struct rpc_task *task,
 			const struct nfs_commit_data *data
 		),
 
-		TP_ARGS(data),
+		TP_ARGS(task, data),
 
 		TP_STRUCT__entry(
-			__field(int, status)
-			__field(loff_t, offset)
-			__field(unsigned long long, verifier)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(int, status)
+			__field(enum nfs3_stable_how, stable)
+			__array(char, verifier, NFS4_VERIFIER_SIZE)
 		),
 
 		TP_fast_assign(
 			const struct inode *inode = data->inode;
 			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = data->args.fh ?
+						  data->args.fh : &nfsi->fh;
+			const struct nfs_writeverf *verf = data->res.verf;
 
-			__entry->status = data->res.op_status;
+			__entry->status = task->tk_status;
 			__entry->offset = data->args.offset;
-			memcpy(&__entry->verifier, &data->verf.verifier,
-			       sizeof(__entry->verifier));
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
-			"offset=%lld status=%d verifier 0x%016llx",
+			"offset=%lld status=%d stable=%s verifier=%s",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			__entry->offset, __entry->status,
-			__entry->verifier
+			(long long)__entry->offset, __entry->status,
+			nfs_show_stable(__entry->stable),
+			__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE)
 		)
 );
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d0f62aef3489..985ddff46051 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1831,7 +1831,7 @@ static void nfs_commit_done(struct rpc_task *task, void *calldata)
 
 	/* Call the NFS version-specific code */
 	NFS_PROTO(data->inode)->commit_done(task, data);
-	trace_nfs_commit_done(data);
+	trace_nfs_commit_done(task, data);
 }
 
 static void nfs_commit_release_pages(struct nfs_commit_data *data)
-- 
2.24.1

