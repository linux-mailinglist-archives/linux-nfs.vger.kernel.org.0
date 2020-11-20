Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845B12BB791
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbgKTUlh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731726AbgKTUlh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:37 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19588C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:37 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id l2so10278334qkf.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1/6sezHjNuTXOvK+ZMvEJnAvamRr/1XYRJMAF83mGrM=;
        b=rWSTZPBonbf1BalYq4R30sukDE7tTgzMQRJuh9oIegdBOQJGLh09CoG/Fe6YL3vFYo
         enFPatpO0Ft7FGZ+PDSYBNzs9LXA/IDwN7y18/aHxIW5WhwnJwwEZpl1LyfsLsv8e0XK
         hp0a2rMrgnpIlo7TJfk8CcN/OyheURQYNsuaEfgJb89AbmvJD5WpSJuXC8g40g8VsY3O
         bLXRzx9dtLfWTsh+6v15tIuZNHEYvsCNEIvPgYXN2iQnU9xuURqC8InENunLnnmbzo+9
         1KjyOHaRKfmjJBdmNK5LNJtPc5M/XFCqdqSYd5g1/665jLYYWEDd9vRGNrSQrLBpX9uu
         i+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1/6sezHjNuTXOvK+ZMvEJnAvamRr/1XYRJMAF83mGrM=;
        b=Mbq1IxhBxNASQLlNxGl8AD16Wd9feV4U+FGo8wWKALemuovWJoCl2vTFOo00mm3o2u
         FPtk/fL6pk6yxZ7eHIjCQGW/HjvxyZNVOzgHCkkhWoW6A0sFbLDZJRXhPOaf6uoaTMtV
         AB11bcRj6jDpYZ4+rPYFKpzQXov8s75Lo/EV8rcLaiFuhAo3V7F3g66NLLwp6eg471TA
         ETXlj10Xdho2ZA67pBsDnp44EZ91OArePm7HTdDh6jO9C7l/hX5CRJqth+kLUstSZcR1
         7ETqGnT6eDyZaSQUl+6el/vAypUUjObKnIzhlNyyInB5qcjjAOKVMZzZZAFGXwU5Dcp5
         P2xw==
X-Gm-Message-State: AOAM532ynafTf18SHyDHQH0dZsdx4kF7OOKwWY1Yiy/s47ZsX6BsXjvQ
        2pAIrACCMJ+EooBMsw2lols8dJqbznY=
X-Google-Smtp-Source: ABdhPJy7FpUpQF7L4zxyDRDyiJOtQsq5Dh3TAkEhICBdcKquYJ2u0/oAN30njLKqI8mW8B6Pk+VUbA==
X-Received: by 2002:a37:b985:: with SMTP id j127mr17882969qkf.282.1605904896076;
        Fri, 20 Nov 2020 12:41:36 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i9sm2691771qtp.72.2020.11.20.12.41.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:35 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKfY5L029477
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:34 GMT
Subject: [PATCH v2 088/118] NFSD: Update COMMIT3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:34 -0500
Message-ID: <160590489459.1340.11960263790467032127.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 05fa16d91564..a74c309ad429 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -594,14 +594,18 @@ nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_commitargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_commitargs *args = rqstp->rq_argp;
-	p = decode_fh(p, &args->fh);
+
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	p = xdr_inline_decode(xdr, sizeof(__be32) * 3);
 	if (!p)
-		return 0;
+		return XDR_DECODE_FAILED;
 	p = xdr_decode_hyper(p, &args->offset);
-	args->count = ntohl(*p++);
+	args->count = be32_to_cpup(p);
 
-	return xdr_argsize_check(rqstp, p);
+	return XDR_DECODE_DONE;
 }
 
 /*


