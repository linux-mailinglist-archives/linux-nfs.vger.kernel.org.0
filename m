Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1164A26154B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbgIHQrM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgIHQ0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:26:19 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F0FC061799
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:25:25 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l4so15987823ilq.2
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McNZrU0EDFV6A3TZqivdfUIZNz6mK+EHHnD6g+nLLJ8=;
        b=jHRVG4tPsvF1IqVMGyQfVzxW8qACaqbKAd12Yx4AX8QZE/wjKLYHEggEi3xZPzTKbN
         E6/S0d+xSmgnAsjmDCypPOi+R3IyFH0foW/TexU6incpe8aHwEBRiJNrEYe0hEWLVqZv
         xoXxvqWnMNtJ4pLiqkZPYWKXkBi2S3eC82qFaF+Yc2J0GzNwMM28LNWxhLGryVjVKfev
         XKdBACG46frQZIgTDx/RujNIpPqpRLxFsLkCatumSuAfSCROC6NZe8asVRJ8JNVp/4rB
         GDuIg4uu70eg94n/ziRkR0SYYcSHIGTSpIGFy/5DJXfKKXzFh4m3LpGbOv1+pX7au0qd
         Pd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=McNZrU0EDFV6A3TZqivdfUIZNz6mK+EHHnD6g+nLLJ8=;
        b=qp4H5Q0nXoLp8LzGNAZvvucAfkrjWOOvulJjyAAJUj7F91M+H2nh86NuSXyWdjoRrn
         Q/n6awcqW+ucdLcRarbd7wAl2d2SbI/KwNoLe6qZck00afyJDYQMMozYFT01MKUgFcoJ
         x4GCHUnrhNiBGKTSXkgwPvV/F5U3YXMRhU4E7++uGneZW/B8730/6ImrOKE1A3/uTFO0
         h8UaAoq6ylAORGxjgens8bWktVEitSOQ92AoNwBtPc8pjkb5TzVXgtzLSAMgSaThVqAW
         /1WwGqDjt9X/K2yFLstYQ67/P+3Brxqd5ILQzZXZME6fopUk3ONd94cJzVG3O1lzK1gC
         eNMQ==
X-Gm-Message-State: AOAM532+fCSL0suG2IntVoZ1HAUmRnTdtYgLkzhRHcfw+x0YcZLzIIfl
        V7eVHhh31q6/oeH7XMIDkk2Ik58A4Ys=
X-Google-Smtp-Source: ABdhPJyw07jYdzBGJ819pYypA+BcTw1md400y3Gh2zgG6nRzxPW18G2pcG7Uj2IPlDsTwVzrTw3mJQ==
X-Received: by 2002:a92:dd85:: with SMTP id g5mr23754878iln.210.1599582324596;
        Tue, 08 Sep 2020 09:25:24 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 2sm10291375ilj.24.2020.09.08.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:25:23 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 10/10] NFS: Decode a full READ_PLUS reply
Date:   Tue,  8 Sep 2020 12:25:13 -0400
Message-Id: <20200908162513.508991-11-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908162513.508991-1-Anna.Schumaker@Netapp.com>
References: <20200908162513.508991-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Decode multiple hole and data segments sent by the server, placing
everything directly where they need to go in the xdr pages.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9720fedd2e57..0dc31ad2362e 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1032,7 +1032,7 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	count = be32_to_cpup(p);
-	recvd = xdr_read_pages(xdr, count);
+	recvd = xdr_align_data(xdr, res->count, count);
 	res->count += recvd;
 
 	if (count > recvd) {
@@ -1057,7 +1057,7 @@ static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	p = xdr_decode_hyper(p, &length);
-	recvd = xdr_expand_hole(xdr, 0, length);
+	recvd = xdr_expand_hole(xdr, res->count, length);
 	res->count += recvd;
 
 	if (recvd < length) {
@@ -1070,7 +1070,7 @@ static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *re
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	uint32_t eof, segments, type;
-	int status;
+	int status, i;
 	__be32 *p;
 
 	status = decode_op_hdr(xdr, OP_READ_PLUS);
@@ -1086,22 +1086,24 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	if (segments == 0)
 		goto out;
 
-	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p))
-		return -EIO;
+	for (i = 0; i < segments; i++) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
 
-	type = be32_to_cpup(p++);
-	if (type == NFS4_CONTENT_DATA)
-		status = decode_read_plus_data(xdr, res, &eof);
-	else if (type == NFS4_CONTENT_HOLE)
-		status = decode_read_plus_hole(xdr, res, &eof);
-	else
-		return -EINVAL;
+		type = be32_to_cpup(p++);
+		if (type == NFS4_CONTENT_DATA)
+			status = decode_read_plus_data(xdr, res, &eof);
+		else if (type == NFS4_CONTENT_HOLE)
+			status = decode_read_plus_hole(xdr, res, &eof);
+		else
+			return -EINVAL;
 
-	if (status)
-		return status;
-	if (segments > 1)
-		eof = 0;
+		if (status < 0)
+			return status;
+		if (status > 0)
+			break;
+	}
 
 out:
 	res->eof = eof;
-- 
2.28.0

