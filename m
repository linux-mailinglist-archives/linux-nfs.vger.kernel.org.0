Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6727319D
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgIUSLi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgIUSLf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:11:35 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB29C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:34 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so14712085ilp.5
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Dc+iGqjxL9+f5q/u0SjeHFWC/01f8kAwFCdaIZBvRmw=;
        b=VQcAYiEWHpwHzpSjmik/dRvBqtCc++ueR6g8REHpcP41Wyt2BIfe1APXczM4ZbGIpU
         Xruu8EEkXb5Xee7DHY3790XyzETtakE/UANaaklbfw2eXnfNl2P+vOMZbWW528ZXwmEx
         omFsgHk6WKMWrMMa079dQkHm5wPDmLSY8Gg8pionHPVSUCoMANoifw207HVfCGf5fOgf
         61EFuO+ppzggbu7IttObXKjBFGnqzc9mLRORumqRgsxHQRHL7ye3hBFQ2v94CGYFZB+1
         nzc+rbbsx2SfJf61h32qcRqsBCckzTmyPPXn6z+r3CmUAA11Fmf3IZ8WIVhPtCYJihsm
         A14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Dc+iGqjxL9+f5q/u0SjeHFWC/01f8kAwFCdaIZBvRmw=;
        b=qRNv8lq8PGI2GtT00f6zXYnmCXGqLk9WLEgzAI9j4/fxcIIcUxEuzgXSvbyM4T5GVz
         HLfBz6QKxGCHUEFmdjBUHUhBecBHYEvCQh5gFgalVS+FhfgE+giuZx9cT2BtfNUdEiJ0
         Ne0aW+X4luFMY8mE6PjQvhpSXHRc0PeC0kgDI5BnILF82rLlLSIHiez8e45bOXgBH2jy
         woZkRL9Xll1ytxHvGGakLhJeMh2iT6Ao9pC31/4e6AszWejbxizv3XnHU+kGvSTXX9Yi
         +XazaXsfGY1PE6MqT/+wc0mq0F93D8pvmvIkmdXGCyN3xiFxxPRBUHrJM4ByMFN3FQGR
         76Nw==
X-Gm-Message-State: AOAM531YUNkWeG7tm6Y4QBk/hO9AAG7htGB3fdN1Wx3OQ9/NET4FmN17
        ErWkwmF5GasChJorX2CJNXLVbN3XV4M=
X-Google-Smtp-Source: ABdhPJxSd46VvIdxx6KCgutb2KBkldkB6hLOPDZJwUd7dDXzpY0CVBU4KugvGtd94LKusN3s4ppGsA==
X-Received: by 2002:a92:c084:: with SMTP id h4mr1152068ile.6.1600711893782;
        Mon, 21 Sep 2020 11:11:33 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f21sm6158815ioh.1.2020.09.21.11.11.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:11:33 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIBWO5003866;
        Mon, 21 Sep 2020 18:11:32 GMT
Subject: [PATCH v2 08/27] SUNRPC: Make trace_svc_process() display the RPC
 procedure symbolically
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:11:32 -0400
Message-ID: <160071189204.1468.2344849490731145227.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A long-requested feature to help make RPC trace logs more human-
readable.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c           |   21 +++++++++++++++++++++
 fs/lockd/svcproc.c            |   21 +++++++++++++++++++++
 fs/nfs/callback_xdr.c         |    2 ++
 fs/nfsd/nfs2acl.c             |    5 +++++
 fs/nfsd/nfs3acl.c             |    3 +++
 fs/nfsd/nfs3proc.c            |   22 ++++++++++++++++++++++
 fs/nfsd/nfs4proc.c            |    2 ++
 fs/nfsd/nfsproc.c             |   18 ++++++++++++++++++
 include/linux/sunrpc/svc.h    |    1 +
 include/trace/events/sunrpc.h |    8 ++++++--
 10 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 77a00c105b03..ea761a8a0844 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -506,6 +506,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "NULL",
 	},
 	[NLMPROC_TEST] = {
 		.pc_func = nlm4svc_proc_test,
@@ -514,6 +515,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
+		.pc_name = "TEST",
 	},
 	[NLMPROC_LOCK] = {
 		.pc_func = nlm4svc_proc_lock,
@@ -522,6 +524,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "LOCK",
 	},
 	[NLMPROC_CANCEL] = {
 		.pc_func = nlm4svc_proc_cancel,
@@ -530,6 +533,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "CANCEL",
 	},
 	[NLMPROC_UNLOCK] = {
 		.pc_func = nlm4svc_proc_unlock,
@@ -538,6 +542,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "UNLOCK",
 	},
 	[NLMPROC_GRANTED] = {
 		.pc_func = nlm4svc_proc_granted,
@@ -546,6 +551,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "GRANTED",
 	},
 	[NLMPROC_TEST_MSG] = {
 		.pc_func = nlm4svc_proc_test_msg,
@@ -554,6 +560,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_MSG",
 	},
 	[NLMPROC_LOCK_MSG] = {
 		.pc_func = nlm4svc_proc_lock_msg,
@@ -562,6 +569,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlm4svc_proc_cancel_msg,
@@ -570,6 +578,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_MSG",
 	},
 	[NLMPROC_UNLOCK_MSG] = {
 		.pc_func = nlm4svc_proc_unlock_msg,
@@ -578,6 +587,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_MSG",
 	},
 	[NLMPROC_GRANTED_MSG] = {
 		.pc_func = nlm4svc_proc_granted_msg,
@@ -586,6 +596,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_MSG",
 	},
 	[NLMPROC_TEST_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -594,6 +605,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_RES",
 	},
 	[NLMPROC_LOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -602,6 +614,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_RES",
 	},
 	[NLMPROC_CANCEL_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -610,6 +623,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_RES",
 	},
 	[NLMPROC_UNLOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -618,6 +632,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_RES",
 	},
 	[NLMPROC_GRANTED_RES] = {
 		.pc_func = nlm4svc_proc_granted_res,
@@ -626,6 +641,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlm4svc_proc_sm_notify,
@@ -634,6 +650,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "SM_NOTIFY",
 	},
 	[ 17 /* unused procedure */ ] = {
 		.pc_func = nlm4svc_proc_null,
@@ -666,6 +683,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "SHARE",
 	},
 	[NLMPROC_UNSHARE] = {
 		.pc_func = nlm4svc_proc_unshare,
@@ -674,6 +692,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "UNSHARE",
 	},
 	[NLMPROC_NM_LOCK] = {
 		.pc_func = nlm4svc_proc_nm_lock,
@@ -682,6 +701,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "NM_LOCK",
 	},
 	[NLMPROC_FREE_ALL] = {
 		.pc_func = nlm4svc_proc_free_all,
@@ -690,5 +710,6 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "FREE_ALL",
 	},
 };
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 9b369e377f40..c9c83aeb831c 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -548,6 +548,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "NULL",
 	},
 	[NLMPROC_TEST] = {
 		.pc_func = nlmsvc_proc_test,
@@ -556,6 +557,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
+		.pc_name = "TEST",
 	},
 	[NLMPROC_LOCK] = {
 		.pc_func = nlmsvc_proc_lock,
@@ -564,6 +566,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "LOCK",
 	},
 	[NLMPROC_CANCEL] = {
 		.pc_func = nlmsvc_proc_cancel,
@@ -572,6 +575,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "CANCEL",
 	},
 	[NLMPROC_UNLOCK] = {
 		.pc_func = nlmsvc_proc_unlock,
@@ -580,6 +584,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "UNLOCK",
 	},
 	[NLMPROC_GRANTED] = {
 		.pc_func = nlmsvc_proc_granted,
@@ -588,6 +593,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "GRANTED",
 	},
 	[NLMPROC_TEST_MSG] = {
 		.pc_func = nlmsvc_proc_test_msg,
@@ -596,6 +602,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_MSG",
 	},
 	[NLMPROC_LOCK_MSG] = {
 		.pc_func = nlmsvc_proc_lock_msg,
@@ -604,6 +611,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlmsvc_proc_cancel_msg,
@@ -612,6 +620,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_MSG",
 	},
 	[NLMPROC_UNLOCK_MSG] = {
 		.pc_func = nlmsvc_proc_unlock_msg,
@@ -620,6 +629,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_MSG",
 	},
 	[NLMPROC_GRANTED_MSG] = {
 		.pc_func = nlmsvc_proc_granted_msg,
@@ -628,6 +638,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_MSG",
 	},
 	[NLMPROC_TEST_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -636,6 +647,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_RES",
 	},
 	[NLMPROC_LOCK_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -644,6 +656,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_RES",
 	},
 	[NLMPROC_CANCEL_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -652,6 +665,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_RES",
 	},
 	[NLMPROC_UNLOCK_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -660,6 +674,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_RES",
 	},
 	[NLMPROC_GRANTED_RES] = {
 		.pc_func = nlmsvc_proc_granted_res,
@@ -668,6 +683,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlmsvc_proc_sm_notify,
@@ -676,6 +692,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "SM_NOTIFY",
 	},
 	[ 17 /* unused procedure */ ] = {
 		.pc_func = nlmsvc_proc_null,
@@ -708,6 +725,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "SHARE",
 	},
 	[NLMPROC_UNSHARE] = {
 		.pc_func = nlmsvc_proc_unshare,
@@ -716,6 +734,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "UNSHARE",
 	},
 	[NLMPROC_NM_LOCK] = {
 		.pc_func = nlmsvc_proc_nm_lock,
@@ -724,6 +743,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "NM_LOCK",
 	},
 	[NLMPROC_FREE_ALL] = {
 		.pc_func = nlmsvc_proc_free_all,
@@ -732,5 +752,6 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
+		.pc_name = "FREE_ALL",
 	},
 };
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 79ff172eb1c8..c5348ba81129 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -1060,6 +1060,7 @@ static const struct svc_procedure nfs4_callback_procedures1[] = {
 		.pc_decode = nfs4_decode_void,
 		.pc_encode = nfs4_encode_void,
 		.pc_xdrressize = 1,
+		.pc_name = "NULL",
 	},
 	[CB_COMPOUND] = {
 		.pc_func = nfs4_callback_compound,
@@ -1067,6 +1068,7 @@ static const struct svc_procedure nfs4_callback_procedures1[] = {
 		.pc_argsize = 256,
 		.pc_ressize = 256,
 		.pc_xdrressize = NFS4_CALLBACK_BUFSIZE,
+		.pc_name = "COMPOUND",
 	}
 };
 
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 8d20e0d74417..54e597918822 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -362,6 +362,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd3_voidargs),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[ACLPROC2_GETACL] = {
 		.pc_func = nfsacld_proc_getacl,
@@ -372,6 +373,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
+		.pc_name = "GETACL",
 	},
 	[ACLPROC2_SETACL] = {
 		.pc_func = nfsacld_proc_setacl,
@@ -382,6 +384,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "SETACL",
 	},
 	[ACLPROC2_GETATTR] = {
 		.pc_func = nfsacld_proc_getattr,
@@ -392,6 +395,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "GETATTR",
 	},
 	[ACLPROC2_ACCESS] = {
 		.pc_func = nfsacld_proc_access,
@@ -402,6 +406,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd3_accessres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT+1,
+		.pc_name = "SETATTR",
 	},
 };
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 292acb2e529c..7f512dec7460 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -250,6 +250,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_ressize = sizeof(struct nfsd3_voidargs),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[ACLPROC3_GETACL] = {
 		.pc_func = nfsd3_proc_getacl,
@@ -260,6 +261,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
+		.pc_name = "GETACL",
 	},
 	[ACLPROC3_SETACL] = {
 		.pc_func = nfsd3_proc_setacl,
@@ -270,6 +272,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_ressize = sizeof(struct nfsd3_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT,
+		.pc_name = "SETACL",
 	},
 };
 
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 288bc76b4574..02f6bb6d749e 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -721,6 +721,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[NFS3PROC_GETATTR] = {
 		.pc_func = nfsd3_proc_getattr,
@@ -731,6 +732,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_attrstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "GETATTR",
 	},
 	[NFS3PROC_SETATTR] = {
 		.pc_func = nfsd3_proc_setattr,
@@ -741,6 +743,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
+		.pc_name = "SETATTR",
 	},
 	[NFS3PROC_LOOKUP] = {
 		.pc_func = nfsd3_proc_lookup,
@@ -751,6 +754,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_diropres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+FH+pAT+pAT,
+		.pc_name = "LOOKUP",
 	},
 	[NFS3PROC_ACCESS] = {
 		.pc_func = nfsd3_proc_access,
@@ -761,6 +765,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_accessres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+1,
+		.pc_name = "ACCESS",
 	},
 	[NFS3PROC_READLINK] = {
 		.pc_func = nfsd3_proc_readlink,
@@ -771,6 +776,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+1+NFS3_MAXPATHLEN/4,
+		.pc_name = "READLINK",
 	},
 	[NFS3PROC_READ] = {
 		.pc_func = nfsd3_proc_read,
@@ -781,6 +787,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_readres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+4+NFSSVC_MAXBLKSIZE/4,
+		.pc_name = "READ",
 	},
 	[NFS3PROC_WRITE] = {
 		.pc_func = nfsd3_proc_write,
@@ -791,6 +798,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_writeres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC+4,
+		.pc_name = "WRITE",
 	},
 	[NFS3PROC_CREATE] = {
 		.pc_func = nfsd3_proc_create,
@@ -801,6 +809,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "CREATE",
 	},
 	[NFS3PROC_MKDIR] = {
 		.pc_func = nfsd3_proc_mkdir,
@@ -811,6 +820,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "MKDIR",
 	},
 	[NFS3PROC_SYMLINK] = {
 		.pc_func = nfsd3_proc_symlink,
@@ -821,6 +831,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "SYMLINK",
 	},
 	[NFS3PROC_MKNOD] = {
 		.pc_func = nfsd3_proc_mknod,
@@ -831,6 +842,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "MKNOD",
 	},
 	[NFS3PROC_REMOVE] = {
 		.pc_func = nfsd3_proc_remove,
@@ -841,6 +853,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
+		.pc_name = "REMOVE",
 	},
 	[NFS3PROC_RMDIR] = {
 		.pc_func = nfsd3_proc_rmdir,
@@ -851,6 +864,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
+		.pc_name = "RMDIR",
 	},
 	[NFS3PROC_RENAME] = {
 		.pc_func = nfsd3_proc_rename,
@@ -861,6 +875,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_renameres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC+WC,
+		.pc_name = "RENAME",
 	},
 	[NFS3PROC_LINK] = {
 		.pc_func = nfsd3_proc_link,
@@ -871,6 +886,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_linkres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+pAT+WC,
+		.pc_name = "LINK",
 	},
 	[NFS3PROC_READDIR] = {
 		.pc_func = nfsd3_proc_readdir,
@@ -880,6 +896,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_argsize = sizeof(struct nfsd3_readdirargs),
 		.pc_ressize = sizeof(struct nfsd3_readdirres),
 		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "READDIR",
 	},
 	[NFS3PROC_READDIRPLUS] = {
 		.pc_func = nfsd3_proc_readdirplus,
@@ -889,6 +906,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_argsize = sizeof(struct nfsd3_readdirplusargs),
 		.pc_ressize = sizeof(struct nfsd3_readdirres),
 		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "READDIRPLUS",
 	},
 	[NFS3PROC_FSSTAT] = {
 		.pc_func = nfsd3_proc_fsstat,
@@ -898,6 +916,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_fsstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+2*6+1,
+		.pc_name = "FSSTAT",
 	},
 	[NFS3PROC_FSINFO] = {
 		.pc_func = nfsd3_proc_fsinfo,
@@ -907,6 +926,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_fsinfores),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+12,
+		.pc_name = "FSINFO",
 	},
 	[NFS3PROC_PATHCONF] = {
 		.pc_func = nfsd3_proc_pathconf,
@@ -916,6 +936,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_pathconfres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+6,
+		.pc_name = "PATHCONF",
 	},
 	[NFS3PROC_COMMIT] = {
 		.pc_func = nfsd3_proc_commit,
@@ -926,6 +947,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_commitres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+WC+2,
+		.pc_name = "COMMIT",
 	},
 };
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eaf50eafa935..e89a51ed2bbf 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3284,6 +3284,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_ressize = sizeof(struct nfsd4_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 1,
+		.pc_name = "NULL",
 	},
 	[NFSPROC4_COMPOUND] = {
 		.pc_func = nfsd4_proc_compound,
@@ -3294,6 +3295,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_release = nfsd4_release_compoundargs,
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = NFSD_BUFSIZE/4,
+		.pc_name = "COMPOUND",
 	},
 };
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6e0b066480c5..fd78651bd21d 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -595,6 +595,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[NFSPROC_GETATTR] = {
 		.pc_func = nfsd_proc_getattr,
@@ -605,6 +606,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "GETATTR",
 	},
 	[NFSPROC_SETATTR] = {
 		.pc_func = nfsd_proc_setattr,
@@ -615,6 +617,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "SETATTR",
 	},
 	[NFSPROC_ROOT] = {
 		.pc_decode = nfssvc_decode_void,
@@ -623,6 +626,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "ROOT",
 	},
 	[NFSPROC_LOOKUP] = {
 		.pc_func = nfsd_proc_lookup,
@@ -633,6 +637,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+FH+AT,
+		.pc_name = "LOOKUP",
 	},
 	[NFSPROC_READLINK] = {
 		.pc_func = nfsd_proc_readlink,
@@ -642,6 +647,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+NFS_MAXPATHLEN/4,
+		.pc_name = "READLINK",
 	},
 	[NFSPROC_READ] = {
 		.pc_func = nfsd_proc_read,
@@ -652,6 +658,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_readres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4,
+		.pc_name = "READ",
 	},
 	[NFSPROC_WRITECACHE] = {
 		.pc_decode = nfssvc_decode_void,
@@ -660,6 +667,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "WRITECACHE",
 	},
 	[NFSPROC_WRITE] = {
 		.pc_func = nfsd_proc_write,
@@ -670,6 +678,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "WRITE",
 	},
 	[NFSPROC_CREATE] = {
 		.pc_func = nfsd_proc_create,
@@ -680,6 +689,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+FH+AT,
+		.pc_name = "CREATE",
 	},
 	[NFSPROC_REMOVE] = {
 		.pc_func = nfsd_proc_remove,
@@ -689,6 +699,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "REMOVE",
 	},
 	[NFSPROC_RENAME] = {
 		.pc_func = nfsd_proc_rename,
@@ -698,6 +709,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "RENAME",
 	},
 	[NFSPROC_LINK] = {
 		.pc_func = nfsd_proc_link,
@@ -707,6 +719,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "LINK",
 	},
 	[NFSPROC_SYMLINK] = {
 		.pc_func = nfsd_proc_symlink,
@@ -716,6 +729,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "SYMLINK",
 	},
 	[NFSPROC_MKDIR] = {
 		.pc_func = nfsd_proc_mkdir,
@@ -726,6 +740,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+FH+AT,
+		.pc_name = "MKDIR",
 	},
 	[NFSPROC_RMDIR] = {
 		.pc_func = nfsd_proc_rmdir,
@@ -735,6 +750,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "RMDIR",
 	},
 	[NFSPROC_READDIR] = {
 		.pc_func = nfsd_proc_readdir,
@@ -743,6 +759,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_argsize = sizeof(struct nfsd_readdirargs),
 		.pc_ressize = sizeof(struct nfsd_readdirres),
 		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "READDIR",
 	},
 	[NFSPROC_STATFS] = {
 		.pc_func = nfsd_proc_statfs,
@@ -752,6 +769,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_statfsres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+5,
+		.pc_name = "STATFS",
 	},
 };
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 386628b36bc7..56409c39c4a0 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -461,6 +461,7 @@ struct svc_procedure {
 	unsigned int		pc_ressize;	/* result struct size */
 	unsigned int		pc_cachetype;	/* cache info (NFS) */
 	unsigned int		pc_xdrressize;	/* maximum size of XDR reply */
+	const char *		pc_name;	/* for display */
 };
 
 /*
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index aac12f45bfb0..afe0ef534d7e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1336,6 +1336,7 @@ TRACE_EVENT(svc_process,
 		__field(u32, vers)
 		__field(u32, proc)
 		__string(service, name)
+		__string(procedure, rqst->rq_procinfo->pc_name)
 		__string(addr, rqst->rq_xprt ?
 			 rqst->rq_xprt->xpt_remotebuf : "(null)")
 	),
@@ -1345,13 +1346,16 @@ TRACE_EVENT(svc_process,
 		__entry->vers = rqst->rq_vers;
 		__entry->proc = rqst->rq_proc;
 		__assign_str(service, name);
+		__assign_str(procedure, rqst->rq_procinfo->pc_name);
 		__assign_str(addr, rqst->rq_xprt ?
 			     rqst->rq_xprt->xpt_remotebuf : "(null)");
 	),
 
-	TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%u",
+	TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%s",
 			__get_str(addr), __entry->xid,
-			__get_str(service), __entry->vers, __entry->proc)
+			__get_str(service), __entry->vers,
+			__get_str(procedure)
+	)
 );
 
 DECLARE_EVENT_CLASS(svc_rqst_event,


