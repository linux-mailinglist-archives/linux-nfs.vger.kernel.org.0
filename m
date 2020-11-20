Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D622BB790
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgKTUlf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgKTUld (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:33 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C2EC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:32 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so8081820qte.11
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/97E0ZXatAQCA568BieMnkqm5RVKI5EtF0AicBvoV4A=;
        b=eIe6G32hE+6zDP3lSn1mNbx7DQH6byVX1CIW3BqLnR8yVkOGi0W/BtTHnGL8YIxcgw
         n/m1DhWc24cu16oaKI2dMsBgup/CLR+guTnm1o4Qr48MawzyYoN9n1vNA/zMWOxHY2jN
         +O54qPraOgFpWEI0KHS/Kbagz/rOskRDp2uLJJTznxO66Uq6O68H48p3sljORX8hYzPn
         67weBXBQ9jn/Lny/ZGAJUr1rmyhb8thMddiXkJfc74HS/BU/EVucQ3BATHBbF/A0uVE2
         qygnNYd90YiRSAzcdPYueux3Hb5m1oxteGbc9xrqmp2CDRiaLPJDBZAFhwHtle2uZ1uA
         U31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/97E0ZXatAQCA568BieMnkqm5RVKI5EtF0AicBvoV4A=;
        b=T1nIgQlXV3OEri65m9wT6FKZ0jefIaFxeLuNzhKqD9cncu3xHdPbMm0t+V08pxZRsT
         iDKd4SokCFfg6Vx/6eCFZykkllz6sdmDQO2PksNLXIwn191hRik3Cq46i7D5nSxrCEtc
         LWzaf02a9RNw5SI0vNRe71+Naoo50h3v6XOvuZ4KLV9q/s1VgcDP0jr7M1h4Ism5wnll
         09UfWjBxYrApnexheJWLdlKmYL90wJYvmxG1olCDQCuQFlq/7329GoX7ZbJMlYBJqEA/
         OeJ5xs/rRr/OM44KhNQsxANDSByNAt3TLzJnPkIpGjrYojIECqZAWD9iLJzVgPkEeF6x
         sV6Q==
X-Gm-Message-State: AOAM530Yq0JpfZGppz1iQ82POWjsuni7lyLrvOjDRqSULL/u17m4JoFz
        zJm8+l6QI5m2UGxKM9TYVjM6SCbexc4=
X-Google-Smtp-Source: ABdhPJyA7qy7ymYOLVyvezDruhEHh1eAYiuvWZc4JWLsEFNg8ukysQmBTsWbJXelgomXG4mDvaCBSw==
X-Received: by 2002:aed:3882:: with SMTP id k2mr3352302qte.105.1605904890966;
        Fri, 20 Nov 2020 12:41:30 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 9sm2527756qty.30.2020.11.20.12.41.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:30 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKfTYj029474
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:29 GMT
Subject: [PATCH v2 087/118] NFSD: Update READDIR3args decoders to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:29 -0500
Message-ID: <160590488919.1340.2035631615670807514.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As an additional clean up, neither nfsd3_proc_readdir() nor
nfsd3_proc_readdirplus() make use of the dircount argument, so
remove it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   41 +++++++++++++++++++++++++----------------
 fs/nfsd/xdr3.h    |    1 -
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index eceeda96f576..05fa16d91564 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -553,33 +553,42 @@ nfs3svc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	p = xdr_decode_hyper(p, &args->cookie);
-	args->verf   = p; p += 2;
-	args->dircount = ~0;
-	args->count  = ntohl(*p++);
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u64(xdr, &args->cookie) < 0)
+		return XDR_DECODE_FAILED;
+	args->verf = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
+	if (!args->verf)
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
+		return XDR_DECODE_FAILED;
 
-	return xdr_argsize_check(rqstp, p);
+	return XDR_DECODE_DONE;
 }
 
 int
 nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
+	u32 dircount;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	p = xdr_decode_hyper(p, &args->cookie);
-	args->verf     = p; p += 2;
-	args->dircount = ntohl(*p++);
-	args->count    = ntohl(*p++);
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u64(xdr, &args->cookie) < 0)
+		return XDR_DECODE_FAILED;
+	args->verf = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
+	if (!args->verf)
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &dircount) < 0)
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
+		return XDR_DECODE_FAILED;
 
-	return xdr_argsize_check(rqstp, p);
+	return XDR_DECODE_DONE;
 }
 
 int
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 789a364d5e69..64af5b01c5d7 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -90,7 +90,6 @@ struct nfsd3_symlinkargs {
 struct nfsd3_readdirargs {
 	struct svc_fh		fh;
 	__u64			cookie;
-	__u32			dircount;
 	__u32			count;
 	__be32 *		verf;
 };


