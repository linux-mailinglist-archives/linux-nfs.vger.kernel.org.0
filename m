Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF01D261542
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbgIHQrJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731955AbgIHQ0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:26:19 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E8BC0617A0
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:26:07 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a8so10267903ilk.1
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2S2Lxx0kQ3S0aFYVuRfdaPqpk3hF/pusSGQYcIaIQc=;
        b=stx3mu5AMbv4ZUqCMu+mtiYRRt4bMcwJQ/yBwP9AFGM+ofEYENYstgOPbkly7VVeMT
         1PsqNgWhkBS+7UIWTyj+IbEOvnS5vSR6d/w00+Wzfq+x1L414CwbOm6/7WTYBC4pP02x
         IeMOmhcrpBQxFP/M483r1kngnqkaSSIfczwZxruUhhqhnUOTt6IHu+XdXeio4xwbX8DG
         POqpXhbcMY2d+3TAmnsQ8XNpf3d5h9srsvKHDwDdJ4ViEilEvuDVCKAiik843izgb5EI
         QHYnp/65q21RfLJwBB2YImxOtG5FSFL1yYj5QR3AHmJYnYJtHOyR9g9jf+2kHhLeE3Pv
         8K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U2S2Lxx0kQ3S0aFYVuRfdaPqpk3hF/pusSGQYcIaIQc=;
        b=LKhnnCD49AyJelQIRaiVM6AT6p/T4ptSFUPn6nQ140zPoDuXrT5GplyQROOnCGnzJv
         UbkQkMtPSJ4vO5nutwkcBuLoAYdEM9hO7vUpxzMUj9Tbx81O/GJ+POC4FdkJIgg9nQyK
         lATu8KmVNeuaowGdTBkTcjWnEv/0NSnOMPS5JHvOsaSFjGVmSXgeGB/Lsu8dmxN0sbWn
         5Qwxjwy149kF2jHU9s5cgOXu7L3oSH/RpYZ6S3NGUmO2Tj2KaVc5sWNKRvZ0O3ejWDOD
         qwS5ONwAh1Fv/oZ+Io7njPUxIBxR+CGI7eZOFaoAEkap9dV++JfQ2Nlrx9j+IYoYGkbt
         QQOQ==
X-Gm-Message-State: AOAM532LcZqnfVV/tUzRaEmiRWjzy7GPtWILYM1Iuvl5Jo7ML4rtgV/U
        5oBoz3c+2RD/y+kN4iSCz3Y=
X-Google-Smtp-Source: ABdhPJy1l38phwlhZaF3x53OuF8dT4x0AL5v/9sQfAfzSUlFQVtRna3K9X5//LvQtYvS9zef9CE2jg==
X-Received: by 2002:a92:d40d:: with SMTP id q13mr24880553ilm.45.1599582366694;
        Tue, 08 Sep 2020 09:26:06 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id v7sm10269657ilg.83.2020.09.08.09.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:26:06 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 5/5] NFSD: Encode a full READ_PLUS reply
Date:   Tue,  8 Sep 2020 12:25:59 -0400
Message-Id: <20200908162559.509113-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Reply to the client with multiple hole and data segments. I use the
result of the first vfs_llseek() call for encoding as an optimization so
we don't have to immediately repeat the call.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

---
v5: Truncate the encode to the last segment length if we're returning a
    short read
---
 fs/nfsd/nfs4xdr.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 856606263c1d..eec23a7d5ca0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4603,16 +4603,18 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read,
-			    unsigned long *maxcount, u32 *eof)
+			    unsigned long *maxcount, u32 *eof,
+			    loff_t *pos)
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
 	int starting_len = xdr->buf->len;
-	loff_t hole_pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
+	loff_t hole_pos;
 	__be32 nfserr;
 	__be32 *p, tmp;
 	__be64 tmp64;
 
+	hole_pos = pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
 	if (hole_pos > read->rd_offset)
 		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
 
@@ -4677,8 +4679,10 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
+	int last_segment = xdr->buf->len;
 	int segments = 0;
 	__be32 *p, tmp;
+	bool is_data;
 	loff_t pos;
 	u32 eof;
 
@@ -4702,29 +4706,22 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (eof)
 		goto out;
 
-	pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
-	if (pos == -ENXIO)
-		pos = i_size_read(file_inode(file));
-	else if (pos < 0)
-		pos = read->rd_offset;
+	pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
+	is_data = pos > read->rd_offset;
 
-	if (pos == read->rd_offset) {
+	while (count > 0 && !eof) {
 		maxcount = count;
-		nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof);
-		if (nfserr)
-			goto out;
-		count -= maxcount;
-		read->rd_offset += maxcount;
-		segments++;
-	}
-
-	if (count > 0 && !eof) {
-		maxcount = count;
-		nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
+		if (is_data)
+			nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
+						segments == 0 ? &pos : NULL);
+		else
+			nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
 		if (nfserr)
 			goto out;
 		count -= maxcount;
 		read->rd_offset += maxcount;
+		is_data = !is_data;
+		last_segment = xdr->buf->len;
 		segments++;
 	}
 
@@ -4736,7 +4733,10 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
 		tmp = htonl(segments);
 		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
-		nfserr = nfs_ok;
+		if (nfserr) {
+			xdr_truncate_encode(xdr, last_segment);
+			nfserr = nfs_ok;
+		}
 	}
 
 	return nfserr;
-- 
2.28.0

