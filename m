Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A8B2BB78A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbgKTUlH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731558AbgKTUlG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:06 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C92CC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:05 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id p12so8106206qtp.7
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Trk6+Qz4SdAzGD9FvX8i++7UoXmgPbDvS6GVa4q5CWY=;
        b=k2+p1g0MOBAoqmHT8m5eEbP9pWNwEaNFuqEEM/ci3YWhkuuzcqJphmh52dE0Ht2SfX
         jZ6nRMhaTCZEWCzFL5N+ZjBENAaSMHfk+7oiezFOSdC+w3EvbjDauS8YLnze5sjYuwQF
         JiKiNLmGY73slNcV/CNWRQ4Q8/rf2YbzrTmGuKtLpJGTUa3lt9CMnMjHqWIZNnTOtu8W
         G0X5tMRKGw4AaR3+9lQwCL7FTdkOHwNQKHJoN2ycX5HuD5eU+COEVoU4MXxHwF71AaQy
         oxrs5HRBMycdmLZs3TCkiHWWK3q6H7ppEA2+pF9s9Y+gT8Z5UQEr1GPD54QuUXWyetZj
         XfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Trk6+Qz4SdAzGD9FvX8i++7UoXmgPbDvS6GVa4q5CWY=;
        b=KU6UMvCM4ctQVuz0+GUw0ejlm2cKhaZhVJhepZTnEnPpbr0wc/bBuUqR3TDOEaKjPN
         3tFhQuiYcXKFSJFNngRTVm5lkRd3/wWXE2/0XsLTOpA4exfiVz9uY/tr+47kXl6oiNsR
         3BRR+0u0gW3FMvfKVi6e0rakfjVwlS02RgTyPsXqcHsAgWBUFQEeY3vsIa2+wheDLV/m
         aASlFG8TV7GLJPEqVzpGAEAoGnQOg//KdE2KVis6U2bLZ74Wn35K33OggkOc7WDLvOmv
         3FjlrKz3kgJISY8D3PMEvOxET9K9afyYcNJTr1Ji+hzM/JaERPYjWgN12ZhyyDKqPdSx
         nrmQ==
X-Gm-Message-State: AOAM532VNZqEpUxWZ7m8h6pkVxUWGS0RFLKt+8TiexlXMqDj74XH6th0
        hs4jawe5W/3veSsrEb2Lf2/LIxNEBZk=
X-Google-Smtp-Source: ABdhPJwO0sdjXGyQA0qfXFto0IzG2rLBy0Xc0SmTeKTCH05rRbHntONycoUU7hz0Xi6qGlczXrVjBw==
X-Received: by 2002:ac8:4748:: with SMTP id k8mr18489335qtp.336.1605904864192;
        Fri, 20 Nov 2020 12:41:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 72sm2626104qkn.44.2020.11.20.12.41.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:03 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKf20b029459
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:02 GMT
Subject: [PATCH v2 082/118] NFSD: Update ACCESS3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:02 -0500
Message-ID: <160590486271.1340.11805522567454121553.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   11 ++++++-----
 fs/nfsd/xdr3.h    |    2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index f1bff0547da9..600bc45db66e 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -369,14 +369,15 @@ nfs3svc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	args->access = ntohl(*p++);
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &args->access) < 0)
+		return XDR_DECODE_FAILED;
 
-	return xdr_argsize_check(rqstp, p);
+	return XDR_DECODE_DONE;
 }
 
 int
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 62ea669768cf..a4dce4baec7c 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -25,7 +25,7 @@ struct nfsd3_diropargs {
 
 struct nfsd3_accessargs {
 	struct svc_fh		fh;
-	unsigned int		access;
+	__u32			access;
 };
 
 struct nfsd3_readargs {


