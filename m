Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBBA2BB7BB
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgKTUnv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgKTUnu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:50 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DF3C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:50 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id k4so10185173qko.13
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eVTye5HyUNzpAddxFydTGaBmTZSEbiKT2LU4PvE5LZg=;
        b=mGzffmBUXtNStWmukTvXZ+9U7KSTTDk71u3bYs6+g5AwrapqBIg3xQ/CXTSCPUjGlN
         7lSsKbqQQ8P8Hi2eiHJepxAWj9ZBLxu/f9NUwNI3ev+ZllEJNSpBe658aiR4C6OuzIGO
         Sy9Nrjrs+q5XTQYeI8tMjvqOA6fCSuHtm5r55E5I0nZV90OxyDB6MNgByY/Vr0FmGFhi
         220hjiRtkD5zaYswcIW4FNLO7f46oKOPgjsHeWdY/95tt21IhyFNXCQfY5RwiRclIC73
         LAKjulkbjq6q9psq24jkxVZBEbj56X6QJpWTc0ca2p+w4HUc9r2BbTQZJ0dc6OlHEgqi
         Jyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eVTye5HyUNzpAddxFydTGaBmTZSEbiKT2LU4PvE5LZg=;
        b=irm8C9n8/RpG/HELjPmRPDQtjTZSHrt2MVr7b0tQKCI2nBb9gvZaFw9kmLll9TUcwl
         qYZG0OPDIbe+6jxyrW/VMqpVdQDyVIB0O7v37yA+bGpLd5GtAOCEzzx9uLJbAv4RKEjj
         NKEG+07WrTIX+lPMDWQ2I/OhppdG5zQRU7E1KJRPyDHapr4kxb5fN6Ee8S/0Yy1mkhhX
         XPjGxgRkEWZBy4dgZ+Jt+d11fXcPtfbIVYTfJfb9eDB1rqVcs1SalyBhDt0yuqOcPmnO
         bC/EC21GYdq/fjRLPaYZ0u73IDTO3x59tm07YtWNmrpkfS1LrNxOdzzDRQW8hrSbyVsY
         qqbw==
X-Gm-Message-State: AOAM530YQnKfG8/tlRdcywSx5TQ+o7UX40pRWqstoIkrQR3W7hLGTB30
        onQPaw2rgCKsRbLFC6vYQzD0Nh/0yD0=
X-Google-Smtp-Source: ABdhPJypOZOcAieY7ip/kpHQ2WB5g+eofOfYdlFbyQLR3TXfISwoFy6zAJWrUoRsYpuXZVKEQ/dv5A==
X-Received: by 2002:ae9:f40d:: with SMTP id y13mr2745214qkl.124.1605905029467;
        Fri, 20 Nov 2020 12:43:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v14sm2853317qkb.15.2020.11.20.12.43.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:48 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhlcD029553
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:47 GMT
Subject: [PATCH v2 113/118] NFSD: Update the NFSv2 ACL GETATTR argument
 decoder to use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:47 -0500
Message-ID: <160590502759.1340.15213412028314306507.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index 2e44b56e33ad..bc5303f654e5 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -220,16 +220,6 @@ static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 	return XDR_DECODE_DONE;
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
@@ -389,7 +379,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 	},
 	[ACLPROC2_GETATTR] = {
 		.pc_func = nfsacld_proc_getattr,
-		.pc_decode = nfsaclsvc_decode_fhandleargs,
+		.pc_decode = nfssvc_decode_fhandleargs,
 		.pc_encode = nfsaclsvc_encode_attrstatres,
 		.pc_release = nfsaclsvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),


