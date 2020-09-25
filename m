Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF61278F42
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgIYRAd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYRAc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 13:00:32 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83B8C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q4so3543506iop.5
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LT0d43XqDPFQ2igY6aAK/AJnS7eJ9FKHSrKkT4SX47c=;
        b=sWOFV8pjfIMkSRfxnLV5v5Vp9yMmdsUohax5s2S++MR7yycKHiXUGij1PcPc3HcXzA
         rUHWFy+b9yG7WoCn0MBesGno+sJniOX46E7fxK+EkSsfug1P/fJH4JJB2jkdwnSf1Q5a
         DvAbIx+X4j1yxKM1T93kchbLtFITMZS6AXEa4jUTxq2TTXFinkwTN9QUMW77krucJQV5
         Ew/O5Csj1jmfg0c9eBiErrMjHqeerSsEjnnh0PmWgs8I4mIjipqkTQlmx2rH/zW8wi7E
         cZRjUJ+1lxl7QZ6Unz6pzggcPrpC2Rf7aO8eFLMFVwb6Azi6UDiJ+1lWfDljj7OP6TV6
         zqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=LT0d43XqDPFQ2igY6aAK/AJnS7eJ9FKHSrKkT4SX47c=;
        b=doYmWeoA5XyhotmRxb9nT8UbpUL7JGTgNWeSqQYOYBApELOhPU0MtJxbzYlmWMp4K1
         7pHcmTyEqc5ovWLZVFvzinpVeSKJ0/cEVVHDeXyfg0ClJtcUnxsUaSC09M8YrgKJJrUm
         M3u5bS5RB/sf6/gZ8KxDpVqgSJrveaY7rH88JHgXJTShciUBnmAk2pe/OCb54exrTYuj
         /4bKJagIRkxUea6nPUz36rEr/JGIUNCeSfQRSVGsfVmEFnyc+VOPTi7Y0fDYx7umzHc6
         +RzYaw11K3OBOGu98praT6MJB3ZGJmvLXdIu0pkil9ryeEf4/yvaT9rx9dcE+MaaMyS/
         IeFg==
X-Gm-Message-State: AOAM531sv7p4KyIEjRI5huHr3EjE3G0NUKEuLWKW1F8XwoLyjwMeCnOY
        xGq4biy/LiH4R9C5aoLOh1gojcUJNNTqjA==
X-Google-Smtp-Source: ABdhPJzPNZG8DX8jM4d2E2gghV/2KR0RxiqftIlxS0H0MMenDl/qLReitR8k5QMPnpj/cIkfgYsNZA==
X-Received: by 2002:a02:cb99:: with SMTP id u25mr215jap.99.1601053232140;
        Fri, 25 Sep 2020 10:00:32 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e22sm1418514ioc.43.2020.09.25.10.00.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:00:31 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08PH0UGd014539;
        Fri, 25 Sep 2020 17:00:30 GMT
Subject: [PATCH 7/9] NFSD: Clean up nfsd_dispatch() variables
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 25 Sep 2020 13:00:30 -0400
Message-ID: <160105323037.19706.9936685667225383297.stgit@klimt.1015granger.net>
In-Reply-To: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
References: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For consistency and code legibility, use a similar organization of
variables as svc_generic_dispatch().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b2581bcbd81c..2eb20cbf590f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1011,13 +1011,13 @@ static bool nfs_request_too_big(struct svc_rqst *rqstp,
  */
 int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
-	const struct svc_procedure *proc;
-	__be32			nfserr;
-	__be32			*nfserrp;
+	const struct svc_procedure *proc = rqstp->rq_procinfo;
+	struct kvec *argv = &rqstp->rq_arg.head[0];
+	struct kvec *resv = &rqstp->rq_res.head[0];
+	__be32 nfserr, *nfserrp;
 
 	dprintk("nfsd_dispatch: vers %d proc %d\n",
 				rqstp->rq_vers, rqstp->rq_proc);
-	proc = rqstp->rq_procinfo;
 
 	if (nfs_request_too_big(rqstp, proc)) {
 		dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
@@ -1030,7 +1030,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * (necessary in the NFSv4.0 compound case)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
-	if (!proc->pc_decode(rqstp, (__be32 *)rqstp->rq_arg.head[0].iov_base)) {
+	if (!proc->pc_decode(rqstp, argv->iov_base)) {
 		dprintk("nfsd: failed to decode arguments!\n");
 		*statp = rpc_garbage_args;
 		return 1;
@@ -1049,9 +1049,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * Need to grab the location to store the status, as
 	 * NFSv4 does some encoding while processing
 	 */
-	nfserrp = rqstp->rq_res.head[0].iov_base
-		+ rqstp->rq_res.head[0].iov_len;
-	rqstp->rq_res.head[0].iov_len += sizeof(__be32);
+	nfserrp = resv->iov_base + resv->iov_len;
+	resv->iov_len += sizeof(__be32);
 
 	nfserr = proc->pc_func(rqstp);
 	nfserr = map_new_errors(rqstp->rq_vers, nfserr);


