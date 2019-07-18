Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72C6D57D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2019 21:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfGRTyd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jul 2019 15:54:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45318 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfGRTyd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jul 2019 15:54:33 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so53494791ioc.12
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2019 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZf1JGBtEpdR2Kn5xIsk4bVnVt8djUuW1ZWe+4cxkFY=;
        b=pkBzgVvTTtRY0IrDLcTV50nvoNaM/1aK5NMPmbkgXlL5HRYVYZQRMid19zvSEtwoea
         L0+MwUIfxEGFgKJN2lUI+LOJvMblXSy1T+qrdbs0xQbwTNZ7no0wguXbbHgOm0xWWzWL
         7vpGD3m1GUzvwITVRa/7zW0BbSB3/YpapZsc5fE89erramj/0rCtECPsqqwYecEOdlXu
         XpgYyXHcu0g6AnLwlRhx0UaZWjkQ4Gz+ROVhiBVDiVw7+O3Myubs1GP1Y9624e6PrUXs
         o1Go7oe5pgOLLgAtSmSzZyu/q5ePlkO1OQCvPfrNul+URSq/N22eZ6y3xT4DOJl91uLf
         HjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZf1JGBtEpdR2Kn5xIsk4bVnVt8djUuW1ZWe+4cxkFY=;
        b=KjW1S9CS6iY/BfChl4HYptvFO2z+kejarWXjHXn1Ff6GJmyW5rgEGN5MU7RoZDxcVu
         LUuHwqzPRIMMo4GotKbyR61WXHRbfQz9/UAy5EcNdqyurslkacYYiz07ReS7AZDL2Rde
         Du/Wgv7h3U7J/PfqCr7kUZ0CWRCTOAI3m1Z9bR9dJSv5Ie0b49BPLh9ZkcFn9pevu4VV
         mMK5Kp3y1pynhrP2Zsneq/jyFlfJYqMeut/Ns63tApqEKvp8tPOHyqHdVyQHXVN/Kr+v
         dGFrsWq2C7fLHQ/fzRBp6tYmd0ooKVRDC7X6cGl4sTND5pAd3U5ryQqzFQBKsXQjkYDm
         61Ug==
X-Gm-Message-State: APjAAAVy+US8CzJzg+vl32EiuV8b4UXnE+xAVU3Vd6x0qxnl3iUff/LG
        39GDDK59uNdk/DRkpKpQn/6Qy8E=
X-Google-Smtp-Source: APXvYqxHdh/NTEqWzYjNfBkO2xF9XbZSWPsA4kqwSyHywSd78cBov8eWB7I5Bvwr3sYI2neluzag8w==
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr45666276iol.269.1563479671881;
        Thu, 18 Jul 2019 12:54:31 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j23sm21969825ioo.6.2019.07.18.12.54.31
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 12:54:31 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] pnfs/flexfiles: Add tracepoints for detecting pnfs fallback to MDS
Date:   Thu, 18 Jul 2019 15:52:24 -0400
Message-Id: <20190718195224.36419-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add tracepoints to allow debugging of the event chain leading to
a pnfs fallback to doing I/O through the MDS.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 26 +++++++++
 fs/nfs/nfs4trace.c                     |  8 +++
 fs/nfs/nfs4trace.h                     | 76 +++++++++++++++++++++++++-
 fs/nfs/pnfs.c                          |  2 +
 include/linux/nfs4.h                   |  1 +
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index bcff3bf5ae09..b04e20d28162 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -934,6 +934,10 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	if (pgio->pg_error < 0)
 		return;
 out_mds:
+	trace_pnfs_mds_fallback_pg_init_read(pgio->pg_inode,
+			0, NFS4_MAX_UINT64, IOMODE_READ,
+			NFS_I(pgio->pg_inode)->layout,
+			pgio->pg_lseg);
 	pnfs_put_lseg(pgio->pg_lseg);
 	pgio->pg_lseg = NULL;
 	nfs_pageio_reset_read_mds(pgio);
@@ -1000,6 +1004,10 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	return;
 
 out_mds:
+	trace_pnfs_mds_fallback_pg_init_write(pgio->pg_inode,
+			0, NFS4_MAX_UINT64, IOMODE_RW,
+			NFS_I(pgio->pg_inode)->layout,
+			pgio->pg_lseg);
 	pnfs_put_lseg(pgio->pg_lseg);
 	pgio->pg_lseg = NULL;
 	nfs_pageio_reset_write_mds(pgio);
@@ -1026,6 +1034,10 @@ ff_layout_pg_get_mirror_count_write(struct nfs_pageio_descriptor *pgio,
 	if (pgio->pg_lseg)
 		return FF_LAYOUT_MIRROR_COUNT(pgio->pg_lseg);
 
+	trace_pnfs_mds_fallback_pg_get_mirror_count(pgio->pg_inode,
+			0, NFS4_MAX_UINT64, IOMODE_RW,
+			NFS_I(pgio->pg_inode)->layout,
+			pgio->pg_lseg);
 	/* no lseg means that pnfs is not in use, so no mirroring here */
 	nfs_pageio_reset_write_mds(pgio);
 out:
@@ -1075,6 +1087,10 @@ static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
 
+		trace_pnfs_mds_fallback_write_done(hdr->inode,
+				hdr->args.offset, hdr->args.count,
+				IOMODE_RW, NFS_I(hdr->inode)->layout,
+				hdr->lseg);
 		task->tk_status = pnfs_write_done_resend_to_mds(hdr);
 	}
 }
@@ -1094,6 +1110,10 @@ static void ff_layout_reset_read(struct nfs_pgio_header *hdr)
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
 
+		trace_pnfs_mds_fallback_read_done(hdr->inode,
+				hdr->args.offset, hdr->args.count,
+				IOMODE_READ, NFS_I(hdr->inode)->layout,
+				hdr->lseg);
 		task->tk_status = pnfs_read_done_resend_to_mds(hdr);
 	}
 }
@@ -1827,6 +1847,9 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 out_failed:
 	if (ff_layout_avoid_mds_available_ds(lseg))
 		return PNFS_TRY_AGAIN;
+	trace_pnfs_mds_fallback_read_pagelist(hdr->inode,
+			hdr->args.offset, hdr->args.count,
+			IOMODE_READ, NFS_I(hdr->inode)->layout, lseg);
 	return PNFS_NOT_ATTEMPTED;
 }
 
@@ -1892,6 +1915,9 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 out_failed:
 	if (ff_layout_avoid_mds_available_ds(lseg))
 		return PNFS_TRY_AGAIN;
+	trace_pnfs_mds_fallback_write_pagelist(hdr->inode,
+			hdr->args.offset, hdr->args.count,
+			IOMODE_RW, NFS_I(hdr->inode)->layout, lseg);
 	return PNFS_NOT_ATTEMPTED;
 }
 
diff --git a/fs/nfs/nfs4trace.c b/fs/nfs/nfs4trace.c
index e9fb3e50a999..1a8f376b3f73 100644
--- a/fs/nfs/nfs4trace.c
+++ b/fs/nfs/nfs4trace.c
@@ -16,4 +16,12 @@
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs4_pnfs_read);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs4_pnfs_write);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs4_pnfs_commit_ds);
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_pg_init_read);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_pg_init_write);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_pg_get_mirror_count);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_read_done);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_write_done);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_read_pagelist);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_write_pagelist);
 #endif
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index d85f20945a2b..b2f395fa7350 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1771,6 +1771,7 @@ TRACE_DEFINE_ENUM(PNFS_UPDATE_LAYOUT_BLOCKED);
 TRACE_DEFINE_ENUM(PNFS_UPDATE_LAYOUT_INVALID_OPEN);
 TRACE_DEFINE_ENUM(PNFS_UPDATE_LAYOUT_RETRY);
 TRACE_DEFINE_ENUM(PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET);
+TRACE_DEFINE_ENUM(PNFS_UPDATE_LAYOUT_EXIT);
 
 #define show_pnfs_update_layout_reason(reason)				\
 	__print_symbolic(reason,					\
@@ -1786,7 +1787,8 @@ TRACE_DEFINE_ENUM(PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET);
 		{ PNFS_UPDATE_LAYOUT_BLOCKED, "layouts blocked" },	\
 		{ PNFS_UPDATE_LAYOUT_INVALID_OPEN, "invalid open" },	\
 		{ PNFS_UPDATE_LAYOUT_RETRY, "retrying" },	\
-		{ PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET, "sent layoutget" })
+		{ PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET, "sent layoutget" }, \
+		{ PNFS_UPDATE_LAYOUT_EXIT, "exit" })
 
 TRACE_EVENT(pnfs_update_layout,
 		TP_PROTO(struct inode *inode,
@@ -1845,6 +1847,78 @@ TRACE_EVENT(pnfs_update_layout,
 		)
 );
 
+DECLARE_EVENT_CLASS(pnfs_layout_event,
+		TP_PROTO(struct inode *inode,
+			loff_t pos,
+			u64 count,
+			enum pnfs_iomode iomode,
+			struct pnfs_layout_hdr *lo,
+			struct pnfs_layout_segment *lseg
+		),
+		TP_ARGS(inode, pos, count, iomode, lo, lseg),
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u64, fileid)
+			__field(u32, fhandle)
+			__field(loff_t, pos)
+			__field(u64, count)
+			__field(enum pnfs_iomode, iomode)
+			__field(int, layoutstateid_seq)
+			__field(u32, layoutstateid_hash)
+			__field(long, lseg)
+		),
+		TP_fast_assign(
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->pos = pos;
+			__entry->count = count;
+			__entry->iomode = iomode;
+			if (lo != NULL) {
+				__entry->layoutstateid_seq =
+				be32_to_cpu(lo->plh_stateid.seqid);
+				__entry->layoutstateid_hash =
+				nfs_stateid_hash(&lo->plh_stateid);
+			} else {
+				__entry->layoutstateid_seq = 0;
+				__entry->layoutstateid_hash = 0;
+			}
+			__entry->lseg = (long)lseg;
+		),
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"iomode=%s pos=%llu count=%llu "
+			"layoutstateid=%d:0x%08x lseg=0x%lx",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			show_pnfs_iomode(__entry->iomode),
+			(unsigned long long)__entry->pos,
+			(unsigned long long)__entry->count,
+			__entry->layoutstateid_seq, __entry->layoutstateid_hash,
+			__entry->lseg
+		)
+);
+
+#define DEFINE_PNFS_LAYOUT_EVENT(name) \
+	DEFINE_EVENT(pnfs_layout_event, name, \
+		TP_PROTO(struct inode *inode, \
+			loff_t pos, \
+			u64 count, \
+			enum pnfs_iomode iomode, \
+			struct pnfs_layout_hdr *lo, \
+			struct pnfs_layout_segment *lseg \
+		), \
+		TP_ARGS(inode, pos, count, iomode, lo, lseg))
+
+DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_pg_init_read);
+DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_pg_init_write);
+DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_pg_get_mirror_count);
+DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_read_done);
+DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_write_done);
+DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_read_pagelist);
+DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_write_pagelist);
+
 #endif /* CONFIG_NFS_V4_1 */
 
 #endif /* _TRACE_NFS4_H */
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 758917463700..75bd5b552ba4 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2037,6 +2037,8 @@ pnfs_update_layout(struct inode *ino,
 out_put_layout_hdr:
 	if (first)
 		pnfs_clear_first_layoutget(lo);
+	trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
+				 PNFS_UPDATE_LAYOUT_EXIT);
 	pnfs_put_layout_hdr(lo);
 out:
 	dprintk("%s: inode %s/%llu pNFS layout segment %s for "
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 22494d170619..fd59904a282c 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -660,6 +660,7 @@ enum pnfs_update_layout_reason {
 	PNFS_UPDATE_LAYOUT_BLOCKED,
 	PNFS_UPDATE_LAYOUT_INVALID_OPEN,
 	PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET,
+	PNFS_UPDATE_LAYOUT_EXIT,
 };
 
 #define NFS4_OP_MAP_NUM_LONGS					\
-- 
2.21.0

