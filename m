Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE79F23AB20
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgHCRAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHCRAC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:02 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF4C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:02 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j9so28312322ilc.11
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHsvIo6B5kn1CX5NV/inEHyATDX6IWmUUP9Oh7/wY5M=;
        b=JXX8gl2A+lM+P/Dw/zSq4NmmSzUhuPsf0UC3VBBYfCGeIhdGZxfJnYk6h8OJ/5NOsD
         bW6S5denBBuVifRx+cdbMhmG4i/GX96ZfzFGRHbyl2jzLHlyU6lr2o/YN3RjWFWyvGia
         XS1f2X75vv1EuLFv/neaMx/mY88BVPy2vBsQaEryFdoYfIsvzfYlDJZ564p0bY9FPmAO
         F0bLO8WSzFKNR+Bagcuk20LcFpr74YBXNVuh3cryY2y5WJTMEfdJbZx4wPbSYptl1qve
         Mbd/1ryW+aYRTEYNSFQTZBzG7HwfpMFgMZNQT/lhOJGHYHGuuI+vH6Qj/9cRdnC3c4u1
         Dxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vHsvIo6B5kn1CX5NV/inEHyATDX6IWmUUP9Oh7/wY5M=;
        b=koWKi+/XxK1sNUsGqr4G9YQ36Ue+3ksX+RAVdS5iiT00JgLEDBjln3IHvV6rnq/o5E
         gDQW11PNr/LlE0tGBu2VAJVRUkS0IIef/kWaXKOVsR0Rqzs32nMmhX76cZ/kri6cd4O5
         uZJm5eAa+7x8BV7ACd8MWIUVdfWjb8//MlAs73iai3BIZ+NK9nTP00PD5TA7S1ZGSzbk
         QWl8YrB7Nb5rZxNlqyuO7hB5pVQGg7j3cdJp4xOTDd2+7fCAmY4wnYU+KZtrqNGcZufP
         GOoD1lkyvlhhPx/enIBAK1Q1a36cz9XA8n1ot1gj6zPcenLoa8cCUsmVfZmjD5jlKVI9
         oldg==
X-Gm-Message-State: AOAM531E9M/yykFQlXnElSHM/qz0/76+RTzcpb8zqs36CZidPWp8t+23
        DAQjOt5rjI2HyvLI313p8+L1IiLR
X-Google-Smtp-Source: ABdhPJyYbkJ9HkxqKTKoFodWxkXLxfdRWBqiWSRe+ikVjrAlbtvS745loDHEpc3xoh6UeajfSa9HdA==
X-Received: by 2002:a92:d289:: with SMTP id p9mr350777ilp.100.1596474002065;
        Mon, 03 Aug 2020 10:00:02 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id f20sm10794639ilj.62.2020.08.03.10.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:01 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 5/6] NFSD: Return both a hole and a data segment
Date:   Mon,  3 Aug 2020 12:59:53 -0400
Message-Id: <20200803165954.1348263-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
References: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

But only one of each right now. We'll expand on this in the next patch.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 53 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 292819eafcac..c01bf6241c71 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4373,7 +4373,7 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read,
-			    unsigned long maxcount,  u32 *eof)
+			    unsigned long *maxcount, u32 *eof)
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
@@ -4384,29 +4384,29 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	__be64 tmp64;
 
 	if (hole_pos > read->rd_offset)
-		maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
+		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
 
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
 		return nfserr_resource;
 
-	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
+	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
 	if (read->rd_vlen < 0)
 		return nfserr_resource;
 
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
+			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
 	if (nfserr)
 		return nfserr;
-	if (svc_encode_read_payload(resp->rqstp, starting_len + 16, maxcount))
+	if (svc_encode_read_payload(resp->rqstp, starting_len + 16, *maxcount))
 		return nfserr_io;
 
 	tmp = htonl(NFS4_CONTENT_DATA);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
 	tmp64 = cpu_to_be64(read->rd_offset);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
-	tmp = htonl(maxcount);
+	tmp = htonl(*maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
 	return nfs_ok;
 }
@@ -4414,11 +4414,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 static __be32
 nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read,
-			    unsigned long maxcount, u32 *eof)
+			    unsigned long *maxcount, u32 *eof)
 {
 	struct file *file = read->rd_nf->nf_file;
+	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	unsigned long count;
 	__be32 *p;
 
+	if (data_pos == -ENXIO)
+		data_pos = i_size_read(file_inode(file));
+	else if (data_pos <= read->rd_offset)
+		return nfserr_resource;
+	count = data_pos - read->rd_offset;
+
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
 	if (!p)
@@ -4426,9 +4434,10 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 
 	*p++ = htonl(NFS4_CONTENT_HOLE);
 	 p   = xdr_encode_hyper(p, read->rd_offset);
-	 p   = xdr_encode_hyper(p, maxcount);
+	 p   = xdr_encode_hyper(p, count);
 
-	*eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
+	*eof = (read->rd_offset + count) >= i_size_read(file_inode(file));
+	*maxcount = min_t(unsigned long, count, *maxcount);
 	return nfs_ok;
 }
 
@@ -4436,7 +4445,7 @@ static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
-	unsigned long maxcount;
+	unsigned long maxcount, count;
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
@@ -4459,6 +4468,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, maxcount,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+	count    = maxcount;
 
 	eof = read->rd_offset >= i_size_read(file_inode(file));
 	if (eof)
@@ -4467,13 +4477,26 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
 	if (pos == -ENXIO)
 		pos = i_size_read(file_inode(file));
+	else if (pos < 0)
+		pos = read->rd_offset;
 
-	if (pos > read->rd_offset) {
-		maxcount = pos - read->rd_offset;
-		nfserr = nfsd4_encode_read_plus_hole(resp, read, maxcount, &eof);
+	if (pos == read->rd_offset) {
+		maxcount = count;
+		nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof);
+		if (nfserr)
+			goto out;
+		count -= maxcount;
+		read->rd_offset += maxcount;
 		segments++;
-	} else {
-		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+	}
+
+	if (count > 0 && !eof) {
+		maxcount = count;
+		nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
+		if (nfserr)
+			goto out;
+		count -= maxcount;
+		read->rd_offset += maxcount;
 		segments++;
 	}
 
-- 
2.27.0

