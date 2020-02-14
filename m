Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7B15F87E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbgBNVMO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:14 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35701 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbgBNVMO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:14 -0500
Received: by mail-yb1-f194.google.com with SMTP id p123so5460804ybp.2
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtYU/0Wy3sqMPbMsYOYq4Pr2V/KGFlNx6o6cnmuPpPY=;
        b=FeDLswp7rUqUCzwlHuYADnP5vUKcj6iSFsINwCabOGdxIELtURw/XPEF/11Af8QRXW
         N0SRcJ3r1BT6T7NI0jhW0NZqIMK8coTgm2Stf1pnzLvltmfZW0GofarTBqV+RLs+otPA
         kXhnWLlkoVNdIk+lOQtUrgHY9zURsNF3hn3fmhYBOCoZcbeDV9u6PwuAAEEjs/fM6gGk
         Cq7M77J2wBejLKaICgew8ILnNuifCWHOYqy1Uya4pmDbcSGbpfvGm0/Fgk98R+Mr6xNv
         VlLYWzjoH9gfP7oHX+yKqoGgwOmvaFNAsYhg+ySMSIgnctxvjMaLi5leMpqjdjVmPWMb
         MVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UtYU/0Wy3sqMPbMsYOYq4Pr2V/KGFlNx6o6cnmuPpPY=;
        b=ikWZyts7emuGGQIATT2ov+L9s7rZ9BqHZ4uHrEzh5lqfi5i3p20drUMDqMHTmU5MEl
         l2qDfGG9lAx9wGXvd3id4NgvGt1SKDEF1YRHaxBMhN8e3Me0VWuED091EwT/MPH4uBCc
         C0QNtm727tYql0pPtxtsmE40Ry0JqCp9xLgEnYdEmFCA0d9PxrokBI5kzCzWAMQ9450b
         028VLUbRSa7+hUGDuE1AjVKf83zVfdSsWMQZOC8YSUlPFDp8qU5nTXX4hyhP4vrlhBAc
         pZfNDNf8MUe0US8gHc/q7a6L25rrzJ8YRiw+0MWogltjd0H4/6A0eBvKBUwfZ42Af6k5
         xZ4w==
X-Gm-Message-State: APjAAAVB8h94jRQZOcO0pqjnHI2oYzsBowNig6uoxsdXn4K03SCyqomS
        rjdThsLG9uSrvVKs6m0o+b8t5SI5
X-Google-Smtp-Source: APXvYqwdQj5Sat8+ZyFAWaHJuctVfaUbplKIdC9puY5XL02yE3bdt4Sl4nHcZ4wxZmpjT9Jcoyspxw==
X-Received: by 2002:a25:578b:: with SMTP id l133mr4646131ybb.439.1581714732251;
        Fri, 14 Feb 2020 13:12:12 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id t3sm3360985ywi.18.2020.02.14.13.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:11 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 4/4] NFSD: Encode a full READ_PLUS reply
Date:   Fri, 14 Feb 2020 16:12:06 -0500
Message-Id: <20200214211206.407725-5-Anna.Schumaker@Netapp.com>
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

Reply to the client with multiple hole and data segments. This might
have performance issues due to the number of calls to vfs_llseek(),
depending on the underlying filesystem used on the server.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1a2f06de651d..44bd0b8deafb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4385,14 +4385,18 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
-			    struct nfsd4_read *read,
-			    unsigned long maxcount,  u32 *eof)
+			    struct nfsd4_read *read, u32 *eof)
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
+	unsigned long maxcount = read->rd_length;
+	loff_t hole_pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
 	__be32 nfserr;
 	__be32 *p;
 
+	if (hole_pos > read->rd_offset)
+		maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
+
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
@@ -4404,6 +4408,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 		nfserr = nfsd4_encode_splice_read(resp, read, file, &maxcount, eof);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, &maxcount, eof);
+	clear_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
 
 	if (nfserr)
 		return nfserr;
@@ -4418,18 +4423,24 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 }
 
 static __be32
-nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp, struct nfsd4_read *read,
-			    unsigned long maxcount, u32 *eof)
+nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
+			    struct nfsd4_read *read, u32 *eof, loff_t data_pos)
 {
 	struct file *file = read->rd_nf->nf_file;
+	unsigned long maxcount = read->rd_length;
 	__be32 *p;
 
+	if (data_pos == 0)
+		data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	if (data_pos == -ENXIO)
+		data_pos = i_size_read(file_inode(file));
+
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
 	if (!p)
 		return nfserr_resource;
 
-	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+	maxcount = min_t(unsigned long, maxcount, data_pos - read->rd_offset);
 
 	*p++ = cpu_to_be32(NFS4_CONTENT_HOLE);
 	 p   = xdr_encode_hyper(p, read->rd_offset);
@@ -4453,6 +4464,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int starting_len = xdr->buf->len;
 	unsigned int segments = 0;
 	loff_t data_pos;
+	bool is_data;
 	__be32 *p;
 
 	if (nfserr)
@@ -4476,21 +4488,26 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, maxcount,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+	read->rd_length = maxcount;
 
 	data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
 	if (data_pos == -ENXIO)
 		data_pos = i_size_read(file_inode(file));
 	else if (data_pos < 0)
 		data_pos = read->rd_offset;
+	is_data = (data_pos == read->rd_offset);
+	eof = read->rd_offset > i_size_read(file_inode(file));
 
-	if (data_pos > read->rd_offset) {
-		nfserr = nfsd4_encode_read_plus_hole(resp, read,
-						     data_pos - read->rd_offset, &eof);
-		segments++;
-	}
+	while (read->rd_length > 0 && !eof) {
+		if (is_data)
+			nfserr = nfsd4_encode_read_plus_data(resp, read, &eof);
+		else
+			nfserr = nfsd4_encode_read_plus_hole(resp, read, &eof, data_pos);
 
-	if (!nfserr && !eof && read->rd_length > 0) {
-		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+		if (nfserr)
+			break;
+		is_data = !is_data;
+		data_pos = 0;
 		segments++;
 	}
 
-- 
2.25.0

