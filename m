Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4912E1379C3
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgAJWfH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:07 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38896 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgAJWfG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:06 -0500
Received: by mail-yb1-f194.google.com with SMTP id c13so1374033ybq.5
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxZxDJC1OGNPkdu6FTqfNdzC3MlEzliAiWbAbPd4MXM=;
        b=VgWzjS5KULN0A+3KyOgbU1q/PLC51PO4DKwwQIX8v8IoatwtoJeNaiD0ntCUF+Lj1d
         zdaTZWE8KHsMYeZCwIsooFM+4/CephsnQeKDABU7jGPa8i4pNhrnfOaQsjQla4PhpJQz
         ckLblEo9gm1x8rkPJbjWtH3xofZTx5FhcIGFPS9LeILZmxr72CEj4TFd8ZR93C6fdity
         7W1MiscreUz0ohkCeJioPCf4Uf5LIjyMPzDuKNeFNDBuk8UbtYn5wxPkvktzsOsuHDBN
         ppuKQ6OSwuK68UiiX/1E6bLA0Ghzf2qNoY+xHM9a2U/p7RP3jR1m8dJRC3IWPCiNO+aG
         Cu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XxZxDJC1OGNPkdu6FTqfNdzC3MlEzliAiWbAbPd4MXM=;
        b=KEMQ6+/NCvdAY7bETL77eAWI0MWwJRT7juz2RUnjetiUd7tS+nO7Z2F9gP6fGq/f0O
         ieBmFk2tBh/sELBcbDhk0F9JPn7MjUtEoyL2mJR1oxqdWONLG2VZgGSLahNM7gJIRf8v
         e9NtpO70svAwEQnUtaYFWRrJVlfOUcLTkejQRG2LsJ4mnKJAhJENnaLUsJG887VdnyPp
         MMtgGS9TwjVBCCtOVADa3gxhzrP0DWzN0TpLWbbpKy0bJ68Xf8MxkXV85yQ3PH/U0rBd
         fBIHHQYSXzpNVpQpp5fxj24uJXtlY9NZAHhf8N/ODNCfFL2OObL3QmCRXfN4rnk3gNmg
         PqEQ==
X-Gm-Message-State: APjAAAXt3cfPslilhHxhIFZZ8doquHP5GHJfBzMRPIPLYZ6+DNynmFYr
        EloXC1k6yNLXKh2K6nwM0oU=
X-Google-Smtp-Source: APXvYqxlwCXWyjj5tqumtCIL+ajfYqastA8LfFP767LQrHojK9u8LUnMf9/xImqEOIgtKqtDMbdlgw==
X-Received: by 2002:a25:50c6:: with SMTP id e189mr4572624ybb.472.1578695705880;
        Fri, 10 Jan 2020 14:35:05 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id e186sm1554060ywb.73.2020.01.10.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:35:05 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 6/7] NFS: Decode multiple READ_PLUS segments
Date:   Fri, 10 Jan 2020 17:34:54 -0500
Message-Id: <20200110223455.528471-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
References: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
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
2.24.1

