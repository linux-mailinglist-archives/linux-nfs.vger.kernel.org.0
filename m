Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3E1D007D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgELVOP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVOP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:14:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7202C061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:14:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f13so14646071qkh.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hgx+YvI+ycbQdWpCFSj8PO1/TeDJrD2GWM6MZFwywAM=;
        b=uGARIsyhar+Bc47iy0cr4stuB1KbE2WOgTh9hK/ZSBhuQrfvGNhZ7V0HSLHk4SaeJm
         TmfxkHWpyute9B9iamvk1pEGLRFtx7mP+VfpDR6OcNla6YrksvaXNz8p+2dvvUlRA4sy
         QIgYfpUFWNSJ/ZvqxXgqTMoKRIGZxjRlNQVhUEGYjtJmYEgwz7u+KTKqVmDuGyRIYIzU
         SFJbekyRqzoWJGMtbL0SYwmtR+jJb8w9TDn+aTe4I0jBQXHtNCjPqKnK4fSZi45O7gNd
         R3BrxT/y2hi0gy9aPtAGd2mC2GdRsxZDHh8bAdHrR6O4IKXEPP/lMVPjY+8C2wlR4fhU
         fU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=hgx+YvI+ycbQdWpCFSj8PO1/TeDJrD2GWM6MZFwywAM=;
        b=JFq1RnfhJguR1oa+vxf4sT821DqN0q5szFcdp6fvnAaTmHhCstoeiHsAqlc4DISTfU
         NEEdoZXl5WwPyWTJW/INrQea+0J5rOR260k3eNk/D5bBNPOvXUNHjxXOLLyOeu3XHg8k
         H1l5IpM+d748vuGXH7XQP4B6QedbCjtYY4ORGDxLrhM0sRB1N53QATq6wZhE01CO+g2x
         Wu8tL5YmXV2s5xPd3ud6aTvptqDKR0+SLgBOmdjnj8WjqZUqIwpgZ0x64FLIoKvg5TkA
         WKxH5sItARurQESQ/hxnll/XbBXGE2dvsSarid5GtAeLSc77Z+sXhWm+dguhtHS/feZI
         9Kdg==
X-Gm-Message-State: AGi0PuYDSOqDqulprrWyibi4urK6g+AHDzur9Eem+o3dUFwMM/R88dei
        BYQM7NN2FcxQAbd5kBWdQHU=
X-Google-Smtp-Source: APiQypIN0bV/FF2GfOsBvHAY8rL4y+TQyq+LlXcxmeZi/FJ8+zGaxgbt3GSdLXnGxTXRjXJMbxzp1A==
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr16884690qkg.314.1589318052770;
        Tue, 12 May 2020 14:14:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o16sm12528556qko.38.2020.05.12.14.14.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:14:12 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLEB7f009836;
        Tue, 12 May 2020 21:14:11 GMT
Subject: [PATCH v1 15/15] NFS: Add a tracepoint in nfs_set_pgio_error()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:14:11 -0400
Message-ID: <20200512211410.3288.41934.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/pagelist.c |    2 ++
 2 files changed, 46 insertions(+)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index b35998c5c9ca..547cec79899f 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1008,6 +1008,50 @@
 		)
 );
 
+TRACE_EVENT(nfs_pgio_error,
+	TP_PROTO(
+		const struct nfs_pgio_header *hdr,
+		int error,
+		loff_t pos
+	),
+
+	TP_ARGS(hdr, error, pos),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u32, fhandle)
+		__field(u64, fileid)
+		__field(loff_t, offset)
+		__field(u32, arg_count)
+		__field(u32, res_count)
+		__field(loff_t, pos)
+		__field(int, status)
+	),
+
+	TP_fast_assign(
+		const struct inode *inode = hdr->inode;
+		const struct nfs_inode *nfsi = NFS_I(inode);
+		const struct nfs_fh *fh = hdr->args.fh ?
+					  hdr->args.fh : &nfsi->fh;
+
+		__entry->status = error;
+		__entry->offset = hdr->args.offset;
+		__entry->arg_count = hdr->args.count;
+		__entry->res_count = hdr->res.count;
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->fileid = nfsi->fileid;
+		__entry->fhandle = nfs_fhandle_hash(fh);
+	),
+
+	TP_printk("fileid=%02x:%02x:%llu fhandle=0x%08x "
+		  "offset=%lld count=%u res=%u pos=%llu status=%d",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		(unsigned long long)__entry->fileid, __entry->fhandle,
+		(long long)__entry->offset, __entry->arg_count, __entry->res_count,
+		__entry->pos, __entry->status
+	)
+);
+
 TRACE_DEFINE_ENUM(NFS_UNSTABLE);
 TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
 TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index f61f96603df7..a517cf02c197 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -24,6 +24,7 @@
 
 #include "internal.h"
 #include "pnfs.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
@@ -64,6 +65,7 @@ void nfs_set_pgio_error(struct nfs_pgio_header *hdr, int error, loff_t pos)
 {
 	unsigned int new = pos - hdr->io_start;
 
+	trace_nfs_pgio_error(hdr, error, pos);
 	if (hdr->good_bytes > new) {
 		hdr->good_bytes = new;
 		clear_bit(NFS_IOHDR_EOF, &hdr->flags);

