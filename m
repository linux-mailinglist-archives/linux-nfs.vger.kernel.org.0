Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38A2BB76E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgKTUj3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730886AbgKTUj3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:29 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B209C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:29 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z24so6102461qto.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XXP39M2qf0dfgfcT6WEIO6FnUSsetZgutTLO/TUaYwc=;
        b=nSoOECqpBIw1JyLjSo5J2Au4NjVVaOFqPyowLgpdX6HthEw+mzwh2ReIQU1px56tlk
         dlt/pLnu8ir2fjfNiA1gCfugH5vnNmz5MOM0+tAxkqEN4dzPk4zsUsOClhprlvlNrF5G
         0K4dbJM/s87+tTfhPGukKsJGDQvb+JadHhlObTY27DXxTAAn8KCW62GcUDh0siGjHK9P
         MWfC8rn9Rfmhb/fF+a+dT/kUo0eZncscV9vPFwOY7CXDReWjxu3j5TO2JdCB9Yb/b4+F
         faevD1QFMFaAa9MFelkxLAeHLahQp7FxJg1F8xvCRWVZw8ZAS8J7OBoGEHnh/H6q0Tm6
         YYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=XXP39M2qf0dfgfcT6WEIO6FnUSsetZgutTLO/TUaYwc=;
        b=ccmPumHLB0Br81zOPz0IiCbwAD8Vre5Oz0WEAmzDzAWF4wYE8BMwtH72r6oX71HkWU
         ZAdY1CDoeo4AnRnAmq35DhiQFCVEXyPuWyuK2BI0/DlyeZtl/YxnGeVea8wnmT2uW7BZ
         nWdn2BIAi5vQuec3epaRzvM8EXrrPciHKdxjALMT0Vj5IQRaKv9YV5LdbFmfC8wukwpO
         zGc1eyCit/l3dGzoIJ5nmWyiiL/TdMl1sfMYPgmzsO8K1+njoBgpEf3rfgyU6RBc4s4X
         BicgDiLyWB7WLnKRKPd0wMrRGqWjeGGYrgtsqG+ppmGhB6ZJxinff4YLqPmO2QZWuttG
         hwZA==
X-Gm-Message-State: AOAM530txGabBNfJ/MCNZ1Odqaq35RyIeR20QbLbfEXvDI/GPSe9aX0t
        9G6Tg9JJ4GL7sqsW3WVHc0ydcZodSQ0=
X-Google-Smtp-Source: ABdhPJzGsnXXoD/xRwVOc1mgC0YX5sSQp+TJoh+zWTT/x+gwtuShic10eMWG4Hpm5noBZ2pw6Qxlag==
X-Received: by 2002:ac8:4e14:: with SMTP id c20mr18519334qtw.5.1605904768148;
        Fri, 20 Nov 2020 12:39:28 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c1sm2786257qkd.74.2020.11.20.12.39.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:27 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdQQ2029395
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:26 GMT
Subject: [PATCH v2 064/118] NFSD: Replace READ* macros in
 nfsd4_decode_layoutget()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:26 -0500
Message-ID: <160590476644.1340.18380578618262852515.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2c75e5d3b2f2..8add9b5242f1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1784,24 +1784,27 @@ static __be32
 nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutget *lgp)
 {
-	DECODE_HEAD;
-
-	READ_BUF(36);
-	lgp->lg_signal = be32_to_cpup(p++);
-	lgp->lg_layout_type = be32_to_cpup(p++);
-	lgp->lg_seg.iomode = be32_to_cpup(p++);
-	p = xdr_decode_hyper(p, &lgp->lg_seg.offset);
-	p = xdr_decode_hyper(p, &lgp->lg_seg.length);
-	p = xdr_decode_hyper(p, &lgp->lg_minlength);
+	__be32 status;
 
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_signal) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_layout_type) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_seg.iomode) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lgp->lg_seg.offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lgp->lg_seg.length) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lgp->lg_minlength) < 0)
+		return nfserr_bad_xdr;
 	status = nfsd4_decode_stateid4(argp, &lgp->lg_sid);
 	if (status)
 		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_maxcount) < 0)
+		return nfserr_bad_xdr;
 
-	READ_BUF(4);
-	lgp->lg_maxcount = be32_to_cpup(p++);
-
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


