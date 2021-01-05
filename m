Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A562EAE4F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbhAEPaq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbhAEPaq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:30:46 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC9C0617A2
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:26 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v5so21034121qtv.7
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nqH4pO1Cnsm5uRCc488sXPf62GQEp80KVq1oMzCX/M0=;
        b=FCGfKJ5YrLFVGklKZeYb89YI+hvxhBgSF4oEEXu9t+IlQXoPC6lCgNx3fPI/H2Lnc9
         xs/24QWwGEA1zQo38eZ96oIVr9ePlsXlDu8FtFToi57kJxr400AHM+5wndQwNUcm7DOq
         ZrlFpCvuGS2cBE2ye6tnkiWxw9S7pmuPNMxD1ALuhtOiiDnd/Vp5FY+Kr6jdLDSVcG0S
         wbHkvX4SIY2QP+6DfH1FWq2tgS54zbgVwtKOpV9BflPF9ijPinXUTzJUS7kIcTEJLEj7
         2Wv7iLT0WkTtBpTc4nzUj0QGXwBsR40yfV+GFXs4gYRCMKglcM0pfIkT/YbaBeeQamls
         KZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nqH4pO1Cnsm5uRCc488sXPf62GQEp80KVq1oMzCX/M0=;
        b=GHSZnzE0mb2u2ppCp5R0FuMqSugaMXBbwAvFRt1EkmqB/UGn4Vmfb8rrCDnqUuPuOM
         TPPVaH7Us13ry9Oo8i6Z8veLmizgd9Sme6/INGeTRNkfC7fYS3lAsKtxJca//8nSDI3f
         3ArFE3HITNrPKFsddaVNysow6/Z60t4hbpwccoKk9ZV2nZ4fCHDmJea2jdl608rjHZJW
         tUSUN+9L+Go1e15/aq33BBw0C2WsFo1WE/4RM6UFApwSbdbUfJk5+5dy9ZDkSjaLEUC+
         vMuiZ2YqsZZBxFzbjr2h/w7grQ1SpwQuVQS8mW37HcYnciBRW5s5idi/ssDlA2FVF9ND
         u8bQ==
X-Gm-Message-State: AOAM530pqDUcmdhkm/FOjHKQ1FhCKNyz7pt/dW/xn/eqhMMpM8MIwVsU
        JM57vb6wL/p/Yeqf2uC/zGj4xUdu/ys=
X-Google-Smtp-Source: ABdhPJyinUhOPIRVdqzlW2xIQrDMd3jZe1P6KvFTqvSazsGJ87scnP1cRV0wut7kgNzZ/sQqpiIAGQ==
X-Received: by 2002:ac8:5c0e:: with SMTP id i14mr44184qti.328.1609860625016;
        Tue, 05 Jan 2021 07:30:25 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h26sm52036qtq.18.2021.01.05.07.30.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:24 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUNBm020844
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:23 GMT
Subject: [PATCH v1 08/42] NFSD: Update READLINK3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:23 -0500
Message-ID: <160986062340.5532.17166784261045454715.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFSv3 READLINK request takes a single filehandle, so it can
re-use GETATTR's decoder.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    9 +++++----
 fs/nfsd/nfs3xdr.c  |   13 -------------
 fs/nfsd/xdr3.h     |    6 ------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index acdf47179a38..9e289e0f439b 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -124,15 +124,16 @@ nfsd3_proc_access(struct svc_rqst *rqstp)
 static __be32
 nfsd3_proc_readlink(struct svc_rqst *rqstp)
 {
-	struct nfsd3_readlinkargs *argp = rqstp->rq_argp;
+	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
+	char *buffer = page_address(*(rqstp->rq_next_page++));
 
 	dprintk("nfsd: READLINK(3) %s\n", SVCFH_fmt(&argp->fh));
 
 	/* Read the symlink. */
 	fh_copy(&resp->fh, &argp->fh);
 	resp->len = NFS3_MAXPATHLEN;
-	resp->status = nfsd_readlink(rqstp, &resp->fh, argp->buffer, &resp->len);
+	resp->status = nfsd_readlink(rqstp, &resp->fh, buffer, &resp->len);
 	return rpc_success;
 }
 
@@ -768,10 +769,10 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 	},
 	[NFS3PROC_READLINK] = {
 		.pc_func = nfsd3_proc_readlink,
-		.pc_decode = nfs3svc_decode_readlinkargs,
+		.pc_decode = nfs3svc_decode_fhandleargs,
 		.pc_encode = nfs3svc_encode_readlinkres,
 		.pc_release = nfs3svc_release_fhandle,
-		.pc_argsize = sizeof(struct nfsd3_readlinkargs),
+		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd3_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+1+NFS3_MAXPATHLEN/4,
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0aafb096de91..db1d6ebf1353 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -543,19 +543,6 @@ nfs3svc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_argsize_check(rqstp, p);
 }
 
-int
-nfs3svc_decode_readlinkargs(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nfsd3_readlinkargs *args = rqstp->rq_argp;
-
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	args->buffer = page_address(*(rqstp->rq_next_page++));
-
-	return xdr_argsize_check(rqstp, p);
-}
-
 int
 nfs3svc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 {
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 7dfeeaa4e1df..08f909142ddf 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -70,11 +70,6 @@ struct nfsd3_renameargs {
 	unsigned int		tlen;
 };
 
-struct nfsd3_readlinkargs {
-	struct svc_fh		fh;
-	char *			buffer;
-};
-
 struct nfsd3_linkargs {
 	struct svc_fh		ffh;
 	struct svc_fh		tfh;
@@ -282,7 +277,6 @@ int nfs3svc_decode_createargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_mkdirargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_mknodargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_renameargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_readlinkargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_linkargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_readdirargs(struct svc_rqst *, __be32 *);


