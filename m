Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0579127B2BB
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI1RJM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1RJL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD48C061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s131so1660626qke.0
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IW2ZMhPd1UFeHJdeoJ5W21HZVFAiNbyQBzHJ+bvLFA=;
        b=ga4aF5+AkBCsQ0dBITu8jmJL06404dg6PxnHMb1+NO6GsiZ0AqQ7M6bLpPPMYt0ZjZ
         mE8wn1JLgRkCTC3FVHt9pReijm09Y0B8ZFVpnwEozL+UWcin+pyJY/QPuoPOVuMUVjLy
         wXbvx+ARBGusZsUhDIM4HAvllHj5Ugi6gnvR8yKC9MbSKyOT3jyAJdP6drkF0F0f6yPt
         mk2iNE6O9NtO7Xvb5DSjVS4YI2T7R7zrVRy1xCxKBWGzNF1nz+8F7oouIlq0b4d9nyok
         uAzapjUIqt5UDQO/L3l70KU7iNJI8EdhZrdHCQNXC38sEVmJohMvfGGZPCVf/ZmDySVI
         lfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0IW2ZMhPd1UFeHJdeoJ5W21HZVFAiNbyQBzHJ+bvLFA=;
        b=B8evZW2kIOQFOt73I3P6/7G8NGdyDhex6DVanBQoHyBz3Pp8rzCrEtIboKKawz76WZ
         kU4mNDAuYGyfxf3GAiyu8GoqJEiZHWQhv8HboRIYPzJFbYU0EqlBVG3d8ka0CDloS0He
         OQpdjqKbJbnpjsHzLtv+eAdJRCnx4H4xYH/gmsVU0FYQBHRLPcdfREH4ffaPenko80k6
         vCt1GBrPvh8f23Cd1Bkrx9Vtq6/B/oLL/xKKtIDtdaBDxAVwB5mCP8K3VA0WLoqNXtmD
         YQiohtBzZYxsJHLNYmcft5JYrHzeZaChAjGE05xymQR0TUmCEGcLTsrRf/gokf7Xr/M4
         +vSg==
X-Gm-Message-State: AOAM533MIiZU4EvNEIB3sku95otCJLmUnmZ3taQELNmpMlvty4zbYqC+
        0h91whcZuHRXZRGr1UcZP4U=
X-Google-Smtp-Source: ABdhPJzzteH8NwmOu2oKcvS2yscJYbId9j87it/+EazZcaEepE+C2qdVU2YpWncKoJTJyNqmQRd06w==
X-Received: by 2002:a05:620a:4e7:: with SMTP id b7mr405835qkh.415.1601312949438;
        Mon, 28 Sep 2020 10:09:09 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k20sm2011631qtb.34.2020.09.28.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:08 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 5/5] NFSD: Encode a full READ_PLUS reply
Date:   Mon, 28 Sep 2020 13:09:01 -0400
Message-Id: <20200928170901.707554-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
References: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Reply to the client with multiple hole and data segments. I use the
result of the first vfs_llseek() call for encoding as an optimization so
we don't have to immediately repeat the call. This also lets us encode
any remaining reply as data if we get an unexpected result while trying
to calculate a hole.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

---
v6: Bail out of unexpected hole values by encoding the remaining reply
    as data
v5: Truncate the encode to the last segment length if we're returning a
    short read
---
 fs/nfsd/nfs4xdr.c | 49 ++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7ed9181a69d4..dfbde8fb08f9 100644
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
 	*maxcount = min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->buf->len));
@@ -4647,13 +4649,14 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 {
 	struct file *file = read->rd_nf->nf_file;
 	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	loff_t f_size = i_size_read(file_inode(file));
 	unsigned long count;
 	__be32 *p;
 
 	if (data_pos == -ENXIO)
-		data_pos = i_size_read(file_inode(file));
-	else if (data_pos <= read->rd_offset)
-		return nfserr_resource;
+		data_pos = f_size;
+	else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
+		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
 	count = data_pos - read->rd_offset;
 
 	/* Content type, offset, byte count */
@@ -4665,7 +4668,7 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 	 p   = xdr_encode_hyper(p, read->rd_offset);
 	 p   = xdr_encode_hyper(p, count);
 
-	*eof = (read->rd_offset + count) >= i_size_read(file_inode(file));
+	*eof = (read->rd_offset + count) >= f_size;
 	*maxcount = min_t(unsigned long, count, *maxcount);
 	return nfs_ok;
 }
@@ -4678,8 +4681,10 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
+	int last_segment = xdr->buf->len;
 	int segments = 0;
 	__be32 *p, tmp;
+	bool is_data;
 	loff_t pos;
 	u32 eof;
 
@@ -4703,29 +4708,22 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
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
 
@@ -4737,7 +4735,10 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
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

