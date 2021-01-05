Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8562EAE49
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbhAEPab (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbhAEPaa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:30:30 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B04FC061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:29:50 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g24so21029392qtq.12
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5N4FTn+TgpeoEyVCAU7XSKYvnvhJ/G4lnNXpgKpd1tM=;
        b=u59RGBEytHUWMc5xY3sTMhjQE6LP7OivOh67YIU46DZto1G5whSRCL2eMEMdu1R76F
         S7fpeUyLthAa4jIHq48Me1hZ4X8Q1vzgFqu9kBwV3lI21rSMVdCAyUdypBtFZt1MM4tW
         A+UR0xAj5+hIoz1AFcOji/pcgm8fFezRDjC5LJ0t0x7mYo15cNoOZA+pqQcus6zOW6A3
         TrlP44t0Pdx7GEF/SfTESh2KuaWuu8P8eSIFc3fn2VTQrRPBDZUILSgxYqdTN281dNIG
         lFJV0YDn3mKgL/qQEgQXXxdXHlLh2HQUeiIclrX60pSPkqdGFuOu0OfKIo9GkdMQRGWm
         3vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5N4FTn+TgpeoEyVCAU7XSKYvnvhJ/G4lnNXpgKpd1tM=;
        b=FW22XSxR5JNN7R/MKK8nPW+H/sKS18FHyii1dpFxm2v7LzWq0mzWDSLVLhcVqnhfJE
         SqEkSJYf/kZcCPXBSCcpmXgCQM96gJDvzcd9MzPCitb69CfHx1d3wyUJE2wzcuJA8peN
         Ky2WF3X5OrBNlhJE9s+t8itqx5yQOtg+UeTucfw8Qsbbc3C89pbGjl4/WQRuKxDrgeZv
         BF6Kos/AJ8MOHkM3xjJOTHFjL79cYe8BQjcWO2pHaAQmwSHznFW7twf3AQ6bM9FGZ+md
         EeCOv9PMOMzkoWOYMVILrbONr5ATEjDkBe+nV5X9cPij59KIFLbcdqFRwte3uWh2nbGC
         LKqQ==
X-Gm-Message-State: AOAM533H0s3dfW1uOPVaj3bU3hS+G4i5TBG1X13bdvGYxcafWnB9i+gv
        hAOn0difk+qVPR0kDKFLAOpAjcCa6g4=
X-Google-Smtp-Source: ABdhPJzxAQNqTO6yHeZpfFntG4JZ8436qQ0xNyrcgLclSiD7sNgDnzOxLc4IYGhHczLXfK+3vUqR0A==
X-Received: by 2002:aed:2ae2:: with SMTP id t89mr75408qtd.82.1609860588723;
        Tue, 05 Jan 2021 07:29:48 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 70sm166705qkk.10.2021.01.05.07.29.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:29:48 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FTkwo020814
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:29:46 GMT
Subject: [PATCH v1 01/42] SUNRPC: Make trace_svc_process() display the RPC
 procedure symbolically
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:29:46 -0500
Message-ID: <160986058682.5532.8737122728649327044.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The next few patches will employ these strings to help make server-
side trace logs more human-readable. A similar technique is already
in use in kernel RPC client code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c        |   24 ++++++++++++++++++++++++
 fs/lockd/svcproc.c         |   24 ++++++++++++++++++++++++
 fs/nfs/callback_xdr.c      |    2 ++
 fs/nfsd/nfs2acl.c          |    5 +++++
 fs/nfsd/nfs3acl.c          |    3 +++
 fs/nfsd/nfs3proc.c         |   22 ++++++++++++++++++++++
 fs/nfsd/nfs4proc.c         |    2 ++
 fs/nfsd/nfsproc.c          |   18 ++++++++++++++++++
 include/linux/sunrpc/svc.h |    1 +
 9 files changed, 101 insertions(+)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index fa41dda39925..4c10fb5138f1 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -512,6 +512,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "NULL",
 	},
 	[NLMPROC_TEST] = {
 		.pc_func = nlm4svc_proc_test,
@@ -520,6 +521,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
+		.pc_name = "TEST",
 	},
 	[NLMPROC_LOCK] = {
 		.pc_func = nlm4svc_proc_lock,
@@ -528,6 +530,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "LOCK",
 	},
 	[NLMPROC_CANCEL] = {
 		.pc_func = nlm4svc_proc_cancel,
@@ -536,6 +539,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "CANCEL",
 	},
 	[NLMPROC_UNLOCK] = {
 		.pc_func = nlm4svc_proc_unlock,
@@ -544,6 +548,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "UNLOCK",
 	},
 	[NLMPROC_GRANTED] = {
 		.pc_func = nlm4svc_proc_granted,
@@ -552,6 +557,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "GRANTED",
 	},
 	[NLMPROC_TEST_MSG] = {
 		.pc_func = nlm4svc_proc_test_msg,
@@ -560,6 +566,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_MSG",
 	},
 	[NLMPROC_LOCK_MSG] = {
 		.pc_func = nlm4svc_proc_lock_msg,
@@ -568,6 +575,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlm4svc_proc_cancel_msg,
@@ -576,6 +584,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_MSG",
 	},
 	[NLMPROC_UNLOCK_MSG] = {
 		.pc_func = nlm4svc_proc_unlock_msg,
@@ -584,6 +593,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_MSG",
 	},
 	[NLMPROC_GRANTED_MSG] = {
 		.pc_func = nlm4svc_proc_granted_msg,
@@ -592,6 +602,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_MSG",
 	},
 	[NLMPROC_TEST_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -600,6 +611,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_RES",
 	},
 	[NLMPROC_LOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -608,6 +620,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_RES",
 	},
 	[NLMPROC_CANCEL_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -616,6 +629,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_RES",
 	},
 	[NLMPROC_UNLOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
@@ -624,6 +638,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_RES",
 	},
 	[NLMPROC_GRANTED_RES] = {
 		.pc_func = nlm4svc_proc_granted_res,
@@ -632,6 +647,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlm4svc_proc_sm_notify,
@@ -640,6 +656,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "SM_NOTIFY",
 	},
 	[17] = {
 		.pc_func = nlm4svc_proc_unused,
@@ -648,6 +665,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
+		.pc_name = "UNUSED",
 	},
 	[18] = {
 		.pc_func = nlm4svc_proc_unused,
@@ -656,6 +674,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
+		.pc_name = "UNUSED",
 	},
 	[19] = {
 		.pc_func = nlm4svc_proc_unused,
@@ -664,6 +683,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
+		.pc_name = "UNUSED",
 	},
 	[NLMPROC_SHARE] = {
 		.pc_func = nlm4svc_proc_share,
@@ -672,6 +692,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "SHARE",
 	},
 	[NLMPROC_UNSHARE] = {
 		.pc_func = nlm4svc_proc_unshare,
@@ -680,6 +701,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "UNSHARE",
 	},
 	[NLMPROC_NM_LOCK] = {
 		.pc_func = nlm4svc_proc_nm_lock,
@@ -688,6 +710,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "NM_LOCK",
 	},
 	[NLMPROC_FREE_ALL] = {
 		.pc_func = nlm4svc_proc_free_all,
@@ -696,5 +719,6 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "FREE_ALL",
 	},
 };
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 50855f2c1f4b..4ae4b63b5392 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -554,6 +554,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "NULL",
 	},
 	[NLMPROC_TEST] = {
 		.pc_func = nlmsvc_proc_test,
@@ -562,6 +563,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
+		.pc_name = "TEST",
 	},
 	[NLMPROC_LOCK] = {
 		.pc_func = nlmsvc_proc_lock,
@@ -570,6 +572,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "LOCK",
 	},
 	[NLMPROC_CANCEL] = {
 		.pc_func = nlmsvc_proc_cancel,
@@ -578,6 +581,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "CANCEL",
 	},
 	[NLMPROC_UNLOCK] = {
 		.pc_func = nlmsvc_proc_unlock,
@@ -586,6 +590,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "UNLOCK",
 	},
 	[NLMPROC_GRANTED] = {
 		.pc_func = nlmsvc_proc_granted,
@@ -594,6 +599,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "GRANTED",
 	},
 	[NLMPROC_TEST_MSG] = {
 		.pc_func = nlmsvc_proc_test_msg,
@@ -602,6 +608,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_MSG",
 	},
 	[NLMPROC_LOCK_MSG] = {
 		.pc_func = nlmsvc_proc_lock_msg,
@@ -610,6 +617,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlmsvc_proc_cancel_msg,
@@ -618,6 +626,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_MSG",
 	},
 	[NLMPROC_UNLOCK_MSG] = {
 		.pc_func = nlmsvc_proc_unlock_msg,
@@ -626,6 +635,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_MSG",
 	},
 	[NLMPROC_GRANTED_MSG] = {
 		.pc_func = nlmsvc_proc_granted_msg,
@@ -634,6 +644,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_MSG",
 	},
 	[NLMPROC_TEST_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -642,6 +653,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "TEST_RES",
 	},
 	[NLMPROC_LOCK_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -650,6 +662,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "LOCK_RES",
 	},
 	[NLMPROC_CANCEL_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -658,6 +671,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "CANCEL_RES",
 	},
 	[NLMPROC_UNLOCK_RES] = {
 		.pc_func = nlmsvc_proc_null,
@@ -666,6 +680,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNLOCK_RES",
 	},
 	[NLMPROC_GRANTED_RES] = {
 		.pc_func = nlmsvc_proc_granted_res,
@@ -674,6 +689,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlmsvc_proc_sm_notify,
@@ -682,6 +698,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "SM_NOTIFY",
 	},
 	[17] = {
 		.pc_func = nlmsvc_proc_unused,
@@ -690,6 +707,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNUSED",
 	},
 	[18] = {
 		.pc_func = nlmsvc_proc_unused,
@@ -698,6 +716,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNUSED",
 	},
 	[19] = {
 		.pc_func = nlmsvc_proc_unused,
@@ -706,6 +725,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_void),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
+		.pc_name = "UNUSED",
 	},
 	[NLMPROC_SHARE] = {
 		.pc_func = nlmsvc_proc_share,
@@ -714,6 +734,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "SHARE",
 	},
 	[NLMPROC_UNSHARE] = {
 		.pc_func = nlmsvc_proc_unshare,
@@ -722,6 +743,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
+		.pc_name = "UNSHARE",
 	},
 	[NLMPROC_NM_LOCK] = {
 		.pc_func = nlmsvc_proc_nm_lock,
@@ -730,6 +752,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_argsize = sizeof(struct nlm_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
+		.pc_name = "NM_LOCK",
 	},
 	[NLMPROC_FREE_ALL] = {
 		.pc_func = nlmsvc_proc_free_all,
@@ -738,5 +761,6 @@ const struct svc_procedure nlmsvc_procedures[24] = {
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
index b0f66604532a..899762da23c9 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -371,6 +371,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[ACLPROC2_GETACL] = {
 		.pc_func = nfsacld_proc_getacl,
@@ -381,6 +382,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
+		.pc_name = "GETACL",
 	},
 	[ACLPROC2_SETACL] = {
 		.pc_func = nfsacld_proc_setacl,
@@ -391,6 +393,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "SETACL",
 	},
 	[ACLPROC2_GETATTR] = {
 		.pc_func = nfsacld_proc_getattr,
@@ -401,6 +404,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "GETATTR",
 	},
 	[ACLPROC2_ACCESS] = {
 		.pc_func = nfsacld_proc_access,
@@ -411,6 +415,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_ressize = sizeof(struct nfsd3_accessres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT+1,
+		.pc_name = "SETATTR",
 	},
 };
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 7c30876a31a1..9e1a92fb9771 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -251,6 +251,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[ACLPROC3_GETACL] = {
 		.pc_func = nfsd3_proc_getacl,
@@ -261,6 +262,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_ressize = sizeof(struct nfsd3_getaclres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+2*(1+ACL),
+		.pc_name = "GETACL",
 	},
 	[ACLPROC3_SETACL] = {
 		.pc_func = nfsd3_proc_setacl,
@@ -271,6 +273,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_ressize = sizeof(struct nfsd3_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT,
+		.pc_name = "SETACL",
 	},
 };
 
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 76931f4f57c3..c9c64471c568 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -708,6 +708,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
+		.pc_name = "NULL",
 	},
 	[NFS3PROC_GETATTR] = {
 		.pc_func = nfsd3_proc_getattr,
@@ -718,6 +719,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_attrstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "GETATTR",
 	},
 	[NFS3PROC_SETATTR] = {
 		.pc_func = nfsd3_proc_setattr,
@@ -728,6 +730,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
+		.pc_name = "SETATTR",
 	},
 	[NFS3PROC_LOOKUP] = {
 		.pc_func = nfsd3_proc_lookup,
@@ -738,6 +741,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_diropres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+FH+pAT+pAT,
+		.pc_name = "LOOKUP",
 	},
 	[NFS3PROC_ACCESS] = {
 		.pc_func = nfsd3_proc_access,
@@ -748,6 +752,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_accessres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+1,
+		.pc_name = "ACCESS",
 	},
 	[NFS3PROC_READLINK] = {
 		.pc_func = nfsd3_proc_readlink,
@@ -758,6 +763,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+1+NFS3_MAXPATHLEN/4,
+		.pc_name = "READLINK",
 	},
 	[NFS3PROC_READ] = {
 		.pc_func = nfsd3_proc_read,
@@ -768,6 +774,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_readres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+4+NFSSVC_MAXBLKSIZE/4,
+		.pc_name = "READ",
 	},
 	[NFS3PROC_WRITE] = {
 		.pc_func = nfsd3_proc_write,
@@ -778,6 +785,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_writeres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC+4,
+		.pc_name = "WRITE",
 	},
 	[NFS3PROC_CREATE] = {
 		.pc_func = nfsd3_proc_create,
@@ -788,6 +796,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "CREATE",
 	},
 	[NFS3PROC_MKDIR] = {
 		.pc_func = nfsd3_proc_mkdir,
@@ -798,6 +807,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "MKDIR",
 	},
 	[NFS3PROC_SYMLINK] = {
 		.pc_func = nfsd3_proc_symlink,
@@ -808,6 +818,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "SYMLINK",
 	},
 	[NFS3PROC_MKNOD] = {
 		.pc_func = nfsd3_proc_mknod,
@@ -818,6 +829,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_createres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+(1+FH+pAT)+WC,
+		.pc_name = "MKNOD",
 	},
 	[NFS3PROC_REMOVE] = {
 		.pc_func = nfsd3_proc_remove,
@@ -828,6 +840,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
+		.pc_name = "REMOVE",
 	},
 	[NFS3PROC_RMDIR] = {
 		.pc_func = nfsd3_proc_rmdir,
@@ -838,6 +851,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_wccstatres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC,
+		.pc_name = "RMDIR",
 	},
 	[NFS3PROC_RENAME] = {
 		.pc_func = nfsd3_proc_rename,
@@ -848,6 +862,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_renameres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+WC+WC,
+		.pc_name = "RENAME",
 	},
 	[NFS3PROC_LINK] = {
 		.pc_func = nfsd3_proc_link,
@@ -858,6 +873,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_linkres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+pAT+WC,
+		.pc_name = "LINK",
 	},
 	[NFS3PROC_READDIR] = {
 		.pc_func = nfsd3_proc_readdir,
@@ -867,6 +883,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_argsize = sizeof(struct nfsd3_readdirargs),
 		.pc_ressize = sizeof(struct nfsd3_readdirres),
 		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "READDIR",
 	},
 	[NFS3PROC_READDIRPLUS] = {
 		.pc_func = nfsd3_proc_readdirplus,
@@ -876,6 +893,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_argsize = sizeof(struct nfsd3_readdirplusargs),
 		.pc_ressize = sizeof(struct nfsd3_readdirres),
 		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "READDIRPLUS",
 	},
 	[NFS3PROC_FSSTAT] = {
 		.pc_func = nfsd3_proc_fsstat,
@@ -885,6 +903,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_fsstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+2*6+1,
+		.pc_name = "FSSTAT",
 	},
 	[NFS3PROC_FSINFO] = {
 		.pc_func = nfsd3_proc_fsinfo,
@@ -894,6 +913,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_fsinfores),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+12,
+		.pc_name = "FSINFO",
 	},
 	[NFS3PROC_PATHCONF] = {
 		.pc_func = nfsd3_proc_pathconf,
@@ -903,6 +923,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_pathconfres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+pAT+6,
+		.pc_name = "PATHCONF",
 	},
 	[NFS3PROC_COMMIT] = {
 		.pc_func = nfsd3_proc_commit,
@@ -913,6 +934,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_ressize = sizeof(struct nfsd3_commitres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+WC+2,
+		.pc_name = "COMMIT",
 	},
 };
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8d6d2678abad..f567592692ee 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3305,6 +3305,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 1,
+		.pc_name = "NULL",
 	},
 	[NFSPROC4_COMPOUND] = {
 		.pc_func = nfsd4_proc_compound,
@@ -3315,6 +3316,7 @@ static const struct svc_procedure nfsd_procedures4[2] = {
 		.pc_release = nfsd4_release_compoundargs,
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = NFSD_BUFSIZE/4,
+		.pc_name = "COMPOUND",
 	},
 };
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 9473d048efec..1f85a4dc9d1b 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -623,6 +623,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
+		.pc_name = "NULL",
 	},
 	[NFSPROC_GETATTR] = {
 		.pc_func = nfsd_proc_getattr,
@@ -633,6 +634,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "GETATTR",
 	},
 	[NFSPROC_SETATTR] = {
 		.pc_func = nfsd_proc_setattr,
@@ -643,6 +645,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "SETATTR",
 	},
 	[NFSPROC_ROOT] = {
 		.pc_func = nfsd_proc_root,
@@ -652,6 +655,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
+		.pc_name = "ROOT",
 	},
 	[NFSPROC_LOOKUP] = {
 		.pc_func = nfsd_proc_lookup,
@@ -662,6 +666,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+FH+AT,
+		.pc_name = "LOOKUP",
 	},
 	[NFSPROC_READLINK] = {
 		.pc_func = nfsd_proc_readlink,
@@ -671,6 +676,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_readlinkres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+1+NFS_MAXPATHLEN/4,
+		.pc_name = "READLINK",
 	},
 	[NFSPROC_READ] = {
 		.pc_func = nfsd_proc_read,
@@ -681,6 +687,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_readres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4,
+		.pc_name = "READ",
 	},
 	[NFSPROC_WRITECACHE] = {
 		.pc_func = nfsd_proc_writecache,
@@ -690,6 +697,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
+		.pc_name = "WRITECACHE",
 	},
 	[NFSPROC_WRITE] = {
 		.pc_func = nfsd_proc_write,
@@ -700,6 +708,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+AT,
+		.pc_name = "WRITE",
 	},
 	[NFSPROC_CREATE] = {
 		.pc_func = nfsd_proc_create,
@@ -710,6 +719,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+FH+AT,
+		.pc_name = "CREATE",
 	},
 	[NFSPROC_REMOVE] = {
 		.pc_func = nfsd_proc_remove,
@@ -719,6 +729,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "REMOVE",
 	},
 	[NFSPROC_RENAME] = {
 		.pc_func = nfsd_proc_rename,
@@ -728,6 +739,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "RENAME",
 	},
 	[NFSPROC_LINK] = {
 		.pc_func = nfsd_proc_link,
@@ -737,6 +749,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "LINK",
 	},
 	[NFSPROC_SYMLINK] = {
 		.pc_func = nfsd_proc_symlink,
@@ -746,6 +759,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "SYMLINK",
 	},
 	[NFSPROC_MKDIR] = {
 		.pc_func = nfsd_proc_mkdir,
@@ -756,6 +770,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
 		.pc_xdrressize = ST+FH+AT,
+		.pc_name = "MKDIR",
 	},
 	[NFSPROC_RMDIR] = {
 		.pc_func = nfsd_proc_rmdir,
@@ -765,6 +780,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
+		.pc_name = "RMDIR",
 	},
 	[NFSPROC_READDIR] = {
 		.pc_func = nfsd_proc_readdir,
@@ -773,6 +789,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_argsize = sizeof(struct nfsd_readdirargs),
 		.pc_ressize = sizeof(struct nfsd_readdirres),
 		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "READDIR",
 	},
 	[NFSPROC_STATFS] = {
 		.pc_func = nfsd_proc_statfs,
@@ -782,6 +799,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_ressize = sizeof(struct nfsd_statfsres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+5,
+		.pc_name = "STATFS",
 	},
 };
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 34c2a69820e9..31ee3b6047c3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -463,6 +463,7 @@ struct svc_procedure {
 	unsigned int		pc_ressize;	/* result struct size */
 	unsigned int		pc_cachetype;	/* cache info (NFS) */
 	unsigned int		pc_xdrressize;	/* maximum size of XDR reply */
+	const char *		pc_name;	/* for display */
 };
 
 /*


