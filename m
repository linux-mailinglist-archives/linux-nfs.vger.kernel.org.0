Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441272BB7A2
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgKTUnJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKTUnJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:09 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FA8C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:07 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id r7so10233336qkf.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+f0tdE9Z4Q1BQjsV9j3ElRPSPLtgiYcLW2//l5ETt+4=;
        b=nb21IT1ux4Q8W2mViCbqvRzvHF2sUQQVbNWKmEX5WOSSM3HQo5Dr+ZkpmU6dDUNJWc
         eIW14Q5SxI4dMdzNB+jgUMA1jIlwP7AH1mcqL39hzMXBkiAOwLmAwp9bvH58tw/4VsHu
         xo3A+RiLkPCOUuGsUBfJJj8c1vb+Nmz7yPpTAovA8tGtnqt+P2Eo0fNAQp8aI8WDq5rW
         76knR6XGAq3T5wrY/I+03QPVpmEzuheH45RYWIUJXuHl+NKilbm6FODP8mLUgKusIrYh
         XDuFGmVYy+GA7KIkDqyfRqY0qOIl4nqeje2UCZdLkymoBxRrKZjUM7Xwe3ZF9pvT0NsZ
         EG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+f0tdE9Z4Q1BQjsV9j3ElRPSPLtgiYcLW2//l5ETt+4=;
        b=cDtvapd6UaaDxkCOkOGPsC9U82vXnypnke07zKQSnp7uY0zjlu2LdGkHAEm1wwCHw8
         2ZUSbL4CGuD8COfkIStN4ZcE53J9Cvcd5TPev9/QJEXYxwBTvPgpLEYF3+mhamPU1i+F
         IwURf00311b5B2dSqxEU+5c7C8KIyU3kE9n+K3mFYnIOwnB1yAJP03lSRIr1h3de4Eal
         2ntMYheXj2H0ZMT21ErG5wgehtp8b5vq2/99yUbiTQhUY+9mcqxB3jqLnJMWP9tmRpuf
         Um3BFIYOqWG/LOAZH0aOw0vEsczAb4n/Z6UcA+OeOLbnNyf40Z3+dFKSsmuWCQfuTBJm
         SMeg==
X-Gm-Message-State: AOAM530NWFhaMt19AYN7D2taIxOI0Bm6PVcMQzy0frKww60e3/9jEE4E
        iAK9n7yl+pMMi1Fltg4XjVZE8icHljI=
X-Google-Smtp-Source: ABdhPJwUr3wTD+E+a1LycvxuHYguD2iyJDBbDZiM+HOnhdejnZ65XnHEpmcQLEdS/nQNfR4GZHvoLw==
X-Received: by 2002:a37:c20b:: with SMTP id i11mr18463803qkm.52.1605904986653;
        Fri, 20 Nov 2020 12:43:06 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c4sm2751729qtn.39.2020.11.20.12.43.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:06 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKh57a029529
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:05 GMT
Subject: [PATCH v2 105/118] NFSD: Update the NFSv2 LINK argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:05 -0500
Message-ID: <160590498515.1340.24844311065052603.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 94c637a0a24d..40def4a461df 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -350,14 +350,12 @@ nfssvc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_linkargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->ffh))
-	 || !(p = decode_fh(p, &args->tfh))
-	 || !(p = decode_filename(p, &args->tname, &args->tlen)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_fhandle(xdr, &args->ffh))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_diropargs(xdr, &args->tfh, &args->tname, &args->tlen);
 }
 
 int


