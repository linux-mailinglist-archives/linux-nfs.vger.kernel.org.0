Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29AB280AA1
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbgJAW7d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW7c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:32 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB15C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:31 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id f11so326921qvw.3
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+CMpMrw5DJS0RtW4Jttvyvx/fjM3ibc2Vs4qiDoHGyY=;
        b=Ik9Jz2K+OqUq920BDRQAtKcmGKTmKek0vR8JVqqWWK3wtbSQs9GSgxIOW+CBgHQu2u
         7KM4n5sNjAR7NjIjW4awaS6imCLNsjQdo+ixKLyJHAmDizdpdYecpG62//kkelXzs4Uk
         pnnWq3MaC78gW/Of3oc/LWUe8B+pFAB3SR/xBjwpoUzJksBdFe094c1aZ0/PMWdxa0DF
         L0tG/WILueuxz4wdrVpkxGkuP0mb1/tICAUYiCRety6ppfaIHsgZ6cK/cUZ8kXDpZUb7
         31+x8px8Q7DnDhIibPW9S3icxT8olIyHfiPOlTdkOLAwK2Yr7LHzlzz2bcUX95lNIVUF
         Focw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+CMpMrw5DJS0RtW4Jttvyvx/fjM3ibc2Vs4qiDoHGyY=;
        b=B+eQHv+gOw90IkCt5fPHjf4A8HitajWsSaJ9M7SmSoc7RfUnfGBlZavOWVkD1zLWEA
         RDDjY5sW4/CvnKNAjaDX2IjjhsXiQtwIE2waReMYElN4ADoYGjU8ps8wTHoTaa9BzUtu
         TDszKJU+jBpmJE6SiELsDAinrLdWHMbNKtXrJLJYnnrDJMsZ+fiTWswyTQt8+6axW/oJ
         KGi962w9xnf2qppaU3ZhK/dQ7vDcUz9hCCE9Hn4FwN27SDPEM685swvl03XbHqXf9bDu
         SbtWL0BmyQ+T8Ybni/DowJk9PiHHVeuZHdcE0eBiUnt+UOo1uJYLprkaQABRYjFw9rCN
         quig==
X-Gm-Message-State: AOAM533XneVU3rKW2ls1urKlkIHyEe14vnAyBYcLeEfgXOKpYWriUaQJ
        ZIi4AsT0yZHm0LrcEjt6y0x7OS2U9dgDqg==
X-Google-Smtp-Source: ABdhPJzinnZxwk3Rfy0ZPSkx1ABvPHOfCkoVQGXlrR+Yjv7ilr3kPVfqz4Y2FZX3OACWWwzK4qZQNg==
X-Received: by 2002:a0c:b21b:: with SMTP id x27mr10163613qvd.12.1601593170149;
        Thu, 01 Oct 2020 15:59:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n203sm7222728qke.66.2020.10.01.15.59.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:29 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MxSEA032586;
        Thu, 1 Oct 2020 22:59:28 GMT
Subject: [PATCH v3 08/15] NFSD: Clean up nfsd_dispatch() variables
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:28 -0400
Message-ID: <160159316832.79253.9696512483283981117.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
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
index 9be2e14b3bca..aa516838ce0b 100644
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
+	__be32 nfserr, *nfserrp;
 
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
+	nfserrp = resv->iov_base + resv->iov_len;
+	resv->iov_len += sizeof(__be32);
 
 	nfserr = proc->pc_func(rqstp);
 	nfserr = map_new_errors(rqstp->rq_vers, nfserr);


