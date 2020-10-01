Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6413B280A9D
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgJAW7M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW7M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E801C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c18so708612qtw.5
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AziyCTg3ikJfk50903sKb1UZF3qV939G6EeX6uDucTA=;
        b=MCW3R1plgPeJ3f3A+L6hYqQnUuP5sAa1+mY6ATjnXWXrLzEPZB7fhvI6hw9xl8KtC/
         2UWKQfo+bkYdyq8p6WqvQeYlC8Clq9v2P0ED/FWRlVTaaBakB/LJYcNNUcMhrIoZXpQs
         z5AQUZFrHYb+2JlUfV3+x7GX+L7iIhk3pzwn7G3K0wChWnWOHLGTwyC6oXeLtQjLQp7k
         atyuIt/+UM8eMjAVC5WKxjYEkBYz061tRhTVbnLCec3I+xqnMNOnXJas/toJYalio997
         e1oiwVtn1kKwN3YnZRIZapULdzkKmi4itScm8t1BIajVr4w/RqBLsXa54PPWlDr9g3YL
         lA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AziyCTg3ikJfk50903sKb1UZF3qV939G6EeX6uDucTA=;
        b=BrKNI/ymYB1yfVz0zMcaqg5S1NM88gFS/NIJIXu8GwVBe683dQ56kjgO5llAFD0oDm
         5DTNu18RDGn12TrR5mWujAigCqA07oAuzppJ1HiaE6rhCYg9E66lEZaHwPIfaSr9fKNL
         W/4301pYm/WJmOi8ljdVkOgzr4L0wbxlAVaLQGIglCkkh01rDnJwUyM+sqRohF46lcf+
         uPs/Nk7XxE5AsqQ7ohg2vjS6iTgSKF0MNogsvnlIqCq4yUDJHQAua4vB9lK5bw4JeGBB
         6uccAK3e4BXeX5iNT1QJpoNCeUkxeVfuUE8k6fXLVb5c0FypjMhl6Kg1M9MUEg9BQ8kc
         3m4A==
X-Gm-Message-State: AOAM531+g5WUjwoEhriDyLYwB8Bvc/SOX0i2CKAhowaiHiWut7Qf8czt
        /OX4MVhrzM7h02JNXCQyp/oqh8QvE/3slg==
X-Google-Smtp-Source: ABdhPJym/PMofqae+ge4MU+Wl67wtJwO12+sdnHNfYwDD+q8uOHeB1bUMjeqVwYkeBVO/sHrN7kYCQ==
X-Received: by 2002:ac8:142:: with SMTP id f2mr9845915qtg.191.1601593149246;
        Thu, 01 Oct 2020 15:59:09 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n1sm8312187qte.91.2020.10.01.15.59.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:08 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091Mx7lo032574;
        Thu, 1 Oct 2020 22:59:07 GMT
Subject: [PATCH v3 04/15] NFSACL: Replace PROC() macro with open code
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:07 -0400
Message-ID: <160159314755.79253.12467142530224826977.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Follow-up on ten-year-old commit b9081d90f5b9 ("NFS: kill
off complicated macro 'PROC'") by performing the same conversion in
the NFSACL code. To reduce the chance of error, I copied the original
C preprocessor output and then made some minor edits.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c           |   72 +++++++++++++++++++++++++++++--------------
 fs/nfsd/nfs3acl.c           |   49 +++++++++++++++++------------
 include/uapi/linux/nfsacl.h |    2 +
 3 files changed, 80 insertions(+), 43 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index cbab1d2d8a75..8d20e0d74417 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -347,36 +347,62 @@ static void nfsaclsvc_release_access(struct svc_rqst *rqstp)
 	fh_put(&resp->fh);
 }
 
-#define nfsaclsvc_decode_voidargs	NULL
-#define nfsaclsvc_release_void		NULL
-#define nfsd3_fhandleargs	nfsd_fhandle
-#define nfsd3_attrstatres	nfsd_attrstat
-#define nfsd3_voidres		nfsd3_voidargs
 struct nfsd3_voidargs { int dummy; };
 
-#define PROC(name, argt, rest, relt, cache, respsize)			\
-{									\
-	.pc_func	= nfsacld_proc_##name,				\
-	.pc_decode	= nfsaclsvc_decode_##argt##args,		\
-	.pc_encode	= nfsaclsvc_encode_##rest##res,			\
-	.pc_release	= nfsaclsvc_release_##relt,	\
-	.pc_argsize	= sizeof(struct nfsd3_##argt##args),		\
-	.pc_ressize	= sizeof(struct nfsd3_##rest##res),		\
-	.pc_cachetype	= cache,					\
-	.pc_xdrressize	= respsize,					\
-}
-
 #define ST 1		/* status*/
 #define AT 21		/* attributes */
 #define pAT (1+AT)	/* post attributes - conditional */
 #define ACL (1+NFS_ACL_MAX_ENTRIES*3)  /* Access Control List */
 
-static const struct svc_procedure nfsd_acl_procedures2[] = {
-  PROC(null,	void,		void,		void,	  RC_NOCACHE, ST),
-  PROC(getacl,	getacl,		getacl,		getacl,	  RC_NOCACHE, ST+1+2*(1+ACL)),
-  PROC(setacl,	setacl,		attrstat,	attrstat, RC_NOCACHE, ST+AT),
-  PROC(getattr, fhandle,	attrstat,	attrstat, RC_NOCACHE, ST+AT),
-  PROC(access,	access,		access,		access,   RC_NOCACHE, ST+AT+1),
+static const struct svc_procedure nfsd_acl_procedures2[5] = {
+	[ACLPROC2_NULL] = {
+		.pc_func = nfsacld_proc_null,
+		.pc_encode = nfsaclsvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd3_voidargs),
+		.pc_ressize = sizeof(struct nfsd3_voidargs),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST,
+	},
+	[ACLPROC2_GETACL] = {
+		.pc_func = nfsacld_proc_getacl,
+		.pc_decode = nfsaclsvc_decode_getaclargs,
+		.pc_encode = nfsaclsvc_encode_getaclres,
+		.pc_release = nfsaclsvc_release_getacl,
+		.pc_argsize = sizeof(struct nfsd3_getaclargs),
+		.pc_ressize = sizeof(struct nfsd3_getaclres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST+1+2*(1+ACL),
+	},
+	[ACLPROC2_SETACL] = {
+		.pc_func = nfsacld_proc_setacl,
+		.pc_decode = nfsaclsvc_decode_setaclargs,
+		.pc_encode = nfsaclsvc_encode_attrstatres,
+		.pc_release = nfsaclsvc_release_attrstat,
+		.pc_argsize = sizeof(struct nfsd3_setaclargs),
+		.pc_ressize = sizeof(struct nfsd_attrstat),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST+AT,
+	},
+	[ACLPROC2_GETATTR] = {
+		.pc_func = nfsacld_proc_getattr,
+		.pc_decode = nfsaclsvc_decode_fhandleargs,
+		.pc_encode = nfsaclsvc_encode_attrstatres,
+		.pc_release = nfsaclsvc_release_attrstat,
+		.pc_argsize = sizeof(struct nfsd_fhandle),
+		.pc_ressize = sizeof(struct nfsd_attrstat),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST+AT,
+	},
+	[ACLPROC2_ACCESS] = {
+		.pc_func = nfsacld_proc_access,
+		.pc_decode = nfsaclsvc_decode_accessargs,
+		.pc_encode = nfsaclsvc_encode_accessres,
+		.pc_release = nfsaclsvc_release_access,
+		.pc_argsize = sizeof(struct nfsd3_accessargs),
+		.pc_ressize = sizeof(struct nfsd3_accessres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST+AT+1,
+	},
 };
 
 static unsigned int nfsd_acl_count2[ARRAY_SIZE(nfsd_acl_procedures2)];
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 13bca4a2f89d..292acb2e529c 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -235,33 +235,42 @@ static void nfs3svc_release_getacl(struct svc_rqst *rqstp)
 	posix_acl_release(resp->acl_default);
 }
 
-#define nfs3svc_decode_voidargs		NULL
-#define nfs3svc_release_void		NULL
-#define nfsd3_setaclres			nfsd3_attrstat
-#define nfsd3_voidres			nfsd3_voidargs
 struct nfsd3_voidargs { int dummy; };
 
-#define PROC(name, argt, rest, relt, cache, respsize)			\
-{									\
-	.pc_func	= nfsd3_proc_##name,				\
-	.pc_decode	= nfs3svc_decode_##argt##args,			\
-	.pc_encode	= nfs3svc_encode_##rest##res,			\
-	.pc_release	= nfs3svc_release_##relt,			\
-	.pc_argsize	= sizeof(struct nfsd3_##argt##args),		\
-	.pc_ressize	= sizeof(struct nfsd3_##rest##res),		\
-	.pc_cachetype	= cache,					\
-	.pc_xdrressize	= respsize,					\
-}
-
 #define ST 1		/* status*/
 #define AT 21		/* attributes */
 #define pAT (1+AT)	/* post attributes - conditional */
 #define ACL (1+NFS_ACL_MAX_ENTRIES*3)  /* Access Control List */
 
-static const struct svc_procedure nfsd_acl_procedures3[] = {
-  PROC(null,	void,		void,		void,	  RC_NOCACHE, ST),
-  PROC(getacl,	getacl,		getacl,		getacl,	  RC_NOCACHE, ST+1+2*(1+ACL)),
-  PROC(setacl,	setacl,		setacl,		fhandle,  RC_NOCACHE, ST+pAT),
+static const struct svc_procedure nfsd_acl_procedures3[3] = {
+	[ACLPROC3_NULL] = {
+		.pc_func = nfsd3_proc_null,
+		.pc_encode = nfs3svc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd3_voidargs),
+		.pc_ressize = sizeof(struct nfsd3_voidargs),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST,
+	},
+	[ACLPROC3_GETACL] = {
+		.pc_func = nfsd3_proc_getacl,
+		.pc_decode = nfs3svc_decode_getaclargs,
+		.pc_encode = nfs3svc_encode_getaclres,
+		.pc_release = nfs3svc_release_getacl,
+		.pc_argsize = sizeof(struct nfsd3_getaclargs),
+		.pc_ressize = sizeof(struct nfsd3_getaclres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST+1+2*(1+ACL),
+	},
+	[ACLPROC3_SETACL] = {
+		.pc_func = nfsd3_proc_setacl,
+		.pc_decode = nfs3svc_decode_setaclargs,
+		.pc_encode = nfs3svc_encode_setaclres,
+		.pc_release = nfs3svc_release_fhandle,
+		.pc_argsize = sizeof(struct nfsd3_setaclargs),
+		.pc_ressize = sizeof(struct nfsd3_attrstat),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST+pAT,
+	},
 };
 
 static unsigned int nfsd_acl_count3[ARRAY_SIZE(nfsd_acl_procedures3)];
diff --git a/include/uapi/linux/nfsacl.h b/include/uapi/linux/nfsacl.h
index ca9a8501ff30..2c2ad204d3b0 100644
--- a/include/uapi/linux/nfsacl.h
+++ b/include/uapi/linux/nfsacl.h
@@ -9,11 +9,13 @@
 
 #define NFS_ACL_PROGRAM	100227
 
+#define ACLPROC2_NULL		0
 #define ACLPROC2_GETACL		1
 #define ACLPROC2_SETACL		2
 #define ACLPROC2_GETATTR	3
 #define ACLPROC2_ACCESS		4
 
+#define ACLPROC3_NULL		0
 #define ACLPROC3_GETACL		1
 #define ACLPROC3_SETACL		2
 


