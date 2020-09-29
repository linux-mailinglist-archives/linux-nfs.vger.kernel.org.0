Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4307727D077
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgI2OEB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2OEA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:04:00 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEA2C061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g128so4884710iof.11
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fBOle0GGHEvax1nzjwHqgeMatP9Vtf9Rs51uOSV0YEs=;
        b=TONLrPXx44VRIu/aejTRKhd2ixC5OdLfe46sigEN4jNba3Wvn2ktkXOhAC15uWWY4a
         tY/Ev2cb7HKfI5LYPRUN+FmxxY1afYSQniBxnoDMvH65rD1lBE8U3KbXxjJMo3zMVzWE
         RcsNrpNAQwxm4GRVQLRUMHX4w2xzXlGMn6C2VN70zkZXIW47zlp9U6dSTZQOT70rFRrd
         ABQlaJ5pYw7JhyO/WYbBq/llJIQziE6koQLwsdVCquxQk7EVi3jU4N6Xvn8cENHUF/zm
         RQP/OKm68xYV4sqDlMF/ojx6qpGr9VsMCF4ITUiVIUMiJBFOsKnsI23iZOAyB4wwQED4
         n06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=fBOle0GGHEvax1nzjwHqgeMatP9Vtf9Rs51uOSV0YEs=;
        b=n/mVxXMXJf2oOk1IGBWHq+89rNFXH8bFhrQogjXgtn2Ehvwx2IGaOij/lqCXbC1/Do
         aQlWej411RDddk8MqP2HCyerN85grvbNO8oAoWAwDOzFWz3d6thpsVAt+cgd2Btjs40Z
         /iASqJSd69G7ZNZBxaKLqK1qiNxTQRqtmF7suIDm5+t16uOcjp2JxtvJwe1I0L8S/rBI
         F2poZhw/tZhCQncx2hUMHW0IFjle3qRsn8I8gZNZ6eizsGzy4xGMs3dk3GV6ZroMdKW8
         XWmoZ9kQNDkIGE0/VjkUCPl1/HjoWfNCUKbjJQ9S9iPNIKqYQohc0jeYqOj5q9kM10nh
         yiZQ==
X-Gm-Message-State: AOAM530EpDtA+qkGiK8U2y6wVs6EAwmNPzRvJKBIwYSXpjrQr0Eahh5Z
        d8UTaAULr3nZR/vjPl2IYCvCvhSPs8/VJw==
X-Google-Smtp-Source: ABdhPJy7s0bO7jmWaDVia+/wGal6io0SaFznnUpoACGMnmETlxJonsiC0IzCV/BtgiN0XvtyKujiSw==
X-Received: by 2002:a05:6602:2b03:: with SMTP id p3mr2655312iov.28.1601388240113;
        Tue, 29 Sep 2020 07:04:00 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f21sm1768206ioh.1.2020.09.29.07.03.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:03:59 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE3wua026424;
        Tue, 29 Sep 2020 14:03:58 GMT
Subject: [PATCH v2 04/11] NFSD: Encoder and decoder functions are always
 present
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:03:58 -0400
Message-ID: <160138823834.2558.5938482077630311658.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_dispatch() is a hot path. Let's optimize the XDR method calls
for the by-far common case, which is that the methods are indeed
present.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c  |    6 ++++++
 fs/nfsd/nfs3acl.c  |    1 +
 fs/nfsd/nfs3proc.c |    1 +
 fs/nfsd/nfs3xdr.c  |    6 ++++++
 fs/nfsd/nfs4proc.c |    1 +
 fs/nfsd/nfs4xdr.c  |    6 ++++++
 fs/nfsd/nfssvc.c   |    5 ++---
 fs/nfsd/xdr3.h     |    1 +
 fs/nfsd/xdr4.h     |    1 +
 9 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 8d20e0d74417..3c8b9250dc4a 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -183,6 +183,11 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 /*
  * XDR decode functions
  */
+static int nfsaclsvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
+{
+	return 1;
+}
+
 static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_getaclargs *argp = rqstp->rq_argp;
@@ -357,6 +362,7 @@ struct nfsd3_voidargs { int dummy; };
 static const struct svc_procedure nfsd_acl_procedures2[5] = {
 	[ACLPROC2_NULL] = {
 		.pc_func = nfsacld_proc_null,
+		.pc_decode = nfsaclsvc_decode_voidarg,
 		.pc_encode = nfsaclsvc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd3_voidargs),
 		.pc_ressize = sizeof(struct nfsd3_voidargs),
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 292acb2e529c..614168675c17 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -245,6 +245,7 @@ struct nfsd3_voidargs { int dummy; };
 static const struct svc_procedure nfsd_acl_procedures3[3] = {
 	[ACLPROC3_NULL] = {
 		.pc_func = nfsd3_proc_null,
+		.pc_decode = nfs3svc_decode_voidarg,
 		.pc_encode = nfs3svc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd3_voidargs),
 		.pc_ressize = sizeof(struct nfsd3_voidargs),
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 288bc76b4574..3d09959c7042 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -716,6 +716,7 @@ struct nfsd3_voidargs { int dummy; };
 static const struct svc_procedure nfsd_procedures3[22] = {
 	[NFS3PROC_NULL] = {
 		.pc_func = nfsd3_proc_null,
+		.pc_decode = nfs3svc_decode_voidarg,
 		.pc_encode = nfs3svc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd3_voidargs),
 		.pc_ressize = sizeof(struct nfsd3_voidres),
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index aae514d40b64..e540fd1a29d8 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -304,6 +304,12 @@ void fill_post_wcc(struct svc_fh *fhp)
 /*
  * XDR decode functions
  */
+int
+nfs3svc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
+{
+	return 1;
+}
+
 int
 nfs3svc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p)
 {
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eaf50eafa935..b99c050797db 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3279,6 +3279,7 @@ struct nfsd4_voidargs { int dummy; };
 static const struct svc_procedure nfsd_procedures4[2] = {
 	[NFSPROC4_NULL] = {
 		.pc_func = nfsd4_proc_null,
+		.pc_decode = nfs4svc_decode_voidarg,
 		.pc_encode = nfs4svc_encode_voidres,
 		.pc_argsize = sizeof(struct nfsd4_voidargs),
 		.pc_ressize = sizeof(struct nfsd4_voidres),
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f14d90a95fe3..758d8154a5b3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5156,6 +5156,12 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 	}
 }
 
+int
+nfs4svc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
+{
+	return 1;
+}
+
 int
 nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f6bc94cab9da..b2d20920a998 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1022,8 +1022,7 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
 	/* Decode arguments */
-	if (proc->pc_decode &&
-	    !proc->pc_decode(rqstp, (__be32*)rqstp->rq_arg.head[0].iov_base)) {
+	if (!proc->pc_decode(rqstp, (__be32 *)rqstp->rq_arg.head[0].iov_base)) {
 		dprintk("nfsd: failed to decode arguments!\n");
 		*statp = rpc_garbage_args;
 		return 1;
@@ -1062,7 +1061,7 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * For NFSv2, additional info is never returned in case of an error.
 	 */
 	if (!(nfserr && rqstp->rq_vers == 2)) {
-		if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp)) {
+		if (!proc->pc_encode(rqstp, nfserrp)) {
 			/* Failed to encode result. Release cache entry */
 			dprintk("nfsd: failed to encode result!\n");
 			nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 4155fd71714c..ae6fa6c9cb46 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -273,6 +273,7 @@ union nfsd3_xdrstore {
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
 
+int nfs3svc_decode_voidarg(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_fhandle(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_sattrargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_diropargs(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 66499fb6b567..679d40af1bbb 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -781,6 +781,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
+int nfs4svc_decode_voidarg(struct svc_rqst *, __be32 *);
 int nfs4svc_encode_voidres(struct svc_rqst *, __be32 *);
 int nfs4svc_decode_compoundargs(struct svc_rqst *, __be32 *);
 int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *);


