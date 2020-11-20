Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1252BB7A8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgKTUnS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgKTUnS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:18 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21558C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:18 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z24so6110825qto.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7msy/n0JKvli6W7JM3p6GkoxmcF+GlMP4FBJdOeBya8=;
        b=ThGSQdMoLVXWyJK/zLW8bqAbqXrz73BoylktVL0cVkD1bB8LH9cm0xTcmalYeU1+ih
         BsiBzwO0kVCEdnbyfu/HrySTp6EBAfXldFbeQuHsUYUYNSOh+o45950wey89kJtuto74
         9zwK8XpcYgGDk+G4COUPdOuIKCQwMgYPWi4oEDWjcIon1g1yoYlQxd1vt7cIQht1Am/0
         Wve5g9oRdoHY16xlF+jKVp/n7J75aPYWw1kimgtX5fcwkp0+qEGTlG6YRRMPOIwmdl2q
         37/qOCszDzJbpg9gWjG0LKo1+2FXP1dOh+nJmLcnRGfhgyMdyNTRbCpeqzUhpcnGMXt2
         LwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7msy/n0JKvli6W7JM3p6GkoxmcF+GlMP4FBJdOeBya8=;
        b=dskuDMpjRsGfVUBGGwx2qvqQF6L0ujUTTs1HDlP8pwnnqMxW8KtuQYp42i8HFsbI/H
         if+ouPT2sRPW4SPj/SIU8ONpc/UL35HLrOiAtIXNmBFSQafdSu1CxoAaKHYakbAErOr5
         OJRRuJidgvyAQtm+5LBB8jV294C32xn0uU951eQo8/BvEHVPuLk5g4zV27brOBMV5anh
         6MfSiRX3elUNtqyuZ4qvbFyjoqWGKnpcEwEnvjcm75/1KmLEuuR6p4RAgRclWh8bf8Qy
         5D0QbMtPjqntyxXjO8qMe/67etnWQqWZ6+zLdAWle4RZTLYXJxTPQ+mqAiiwRYMlX+HG
         H6/w==
X-Gm-Message-State: AOAM530UJhy+7v2m2/0Dy7lxNQGoSaGY2bz0E1dssSoBMkwuPXsGZaSC
        3X5biQy70Fz52GQJQRkXFMruuLq9CKc=
X-Google-Smtp-Source: ABdhPJxeIBbmEA53f/Xqxcy2N3syHNTq0GGz4Mrjaa9+JEzvMhJCun1bCctQbz2yStU0UsRRrm4OUg==
X-Received: by 2002:ac8:4a01:: with SMTP id x1mr17441990qtq.276.1605904997070;
        Fri, 20 Nov 2020 12:43:17 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v14sm2852189qkb.15.2020.11.20.12.43.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:16 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhFQe029535
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:15 GMT
Subject: [PATCH v2 107/118] NFSD: Update the NFSv2 CREATE argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:15 -0500
Message-ID: <160590499559.1340.7433767896526228380.stgit@klimt.1015granger.net>
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
index c34446c650ca..f02fef8a805e 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -397,14 +397,12 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_createargs *args = rqstp->rq_argp;
 
-	if (   !(p = decode_fh(p, &args->fh))
-	    || !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-	p = decode_sattr(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_diropargs(xdr, &args->fh, &args->name, &args->len))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
 int


