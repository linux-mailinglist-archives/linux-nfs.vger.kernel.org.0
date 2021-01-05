Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B754F2EAE84
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbhAEPdT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbhAEPdS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:18 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB537C06179A
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:33:03 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id v126so26719051qkd.11
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KK5pH2d4/hYCVjeFLoyzSReEdz7WVJMLxtkHihiCNeY=;
        b=dHqbEkaksRDyrnk1LOw8cQHNpD8eR/LKM7frsi/5XlJ2VDyFtrVgaJlnEhQMq/cMRY
         fUr8kml1ehp0BWqpRFCue5GcW6651QBvkP8cmQiHZxiO40ixzH/2fv+S5sDiG30xw1u/
         l6boQncYE/uJcE3M6/OGAR+xrG5S8i568TenGerxI9XYQ6RNZytVee4HSrXCRHtxAMmM
         Fa5TfwVRhs+KvVpGFtFTLfk6RP3lh5IY1k78TVZ514T8AVc2L3WAeLkEKR2c+gcFuoKP
         q0m6qPYVGHDzuxiWga+ZM5uZ2+XIHScLChe6ur1qKuydlKMhdZDR+2To5XRAjLgjcWuA
         m5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KK5pH2d4/hYCVjeFLoyzSReEdz7WVJMLxtkHihiCNeY=;
        b=KWvquvFjKUju/Qwf7ApKtCQ8nToE6/1/zeHtwkG4hvryDn6RN4+RCJI8oWS5x4oOjh
         FqT13uunTo2CboHjc7WEm4jFbaE59rjY9+xPlucmtMjeOlBGF8E17TROf4GxeED93O/H
         SURijrxHJN/9xL1vjh7NZrzBjXJ481Hir/GLokvCv7It+lPwYUo653QQunISkKpV9fXa
         m6xLTeCbOUqRTDq+qGC9s7WWRjcfU01o320Cr0Ge0PYjO5izsganNfEL+R0jP00efBbA
         Toc3uHP6v0X6FTyI8kRUb81NbJb1fYlz7xbcE/pthO4dZX3NJmF8k3qbiOW39luy9Sn2
         mBQw==
X-Gm-Message-State: AOAM533A2Ic4XoNWLCj+L9YfYxo060NJrmwZFf4rHXALntC3Tp6Fd9FX
        Bi1KJDz6qLB8jvXR4YaXdLTMICis45g=
X-Google-Smtp-Source: ABdhPJz06VrfWmqm2TnQ0IAAlBSuLajal6JH40VbV2ST/mkdVP/x76oRJ53qIW7KvS1M+N0GvBvkfw==
X-Received: by 2002:a37:9d14:: with SMTP id g20mr76612qke.260.1609860782707;
        Tue, 05 Jan 2021 07:33:02 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n62sm131565qkn.125.2021.01.05.07.33.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:33:02 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FX0WC020934
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:33:00 GMT
Subject: [PATCH v1 38/42] NFSD: Update the NFSv2 ACL ACCESS argument decoder
 to use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:33:00 -0500
Message-ID: <160986078097.5532.12225653251775677522.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 0274348f6679..7eeac5b81c20 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -222,14 +222,15 @@ static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 
 static int nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nfsd3_accessargs *argp = rqstp->rq_argp;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
-	p = nfs2svc_decode_fh(p, &argp->fh);
-	if (!p)
+	if (!svcxdr_decode_fhandle(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->access) < 0)
 		return 0;
-	argp->access = ntohl(*p++);
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 /*


