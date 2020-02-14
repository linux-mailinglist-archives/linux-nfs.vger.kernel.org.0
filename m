Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77915F884
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbgBNVMf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:35 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36483 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388784AbgBNVMf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:35 -0500
Received: by mail-yw1-f67.google.com with SMTP id n184so4895872ywc.3
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQJF/Us8mBq5d5w2VX07T1bAiTh/kW0x7QYbqFKK47M=;
        b=FJPvo5WXjTC5nzcMgH3NXfFSrzphA2HH7zJ/pbOFGNyF1Vkga9GN9vaYKCGFZ4daWc
         u3R63QaE3ijs6RNYvtl6OBr31P1uGDrFjCQlcog7PFnabuuTcI9RSRp6kb5zoFgDj4e8
         JobmyUNIMRq9gb3LFUIpHWtDwtQIX3O/EOUIpPK5wdarfYlWNBQQ65A5gGLzNlC8nuqP
         8cbjE+NZmSY8lbSC0ryy32y+rZN3NuWbCY6uyTGjdCsQwqDd/uNvreO1GbY3MiT1sEAS
         Rer2AYzRy+3SErrQ6cZLfEDIsXbImuzfWdFl9V2loLNrK2x9enpJTr7A4pE6jBzP6BF0
         SMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hQJF/Us8mBq5d5w2VX07T1bAiTh/kW0x7QYbqFKK47M=;
        b=BGBkOBRDsKNiB2I/KXxAvDv/q68a2TdmEdgh1YskkiSeFsqSARf1vxLxnKfzummveD
         0ovbozRVM3Un84ywJDJ0P3O7FG2/a0AtaBIBNOUtof6TtSVZXKZ83srSUeQLH+7tjQ0C
         8xtsojJHNojckPlNZoJyrdxSfvga4HsfmeromYbiLVDXfjpbIwY4GVycwVrm3Gk/l8p+
         ml33Vm+k9U3W0WR5u2izCxMS/YfZqfZNpKlEP93nQm1laQJPcLyQUijy2gX+V5QN9l2X
         uSS334sp3wf7w4w5fGSv1d3h1ycWM610T6AMuNz5EbEgACGu3E4mgqpFTzx8ZHN5FUms
         +AYg==
X-Gm-Message-State: APjAAAWN7CanQ3Wj9xmHtetFybfbHaSYNXQaRfkzR71pMBXM+xjWjXXs
        Ybd7Sdj7GXs+R7ZR0jYcsSjlHf/f
X-Google-Smtp-Source: APXvYqy9QFsgUDNErv5C/XjB7YRkKlPrwTpLhuVOrDXXdiQROJqsKAOYHsyEn1uCiXEfmsHFC+4O5g==
X-Received: by 2002:a0d:d551:: with SMTP id x78mr4101649ywd.50.1581714754470;
        Fri, 14 Feb 2020 13:12:34 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id z2sm2840636ywb.13.2020.02.14.13.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:33 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 5/6] NFS: Add READ_PLUS hole segment decoding
Date:   Fri, 14 Feb 2020 16:12:26 -0500
Message-Id: <20200214211227.407836-6-Anna.Schumaker@Netapp.com>
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

We keep things simple for now by only decoding a single hole or data
segment returned by the server, even if they returned more to us.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index bf118ecabe2c..3407a3cf2e13 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -47,7 +47,7 @@
 #define decode_deallocate_maxsz		(op_decode_hdr_maxsz)
 #define encode_read_plus_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + 3)
-#define NFS42_READ_PLUS_SEGMENT_SIZE	(1 /* data_content4 */ + \
+#define NFS42_READ_PLUS_SEGMENT_SIZE	(2 /* data_content4 */ + \
 					 2 /* data_info4.di_offset */ + \
 					 2 /* data_info4.di_length */)
 #define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
@@ -771,6 +771,31 @@ static uint32_t decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_re
 	return count;
 }
 
+static uint32_t decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *res,
+				      uint32_t *eof)
+{
+	__be32 *p;
+	uint64_t offset, length;
+	size_t recvd;
+
+	p = xdr_inline_decode(xdr, 8 + 8);
+	if (unlikely(!p))
+		return -EIO;
+
+	p = xdr_decode_hyper(p, &offset);
+	p = xdr_decode_hyper(p, &length);
+	if (length == 0)
+		return 0;
+
+	recvd = xdr_expand_hole(xdr, 0, length);
+	if (recvd < length) {
+		*eof = 0;
+		length = recvd;
+	}
+
+	return length;
+}
+
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	__be32 *p;
@@ -798,7 +823,10 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	if (type == NFS4_CONTENT_DATA)
 		count = decode_read_plus_data(xdr, res, &eof);
 	else
-		return -EINVAL;
+		count = decode_read_plus_hole(xdr, res, &eof);
+
+	if (segments > 1)
+		eof = 0;
 
 	res->eof = eof;
 	res->count = count;
-- 
2.25.0

