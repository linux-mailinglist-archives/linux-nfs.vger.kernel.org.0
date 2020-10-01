Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07E280AA0
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgJAW71 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW71 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E484DC0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c62so33766qke.1
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ApApgnFDtOn88XT0rG3ss/TYDMXcFvEoIp7kwLbIfPs=;
        b=cn5c2dRmrzJlWzW1E0/5FxQcJyQxzgC+yF1VScXdC9cyuixBWOELL0B1Gc9RTe44cy
         WEUA2e1UR867yq/+LEJnzyWBTEqMovinBshH318ETAdWkjzwbKoOcjVG/I3/APUg0kZs
         eLa3fyMCuJJSnZPeE4GDOQWDg9FbWUqE3YweGR4fwsMMvdnbmPNSTftQfo5ss3MvoemH
         6YXAcTJCTSRfeAjkTQmvpQrCCzX9h1uHBMsuhv0XUXWAhuyQT6zocAKM2ip/lRgZmhIv
         nLLrPzdEapKy5s5EXIE3hLzIi8AtVXcVa0KqYJmyULIj04HBVNhElrQ2Y0ts1wG9TjFR
         FzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ApApgnFDtOn88XT0rG3ss/TYDMXcFvEoIp7kwLbIfPs=;
        b=MPIlJjZEWOuKGMHloi6ICRfJWQlmrtQ1j3EUxa0WWvVm+mHtV3MF0HpHnXOTIHL3lk
         aepdxyka1+gWuGd/RG4UvzGaw8P62kgTWUEO142kbwVDuKw7TRqtu7VDW1an/HP3ebUs
         rQiCno3SLeoZvz5kH98jlSMG/PQcc8QqsTYc3b07NNBCNzlJrRqibnPhy0z6jefeFLLH
         ZjRw8tO4UH/bB0TaTlwuPuztgiagiaEBXC3P7AlH6cG73hH56sc3vE80mI7vY9fPDKbb
         mcyxw3zatMRGiue9h+B0wcSvwQFAGVYSIaoWxr4JAJfKAeIe/yVF7B3FSwObD4ASX0Sh
         PEGw==
X-Gm-Message-State: AOAM531LN3f7frFUz/psLCRTOfneIlWeH5Ffs3fbaj4tOmMx+rTWckIS
        iIgBGFoTaWJXRmwW2o7U8gKPiOSw2tGBVA==
X-Google-Smtp-Source: ABdhPJyRzF6J/4Yl/QPS3hfFXwRR02tss/kYDbiTQBuIZKyEbEeRAbeUZ1co8cg/rsc+bbddn4z9mw==
X-Received: by 2002:a37:654b:: with SMTP id z72mr9781640qkb.365.1601593164716;
        Thu, 01 Oct 2020 15:59:24 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x25sm7879383qtp.64.2020.10.01.15.59.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:24 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MxNtW032583;
        Thu, 1 Oct 2020 22:59:23 GMT
Subject: [PATCH v3 07/15] NFSD: Clean up stale comments in nfsd_dispatch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:23 -0400
Message-ID: <160159316324.79253.16173133716101676857.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
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


