Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E702BB77A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbgKTUkG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbgKTUkG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:06 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52382C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:06 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id p12so8104141qtp.7
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dRrWDlEOWVYdurTdcmQ8VwT1YNVRDdAE+N8hCUvjolc=;
        b=QH7d0/lvSUCTb9jJPYjlJubACeOBLWzp2yFT0vwJX7EpU47vUmrwsKXiGvcgj5acXK
         V2eXneiUiDKbkf9Wz7j8yxq4OSyARiXMW6ejWcOoGtATnmYcUApPDMV7nbpUNhzd+uax
         RpDWqgX2ARG3HXzVim5rzFSiBxRHIY9/M9REW4PB/Ot7cmG2L0P2fbzUHORgedZoB9xD
         f/g2+8kGbMiG6y5wYGMUZdktDon1VbEaI45/K6IdFhEqjhI3GTg0GQawkl6BICTJczqb
         Mx5dV9sAG9YOYSFSVoOCOsQ2YZr6e6As/5TlFWMtj1Yn58sJlPj7rx6qAqn7whyDIlBj
         Y52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dRrWDlEOWVYdurTdcmQ8VwT1YNVRDdAE+N8hCUvjolc=;
        b=L2lLT4L+w84sW+rndTxwzNXXbm5dr20UGSV9OCccLcqPAfS3DcZaF4aDtiw7b7LVw9
         fpMMj3weLLtJzwR+1OXSIeP/M8NgTjwPx0Oj0wLImKAzkOC1J/ncItUkvBZaCYImmE55
         fHlzeNtDmT/s9Bd0JDexsjD5mVqlOKtr8+1dkQqld4JCcPRdRGz5wYcwc6WSFofzE8Nz
         871h8RGoMi4cztPsrrvK9z/q7B2Kg3e2KREkvAA4M9Hhy4LpBL14wpIWkpI6nc834i7m
         InaNJrLHilGHqBlmXfc7CYwJW7LWfQD/8UGqBYhrkkvJaskcqwrWNg9LJAFa6MLhs4hM
         ZDxg==
X-Gm-Message-State: AOAM532S7gessmdftlhnTP4m9ZLP5CPMwvhHvq5XqkcDrarMF6AN6x3U
        9hh62+FzaKYRuUrnEdBfDi8zK4Fa0AE=
X-Google-Smtp-Source: ABdhPJxiKqCaeY//VgAj/O8HqF9uWE/L7XX/mXKHab+1oGdxTUdqrv/0tCIiiZCoNKOfPe4qx8Rl3A==
X-Received: by 2002:a05:622a:8f:: with SMTP id o15mr17728561qtw.152.1605904805309;
        Fri, 20 Nov 2020 12:40:05 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u24sm2957718qtb.33.2020.11.20.12.40.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:04 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKe3j5029426
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:03 GMT
Subject: [PATCH v2 071/118] NFSD: Replace READ* macros in
 nfsd4_decode_fallocate()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:03 -0500
Message-ID: <160590480378.1340.2097750501358658369.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6325b71f3d7e..0509f2c00310 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1846,17 +1846,17 @@ static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &fallocate->falloc_stateid);
 	if (status)
 		return status;
+	if (xdr_stream_decode_u64(argp->xdr, &fallocate->falloc_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &fallocate->falloc_length) < 0)
+		return nfserr_bad_xdr;
 
-	READ_BUF(16);
-	p = xdr_decode_hyper(p, &fallocate->falloc_offset);
-	xdr_decode_hyper(p, &fallocate->falloc_length);
-
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


