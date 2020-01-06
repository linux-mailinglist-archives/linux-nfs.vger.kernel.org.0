Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB6131957
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAFU1e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:34 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35967 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFU1e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:34 -0500
Received: by mail-yw1-f68.google.com with SMTP id n184so22431784ywc.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t2HVIvvAWl6CAUdqZd8MDCS0BbExZ4DPY8F7IMA1x3o=;
        b=MwSqQ/CrBb+trAat9+nWTg1q4A00q+T3ehos7+tffEyOJ6g5FU+thBbvGAzR/jt0RD
         fG1fk7IuFKotd0WrxSS15jsIlxZsyaV/6fi8hiL/uP+G1gdB8CV1KM8XNHM3JgtoBFOl
         z9zMJM2aw+ouCxKpUwDeTiDf1MiTOE5fbpcqn4K+fM6MYLpL8zSzRD+FNOo41Q7HMBcH
         8yvploi0+V90QDL6dgiRvrJtAbkdJLFe0qTlDu5KIER/lq7B1/wkQW1jle1EZbSLcUd1
         BvOW9mZtON9oBfWZwdVOYJ/1dJqUVz0nhYowikcRrFdk1818W8Nv7GEay37psDqr5lHp
         dAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2HVIvvAWl6CAUdqZd8MDCS0BbExZ4DPY8F7IMA1x3o=;
        b=jU3EQytp0mxQTLwiMJ0eeiazn8fzIMQNNEmjOjH7OVEX8cWvi9OkxZ/gTvO0ZJMeuZ
         fbjrim3gyeiezXgeu7k1+2rT/qZ8sFmqOqgqqqxHE18FxHTBtVBq0eYF1As9GClPGf5P
         wGU/+9n/cBalL9I8i0/pByBLeVPCt1gULl/D16DUqV2FmsTcaVugld7IWhO1ox1UlVi/
         eWKnLDaICK+DcvtqAuDnHbB9N0LDQnm8/3h/BGwJi/1rbxqT1oxYdgE97EqSxwwlRida
         1mD2k+bCoxI0zT5LW5rRYAZytsZYuMAiF2XX3FPy7od258xaJbnhzzdR0RMfHTYTuwaO
         p2nQ==
X-Gm-Message-State: APjAAAVMUkgRbokTFpjM5vbf47A1w1Ci6w7bth5Of/0kzo1aPpC14Kz+
        K8DOqgoQwmPrx4OfUr/EtQ==
X-Google-Smtp-Source: APXvYqz8lCXBlsUPVPu4cduNDbGaKgKbqV+JyqUJsm77ubljlyXQjIQfxZDxriqmS9nvN3+HHueA4w==
X-Received: by 2002:a81:a0c3:: with SMTP id x186mr75848883ywg.344.1578342452874;
        Mon, 06 Jan 2020 12:27:32 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:32 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/15] NFSv4: Improve read/write/commit tracing
Date:   Mon,  6 Jan 2020 15:25:05 -0500
Message-Id: <20200106202514.785483-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-6-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
 <20200106202514.785483-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure we always return the number of bytes read/written. Also display
the pnfs filehandle if it is in use.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4trace.h | 52 ++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index e60b6fbd5ada..a3155b7f8063 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1694,7 +1694,8 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 			__field(u32, fhandle)
 			__field(u64, fileid)
 			__field(loff_t, offset)
-			__field(size_t, count)
+			__field(u32, arg_count)
+			__field(u32, res_count)
 			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
@@ -1702,13 +1703,18 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 
 		TP_fast_assign(
 			const struct inode *inode = hdr->inode;
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = hdr->args.fh ?
+						  hdr->args.fh : &nfsi->fh;
 			const struct nfs4_state *state =
 				hdr->args.context->state;
+
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
-			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(fh);
 			__entry->offset = hdr->args.offset;
-			__entry->count = hdr->args.count;
+			__entry->arg_count = hdr->args.count;
+			__entry->res_count = hdr->res.count;
 			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
 				be32_to_cpu(state->stateid.seqid);
@@ -1718,14 +1724,14 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%zu stateid=%d:0x%08x",
+			"offset=%lld count=%u res=%u stateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset,
-			__entry->count,
+			__entry->arg_count, __entry->res_count,
 			__entry->stateid_seq, __entry->stateid_hash
 		)
 );
@@ -1754,7 +1760,8 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 			__field(u32, fhandle)
 			__field(u64, fileid)
 			__field(loff_t, offset)
-			__field(size_t, count)
+			__field(u32, arg_count)
+			__field(u32, res_count)
 			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
@@ -1762,13 +1769,18 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 
 		TP_fast_assign(
 			const struct inode *inode = hdr->inode;
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = hdr->args.fh ?
+						  hdr->args.fh : &nfsi->fh;
 			const struct nfs4_state *state =
 				hdr->args.context->state;
+
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
-			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(fh);
 			__entry->offset = hdr->args.offset;
-			__entry->count = hdr->args.count;
+			__entry->arg_count = hdr->args.count;
+			__entry->res_count = hdr->res.count;
 			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
 				be32_to_cpu(state->stateid.seqid);
@@ -1778,14 +1790,14 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%zu stateid=%d:0x%08x",
+			"offset=%lld count=%u res=%u stateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset,
-			__entry->count,
+			__entry->arg_count, __entry->res_count,
 			__entry->stateid_seq, __entry->stateid_hash
 		)
 );
@@ -1814,24 +1826,28 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
-			__field(loff_t, offset)
-			__field(size_t, count)
 			__field(unsigned long, error)
+			__field(loff_t, offset)
+			__field(u32, count)
 		),
 
 		TP_fast_assign(
 			const struct inode *inode = data->inode;
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = data->args.fh ?
+						  data->args.fh : &nfsi->fh;
+
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
-			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(fh);
 			__entry->offset = data->args.offset;
 			__entry->count = data->args.count;
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 		),
 
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%zu",
+			"offset=%lld count=%u",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
-- 
2.24.1

