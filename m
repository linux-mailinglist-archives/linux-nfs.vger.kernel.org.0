Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7D280A9E
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgJAW7Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW7P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB33C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x201so7812654qkb.11
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2O81hYTHVswuplqXBygADsXUGICvs+B6ctiTQXFDGJY=;
        b=SdU+h8ZKKToY+LJw+L9nmajwJOI3cvC+IxuY8jHcFl+yKEBK3TvOZgTGqJ6SxdeWpW
         I8Cg7Xx4NhkcHnPAFrgeM8mePRTXNt6oTmV0SMduZbT73tOqOA4MQzY/FNCtk0ZeVWiB
         0njiFt24b+n0JmCNY7850nUyXLp0NdhdcLwbXkLL8Rwl/tq/5zGAjqXf5zc8rmwzNLkC
         FPicdRrjb/YugrmH+id2iN9KmykIy4obdzcuhWPG0tiqFubizyBpXmTJt3K4d4N1oydc
         hhxD9/wFTDboBloSzQxpDXHugsZrePRal/KUmEEJyZZfHpdz1YV+Ak8bCwp5r1KuK6j8
         rblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2O81hYTHVswuplqXBygADsXUGICvs+B6ctiTQXFDGJY=;
        b=KMW54yYJT9UmCfIXaYVqJPlYx1izSPX/86oLHDUsMOaUj+2OJ4zto8Ay9q1bLnMcM6
         Y/E4K5SmCt0qA+ToNW1f/h5DvxQAhqwmEvREtPysk9/LI44aOTZtcL58NsUQHNd6Tsv3
         8mns80fidWPuI9d4ccCPcSNt2i8sZVhCQcWtqgATg8V1xVSNE/JhhqqtDDCJmYTnIP97
         LBPfIXuFh3fTdGdk9SZeth6It8WOtX4bXElbcfHHmCNL5k+ALq4T9zbTdch9OQbpig1F
         oEnIbwUAx9LspqfeJJDt/EyijX3/qQQgr5cOsCbP28JQFSoNq6o+NTNvAUGHjc3qWnp4
         VWaw==
X-Gm-Message-State: AOAM530u5+ooX86pmrtHgw9BwoHT6s9y9DHJXL7xcssfO4BW8oQTXOUZ
        O0MeIiodJ3TwQSB06X6h3ZCZvIawtOy0Jg==
X-Google-Smtp-Source: ABdhPJxiKRqWeRahBffHgAxiK13kqFJ7jHvp2vLQuR5sJ2Oa3gMdMnEE1iZ5EmtVTvneuvA+UuAqiQ==
X-Received: by 2002:a37:ef14:: with SMTP id j20mr10219016qkk.101.1601593154584;
        Thu, 01 Oct 2020 15:59:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k185sm7875484qkd.94.2020.10.01.15.59.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:13 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MxC7O032577;
        Thu, 1 Oct 2020 22:59:12 GMT
Subject: [PATCH v3 05/15] NFSD: Encoder and decoder functions are always
 present
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:12 -0400
Message-ID: <160159315285.79253.4554438390305260147.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_dispatch() is a hot path. Let's optimize the XDR method calls
for the by-far common case, which is that the XDR methods are indeed
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


