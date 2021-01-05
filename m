Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381D52EAE52
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbhAEPa5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbhAEPa4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:30:56 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD0DC061796
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:41 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 7so21091394qtp.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6KD2ww9giGctRKj5g3zpnKTnSzfsLVKrA4a9YvvdysY=;
        b=AlDfu+bjxNuyqEOlWWiYcGJ0uwu8vPJiwc42kl0cuKgXKh3/8SHhp+Xh7eOHSQ+bzP
         AGheHiKeKVJq7QwfLLa32nSIA7bB5MAoYHt50r/MPTyh/RM4KN7rGUgVcqyiiBgd8ZeK
         dOM3Imj0OKI66ygKACRb2tJ6w7cFfWWlxgVnUiC4oGtr74ipsKu1KLOrTC8qGGEuiZ2q
         zLvVN9AABzt3pT5sdpwtvI90AIMaSXNMDQP6Q32Z3SsAkQCudo+QShpnCVxZ3v9UzLit
         Jq2il9ONyA1tW24TkPfcLmDJV64ujCzw2x4Q9YPcffVDI+wHM8zT0+QRhQ8ItJ6M7SxG
         H6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=6KD2ww9giGctRKj5g3zpnKTnSzfsLVKrA4a9YvvdysY=;
        b=Ero4v+l6MIu70Zcy8bJxZP5QQOKGSF4tNj1RNgMApLDkFffIxKqJ30lvUUK6DCCe9X
         6XtSm9z4XYbrWGOM6Adta9sT9F8SJq3TU504b/xKsX9kLD0DtiA6LftImvlqIhxv1O17
         CeXpABXam8NybSGLTYFnBXCW4aZkEWQ5BZr8Kq8oP7d1u9IUUg++FWBAWR5hX9ASvbz1
         /917tO0pPoXtD2NUYQTrAvrOlIgnqIjj7/vL0XyeRP5WqBvdzOvg0fas+GiNh8s0IWnE
         Bicf2j7pYZEMm1uPPorDEdIOjCJmxDMqafZ1jvT7Igxe84pB6TFw4KPiH0Fib02/iVjT
         xE+g==
X-Gm-Message-State: AOAM5315XFuWuD7jWmj9GNGrjJMHz9Ij33uqII+dbhHiGFesclOTmf2p
        O8OBD1+puYeuqn4QY4T/i0KTwgPgxRs=
X-Google-Smtp-Source: ABdhPJzD27JwH74RG4QyMARtqSyHC4BVKGiS6XC8enEPWSQeGLSILN2VVhIKjLwlE01Ah3Wa4EJi+Q==
X-Received: by 2002:ac8:47da:: with SMTP id d26mr85634qtr.4.1609860640658;
        Tue, 05 Jan 2021 07:30:40 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c2sm129980qke.109.2021.01.05.07.30.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:39 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUdE6020853
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:39 GMT
Subject: [PATCH v1 11/42] NFSD: Update READDIR3args decoders to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:39 -0500
Message-ID: <160986063900.5532.12435650481339734359.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As an additional clean up, neither nfsd3_proc_readdir() nor
nfsd3_proc_readdirplus() make use of the dircount argument, so
remove it from struct nfsd3_readdirargs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   38 ++++++++++++++++++++++++--------------
 fs/nfsd/xdr3.h    |    1 -
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index b601f0c6156f..6167955475e7 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -559,33 +559,43 @@ nfs3svc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u64(xdr, &args->cookie) < 0)
+		return 0;
+	args->verf = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
+	if (!args->verf)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
 		return 0;
-	p = xdr_decode_hyper(p, &args->cookie);
-	args->verf   = p; p += 2;
-	args->dircount = ~0;
-	args->count  = ntohl(*p++);
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 int
 nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
+	u32 dircount;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u64(xdr, &args->cookie) < 0)
+		return 0;
+	args->verf = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
+	if (!args->verf)
+		return 0;
+	/* dircount is ignored */
+	if (xdr_stream_decode_u32(xdr, &dircount) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
 		return 0;
-	p = xdr_decode_hyper(p, &args->cookie);
-	args->verf     = p; p += 2;
-	args->dircount = ntohl(*p++);
-	args->count    = ntohl(*p++);
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
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


