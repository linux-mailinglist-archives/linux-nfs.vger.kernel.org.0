Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D5C246E87
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbgHQRdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389111AbgHQQyE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:54:04 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ABDC061359
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:40 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b17so18284048ion.7
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3AsGc/1Xpo40vE8L6nCtW9cEOngIRVeMlkrIMYelAG0=;
        b=tTyADODwhitY6QSkseippOl+P33mGViQEjaKKMStcePMPz7jf5GaDHFm3Ws1GJhsAX
         HCmACL3w7VdqC2YOBVuXUriwPWLRnFkF6HFbqeJBKacIgl12TYSbNi3IprXCBS8TqeMm
         8BlBVHu9AFn1bqeixAeETq9DHlbp1OigEAXS45nEXgHlwLSi6HddYiceansuVHj0G1BR
         TcneAeZr3i9aUWjpXsv973ZISXDPY8bBzvBoLhVmoZpG1wqMx+Mek+dF6mFtbQAdmnUQ
         TYg/QfALludTLOnrlVkbWQ6vrraaojSanknpwNNRLnUujMTEnFcepoa31fnNKCZHJ5S0
         SNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3AsGc/1Xpo40vE8L6nCtW9cEOngIRVeMlkrIMYelAG0=;
        b=iEd0hgrxHhkMBUe0Gm3qBAZFzn0C0qJrX8ykSlbIozLVVp4+EetZLK00Rt3M0eKi/h
         K62Pz0tjJtmjFQVZRO1j1vCKENgOuxF3HVnO3vR4f2Rkk8LeQUabD1dq19XZ+YSQKQOm
         EzLR68E1vrJI93IzOUmsxi/+VeTYrRj9nIfVNk9irkvvzrUihu7cXLhbvVa2T1WKToyO
         l7htskD9UTTwlrwHAsDVsj0dI9KeHWgmGBPkulIi3xmCQeiXhL4wlDxv9ssM4SZeyyqp
         6V2gsfTIDoQhutuBMec8wFCtZIqCzwfJBpcb5YUFZ1yrlqslwDkbGzYl1vt5rfR/I0ba
         gziQ==
X-Gm-Message-State: AOAM531sFbIfgLuLm8LGVsG0NnxUiHeA1S0MzppN33RPPT5BQW6jJvj/
        MU5PgZi9TM0wFbnZvR9rdLdIvY3Hciw=
X-Google-Smtp-Source: ABdhPJxr708I75qwmNW82UJJrmhpisVBSup1kIgHot/yT3arhPoTZFPDwAJsr99COffOFXlODV1Y/Q==
X-Received: by 2002:a5d:91d4:: with SMTP id k20mr13399540ior.9.1597683219549;
        Mon, 17 Aug 2020 09:53:39 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a16sm7413106ilc.7.2020.08.17.09.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:38 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 10/10] NFS: Decode a full READ_PLUS reply
Date:   Mon, 17 Aug 2020 12:53:27 -0400
Message-Id: <20200817165327.354181-11-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
References: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
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
index 90f415944b90..ffaa7ae9304a 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -756,7 +756,7 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	count = be32_to_cpup(p);
-	recvd = xdr_read_pages(xdr, count);
+	recvd = xdr_align_data(xdr, res->count, count);
 	res->count += recvd;
 
 	if (count > recvd) {
@@ -781,7 +781,7 @@ static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	p = xdr_decode_hyper(p, &length);
-	recvd = xdr_expand_hole(xdr, 0, length);
+	recvd = xdr_expand_hole(xdr, res->count, length);
 	res->count += recvd;
 
 	if (recvd < length) {
@@ -794,7 +794,7 @@ static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *re
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	uint32_t eof, segments, type;
-	int status;
+	int status, i;
 	__be32 *p;
 
 	status = decode_op_hdr(xdr, OP_READ_PLUS);
@@ -810,22 +810,24 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
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

