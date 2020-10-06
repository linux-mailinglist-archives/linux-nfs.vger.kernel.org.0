Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D044284FDA
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgJFQ3h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 12:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFQ3h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 12:29:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C3FC061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 09:29:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s4so3026814qkf.7
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wp5SKBozu7cWhnGG7XLzLGXTHYmhOkgCPiKlw5Gsgd0=;
        b=Fme5L5vicGU99MaLaqA12Ntx8q9X+izGPL/DRXRwF/1hn0xrqTDr62JiFFCEXAjwXQ
         Wak0jSwbNE2zkIfh35L+A+CK32qcdmsoB6nBMUiA5phvydvfNMz356PWDQMMBuglRMjM
         X5fLe/XXaWfAAzNg/GuH3utxHrVuyWViUPkc+K46g6qkaWmazhHT7oenxfsi+wEvg7v7
         Kdr9Tq/rHY+qb4aS8oQbQu76oXVP1NPyIbrfWGmdIi9YA0RII1syCf1f9KBaQGORr2n9
         5pkFAyj9NJGytaLOSSwAebBagHHDMQa9EQO8TSyJ7CktqV5qU1Ni9EycnOdNaO6ehzTw
         IlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wp5SKBozu7cWhnGG7XLzLGXTHYmhOkgCPiKlw5Gsgd0=;
        b=mvqqC3kLekdeKHLrwa1oPzWqSF8VnIfFISXGTzhfEzeNJjoGqOE87BCBNDfTjDHpfB
         Uk7jNvWNO3sTlPXtDPlA7+a7aIMxmEp89XQxuqB1HwBLOvv8MUF2k5xGQWd8kqg5LPFI
         AAMDEUGefLi25B+H5+KP89Pch0tcgGTqi0xkRqF+7eKDgdOxgzSX/bj3WgOhSJBUGTlU
         nU1bXbjsz4hKVjEnHjxqq/WIRtO3BaASpf9PcWO5W6sN4WDujWjwj79CSV7QJm/CyidB
         j8ovl1et1rrTzew3FcnYGAj8Y+4V2RBpP12dB8coGBkiiCsmArkc9KJwz6C7O00W8HIi
         W0Bw==
X-Gm-Message-State: AOAM531EY3i9xoNmwWwriElXXN9SZRbNNRZ0k7j4Q+O7utmHrbNVDrLV
        CeMD7b2hz9lXR6eW30h9HOaucjOLNdhnNQ==
X-Google-Smtp-Source: ABdhPJxImfZec2LSTGH+bu/0zSH+HX2kfWTQxhzWrZIl+YTwlNuWGJzk8qpSn57F/6tsIPKWp1gTtA==
X-Received: by 2002:a05:620a:13a5:: with SMTP id m5mr6423181qki.280.1602001775938;
        Tue, 06 Oct 2020 09:29:35 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q5sm2629984qtn.60.2020.10.06.09.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:29:35 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 08/10] NFS: Add READ_PLUS hole segment decoding
Date:   Tue,  6 Oct 2020 12:29:23 -0400
Message-Id: <20201006162925.1331781-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
References: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We keep things simple for now by only decoding a single hole or data
segment returned by the server, even if they returned more to us.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 930b4ca212c1..9720fedd2e57 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -53,7 +53,7 @@
 #define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
 					 1 /* rpr_eof */ + \
 					 1 /* rpr_contents count */ + \
-					 NFS42_READ_PLUS_SEGMENT_SIZE)
+					 2 * NFS42_READ_PLUS_SEGMENT_SIZE)
 #define encode_seek_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + \
 					 2 /* offset */ + \
@@ -1045,6 +1045,28 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
 	return 0;
 }
 
+static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *res,
+				 uint32_t *eof)
+{
+	uint64_t offset, length, recvd;
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, 8 + 8);
+	if (unlikely(!p))
+		return -EIO;
+
+	p = xdr_decode_hyper(p, &offset);
+	p = xdr_decode_hyper(p, &length);
+	recvd = xdr_expand_hole(xdr, 0, length);
+	res->count += recvd;
+
+	if (recvd < length) {
+		*eof = 0;
+		return 1;
+	}
+	return 0;
+}
+
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	uint32_t eof, segments, type;
@@ -1071,6 +1093,8 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	type = be32_to_cpup(p++);
 	if (type == NFS4_CONTENT_DATA)
 		status = decode_read_plus_data(xdr, res, &eof);
+	else if (type == NFS4_CONTENT_HOLE)
+		status = decode_read_plus_hole(xdr, res, &eof);
 	else
 		return -EINVAL;
 
-- 
2.28.0

