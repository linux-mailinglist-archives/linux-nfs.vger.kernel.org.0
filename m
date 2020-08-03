Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5A023AB1C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgHCRAC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHCRAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A99C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:01 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x1so11389085ilp.7
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/iaCHTj1bfpqh6fyIWupfy5aDZSLO5YIBrwmLa15pE=;
        b=GYKflM59g8ZqdngbOs/hLGmBkIU1dHDHeXrTcuSLpw/JCFqULHsECYZJC6zoO1vtgq
         5Mk9GpEjEpDWBR7yZgD7aHL4KbKfAx3S4gxk2aXEcvOZmys93O8tmzlSb8257HRjIZ0j
         uSg2nRuYo3Njxaeqi6qabZ9GvfeuFEW2jLhY5h2TZ6mufWIDn/op8+SUaYK4mczkOP9X
         GI9kciUTbKfzOhDvK58Ku2TaV3kChJ7rJ4lN/yMsSth9ERYEqalsU3Fx2QxkDyJVOc+d
         htGfBhXRaSRVzlqoFefEFEqCFj/SRFWOAoug23kM3t910mGFyyAsQ5x+vkBRrr8GncvG
         w0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m/iaCHTj1bfpqh6fyIWupfy5aDZSLO5YIBrwmLa15pE=;
        b=ZyVo7aKcYmJjqwS6qZBIiYxbL2l5N3e/h/BA7Rfm8VW8ePEOgB3MEpeqGO8AFkq6gQ
         hLrtfIcL+y8iMR16CwDhDzjyZrUmRB3Zp+KEsj0lf7R7k7w8OVUNTGNbL3ry7jk69Yv2
         ZakC0Dg9pvgEpIOHXEDknwornb0RtYmhY/hchF/HEKhW0yoPkImgt83QaFykoFYoiSMS
         +vetDA9ys7yRFOb/hDne5/+p7QgSo3AJbXhvgCLXpLRmPct2VKYroW/E9cDbik+Znkfw
         kA86GSrqs9jUMUAvWMcPQdXxeH4fY4vqgHYAJhs5XkwKhhGO1u1Dmw4+LYscQi73IQMg
         MrjQ==
X-Gm-Message-State: AOAM531lGETsBROOn4mJO0+eHM5h6S70E8qT1N7nQDR2WWjBY2PSSkhR
        jTMsZnS8LJLP6tln3dl6BJ4=
X-Google-Smtp-Source: ABdhPJzhiJYi14KSK7bDNHDZdGwgKwGV/QFxSsNVfn8dtj5KSvBkvhDtbeDn2m9ANW108TCeQnlFig==
X-Received: by 2002:a92:858a:: with SMTP id f132mr287112ilh.225.1596474000905;
        Mon, 03 Aug 2020 10:00:00 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id f20sm10794639ilj.62.2020.08.03.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:00 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 4/6] NFSD: Add READ_PLUS hole segment encoding
Date:   Mon,  3 Aug 2020 12:59:52 -0400
Message-Id: <20200803165954.1348263-5-Anna.Schumaker@Netapp.com>
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

However, we still only reply to the READ_PLUS call with a single segment
at this time.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfs4xdr.c  | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9630d33211f2..36305b846f5a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2528,7 +2528,7 @@ static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op
 	u32 maxcount = svc_max_payload(rqstp);
 	u32 rlen = min(op->u.read.rd_length, maxcount);
 	/* enough extra xdr space for encoding either a hole or data segment. */
-	u32 segments = 1 + 2 + 2;
+	u32 segments = 2 * (1 + 2 + 2);
 
 	return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1d143bf02b83..292819eafcac 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4378,10 +4378,14 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
 	int starting_len = xdr->buf->len;
+	loff_t hole_pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
 	__be32 nfserr;
 	__be32 *p, tmp;
 	__be64 tmp64;
 
+	if (hole_pos > read->rd_offset)
+		maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
+
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
@@ -4407,6 +4411,27 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
+			    struct nfsd4_read *read,
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
+	*p++ = htonl(NFS4_CONTENT_HOLE);
+	 p   = xdr_encode_hyper(p, read->rd_offset);
+	 p   = xdr_encode_hyper(p, maxcount);
+
+	*eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
@@ -4417,6 +4442,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int starting_len = xdr->buf->len;
 	int segments = 0;
 	__be32 *p, tmp;
+	loff_t pos;
 	u32 eof;
 
 	if (nfserr)
@@ -4435,11 +4461,23 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
 
 	eof = read->rd_offset >= i_size_read(file_inode(file));
-	if (!eof) {
+	if (eof)
+		goto out;
+
+	pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	if (pos == -ENXIO)
+		pos = i_size_read(file_inode(file));
+
+	if (pos > read->rd_offset) {
+		maxcount = pos - read->rd_offset;
+		nfserr = nfsd4_encode_read_plus_hole(resp, read, maxcount, &eof);
+		segments++;
+	} else {
 		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
 		segments++;
 	}
 
+out:
 	if (nfserr)
 		xdr_truncate_encode(xdr, starting_len);
 	else {
-- 
2.27.0

