Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD527D076
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgI2ODz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2ODz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:03:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9BEC061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:03:55 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c5so4963828ilk.11
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AziyCTg3ikJfk50903sKb1UZF3qV939G6EeX6uDucTA=;
        b=OUgS/KirPI4G5pARvg6jpvbFjO526tUlTWc2BDmLN6Q4s3R2Wihflsnn9RsJ0EEeEy
         XEAn4Oky/xRQWLFqbI9zgEp8Bx547gNzROk433qK5BIjAZdiHTOrlDvWJvvmq8HkkqiY
         5qohC8oB+D10a2RSZX3cwxXGHI9qFinlLpe5E0WW85LD9LwXx6QAehwBaWvAahBITRsI
         cIKXU1/0x/WWQaIr+j+w/YKxcsI55e/4wr+rylIDj+ee1y5IVWUgMbyAP7GW4yQRH+NL
         VOsQjy5rhMaGnfIimq8PYyXtuuAX5lDzPlYm9KZ9sjfOYdmcfMOU8uAfuYoZ9DldOGRX
         V8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AziyCTg3ikJfk50903sKb1UZF3qV939G6EeX6uDucTA=;
        b=ArbzA0fmieII5fdMS7CbZI7j2DsT9MHC8bp/BaKiY2KxMtebtXlVk/TnhZ8GE+k/Gi
         SFcCJGQLYckLbIoNfbFTD/EP/gxSLlnDeV535BJUhjn4hJlHxOTQPWaqkb2J2KXy75kr
         S4T58pQBJhpra/XKwXTtRys3JEK5M3nER2di8Tr8nzVZw13UtEQTDgS/L5FbGPLmGeV1
         lA88/c59ZdQuxj45G5rrUUqVErQwko/9BlR6b+J6oplsofVk30bncIYcja4V4vWuSXj9
         qiCm3iMGUr6+wRbEOZ+WgCknY582ZSd0jaf8ZayXSXRGFk1+X7JYXmstdTw0hlFvoZw+
         jBBA==
X-Gm-Message-State: AOAM531juqWOkH78rybTD+44hjCDKnNWnmbHkbWt7GxXhCMgrU3sNo5o
        KJSc6lC6g026LmFlsCVgOaKIeNyUov5AtQ==
X-Google-Smtp-Source: ABdhPJwMYy/gmaM5DTGobf21b8DBViH0FZu8r2yUH2NT6BdofydWXAo0TacVP9m9EHOpLZba3X8VhA==
X-Received: by 2002:a92:d48c:: with SMTP id p12mr3014651ilg.283.1601388234796;
        Tue, 29 Sep 2020 07:03:54 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c15sm2492743ilr.54.2020.09.29.07.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:03:54 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE3r0F026421;
        Tue, 29 Sep 2020 14:03:53 GMT
Subject: [PATCH v2 03/11] NFSACL: Replace PROC() macro with open code
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:03:53 -0400
Message-ID: <160138823303.2558.3709695094022164879.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
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
 


