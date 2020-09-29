Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C067227D07A
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgI2OEQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2OEQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:04:16 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68776C061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:16 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b17so1707356ilr.12
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mrKAgEf/f4LY/lFddxen1fAz8Um6A+43IX6tdcT9CAw=;
        b=enhtmCkFLXliCH/OxnQhnVqNyh1Kwdip9BJoV2MW7GPFupC9wWMlbTOkAW5604VnDs
         ipyog+8PS44myxD//AkF0Arbt1ahZY66q4NN45qN4GIo6vMWba3eK+YgBoKQIgZ5v/L2
         Z3ZZbRj/28YkTijH4cSn4Gq0G0qy9K3FMJNGGkiBZdnOp7F7cM++drcxUNIU9bjL6HRO
         WFBq13kDWW5TUVF6Lqc34rImYFnhoVnprzl91D3L62dKpVmDSY1bXVLNiVKsB3XuZCrL
         +aQM2y/PIujIm9a2ASwm6IZW17GCdNptdOVr8kB9jxqaLUeUDHHdmTPy6nQnVOtSlEzS
         ADcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=mrKAgEf/f4LY/lFddxen1fAz8Um6A+43IX6tdcT9CAw=;
        b=oOVmn1vrZgPvAXQyBjFxm0+l2KvYcoBjv6qH3xAi0gkwv5y3qkc4Dx7/Y2SsaSNKua
         SdInTrpaLmqTKWFRFnO2Q8GsS5GOmlv0829mBZqBDo9uOzfvV+7fN57qgqAB+CiNg0OE
         XPjXquSkm9SABU07GIHuJQStTZQO+JAJTgx11w6WDgBHcRYbtc3vZl+s6587aJHKfx0c
         rSW0s4V3q7Bup2um1/iNIe/9e6KWjIvJe+oEsfb8Q98XsjfTlx+J84jtH5ZnLvV1NdoK
         MYn6+wdA8HNqqbJdTDxAYiG3FxQbWon8W94OiPbuIktryCEh3g2+n16qiNRXzQJkPKQy
         7T0g==
X-Gm-Message-State: AOAM533sODYaneSt4tXD8UfL/GSX5/Uy0wiu1jGAYMuzx1qRn2PpW2lf
        KJL/oi5ddg2kdxOLIJvPmpdLp2DndKAW2w==
X-Google-Smtp-Source: ABdhPJxV7fNTfCpDy2RFW6qGYK4+KC/Vn27KHvkFpjeK3zvmOejP1SiPnr6gbpjs4JF4CgbAuhcEUA==
X-Received: by 2002:a92:d288:: with SMTP id p8mr3322901ilp.166.1601388255780;
        Tue, 29 Sep 2020 07:04:15 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m18sm2498852ila.27.2020.09.29.07.04.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:04:15 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE4EUm026433;
        Tue, 29 Sep 2020 14:04:14 GMT
Subject: [PATCH v2 07/11] NFSD: Clean up nfsd_dispatch() variables
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:04:14 -0400
Message-ID: <160138825403.2558.7802071453687036540.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For consistency and code legibility, use a similar organization of
variables as svc_generic_dispatch().

Since @nfserrp does not always point to the NFS status code, let's
give it a more generic name.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 9be2e14b3bca..18ec22a8580a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1013,13 +1013,13 @@ static bool nfs_request_too_big(struct svc_rqst *rqstp,
  */
 int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
-	const struct svc_procedure *proc;
-	__be32			nfserr;
-	__be32			*nfserrp;
+	const struct svc_procedure *proc = rqstp->rq_procinfo;
+	struct kvec *argv = &rqstp->rq_arg.head[0];
+	struct kvec *resv = &rqstp->rq_res.head[0];
+	__be32 *p, nfserr;
 
 	dprintk("nfsd_dispatch: vers %d proc %d\n",
 				rqstp->rq_vers, rqstp->rq_proc);
-	proc = rqstp->rq_procinfo;
 
 	if (nfs_request_too_big(rqstp, proc)) {
 		dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
@@ -1031,7 +1031,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * (necessary in the NFSv4.0 compound case)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
-	if (!proc->pc_decode(rqstp, (__be32 *)rqstp->rq_arg.head[0].iov_base)) {
+	if (!proc->pc_decode(rqstp, argv->iov_base)) {
 		dprintk("nfsd: failed to decode arguments!\n");
 		*statp = rpc_garbage_args;
 		return 1;
@@ -1050,9 +1050,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * Need to grab the location to store the status, as
 	 * NFSv4 does some encoding while processing
 	 */
-	nfserrp = rqstp->rq_res.head[0].iov_base
-		+ rqstp->rq_res.head[0].iov_len;
-	rqstp->rq_res.head[0].iov_len += sizeof(__be32);
+	p = resv->iov_base + resv->iov_len;
+	resv->iov_len += sizeof(__be32);
 
 	nfserr = proc->pc_func(rqstp);
 	nfserr = map_new_errors(rqstp->rq_vers, nfserr);
@@ -1063,13 +1062,13 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	}
 
 	if (rqstp->rq_proc != 0)
-		*nfserrp++ = nfserr;
+		*p++ = nfserr;
 
 	/*
 	 * For NFSv2, additional info is never returned in case of an error.
 	 */
 	if (!(nfserr && rqstp->rq_vers == 2)) {
-		if (!proc->pc_encode(rqstp, nfserrp)) {
+		if (!proc->pc_encode(rqstp, p)) {
 			dprintk("nfsd: failed to encode result!\n");
 			nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
 			*statp = rpc_system_err;


