Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C64284FDC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 18:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJFQ3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgJFQ3k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 12:29:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67364C0613D1
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 09:29:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c23so6395004qtp.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McNZrU0EDFV6A3TZqivdfUIZNz6mK+EHHnD6g+nLLJ8=;
        b=M1Q8kcPdHu06aINxLDFqi3ieaK1kk5EiJyIU2JfQbuIi8EOhdrw7S8eufjzUr+5Lpp
         3bpVsLZi5MEHQWe4X5KDem1PX55A01B3+D3sAMV5l8XQhEE1IgSABKuCRfwHdBlPJwKV
         u/3FH2mM9Ekb6lWrrIrlUUOpEWAlYzAGofZl4Xlpz+7H90mnWEZ8FAGu/wJKth5l4Uzx
         kufhY8Ln/Aan8MAJxtjUA9ivu/v0xUjXozZ1t+HJokIp+oAm/XitDXkUAjNzuH1IZ3Wu
         xvjhQWmFQqPfiM2y4zKcV9cHkcGPdZTBiDy7g4+CEo72/n0W5Hdodn8qLpFCzlW/+fKL
         Y2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=McNZrU0EDFV6A3TZqivdfUIZNz6mK+EHHnD6g+nLLJ8=;
        b=RD7MJcWdIkiy8+zWExPpjbS7eXp1Yz1ijvDRp3dDAj76EbnKLKDGh9Y9EH7ubAwYmN
         JPBzWAh2ucBhoI15+ur/lTZkLsY5fz0M1xgSQ7M4nDeXbo+8JADSweAaW+y3DaYRqPu3
         hs0ppWGFb6noviF0K3ssqGZpE884sRfPMHYJUguiw78qOtO7GCX41K6r1SwKH1BbI95W
         VSygavpDuC3m0xIyvnMllsjzJo7X4c7BC3kKZ0N8KjnX2BJ5Lz9DsOkQMGofX+W5vRPn
         Gg4Tf5MWLQ/KpDLqxKmkWFE/JFLK2CyABHqISdr8/98py+Sr85fbvihCbkXu/z3mV+9k
         9Xrw==
X-Gm-Message-State: AOAM53213NkpuP6FBpWRKFdjfLhmc7/O6K6bxsEVdCQvWhL49n6j4VNT
        IyliUdUubwFBUpYAFL95pMQ2TvFjifPSkg==
X-Google-Smtp-Source: ABdhPJw9v6VsMKZSVFemXYiIaCJmhaXyadblqd4T1u5Angi1h2XPKjPzqccwXVmCVLKxmRcWJU7exw==
X-Received: by 2002:ac8:5491:: with SMTP id h17mr5991495qtq.47.1602001779281;
        Tue, 06 Oct 2020 09:29:39 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q5sm2629984qtn.60.2020.10.06.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:29:38 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 10/10] NFS: Decode a full READ_PLUS reply
Date:   Tue,  6 Oct 2020 12:29:25 -0400
Message-Id: <20201006162925.1331781-11-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
References: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

