Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2866223AB21
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHCRAE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgHCRAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D813C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:03 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j9so28312364ilc.11
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ec36spzdfrPyvBwQNxLIcliUAGfsOXwO4aIN5yaiCIo=;
        b=ea/KKgtGu4yKoXgcyCmuzgA7Ll10TJnguAlNHQ5Q5XpC5DYIjiR96vYucetmr/TRPt
         y9i2toNQo+ylt94v8HwgiXcKWuVfRP8/7kZlKodBQYxh+V7H1jkYcZMVvwzzTVMXHhEv
         J2dzeC9/YcZhNf11MYzHNvc4/ElhRMkPUe1+TbnVdByKVKZ/2WenFrgSmxf41NJY1p/N
         VyQOHPUycJTvNlbLyEMomEFGJ4faxzlX1fesmLPIvIxKHlLunj9wy5w/ybIvoD2OmlUp
         wEBiDekrguJwYQgKt21sradCuusQ7JR2QRDa5pRZnPXq3pwHPXHKJeTMQ2SNBTP5tSc4
         hTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ec36spzdfrPyvBwQNxLIcliUAGfsOXwO4aIN5yaiCIo=;
        b=LhrpHHvurz4QNhOw8mv16sZh7tCJClx0Gtss4/YBjqdjd5oEnSfss5oP31/j/vJD/4
         S9wU1htxr463DnB0MNvh00FuqpAbagweKKVEkfBWr8BVuGKCcQCr85dMOS4Yv/IYlKoD
         /aLaOrOVq+ZhDAM/rDpBaqG/aHiLBqJdNpp8mEQdDkAR51HmPQN8raKi5lokg2ljhFp/
         9ePQ8HJp40odIwzjOXp7MCTARO+ZB2mkToODJEUZhfBVBhuXNaOt60v4YCzciYN5nDbR
         DZPiB8/oK/CF6q7AyekJJdahoGKxW4GArCjvUFo1wOtoriIeensPuCcHDofW8eAtBlrr
         z/8A==
X-Gm-Message-State: AOAM5308j4gf7RaDTx5e0jwYRX5pP0MYGnJNyMsS8tGmZ1TEXEYywVPr
        QKRHcI8rn3w4uYuC/pLyJTo=
X-Google-Smtp-Source: ABdhPJwH92zHLg2tm6oPhV0xJcFvjnmNNkEQApTVfQvoB7HJZ2GHDk55lelFX2ZbtDorB8VDXVFuMw==
X-Received: by 2002:a92:2c10:: with SMTP id t16mr334318ile.24.1596474002982;
        Mon, 03 Aug 2020 10:00:02 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id f20sm10794639ilj.62.2020.08.03.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:02 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 6/6] NFSD: Encode a full READ_PLUS reply
Date:   Mon,  3 Aug 2020 12:59:54 -0400
Message-Id: <20200803165954.1348263-7-Anna.Schumaker@Netapp.com>
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

Reply to the client with multiple hole and data segments. I use the
result of the first vfs_llseek() call for encoding as an optimization so
we don't have to immediately repeat the call.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c01bf6241c71..8e334f6da8e4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4373,16 +4373,18 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
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
 
@@ -4451,6 +4453,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int starting_len = xdr->buf->len;
 	int segments = 0;
 	__be32 *p, tmp;
+	bool is_data;
 	loff_t pos;
 	u32 eof;
 
@@ -4474,29 +4477,21 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
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
 		segments++;
 	}
 
-- 
2.27.0

