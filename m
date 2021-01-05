Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB922EAE8A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbhAEPdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAEPdi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:38 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DDEC061796
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:58 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id c7so26786301qke.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cxW0R+i2awO1nEIk/owL25UAcFkZS5u1R3IElRZBeEY=;
        b=H42cFXUi7DGaNNN3yPQdczQPwDuA2J6wvjMPPQ1O3u94NwytvJY8AfYaRujqR/VbbR
         l5LWMTjG7dHZsBQEQJsi3hwxrF2OemXy6YTgbfH65xCW0oI21qVqLU9+oCqTOs6eaSJt
         ld3rgXQgj4fHimsoSqa66hO1JqKDRS3tHyWZU4iyk/ySTUbAOmVzHxjkpHkPHWI8so+5
         QOeXRZIuxArLGsYAz9UvhZJyQYavbVZ0HobqNDhISkYAS9VLxfxLx5110aztUOk2zKWQ
         wCH4j7/T/OqdkZbc6otbjDvzwMlmZMOGfK33J1dvmU7/piPqW7uHzxI9O8am67yuOHeB
         SDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=cxW0R+i2awO1nEIk/owL25UAcFkZS5u1R3IElRZBeEY=;
        b=f/Wchu4CGPlATiFjAoJE/qnaGkjSGhTBktIf/mPDM1E8XfgesMoQdwzxO2lLIBUN4p
         QcS9ySTKmtljvnobR/knFnS02a1jnSIsKu0gRXWFjEd/X10rEpk/qyXfp1llVaOf6K5I
         plXfy17c4AspOiQDeoEcjanYe9ZUjNO+cl85XokI+Fd7+aa5JAG0OM7s5wocCux88HTc
         2q1vhMlBRjLI+HidfrHnddTSp2s2RtviYLyxaH5iu7WGB+9zkqN+yo7IYx8V6jUsXxnO
         4NZUNptmE5foscN3Bu1dqlAJ9rim5Ynpy0dKTuxYMmb1jxlvV4tEmxoTEKGySFnT/q/U
         eWpA==
X-Gm-Message-State: AOAM5305TGhWv5AYC5iltTi8vn3NfZcrU82RRilh4M5arClcsUPez/Pf
        zRNggcsiUnYG4XGeaKwK288+v7ZJmZE=
X-Google-Smtp-Source: ABdhPJxZgvy/2SqWKUSB5hLkZKu7onK10uqD21oTbF3cDswHH6/AmHw6l1J3oW7X+u271GYXxI3LCw==
X-Received: by 2002:a05:620a:983:: with SMTP id x3mr27317qkx.231.1609860777465;
        Tue, 05 Jan 2021 07:32:57 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m64sm145269qkb.90.2021.01.05.07.32.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:56 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FWt5u020931
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:55 GMT
Subject: [PATCH v1 37/42] NFSD: Update the NFSv2 ACL GETATTR argument decoder
 to use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:55 -0500
Message-ID: <160986077591.5532.8940844074097535914.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since the ACL GETATTR procedure is the same as the normal GETATTR
procedure, simply re-use nfssvc_decode_fhandleargs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 123820ec79d3..0274348f6679 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -220,16 +220,6 @@ static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
-static int nfsaclsvc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nfsd_fhandle *argp = rqstp->rq_argp;
-
-	p = nfs2svc_decode_fh(p, &argp->fh);
-	if (!p)
-		return 0;
-	return xdr_argsize_check(rqstp, p);
-}
-
 static int nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_accessargs *argp = rqstp->rq_argp;
@@ -392,7 +382,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 	},
 	[ACLPROC2_GETATTR] = {
 		.pc_func = nfsacld_proc_getattr,
-		.pc_decode = nfsaclsvc_decode_fhandleargs,
+		.pc_decode = nfssvc_decode_fhandleargs,
 		.pc_encode = nfsaclsvc_encode_attrstatres,
 		.pc_release = nfsaclsvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),


