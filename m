Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945812BB79A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbgKTUmZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbgKTUmZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:25 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A72C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:25 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id i12so8148686qtj.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bEZxlptV0LvDBiCsQ8pcnlXx7WPUts0bE6odT0CmY90=;
        b=FUb45V6xxM+O9ZayV2WbsDsw/UrD93T2o2Vla/mKfmqSghUr5mlzTc4W6XgTps50bd
         KapTbuCYH2s5sl/0d4KHeiv6K1yZBnX5IRmyffrtza6XpzOfyRiW2XdfNip/3JDQ7DmZ
         KGtRH0CxeGnOnWXNAB0bLvUlV0I9Dy52CmgnwNvapMU2u238WzfhP5y9fYN3HqyslJ4/
         9onBqhlnZCtX23EKDMvQxzfpR8nJ1CiWJdZcU/xmoODDik7W+yMboWYMAeCbPDDuOBpN
         RjWmuGpzWNUz/Ts0EoA5QQbTkUYlnNlZqmVSvAcMEClZHBcimmydLW3k3PWi+K2P/mD8
         sItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bEZxlptV0LvDBiCsQ8pcnlXx7WPUts0bE6odT0CmY90=;
        b=bkUiJGGqL5QQ1IiuAKHJ4ZMMMGwXpOYSd+qHqt93icafUA2CoVGH9jpDgHQhITEgk9
         TvMo50C+uveIMV8WwGpGkjikEvwdNMlvBefmWyzTaTKxPlsO6qxPyRPYS8tXjQJZgpoh
         7z8RMyuNKj9HIX3g3UZachPafYFb05dv1bgVJLfEKb++MByZHK47H/smmpD+MJym4hAg
         kVsfTQkdQN/CaYaYRm/8RlbWGHYjzVgJYKsGNQcMa0nC+lSAOIlETCgW+C1Ss40r2Gqi
         YwaAZbjyr0lqXUDkw+cwxfpwzjOdcieGHVnxL3L1e9elNGLIrloBKM556hPJh61ox4h9
         7kvQ==
X-Gm-Message-State: AOAM532szBP8HyJfpfJPXFdn7dEBF0mHC1hHgLqTImJI2t1+1ttKQVS0
        Bg44SGA1XNJz4QZn0sc++K0bAcz6S2o=
X-Google-Smtp-Source: ABdhPJz3o4qFAYY70dUCHozBqDTlX+EdXAPK2eg48oEBK+vnDTlg5/y39O16p8uF8yV7F2zicGkkBw==
X-Received: by 2002:ac8:4252:: with SMTP id r18mr17666661qtm.26.1605904944188;
        Fri, 20 Nov 2020 12:42:24 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y192sm2980284qkb.12.2020.11.20.12.42.23
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:23 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgM50029504
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:22 GMT
Subject: [PATCH v2 097/118] NFSD: Update the NFSv2 GETATTR argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:22 -0500
Message-ID: <160590494253.1340.2204577527335801278.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |    4 ++--
 fs/nfsd/nfsxdr.c  |   26 ++++++++++++++++++++------
 fs/nfsd/xdr.h     |    2 +-
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 9473d048efec..5b8436af43a9 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -626,7 +626,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 	[NFSPROC_GETATTR] = {
 		.pc_func = nfsd_proc_getattr,
-		.pc_decode = nfssvc_decode_fhandle,
+		.pc_decode = nfssvc_decode_fhandleargs,
 		.pc_encode = nfssvc_encode_attrstat,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
@@ -776,7 +776,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 	[NFSPROC_STATFS] = {
 		.pc_func = nfsd_proc_statfs,
-		.pc_decode = nfssvc_decode_fhandle,
+		.pc_decode = nfssvc_decode_fhandleargs,
 		.pc_encode = nfssvc_encode_statfsres,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_statfsres),
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 7aa6e8aca2c1..36765a96abae 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -23,8 +23,9 @@ static u32	nfs_ftypes[] = {
 
 
 /*
- * XDR functions for basic NFS types
+ * Basic NFSv2 data types (RFC 1094 Section 2.3)
  */
+
 static __be32 *
 decode_fh(__be32 *p, struct svc_fh *fhp)
 {
@@ -37,6 +38,21 @@ decode_fh(__be32 *p, struct svc_fh *fhp)
 	return p + (NFS_FHSIZE >> 2);
 }
 
+static enum xdr_decode_result
+svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, NFS_FHSIZE);
+	if (!p)
+		return XDR_DECODE_FAILED;
+	fh_init(fhp, NFS_FHSIZE);
+	memcpy(&fhp->fh_handle.fh_base, p, NFS_FHSIZE);
+	fhp->fh_handle.fh_size = NFS_FHSIZE;
+
+	return XDR_DECODE_DONE;
+}
+
 /* Helper function for NFSv2 ACL code */
 __be32 *nfs2svc_decode_fh(__be32 *p, struct svc_fh *fhp)
 {
@@ -194,14 +210,12 @@ __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *f
  */
 
 int
-nfssvc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_fhandle *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_fhandle(xdr, &args->fh);
 }
 
 int
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index ad77387734cc..84256a6a1ba1 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -144,7 +144,7 @@ union nfsd_xdrstore {
 #define NFS2_SVC_XDRSIZE	sizeof(union nfsd_xdrstore)
 
 
-int nfssvc_decode_fhandle(struct svc_rqst *, __be32 *);
+int nfssvc_decode_fhandleargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_sattrargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_diropargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_readargs(struct svc_rqst *, __be32 *);


