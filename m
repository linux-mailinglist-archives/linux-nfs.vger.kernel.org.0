Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48DF278F43
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgIYRAi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYRAi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 13:00:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF695C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:37 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y13so3537471iow.4
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+yTv7eTXBEq4HoQ7tn4eqVMa0bjmmSQdI3afPBQcOu0=;
        b=nGusW9NOlzykeEVXezpSNopK4aVPyW3+nWCNzyYWM626KkXwmwjXriJHeiUvcp5eOs
         EKbLl3NDDmjP97WXM1deUvLAZ2geLMxLG7yxnlAr+LbIQy7NQQSQ7qu+dHc2MM04SKtb
         V0EA/SGbMS4FdNZd08qj/9x5yU7U80/xeQgtSgk7UMJu39MBMO7CLURl2EJ8Z5tWI0PY
         H7klBU548EdOU8EyvJJRxAk7hi99OWH2kUpyLnKej4rhlyD7nRPdBi+nH+FKljt6PivW
         1JPqnc5dIArUN3CJiZglI/jaBWk1uTxIFJN7pjlXm59KHKWImxua8JiogjJoVNaGFFeu
         dMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+yTv7eTXBEq4HoQ7tn4eqVMa0bjmmSQdI3afPBQcOu0=;
        b=kTt0jc01Roj1ac5czAe48+Ue9ahIxVkrD4nnHFd/N/2Df2et3kHFkBrCNiAx4QRt01
         h9yXGAliQ0GLB3N3eyMsjOMFUl+bFgy5xdnkuusZDMrfFLkyxrltuljw8uR9WhbGpIWO
         cOC8k46VN0NpNQIuPORzr5pJ2yFMfAxomtpqKNmVq6uMhdY/z+o4M9Cx5wKQ90CWdJIA
         LF5Z+LwXCJdJ6Xus5gOaoBbgeDaCDE3B3ZwcuqRfSNtFyHku3hoWmUcJ+dMYcE6jSL2u
         gARJlQOIoFBoT2uQG0k/F139y31q05LeUlzrZRWtI8qTiw61J8VCwRRrvfoaBsiDGKuV
         2opQ==
X-Gm-Message-State: AOAM532mgGPtkVKcm9mrkaeR8aLFBBzIwZ3ZdIffLJI4yjO3L7uSFHMI
        iw9asKASKM530IGhs9OWiirB7euAlBsxLw==
X-Google-Smtp-Source: ABdhPJw9alu2qQv86ia/oq6No3cMJwN/B6qGDHxJaKsnGCBJ1Pc51qpeUFHPI1O4YEBVvY9O8bYVBw==
X-Received: by 2002:a02:7654:: with SMTP id z81mr36135jab.80.1601053237174;
        Fri, 25 Sep 2020 10:00:37 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f22sm1802598ilf.56.2020.09.25.10.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:00:36 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08PH0ZCq014542;
        Fri, 25 Sep 2020 17:00:35 GMT
Subject: [PATCH 8/9] NFSD: Refactor nfsd_dispatch() error paths
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 25 Sep 2020 13:00:35 -0400
Message-ID: <160105323573.19706.6751036475347020759.stgit@klimt.1015granger.net>
In-Reply-To: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
References: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_dispatch() is a hot path. Ensure the compiler takes the
processing of infrequent errors out of line.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |   59 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 2eb20cbf590f..d389b276aa5e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1019,30 +1019,24 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	dprintk("nfsd_dispatch: vers %d proc %d\n",
 				rqstp->rq_vers, rqstp->rq_proc);
 
-	if (nfs_request_too_big(rqstp, proc)) {
-		dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
-		*statp = rpc_garbage_args;
-		return 1;
-	}
+	if (nfs_request_too_big(rqstp, proc))
+		goto out_too_large;
 
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
@@ -1054,11 +1048,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 
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
@@ -1066,16 +1057,34 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
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
 


