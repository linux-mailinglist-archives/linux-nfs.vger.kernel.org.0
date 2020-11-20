Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261CC2BB78D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgKTUlW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgKTUlV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:21 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664F7C061A04
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:21 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id z17so5298793qvy.11
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=w54Di6aQJXYcC47cTVvuB25exFlgjYN0swGOqbGN0Ww=;
        b=iujlnzikXQ2gwg8U3j5YbHTQC9EMflQyHqDAec8esBX/uqAAHpCylB+b9GhkZ8Tjc2
         Q8Mi2SnvuoOnDhp4z50SbXRAGKUASskeyZSFs/Re2FcmJCtQIasBbIc9dY5mCiV/+dwJ
         CsNW0nGNJRjb3f433YmJnkQEC58yrCcWZEB91Pqq+fDuulZLpiqOj4ZbWo9eUr8AJusc
         AV2uVChnu5Y6QyU0ZA2P5xbZP7g66SoI9U+hZ2iEZgo01rlfnZ8qXj5jO+mur6VfGeO+
         4eu5OZg54QdoCcHeWT3ZtBKCckNsmkMQN1jCtNjCVDKZ1mqDJ1Bwhjo7Te1ttmVVpAcO
         vwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=w54Di6aQJXYcC47cTVvuB25exFlgjYN0swGOqbGN0Ww=;
        b=gCtqYdemQpsXzLJj5M87QRsLD7Ej/xaQHNQ4b6RLL6aI5siWndadh2PtwcXXUEivYA
         5CUcj50cKTop/usPb1+whRilcAkzQO0EJjoYJ/TrBWH7aSRAgwkvbgUSno8HuelMfgQt
         rkkaOjniD0cer9Y/QGe5n8vDBoHP33zubJ5/qvMfpC6RjUS/tRsdAk1ToxWlOt2hO2dZ
         fRiT091unCEZRW1+PZvFr3Zvf7wxkKquj0SyFIQO+f4VB5f1G1kJSRWOse0FRxPQfIbR
         OuVAuSYieoteZFBZjG0RN5lL2vaCAPNvUi+g4b9q35u6YC1MsjRTKA5mS781mxGNoxEY
         0sSg==
X-Gm-Message-State: AOAM531ZIlXNuRWavQmWd+E9r8pdzUyJZdqHhc7N8gyBPwZx67fFmx9G
        iEpHf79ByAdaTt5czMax5FYE7lJ46Pw=
X-Google-Smtp-Source: ABdhPJwFu83TcKdlGRsbu2ssZ4GkpVFZwDhnVM4508axDnAfK+6y3M+6Zp/siN456cL3REv+gzXjGA==
X-Received: by 2002:a0c:8d47:: with SMTP id s7mr8347808qvb.17.1605904880292;
        Fri, 20 Nov 2020 12:41:20 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p127sm2867998qkc.37.2020.11.20.12.41.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:19 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKfIvI029468
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:18 GMT
Subject: [PATCH v2 085/118] NFSD: Update READLINK3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:18 -0500
Message-ID: <160590487851.1340.4645888597133004475.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index 5c0664486485..2c4fe7b8723d 100644
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
 
@@ -764,10 +765,10 @@ static const struct svc_procedure nfsd_procedures3[22] = {
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
index 38dad447a760..35804abc9c1f 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -537,19 +537,6 @@ nfs3svc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
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


