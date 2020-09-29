Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E127D079
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgI2OEL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2OEL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:04:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D30C061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l16so4975613ilt.13
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ApApgnFDtOn88XT0rG3ss/TYDMXcFvEoIp7kwLbIfPs=;
        b=oLcLszvlsX4gRFYYTLWS+KpC2b0oWmWq5875xk2s3wG4XZZCfV8oer9R4RuhWR+EP1
         FdTgEHLNpNaIXUYvcSN8F1gbHHf2fY66u3MpvlT4LXIf2/c6w/NtpzTaeBU9ypqFugRx
         uS6tuP/g/cVVi2nspC+x2t1XhZyiggBV3ZWANB+/16RHAlaexpDI3kM4HSF0KZuFEDUK
         nhqKNZdny2kZxznMcBMaSQMnMiPk+vzNsD7VRp2ZhSoQ2ByKmxpZguFa0D9XlJTKtzKW
         9z8J5njQwdUtci0bnw6qXsfCFIKR19IvxKOmI/Gs2d0iXqynrb1Y+VcXnztNdHJzyAqp
         lrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ApApgnFDtOn88XT0rG3ss/TYDMXcFvEoIp7kwLbIfPs=;
        b=LXZQxSKSyA6hFaANO1lR8nKpwo18lApYkWhSSPF7FpjJ+6aD+Tx6tCXgea+beyYcqx
         xBzEm9K0WiQbXKzAsNf+8I9tlLQZ41D5qjC4MI601auEE7Kwt3Jh0AKSwPOZL+mq53tb
         ive1l6kalEwLRoMsmTmGmD3i09pdHcKGr1xMFZdMC9guON+ulT3VcZh9H2AJbcTQq+9T
         owwXIwp95KIJsKh3nO2ZFkvJyN+Kvzq5nTQlfvER6+JvXN3Mz41trCqkmXLIHo5CR4W7
         RdlBz4do71DAwQRqcxUAr9rdLcYRypkQJBZCwCnJ6Z2b0Q+aZuykclMPuQmFSRyfr6x2
         jIww==
X-Gm-Message-State: AOAM530uEkeu8MPDQBy8LtRCwamZZDYMRVVtfTnWO/7IkTpe0zlv7typ
        73HLd2YoFIscwEmKNSrQgAFfoPGEEwbqlQ==
X-Google-Smtp-Source: ABdhPJw0hV40Nc8eTTMNJNI5WEuSk1fQm6zhPVugOHh/JCwze4NCiatSSvVcfBe1BaNtZuCVHoChGQ==
X-Received: by 2002:a05:6e02:d05:: with SMTP id g5mr1126647ilj.259.1601388250389;
        Tue, 29 Sep 2020 07:04:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s17sm2518827ilb.24.2020.09.29.07.04.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:04:09 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE48Gk026430;
        Tue, 29 Sep 2020 14:04:08 GMT
Subject: [PATCH v2 06/11] NFSD: Clean up stale comments in nfsd_dispatch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:04:08 -0400
Message-ID: <160138824895.2558.3194986709912175601.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfssvc.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3cdefb2294ce..9be2e14b3bca 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1000,8 +1000,18 @@ static bool nfs_request_too_big(struct svc_rqst *rqstp,
 	return rqstp->rq_arg.len > PAGE_SIZE;
 }
 
-int
-nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
+/**
+ * nfsd_dispatch - Process an NFS or NFSACL Request
+ * @rqstp: incoming request
+ * @statp: pointer to location of accept_stat field in RPC Reply buffer
+ *
+ * This RPC dispatcher integrates the NFS server's duplicate reply cache.
+ *
+ * Return values:
+ *  %0: Processing complete; do not send a Reply
+ *  %1: Processing complete; send Reply in rqstp->rq_res
+ */
+int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *proc;
 	__be32			nfserr;
@@ -1021,14 +1031,12 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
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
@@ -1038,14 +1046,14 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
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
@@ -1057,12 +1065,11 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
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
@@ -1070,7 +1077,6 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		}
 	}
 
-	/* Store reply in cache. */
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
 	return 1;
 }


