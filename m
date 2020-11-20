Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC252BB79F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbgKTUmw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbgKTUmw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:52 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF9BC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:51 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d9so10205198qke.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YPhtyK2Sr8bdn8/jf70GHGqh2pF8GuLPrHSBtyujEwE=;
        b=RlEv/CpYsdi/aDROEsDfm1SymxewQt1CxX9WeG9WoG9W3ocX0+dLnpXZFxO7xT96n4
         AVnwG0VK1D+8K/V+Xn+HDeOpHcqeYPbpkqOV0lHnjCVM/p5ixIesSi6Oy4WeHozPHe+y
         KSy825AGAqxpTk0Gblkwi1rgFK5pgfcKx1K5Xu+pswD4GgvGQKofJbsyT2qcGaEr8aV+
         0kR5RizVduf6HiB9arOtYNWx17VGA8Ba5QxHGqL8zxojxp0GaO81zzLAvCo7ulg2hkSt
         6QIgA01v1mjNWsBjuL0YnKz8Q12P9dBAV7Ev5WRM0cq3VGaVoHnvSsayzXiqTsdO4f+c
         Tw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YPhtyK2Sr8bdn8/jf70GHGqh2pF8GuLPrHSBtyujEwE=;
        b=gx/Ip7lo53rdiD34wCa4w3p5R4vCdQsnv7nll28rExOsEKBNqS7JFdnNKKJpzbzwrZ
         KBNeYSc7OrYgnEkG9fKIOMI5saOY7z+YZuMto6xshzGb/YQ+iC96lnO42r3k9qZ/uudN
         tOau8Td/XaP+pKd0997A7GLIVcuzBxAhBnK++lqvA78gd1ynKk6PXzzENQp5qXFvY3vx
         MGZA6Vt3TDxiZ5pDJe9q5tvWNgs92vvdvY0Vq02TiBM0DZokmjm+cgS1So0DTnHy/g/y
         1S5HRFii7OY2nEW7g/X7EobZZBgjnUMmN6FJ2MEyNjpKoMPsJSybdgtnL2Ei1zBr+PUR
         6QUA==
X-Gm-Message-State: AOAM530XHl+tQ2nZRZRxw/ZYBi11Lr6hhipApQpwH3paYNq9JVBs+4SQ
        fQlYmQb8fUuE55OUXAWVAjoy3YUKx4w=
X-Google-Smtp-Source: ABdhPJyBaqDdsXOXbz2O6d49pwz/8u5q5z9GczCTqbuUVHOGPcoDYRtVG/vNIRqzOldakVMtyL1wFQ==
X-Received: by 2002:a37:6195:: with SMTP id v143mr17231766qkb.71.1605904970801;
        Fri, 20 Nov 2020 12:42:50 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 82sm2861857qke.76.2020.11.20.12.42.49
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:50 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgnxW029520
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:49 GMT
Subject: [PATCH v2 102/118] NFSD: Update the NFSv2 READDIR argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:49 -0500
Message-ID: <160590496908.1340.11226739774715535342.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As an additional clean up, move code not related to XDR decoding
into readdir's .pc_func call out.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 2664101aa1dc..6f4115303f58 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -375,15 +375,18 @@ nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_readdirargs *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
+	if (!svcxdr_decode_fhandle(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	p = xdr_inline_decode(xdr, sizeof(__be32) * 2);
 	if (!p)
-		return 0;
-	args->cookie = ntohl(*p++);
-	args->count  = ntohl(*p++);
+		return XDR_DECODE_FAILED;
+	args->cookie = be32_to_cpup(p++);
+	args->count = be32_to_cpup(p);
 
-	return xdr_argsize_check(rqstp, p);
+	return XDR_DECODE_DONE;
 }
 
 /*


