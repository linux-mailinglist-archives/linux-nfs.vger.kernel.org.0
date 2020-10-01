Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4969E280A9C
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgJAW7F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW7F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:05 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626EEC0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:05 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 19so742417qtp.1
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zioICtC9vCTtZBt0tdx7q0OcMxkLYqm7M+yA+cOUA6k=;
        b=cE2RaZ6gMLFUFz1hDmqOG24Xoj+qMb4UMfq0zwvYw1EshYUvlLT7hjroMo1d93dycB
         v/Ji4Ubes/Z0aIVk0xVc1K9TJ0KjrRPE2PlDUcwvE/lKVA9HXnnWp0k300m2iEgjVTvN
         8idF91Fvoqzq/MtziPggLFW2z4KnUIgSNKy21BWptz5k4VB9dhapfrpVBEYhBbpAhoRn
         kTsAcGfxTR1WILLsCllIdwO9oSsTcN3GZvgLYho4NDbH3PjGFi6HcjxzAOI7iLZ/oe0G
         x+MIUoGYDI2VoJPC7fJ0lgT2e1CR9Mi550IAmrZnCqkvXcp4KNFy/5M20FTWrpR7oJ5R
         SmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zioICtC9vCTtZBt0tdx7q0OcMxkLYqm7M+yA+cOUA6k=;
        b=DWb2ioR9cY+8X9jnmGJYhCLPcR0b3HJMvL36+dFKK28jITVUlaUGFP+qz5kFYo3+Rv
         wxOjhagG3dwYLShsfDwHLF0fX63U8mdVkWnjvjf3+uCahRYWOkLo/L2nnH/TmpPUZmEA
         W4hb2z4BWurWmk5nx45LA94CBiRyYzwl7Kik5KFJChjYi1HhllcqoqlmaAY1RZVjujJY
         RPCGY5dC6XgwmlTkXW2dGgOYQdNtHyBt81S8I+9Wi8hQXmUpAcIjHfg5sTgNZXBMbiOK
         NTDSTJXeTjMXfQpMMdp22NWFBMfUxQugvMol9nHWI0AyHRzXyPRcxa5DlhjLoQcZAa0e
         ccww==
X-Gm-Message-State: AOAM533e4F7c3Sk702s1J+g6X2jxsaL0ftPWV9czWY9pf7KSPeU9ZJ8e
        1iTPEao0mUXMMhXoUoqlRHGY6qHRwu99UA==
X-Google-Smtp-Source: ABdhPJyn+i+tYiwUlAnc9g94bC/kogYGxWPbJSa9l7GtEEGl1w+XqlXpCpa9nKHzUc9O+ewAO0fwlA==
X-Received: by 2002:ac8:7413:: with SMTP id p19mr10285386qtq.347.1601593144002;
        Thu, 01 Oct 2020 15:59:04 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c11sm8807449qkb.58.2020.10.01.15.59.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:03 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091Mx2xF032571;
        Thu, 1 Oct 2020 22:59:02 GMT
Subject: [PATCH v3 03/15] lockd: Replace PROC() macro with open code
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:02 -0400
Message-ID: <160159314225.79253.17664584554897715259.stgit@klimt.1015granger.net>
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
the lockd code. To reduce the chance of error, I copied the original
C preprocessor output and then made some minor edits.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c |  248 +++++++++++++++++++++++++++++++++++++++++----------
 fs/lockd/svcproc.c  |  250 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 398 insertions(+), 100 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index e4d3f783e06a..fa41dda39925 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -486,65 +486,215 @@ nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
         return rpc_success;
 }
 
+static __be32
+nlm4svc_proc_unused(struct svc_rqst *rqstp)
+{
+	return rpc_proc_unavail;
+}
+
 
 /*
  * NLM Server procedures.
  */
 
-#define nlm4svc_encode_norep	nlm4svc_encode_void
-#define nlm4svc_decode_norep	nlm4svc_decode_void
-#define nlm4svc_decode_testres	nlm4svc_decode_void
-#define nlm4svc_decode_lockres	nlm4svc_decode_void
-#define nlm4svc_decode_unlockres	nlm4svc_decode_void
-#define nlm4svc_decode_cancelres	nlm4svc_decode_void
-#define nlm4svc_decode_grantedres	nlm4svc_decode_void
-
-#define nlm4svc_proc_none	nlm4svc_proc_null
-#define nlm4svc_proc_test_res	nlm4svc_proc_null
-#define nlm4svc_proc_lock_res	nlm4svc_proc_null
-#define nlm4svc_proc_cancel_res	nlm4svc_proc_null
-#define nlm4svc_proc_unlock_res	nlm4svc_proc_null
-
 struct nlm_void			{ int dummy; };
 
-#define PROC(name, xargt, xrest, argt, rest, respsize)	\
- { .pc_func	= nlm4svc_proc_##name,	\
-   .pc_decode	= nlm4svc_decode_##xargt,	\
-   .pc_encode	= nlm4svc_encode_##xrest,	\
-   .pc_release	= NULL,					\
-   .pc_argsize	= sizeof(struct nlm_##argt),		\
-   .pc_ressize	= sizeof(struct nlm_##rest),		\
-   .pc_xdrressize = respsize,				\
- }
 #define	Ck	(1+XDR_QUADLEN(NLM_MAXCOOKIELEN))	/* cookie */
 #define	No	(1+1024/4)				/* netobj */
 #define	St	1					/* status */
 #define	Rg	4					/* range (offset + length) */
-const struct svc_procedure nlmsvc_procedures4[] = {
-  PROC(null,		void,		void,		void,	void, 1),
-  PROC(test,		testargs,	testres,	args,	res, Ck+St+2+No+Rg),
-  PROC(lock,		lockargs,	res,		args,	res, Ck+St),
-  PROC(cancel,		cancargs,	res,		args,	res, Ck+St),
-  PROC(unlock,		unlockargs,	res,		args,	res, Ck+St),
-  PROC(granted,		testargs,	res,		args,	res, Ck+St),
-  PROC(test_msg,	testargs,	norep,		args,	void, 1),
-  PROC(lock_msg,	lockargs,	norep,		args,	void, 1),
-  PROC(cancel_msg,	cancargs,	norep,		args,	void, 1),
-  PROC(unlock_msg,	unlockargs,	norep,		args,	void, 1),
-  PROC(granted_msg,	testargs,	norep,		args,	void, 1),
-  PROC(test_res,	testres,	norep,		res,	void, 1),
-  PROC(lock_res,	lockres,	norep,		res,	void, 1),
-  PROC(cancel_res,	cancelres,	norep,		res,	void, 1),
-  PROC(unlock_res,	unlockres,	norep,		res,	void, 1),
-  PROC(granted_res,	res,		norep,		res,	void, 1),
-  /* statd callback */
-  PROC(sm_notify,	reboot,		void,		reboot,	void, 1),
-  PROC(none,		void,		void,		void,	void, 0),
-  PROC(none,		void,		void,		void,	void, 0),
-  PROC(none,		void,		void,		void,	void, 0),
-  PROC(share,		shareargs,	shareres,	args,	res, Ck+St+1),
-  PROC(unshare,		shareargs,	shareres,	args,	res, Ck+St+1),
-  PROC(nm_lock,		lockargs,	res,		args,	res, Ck+St),
-  PROC(free_all,	notify,		void,		args,	void, 1),
 
+const struct svc_procedure nlmsvc_procedures4[24] = {
+	[NLMPROC_NULL] = {
+		.pc_func = nlm4svc_proc_null,
+		.pc_decode = nlm4svc_decode_void,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_void),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_TEST] = {
+		.pc_func = nlm4svc_proc_test,
+		.pc_decode = nlm4svc_decode_testargs,
+		.pc_encode = nlm4svc_encode_testres,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St+2+No+Rg,
+	},
+	[NLMPROC_LOCK] = {
+		.pc_func = nlm4svc_proc_lock,
+		.pc_decode = nlm4svc_decode_lockargs,
+		.pc_encode = nlm4svc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_CANCEL] = {
+		.pc_func = nlm4svc_proc_cancel,
+		.pc_decode = nlm4svc_decode_cancargs,
+		.pc_encode = nlm4svc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_UNLOCK] = {
+		.pc_func = nlm4svc_proc_unlock,
+		.pc_decode = nlm4svc_decode_unlockargs,
+		.pc_encode = nlm4svc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_GRANTED] = {
+		.pc_func = nlm4svc_proc_granted,
+		.pc_decode = nlm4svc_decode_testargs,
+		.pc_encode = nlm4svc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_TEST_MSG] = {
+		.pc_func = nlm4svc_proc_test_msg,
+		.pc_decode = nlm4svc_decode_testargs,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_LOCK_MSG] = {
+		.pc_func = nlm4svc_proc_lock_msg,
+		.pc_decode = nlm4svc_decode_lockargs,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_CANCEL_MSG] = {
+		.pc_func = nlm4svc_proc_cancel_msg,
+		.pc_decode = nlm4svc_decode_cancargs,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_UNLOCK_MSG] = {
+		.pc_func = nlm4svc_proc_unlock_msg,
+		.pc_decode = nlm4svc_decode_unlockargs,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_GRANTED_MSG] = {
+		.pc_func = nlm4svc_proc_granted_msg,
+		.pc_decode = nlm4svc_decode_testargs,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_TEST_RES] = {
+		.pc_func = nlm4svc_proc_null,
+		.pc_decode = nlm4svc_decode_void,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_LOCK_RES] = {
+		.pc_func = nlm4svc_proc_null,
+		.pc_decode = nlm4svc_decode_void,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_CANCEL_RES] = {
+		.pc_func = nlm4svc_proc_null,
+		.pc_decode = nlm4svc_decode_void,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_UNLOCK_RES] = {
+		.pc_func = nlm4svc_proc_null,
+		.pc_decode = nlm4svc_decode_void,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_GRANTED_RES] = {
+		.pc_func = nlm4svc_proc_granted_res,
+		.pc_decode = nlm4svc_decode_res,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_NSM_NOTIFY] = {
+		.pc_func = nlm4svc_proc_sm_notify,
+		.pc_decode = nlm4svc_decode_reboot,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_reboot),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[17] = {
+		.pc_func = nlm4svc_proc_unused,
+		.pc_decode = nlm4svc_decode_void,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_void),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = 0,
+	},
+	[18] = {
+		.pc_func = nlm4svc_proc_unused,
+		.pc_decode = nlm4svc_decode_void,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_void),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = 0,
+	},
+	[19] = {
+		.pc_func = nlm4svc_proc_unused,
+		.pc_decode = nlm4svc_decode_void,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_void),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = 0,
+	},
+	[NLMPROC_SHARE] = {
+		.pc_func = nlm4svc_proc_share,
+		.pc_decode = nlm4svc_decode_shareargs,
+		.pc_encode = nlm4svc_encode_shareres,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St+1,
+	},
+	[NLMPROC_UNSHARE] = {
+		.pc_func = nlm4svc_proc_unshare,
+		.pc_decode = nlm4svc_decode_shareargs,
+		.pc_encode = nlm4svc_encode_shareres,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St+1,
+	},
+	[NLMPROC_NM_LOCK] = {
+		.pc_func = nlm4svc_proc_nm_lock,
+		.pc_decode = nlm4svc_decode_lockargs,
+		.pc_encode = nlm4svc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_FREE_ALL] = {
+		.pc_func = nlm4svc_proc_free_all,
+		.pc_decode = nlm4svc_decode_notify,
+		.pc_encode = nlm4svc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
 };
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index d0bb7a6bf005..50855f2c1f4b 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -529,66 +529,214 @@ nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+static __be32
+nlmsvc_proc_unused(struct svc_rqst *rqstp)
+{
+	return rpc_proc_unavail;
+}
+
 /*
  * NLM Server procedures.
  */
 
-#define nlmsvc_encode_norep	nlmsvc_encode_void
-#define nlmsvc_decode_norep	nlmsvc_decode_void
-#define nlmsvc_decode_testres	nlmsvc_decode_void
-#define nlmsvc_decode_lockres	nlmsvc_decode_void
-#define nlmsvc_decode_unlockres	nlmsvc_decode_void
-#define nlmsvc_decode_cancelres	nlmsvc_decode_void
-#define nlmsvc_decode_grantedres	nlmsvc_decode_void
-
-#define nlmsvc_proc_none	nlmsvc_proc_null
-#define nlmsvc_proc_test_res	nlmsvc_proc_null
-#define nlmsvc_proc_lock_res	nlmsvc_proc_null
-#define nlmsvc_proc_cancel_res	nlmsvc_proc_null
-#define nlmsvc_proc_unlock_res	nlmsvc_proc_null
-
 struct nlm_void			{ int dummy; };
 
-#define PROC(name, xargt, xrest, argt, rest, respsize)	\
- { .pc_func	= nlmsvc_proc_##name,			\
-   .pc_decode	= nlmsvc_decode_##xargt,		\
-   .pc_encode	= nlmsvc_encode_##xrest,		\
-   .pc_release	= NULL,					\
-   .pc_argsize	= sizeof(struct nlm_##argt),		\
-   .pc_ressize	= sizeof(struct nlm_##rest),		\
-   .pc_xdrressize = respsize,				\
- }
-
 #define	Ck	(1+XDR_QUADLEN(NLM_MAXCOOKIELEN))	/* cookie */
 #define	St	1				/* status */
 #define	No	(1+1024/4)			/* Net Obj */
 #define	Rg	2				/* range - offset + size */
 
-const struct svc_procedure nlmsvc_procedures[] = {
-  PROC(null,		void,		void,		void,	void, 1),
-  PROC(test,		testargs,	testres,	args,	res, Ck+St+2+No+Rg),
-  PROC(lock,		lockargs,	res,		args,	res, Ck+St),
-  PROC(cancel,		cancargs,	res,		args,	res, Ck+St),
-  PROC(unlock,		unlockargs,	res,		args,	res, Ck+St),
-  PROC(granted,		testargs,	res,		args,	res, Ck+St),
-  PROC(test_msg,	testargs,	norep,		args,	void, 1),
-  PROC(lock_msg,	lockargs,	norep,		args,	void, 1),
-  PROC(cancel_msg,	cancargs,	norep,		args,	void, 1),
-  PROC(unlock_msg,	unlockargs,	norep,		args,	void, 1),
-  PROC(granted_msg,	testargs,	norep,		args,	void, 1),
-  PROC(test_res,	testres,	norep,		res,	void, 1),
-  PROC(lock_res,	lockres,	norep,		res,	void, 1),
-  PROC(cancel_res,	cancelres,	norep,		res,	void, 1),
-  PROC(unlock_res,	unlockres,	norep,		res,	void, 1),
-  PROC(granted_res,	res,		norep,		res,	void, 1),
-  /* statd callback */
-  PROC(sm_notify,	reboot,		void,		reboot,	void, 1),
-  PROC(none,		void,		void,		void,	void, 1),
-  PROC(none,		void,		void,		void,	void, 1),
-  PROC(none,		void,		void,		void,	void, 1),
-  PROC(share,		shareargs,	shareres,	args,	res, Ck+St+1),
-  PROC(unshare,		shareargs,	shareres,	args,	res, Ck+St+1),
-  PROC(nm_lock,		lockargs,	res,		args,	res, Ck+St),
-  PROC(free_all,	notify,		void,		args,	void, 0),
-
+const struct svc_procedure nlmsvc_procedures[24] = {
+	[NLMPROC_NULL] = {
+		.pc_func = nlmsvc_proc_null,
+		.pc_decode = nlmsvc_decode_void,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_void),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_TEST] = {
+		.pc_func = nlmsvc_proc_test,
+		.pc_decode = nlmsvc_decode_testargs,
+		.pc_encode = nlmsvc_encode_testres,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St+2+No+Rg,
+	},
+	[NLMPROC_LOCK] = {
+		.pc_func = nlmsvc_proc_lock,
+		.pc_decode = nlmsvc_decode_lockargs,
+		.pc_encode = nlmsvc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_CANCEL] = {
+		.pc_func = nlmsvc_proc_cancel,
+		.pc_decode = nlmsvc_decode_cancargs,
+		.pc_encode = nlmsvc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_UNLOCK] = {
+		.pc_func = nlmsvc_proc_unlock,
+		.pc_decode = nlmsvc_decode_unlockargs,
+		.pc_encode = nlmsvc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_GRANTED] = {
+		.pc_func = nlmsvc_proc_granted,
+		.pc_decode = nlmsvc_decode_testargs,
+		.pc_encode = nlmsvc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_TEST_MSG] = {
+		.pc_func = nlmsvc_proc_test_msg,
+		.pc_decode = nlmsvc_decode_testargs,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_LOCK_MSG] = {
+		.pc_func = nlmsvc_proc_lock_msg,
+		.pc_decode = nlmsvc_decode_lockargs,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_CANCEL_MSG] = {
+		.pc_func = nlmsvc_proc_cancel_msg,
+		.pc_decode = nlmsvc_decode_cancargs,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_UNLOCK_MSG] = {
+		.pc_func = nlmsvc_proc_unlock_msg,
+		.pc_decode = nlmsvc_decode_unlockargs,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_GRANTED_MSG] = {
+		.pc_func = nlmsvc_proc_granted_msg,
+		.pc_decode = nlmsvc_decode_testargs,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_TEST_RES] = {
+		.pc_func = nlmsvc_proc_null,
+		.pc_decode = nlmsvc_decode_void,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_LOCK_RES] = {
+		.pc_func = nlmsvc_proc_null,
+		.pc_decode = nlmsvc_decode_void,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_CANCEL_RES] = {
+		.pc_func = nlmsvc_proc_null,
+		.pc_decode = nlmsvc_decode_void,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_UNLOCK_RES] = {
+		.pc_func = nlmsvc_proc_null,
+		.pc_decode = nlmsvc_decode_void,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_GRANTED_RES] = {
+		.pc_func = nlmsvc_proc_granted_res,
+		.pc_decode = nlmsvc_decode_res,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_NSM_NOTIFY] = {
+		.pc_func = nlmsvc_proc_sm_notify,
+		.pc_decode = nlmsvc_decode_reboot,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_reboot),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[17] = {
+		.pc_func = nlmsvc_proc_unused,
+		.pc_decode = nlmsvc_decode_void,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_void),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[18] = {
+		.pc_func = nlmsvc_proc_unused,
+		.pc_decode = nlmsvc_decode_void,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_void),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[19] = {
+		.pc_func = nlmsvc_proc_unused,
+		.pc_decode = nlmsvc_decode_void,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_void),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = St,
+	},
+	[NLMPROC_SHARE] = {
+		.pc_func = nlmsvc_proc_share,
+		.pc_decode = nlmsvc_decode_shareargs,
+		.pc_encode = nlmsvc_encode_shareres,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St+1,
+	},
+	[NLMPROC_UNSHARE] = {
+		.pc_func = nlmsvc_proc_unshare,
+		.pc_decode = nlmsvc_decode_shareargs,
+		.pc_encode = nlmsvc_encode_shareres,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St+1,
+	},
+	[NLMPROC_NM_LOCK] = {
+		.pc_func = nlmsvc_proc_nm_lock,
+		.pc_decode = nlmsvc_decode_lockargs,
+		.pc_encode = nlmsvc_encode_res,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_res),
+		.pc_xdrressize = Ck+St,
+	},
+	[NLMPROC_FREE_ALL] = {
+		.pc_func = nlmsvc_proc_free_all,
+		.pc_decode = nlmsvc_decode_notify,
+		.pc_encode = nlmsvc_encode_void,
+		.pc_argsize = sizeof(struct nlm_args),
+		.pc_ressize = sizeof(struct nlm_void),
+		.pc_xdrressize = 0,
+	},
 };


