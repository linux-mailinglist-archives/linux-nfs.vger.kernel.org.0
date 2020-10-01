Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFF280AA2
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgJAW7i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW7i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1798C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w12so7816777qki.6
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BMs6lGGz6Qa/Nmg9COxYXh3YKKmZEDCNX5IAIj+Hzow=;
        b=CbtQYriGhinOs5SOnaHpYU6kFIz5ZtXlzxzIdhoRhdMiE2m2uBEnOqjzjGUkEi1cfs
         kFLoaVQfwZA5tqVmJeNUBr6As3eaT3/uzBMDz3iMwB8MAn166Q+TNqIMEjJCpMbvjznJ
         7AAGK8/SQtYQ7IEv2Mq+KgfB1abSz4bJL2941/0RDAsjvevDcm0Se39lRNokq1hrdynl
         UWGFYqSgd1C+Vb4fjhOMcvowKhx1c3ujHxQY+5Hk9YxlGoJ+uvNq7aN5zQwfQEdU8U5H
         EfCGZaT/lch8bExy2nzHs8fxemrEAzRxHZObktxZWRjzspDwjunPXApIPpDPn/xS3tuy
         Vcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BMs6lGGz6Qa/Nmg9COxYXh3YKKmZEDCNX5IAIj+Hzow=;
        b=culX2lpVTrNuXW87B6mymFvpyOG45CAEet9i4zsmxKbF6W7weldAkdV4jfjrsF3wbp
         WhivvKgMlfsPnjOvPN+G36hb/8oh57IjWWtPPstzMs538DA/YyoNFiBvPXlgTnLdzif3
         D96yvH2FbgrFmKSYyiSeLnRyiym7KUKMJ7Y4RWPfH2mjm2brpyqrb6OaxvXx1vyc3U4a
         3uSXmIKt/e2hekMbXr4YRBWpi1lBPdRECh+MeVf13WWeQXULxRa6Cd5X+ZR9yBf0rQcs
         hlGYyE5Rqi1vM9MLuKLyEavuahM1N08ECjRuqorVzI3nYGIyrnGu3BcHGWIo0s+OSKhM
         lhbQ==
X-Gm-Message-State: AOAM532Zy7DDaLp6g7yH84gZ8PxiQVKFIzroHXcyfTC3lcyRbemQwbqT
        3lk1VH6LefvNWjQasOdfxLiFmYXzDH1oUA==
X-Google-Smtp-Source: ABdhPJydUEUCFTiY2ylVko6JIdNGbe/511ihFVB0xLwS8E0HduwzOWGfE2vr7MXKy3WPruSHAS7U7g==
X-Received: by 2002:a05:620a:897:: with SMTP id b23mr10105257qka.501.1601593175463;
        Thu, 01 Oct 2020 15:59:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g5sm7769504qtx.43.2020.10.01.15.59.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:34 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MxXHX032589;
        Thu, 1 Oct 2020 22:59:33 GMT
Subject: [PATCH v3 09/15] NFSD: Refactor nfsd_dispatch() error paths
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:33 -0400
Message-ID: <160159317362.79253.5265104530854634684.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_dispatch() is a hot path. Ensure the compiler takes the
processing of rare error cases out of line.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |   60 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index aa516838ce0b..e793344227c9 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1021,29 +1021,24 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	dprintk("nfsd_dispatch: vers %d proc %d\n",
 				rqstp->rq_vers, rqstp->rq_proc);
 
-	if (nfs_request_too_big(rqstp, proc)) {
-		dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
-		*statp = rpc_garbage_args;
-		return 1;
-	}
+	if (nfs_request_too_big(rqstp, proc))
+		goto out_too_large;
+
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
-	if (!proc->pc_decode(rqstp, argv->iov_base)) {
-		dprintk("nfsd: failed to decode arguments!\n");
-		*statp = rpc_garbage_args;
-		return 1;
-	}
+	if (!proc->pc_decode(rqstp, argv->iov_base))
+		goto out_decode_err;
 
 	switch (nfsd_cache_lookup(rqstp)) {
 	case RC_DOIT:
 		break;
 	case RC_REPLY:
-		return 1;
+		goto out_cached_reply;
 	case RC_DROPIT:
-		return 0;
+		goto out_dropit;
 	}
 
 	/*
@@ -1055,11 +1050,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 
 	nfserr = proc->pc_func(rqstp);
 	nfserr = map_new_errors(rqstp->rq_vers, nfserr);
-	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags)) {
-		dprintk("nfsd: Dropping request; may be revisited later\n");
-		nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
-		return 0;
-	}
+	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags))
+		goto out_update_drop;
 
 	if (rqstp->rq_proc != 0)
 		*nfserrp++ = nfserr;
@@ -1067,16 +1059,34 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	/*
 	 * For NFSv2, additional info is never returned in case of an error.
 	 */
-	if (!(nfserr && rqstp->rq_vers == 2)) {
-		if (!proc->pc_encode(rqstp, nfserrp)) {
-			dprintk("nfsd: failed to encode result!\n");
-			nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
-			*statp = rpc_system_err;
-			return 1;
-		}
-	}
+	if (!(nfserr && rqstp->rq_vers == 2))
+		if (!proc->pc_encode(rqstp, nfserrp))
+			goto out_encode_err;
 
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
+out_cached_reply:
+	return 1;
+
+out_too_large:
+	dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
+	*statp = rpc_garbage_args;
+	return 1;
+
+out_decode_err:
+	dprintk("nfsd: failed to decode arguments!\n");
+	*statp = rpc_garbage_args;
+	return 1;
+
+out_update_drop:
+	dprintk("nfsd: Dropping request; may be revisited later\n");
+	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+out_dropit:
+	return 0;
+
+out_encode_err:
+	dprintk("nfsd: failed to encode result!\n");
+	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+	*statp = rpc_system_err;
 	return 1;
 }
 


