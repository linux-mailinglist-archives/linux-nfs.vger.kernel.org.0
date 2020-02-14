Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE8215F885
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbgBNVMg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:36 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33096 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388784AbgBNVMg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:36 -0500
Received: by mail-yw1-f68.google.com with SMTP id 192so4902472ywy.0
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xNABLh/UHDM1w9keGJuUb3+6797t6mQJFRB2SGiWj8=;
        b=cEdO7hpHnuC84UCRYH6QYzQfPsb6YBARXeYZLpTuXSIdfeJKYSIl94PvlBmJgzgTol
         PIiV5yvVjPkdqpVVzBdFJ6iPIOtY4i7Cd+IAyufh3zLCOFm1yGZcCGM6Hpm2T7uUpeuo
         hBbgiewHoqSN/kawqdsXPOFoOqVa+saKnUNjMpvDz1ZRXQwFUukoumoUT+8IBbednqoc
         nwcKGbayLAeEr+JPlgvbyylTK3our/wlkiZFQL4o41QO4YKYhnHqP/W0NgpTvkgVgBtU
         UYtU+Ruwu2BoKH18w2x+e0/cSIlhY1Q3VPEj3ipRxyHDZ+t8OQl3JOcZSiKqTpXjvvcu
         LD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0xNABLh/UHDM1w9keGJuUb3+6797t6mQJFRB2SGiWj8=;
        b=DHY/qrWazNwFClYrsS4Rh5Yyivxj0fVXOoX7zE/ib/f7kXsmgorsWiaXvsg1/orU9j
         FshlWNHcILs/BWyTBQwL0TmU0FZnzh8F1FVjNgu2RW6jPLx1TG9JUGme9f+FEA6N55OE
         rUIYMa4URJnXFBPfZBQC7htNraw5uZkPwLO8P7ozTbnZC3YYhuavvwJdlTx157j61cnl
         JlWtn+MHnAjFd4VXvsr+nbRrfsoqlzHFBxUfGKezuctfkbmaK76qPDB65RH9CuK9ZBWp
         0d01VhMtMvOfF/c4Wb+jYU5tThv2v8oL0Y60DFHzRh0lnvORfDW02k+yMT8Xyu/7DTcW
         fRZg==
X-Gm-Message-State: APjAAAXmzmPvZSuQ4r1w58hlb9XIo7fKhy8F0UwUmXm3U5h+zAsxbL6Z
        5Nqvy2XU7B2VGXgB2e1rUr+f4iY+
X-Google-Smtp-Source: APXvYqzMvIc8IAYZCh2OavvvWpwjJ3WmxetYceZQz8IqudKL7qTGPP3QZzB0yo4JFY+Rq+zzGHWLrA==
X-Received: by 2002:a81:6e09:: with SMTP id j9mr3819871ywc.25.1581714755527;
        Fri, 14 Feb 2020 13:12:35 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id z2sm2840636ywb.13.2020.02.14.13.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:34 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 6/6] NFS: Decode multiple READ_PLUS segments
Date:   Fri, 14 Feb 2020 16:12:27 -0500
Message-Id: <20200214211227.407836-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
References: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We now have everything we need to read holes and shift data to where
it's supposed to be. I switch over to using xdr_align_data() to put data
segments in the proper place.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 3407a3cf2e13..b5c638bcab66 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -53,7 +53,7 @@
 #define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
 					 1 /* rpr_eof */ + \
 					 1 /* rpr_contents count */ + \
-					 NFS42_READ_PLUS_SEGMENT_SIZE)
+					 (2 * NFS42_READ_PLUS_SEGMENT_SIZE))
 #define encode_seek_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + \
 					 2 /* offset */ + \
@@ -745,7 +745,7 @@ static int decode_deallocate(struct xdr_stream *xdr, struct nfs42_falloc_res *re
 }
 
 static uint32_t decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *res,
-				      uint32_t *eof)
+				      uint32_t *eof, uint64_t total)
 {
 	__be32 *p;
 	uint32_t count, recvd;
@@ -760,7 +760,7 @@ static uint32_t decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_re
 	if (count == 0)
 		return 0;
 
-	recvd = xdr_read_pages(xdr, count);
+	recvd = xdr_align_data(xdr, total, count);
 	if (count > recvd) {
 		dprintk("NFS: server cheating in read reply: "
 				"count %u > recvd %u\n", count, recvd);
@@ -772,7 +772,7 @@ static uint32_t decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_re
 }
 
 static uint32_t decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *res,
-				      uint32_t *eof)
+				     uint32_t *eof, uint64_t total)
 {
 	__be32 *p;
 	uint64_t offset, length;
@@ -787,7 +787,7 @@ static uint32_t decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_re
 	if (length == 0)
 		return 0;
 
-	recvd = xdr_expand_hole(xdr, 0, length);
+	recvd = xdr_expand_hole(xdr, total, length);
 	if (recvd < length) {
 		*eof = 0;
 		length = recvd;
@@ -799,8 +799,9 @@ static uint32_t decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_re
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	__be32 *p;
-	uint32_t count, eof, segments, type;
-	int status;
+	uint32_t eof, segments, type, total;
+	int32_t count;
+	int status, i;
 
 	status = decode_op_hdr(xdr, OP_READ_PLUS);
 	if (status)
@@ -810,26 +811,28 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	if (unlikely(!p))
 		return -EIO;
 
+	total = 0;
 	eof = be32_to_cpup(p++);
 	segments = be32_to_cpup(p++);
-	if (segments == 0)
-		return 0;
 
-	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p))
-		return -EIO;
+	for (i = 0; i < segments; i++) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
 
-	type = be32_to_cpup(p++);
-	if (type == NFS4_CONTENT_DATA)
-		count = decode_read_plus_data(xdr, res, &eof);
-	else
-		count = decode_read_plus_hole(xdr, res, &eof);
+		type = be32_to_cpup(p);
+		if (type == NFS4_CONTENT_DATA)
+			count = decode_read_plus_data(xdr, res, &eof, total);
+		else
+			count = decode_read_plus_hole(xdr, res, &eof, total);
 
-	if (segments > 1)
-		eof = 0;
+		if (count < 0)
+			return count;
+		total += count;
+	}
 
 	res->eof = eof;
-	res->count = count;
+	res->count = total;
 	return 0;
 }
 
-- 
2.25.0

