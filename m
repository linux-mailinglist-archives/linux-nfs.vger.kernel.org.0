Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937D6278F41
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgIYRA2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYRA1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 13:00:27 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9391C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:27 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y2so3056999ila.0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=e6jpXj1iIsBJMQQbncZxwsbXY/imdz+QNNDKwkGGWMs=;
        b=Or5bbiOb+kASAb8p+CQqbxG2V+0nQSrMWPsTNoIC6+jfXqd2w+0m/43ZwSF1j3Nta8
         CFz/1JNi0MFRhcG0Y62wUt6HGuZmicn9XjXWsfUw6ZH+SRZUB3+N5zR5BP9iYXjb1LxM
         zLg6lnY3LiXtaffledCZe6WskUfkZ/Wp/3u5uwSLMPqUAaGxtuF7oHeiJKXHmf3hAPEf
         4T6n4NYD0KRF++hSzJsi4hV7SB4rVP1IhNQQJsE4iMfxzmyeYrfQIwDDCUpbYTvkMcuW
         lXQ1LjRqrNOwKOCXk8Vo6Kwdezkit8TyBAfui7Ev+/psMpthPq5HI/obYMWvDfe0DhZY
         ESSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=e6jpXj1iIsBJMQQbncZxwsbXY/imdz+QNNDKwkGGWMs=;
        b=GTJ6lii6fIg15FVFleEMx/3szf9J3zh+Lfby/pmKPYFpV99fTcbPmCgSYVEI7ZELMJ
         IDMvT5kXIuxNNBxJrx3cIWnotFMbyq6baTJPoUh0gF01rNr1yG8KpeVHZxbqgWJPYon7
         YQCjsIs1Zja1+bDYQtDto0nh4rB7NODbAtxdvzCmjk+PrH0nviYBDl8pwgjjvNOWsu0Y
         sSB0A0gIYDAsss3qzrh76ZgIK0UHoo2/FwuEMt37WSt0swU3fqvKxydBdG/pDpBA+kjn
         rwVJhTz+DWmlbYRSy5Tp/3WoUhGdy/wPbKPHTmpsnNe0TWKDVD4Vm3uGP9ZtYJIuciem
         WH/w==
X-Gm-Message-State: AOAM53022lOc3Os4LvRgNu6lqk16DBBizjOzoM6UIm4eg9UxG5oimwms
        W8l8TMc+WXZFS/k8a8EoBKw=
X-Google-Smtp-Source: ABdhPJwkXbVvnUc0DQ6IHzfwGnZOaX4e+aE1OLRZVOAqzfadiFQ99WRtjmBZ8iWSi8RkZ0vnZCsfkQ==
X-Received: by 2002:a05:6e02:925:: with SMTP id o5mr1013223ilt.20.1601053226711;
        Fri, 25 Sep 2020 10:00:26 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c83sm490777ilf.59.2020.09.25.10.00.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:00:26 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08PH0PLI014536;
        Fri, 25 Sep 2020 17:00:25 GMT
Subject: [PATCH 6/9] NFSD: Clean up stale comments in nfsd_dispatch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 25 Sep 2020 13:00:25 -0400
Message-ID: <160105322528.19706.1128827272280936847.stgit@klimt.1015granger.net>
In-Reply-To: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
References: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a documenting comment for the function. Remove comments that
simply describe obvious aspects of the code, but leave comments
that explain the differences in processing of each NFS version.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3cdefb2294ce..b2581bcbd81c 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1000,8 +1000,16 @@ static bool nfs_request_too_big(struct svc_rqst *rqstp,
 	return rqstp->rq_arg.len > PAGE_SIZE;
 }
 
-int
-nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
+/**
+ * nfsd_dispatch - Process an NFS or NFSACL Request
+ * @rqstp: incoming request
+ * @statp: OUT: RPC accept_stat value
+ *
+ * Return values:
+ *  %0: Processing complete; do not send a Reply
+ *  %1: Processing complete; send Reply in rqstp->rq_res
+ */
+int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *proc;
 	__be32			nfserr;
@@ -1016,19 +1024,18 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		*statp = rpc_garbage_args;
 		return 1;
 	}
+
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
-	/* Decode arguments */
 	if (!proc->pc_decode(rqstp, (__be32 *)rqstp->rq_arg.head[0].iov_base)) {
 		dprintk("nfsd: failed to decode arguments!\n");
 		*statp = rpc_garbage_args;
 		return 1;
 	}
 
-	/* Check whether we have this call in the cache. */
 	switch (nfsd_cache_lookup(rqstp)) {
 	case RC_DOIT:
 		break;
@@ -1038,14 +1045,14 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		return 0;
 	}
 
-	/* need to grab the location to store the status, as
-	 * nfsv4 does some encoding while processing 
+	/*
+	 * Need to grab the location to store the status, as
+	 * NFSv4 does some encoding while processing
 	 */
 	nfserrp = rqstp->rq_res.head[0].iov_base
 		+ rqstp->rq_res.head[0].iov_len;
 	rqstp->rq_res.head[0].iov_len += sizeof(__be32);
 
-	/* Now call the procedure handler, and encode NFS status. */
 	nfserr = proc->pc_func(rqstp);
 	nfserr = map_new_errors(rqstp->rq_vers, nfserr);
 	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags)) {
@@ -1057,12 +1064,11 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	if (rqstp->rq_proc != 0)
 		*nfserrp++ = nfserr;
 
-	/* Encode result.
+	/*
 	 * For NFSv2, additional info is never returned in case of an error.
 	 */
 	if (!(nfserr && rqstp->rq_vers == 2)) {
 		if (!proc->pc_encode(rqstp, nfserrp)) {
-			/* Failed to encode result. Release cache entry */
 			dprintk("nfsd: failed to encode result!\n");
 			nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
 			*statp = rpc_system_err;
@@ -1070,7 +1076,6 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		}
 	}
 
-	/* Store reply in cache. */
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
 	return 1;
 }


