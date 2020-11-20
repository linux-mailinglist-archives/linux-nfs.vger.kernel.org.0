Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC42BB794
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgKTUlx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbgKTUlx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:53 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412EBC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:53 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id k4so10179453qko.13
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CbaJr2SMaskePy11W3StPjdkc0HqfHPdNYupIafXH7c=;
        b=VPLQ+4ftLhxl9rfRF0T0KwHODEoMUU/GiIyCQtkpawpkGdh+9lE5CQn+z4x0lML/d+
         DNHdpezcwa8ta4PNuwZ5/qYxtf0FP3Z5Ze6wDiEaGWxfo2WYj4O3C4TFYFIJd2f3jANz
         fznHLeVmLibCqHTmRE6luiaSiDuheZ9wI62Un27npsLtrnGtrspLcXgobir726KfG84w
         ZQGR+J4hZRCEGCiFWqJljHpuKx/wYibiAZnk+TYImlR07PNbUjJiYtLuIYGlACfc27gF
         xr9lQFb4+wMPGowUBTNFvKUsN7UipZsGoqlp+bWOSayzPpjvvIduqNQz4ljer+Bk4H1C
         ZkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=CbaJr2SMaskePy11W3StPjdkc0HqfHPdNYupIafXH7c=;
        b=hF3ARsp7ucpVBz39iHdOM/u+zgwkbEOdiBvR7DJMkyZmcOGfkpc5otGx1s4i2eY3ix
         WMQAoANiTlGH6ITeeji3fqI4GR2kxhI6cBbyV6f30yrTujM6P88gWGabqTPkDkNtKn/O
         mvQ8t2XT97JUAXfUUJsnJDpnyUq3+224Y8FVpNPIT3FakDToN4/h+iSlZLfAyzlC5O4E
         WuQfpBj7wnfD82e55Aq2nwizAY7m5mMpg0LUac01Ms8nsnTVl6qxkLexCBlo6eCK92Xk
         5M1G5uxrd0+H7cSABqGT991H3dhAo2PWHZKP1TRnvGlpQlBKZUmhW/z/iO1d9NrhIlkD
         dmWA==
X-Gm-Message-State: AOAM532B7bl2xI/pGSz/3Vk53rD8g3OOsBwhHmCjHF6vRIRZOywQthUy
        oDsMY/BpAK2c1dRm0d4H77GGZF+yPkA=
X-Google-Smtp-Source: ABdhPJwopMFqeGSK8AzS6sNRFLrt9S5zoDlnDzx58Bdkk0hPHFru63J0i+6bxJuK/A0ZmofpvC7Bwg==
X-Received: by 2002:a05:620a:1286:: with SMTP id w6mr18348607qki.341.1605904912173;
        Fri, 20 Nov 2020 12:41:52 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z186sm2760321qke.100.2020.11.20.12.41.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:51 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKfoSk029486
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:50 GMT
Subject: [PATCH v2 091/118] NFSD: Update the LINK3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:50 -0500
Message-ID: <160590491043.1340.6516292939826969615.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index f941bd740963..b27c04c642b7 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -568,14 +568,12 @@ nfs3svc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_linkargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->ffh))
-	 || !(p = decode_fh(p, &args->tfh))
-	 || !(p = decode_filename(p, &args->tname, &args->tlen)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->ffh))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_diropargs3(xdr, &args->tfh, &args->tname, &args->tlen);
 }
 
 int


