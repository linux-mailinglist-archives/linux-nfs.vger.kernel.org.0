Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B52EAE7D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbhAEPcx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbhAEPcx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:53 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF7AC061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:37 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id h4so26816497qkk.4
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eBDnHnNtbOsWQF3HME0FnBt2R9L4nyG4xusmfpl9RoY=;
        b=WnZxgthLsW0fuGljFIef0KGPZe9kRO7pULZDhuwt/4xIwYrlbT9MtcXIzQgkx6EOlx
         pABa4pqwdrZS4bvHFwAqK9TfFrSbL18xmZK6WiRDOuAiqUv+Rdl9I96w9QXul7c0tABE
         +NUKZ0zw9uFBUCi9Da6CRE/vLodinfJm1NYles9yfJ8kLfwtRldlr4lyBm3rUPC6A39x
         PD0/hA2Wdcj/2prAIhdtOCsP53N45qfguQCtEaBJkH9WPSDGf5iviB4mUHU+unLobtIz
         6yoRDEZtMSPdxvi23XP9Svh+deXnPrIbMV9PDF+OAROX/9um+gD82zBvUdjcksPeEfvl
         vXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eBDnHnNtbOsWQF3HME0FnBt2R9L4nyG4xusmfpl9RoY=;
        b=cs0NQTmExPJqfykC/NPsixubZ0PNizXABV6yn4gnC2tMkkkLX53zcQooKwyvH1d1S1
         vvA00N3+Xg7n+LZCf5VlkbUNdZKc6daio5JFLvhEtyXUqHRPD9mBAW6FMve7d83PQ+uL
         ok0w+eeMLDK+rUgNRWy6AQMNTGhXtxJgJHu9xqVw6TueyDSV1dnVQlda+i/Bvtqvs9YK
         vn/ljTxp+iQrY0btxQRqz7+0uqHxg15J0xBCXM+zzB9Biw1ltwpMlWfU2nqyHVFHpQzK
         V9OycsluGth8uwVwMRqkGXSQrsN7UGQd+6GPUuCIYigawPYHNzoWzNRcwODn5894VQC2
         K1+A==
X-Gm-Message-State: AOAM532k77cZSa+g4tG+7ANB7voPAPi1lD8xXk3sFS0Dx0QKXqH+Dpk2
        Rz1YFCmqQyEEALhaSl9WmfAb3dDQumM=
X-Google-Smtp-Source: ABdhPJw29jBzdXx/HdINXG1Jt3EwpeoC0owDDpBVtVdpCJe3lUn3eoW/UtLlKyY4au0qRRZTsV0pLQ==
X-Received: by 2002:a37:57c7:: with SMTP id l190mr829qkb.487.1609860756532;
        Tue, 05 Jan 2021 07:32:36 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k141sm157032qke.38.2021.01.05.07.32.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:35 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FWY9K020919
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:34 GMT
Subject: [PATCH v1 33/42] NFSD: Remove argument length checking in
 nfsd_dispatch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:34 -0500
Message-ID: <160986075477.5532.874590573395626610.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that the argument decoders for NFSv2 and NFSv3 use the
xdr_stream mechanism, the version-specific length checking logic in
nfsd_dispatch() is no longer necessary.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |   34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f9c9f4c63cc7..6de406322106 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -955,37 +955,6 @@ nfsd(void *vrqstp)
 	return 0;
 }
 
-/*
- * A write procedure can have a large argument, and a read procedure can
- * have a large reply, but no NFSv2 or NFSv3 procedure has argument and
- * reply that can both be larger than a page.  The xdr code has taken
- * advantage of this assumption to be a sloppy about bounds checking in
- * some cases.  Pending a rewrite of the NFSv2/v3 xdr code to fix that
- * problem, we enforce these assumptions here:
- */
-static bool nfs_request_too_big(struct svc_rqst *rqstp,
-				const struct svc_procedure *proc)
-{
-	/*
-	 * The ACL code has more careful bounds-checking and is not
-	 * susceptible to this problem:
-	 */
-	if (rqstp->rq_prog != NFS_PROGRAM)
-		return false;
-	/*
-	 * Ditto NFSv4 (which can in theory have argument and reply both
-	 * more than a page):
-	 */
-	if (rqstp->rq_vers >= 4)
-		return false;
-	/* The reply will be small, we're OK: */
-	if (proc->pc_xdrressize > 0 &&
-	    proc->pc_xdrressize < XDR_QUADLEN(PAGE_SIZE))
-		return false;
-
-	return rqstp->rq_arg.len > PAGE_SIZE;
-}
-
 /**
  * nfsd_dispatch - Process an NFS or NFSACL Request
  * @rqstp: incoming request
@@ -1004,9 +973,6 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	struct kvec *resv = &rqstp->rq_res.head[0];
 	__be32 *p;
 
-	if (nfs_request_too_big(rqstp, proc))
-		goto out_decode_err;
-
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)


