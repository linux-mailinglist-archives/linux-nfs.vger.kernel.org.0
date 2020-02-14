Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D8315F87D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbgBNVMM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:12 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42123 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbgBNVMM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:12 -0500
Received: by mail-yb1-f194.google.com with SMTP id z125so5449554ybf.9
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9W4FRHuuMseETkbkEFFK76sP3y9JfgrFreZU9gs8hLg=;
        b=lYCR3abFSdaBfS5lgzU0xSBtjokrnYxosvdLgfig8FvJ3yPafSV8Cc9mEzyrebHRUu
         G6Gd1zD2NjhvUG2U5kuEexxi5lLrLFjnYM1yQHiIIPnvCCz6AeEpq8sPTs3y/7sMryd/
         SIbm6GPN+RVXS2kBdYkSf0Qv5VceDMFpkWiNM+ZDVMUEJ2aQE0J6mzULY/G9TqMksFNn
         0+p7VABZaYGEdS+ndyRRHtYWik0qR3+hljWiqFCJiQ1GJAMmygv1XlB3MU/vxJcfEvPs
         fNoBFKFkRxJbGZyk83gsmtJkY4OxaU7C2YaNTsYfPa+KLQHfq4dXH/kLMK6z0os0ntWD
         cRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9W4FRHuuMseETkbkEFFK76sP3y9JfgrFreZU9gs8hLg=;
        b=oXPRRN0WEZA6rjNWIwzzZ4PZhxOP0fwD0OAt3BUvRHtRiRfMq8GntsNvrh/VvK+AER
         7B2I4ady1vZFESnVtnTyzYCNG3cn6dFkT04HQSgpV9FuZV3UFrzfAozgxfH+zzRltq59
         WzU3RzWtKqcGCBYfb8tCNWgqmP8LxqRReFuzFJEDmzrpUb7ahJNcV5lEiItzuC/iKPUh
         slL9GEKFQnMmXDDq+euzofL0YSpwD/KyAxRN3/9olCv284XPSIstn+544013I6EHGkCW
         OGadnzEHK+6imL/YtQ8lhdFCwpRNG+epf8tvOwpAUSl7VzuirdJb33/CN+sXr+nd4OsP
         c9gA==
X-Gm-Message-State: APjAAAWLyQ1FsXf/EYmMxqcsKvcq9KAptXIyiDtpC9YeddVIRvR6frV5
        CShkxDEV4doOGUYWTmR2U2LJ49Kk
X-Google-Smtp-Source: APXvYqwGSvSnD6GcFV5Ma00waO+G9WOo/B4a4TC+impzxhSRYTe3iaTXUa0FfbA2XjzRrc0errsWig==
X-Received: by 2002:a25:b226:: with SMTP id i38mr4685274ybj.148.1581714731211;
        Fri, 14 Feb 2020 13:12:11 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id t3sm3360985ywi.18.2020.02.14.13.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:10 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 3/4] NFSD: Add READ_PLUS hole segment encoding
Date:   Fri, 14 Feb 2020 16:12:05 -0500
Message-Id: <20200214211206.407725-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
References: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

However, we only encode the hole if it is at the beginning of the range
and treat everything else as data to keep things simple.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfs4xdr.c  | 47 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9643181591e3..c65939a1e40c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2527,7 +2527,7 @@ static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op
 	u32 maxcount = svc_max_payload(rqstp);
 	u32 rlen = min(op->u.read.rd_length, maxcount);
 	/* enough extra xdr space for encoding either a hole or data segment. */
-	u32 segments = 1 + 2 + 2;
+	u32 segments = 2 * (1 + 2 + 2);
 
 	return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8efb59d4fda4..1a2f06de651d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4417,6 +4417,31 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	return nfserr;
 }
 
+static __be32
+nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp, struct nfsd4_read *read,
+			    unsigned long maxcount, u32 *eof)
+{
+	struct file *file = read->rd_nf->nf_file;
+	__be32 *p;
+
+	/* Content type, offset, byte count */
+	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
+	if (!p)
+		return nfserr_resource;
+
+	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+
+	*p++ = cpu_to_be32(NFS4_CONTENT_HOLE);
+	 p   = xdr_encode_hyper(p, read->rd_offset);
+	 p   = xdr_encode_hyper(p, maxcount);
+
+	*eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
+
+	read->rd_offset += maxcount;
+	read->rd_length  = (maxcount > 0) ? read->rd_length - maxcount : 0;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
@@ -4426,6 +4451,8 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
+	unsigned int segments = 0;
+	loff_t data_pos;
 	__be32 *p;
 
 	if (nfserr)
@@ -4450,12 +4477,28 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
 
-	nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+	data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	if (data_pos == -ENXIO)
+		data_pos = i_size_read(file_inode(file));
+	else if (data_pos < 0)
+		data_pos = read->rd_offset;
+
+	if (data_pos > read->rd_offset) {
+		nfserr = nfsd4_encode_read_plus_hole(resp, read,
+						     data_pos - read->rd_offset, &eof);
+		segments++;
+	}
+
+	if (!nfserr && !eof && read->rd_length > 0) {
+		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+		segments++;
+	}
+
 	if (nfserr)
 		xdr_truncate_encode(xdr, starting_len);
 	else {
 		*p++ = htonl(eof);
-		*p++ = htonl(1);
+		*p++ = htonl(segments);
 	}
 
 	return nfserr;
-- 
2.25.0

