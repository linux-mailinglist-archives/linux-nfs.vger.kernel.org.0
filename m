Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED35C2B1E22
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgKMPFx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKMPFw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:52 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7032FC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:52 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id q7so4683444qvt.12
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UgXNnjZtUIgIStANzooR5lqEvSMHW8KTi+AbUU0DL5E=;
        b=Swg0lvgGRKeTtshlUYnz97ZHEHJkS6JmlxMGso8H8Eyd1aV196tCd5BiXJ2Fwi0oGV
         sEQUExIM2uyN3H+G9NYrvWOK8pIXO7LTz2wgKePsqf1GtwG21yvGNniGwVtZiNtKTkk4
         HtUO7lfuaf1lkKlws2bgVpl4Re5il9445lQwi5HRsYthfRCTJ+m7TsJpYIUIdM5N/ucr
         Cz9VvAEq3DQBPNjuRuU7EuNzinQySdch3c4WcSIGMVMIPYKSJ/CqIVx0xKjzMXGzCRAp
         AHsr622pxP/6WNPyGuimqbtx7JA9BqeS7HZpbfF1YWYyd5aZP3xQYh9lW9jDXfZNocpc
         2tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=UgXNnjZtUIgIStANzooR5lqEvSMHW8KTi+AbUU0DL5E=;
        b=S5WbToUpmXoqIsZK10zyc881bBa6EoGK6rp0kb3urZt7pyPmm8WywXE4mUoeckj6mr
         1SuKkcswsSiw3HFUoxecgyX26MNa+o/Yuye1QjytuktGNT43Rm0WtE9NbZEh3NBqFGfP
         arj8krgXN+OhFl4QDif+OSGt6lavJMfEDsb9HjKwjW6JXUBFURUsyPN6ayXgLOQyl8Yk
         4eh3QK6tA7ciLgjMVcqqjMWeR2tJERsJLMYMAodlTOyMb/L0J3gSzAoee4+YY8G/i5tR
         mdlQaj1gvztwBz/djEUW0CqcgnzZRnO285DeGto6QvK9yNWGjlprPe1HBEuCGdl4YX2B
         Q71Q==
X-Gm-Message-State: AOAM530lRtXZ4d7Ek+Fj1YAYVQyOam/dU+EVylJYtXtrIE56jMwhIe3d
        MLjBptGRWpeOf3OnvrjQQkmblhvhKnE=
X-Google-Smtp-Source: ABdhPJwtSmrwkd4a5HctRcxcp5sxz+eluKJghR7Ilse0Hoyfk8qMbFQGiecLuIiLp2taQEUxdtxMXg==
X-Received: by 2002:a0c:8143:: with SMTP id 61mr2779995qvc.6.1605279949699;
        Fri, 13 Nov 2020 07:05:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p12sm6642479qkp.88.2020.11.13.07.05.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:49 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5mDc032754
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:48 GMT
Subject: [PATCH v1 39/61] NFSD: Add a helper to decode state_protect4_a
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:48 -0500
Message-ID: <160527994831.6186.7016565184206978517.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity.

Also, remove a stale comment. Commit ed94164398c9 ("nfsd: implement
machine credential support for some operations") added support for
SP4_MACH_CRED, so state_protect_a is no longer completely ignored.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    2 +-
 fs/nfsd/nfs4xdr.c   |   51 +++++++++++++++++++++++++++++++++------------------
 fs/nfsd/xdr4.h      |    2 +-
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d7f27ed6b794..be6dcc4c2ab0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3066,7 +3066,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	rpc_ntop(sa, addr_str, sizeof(addr_str));
 	dprintk("%s rqstp=%p exid=%p clname.len=%u clname.data=%p "
-		"ip_addr=%s flags %x, spa_how %d\n",
+		"ip_addr=%s flags %x, spa_how %u\n",
 		__func__, rqstp, exid, exid->clname.len, exid->clname.data,
 		addr_str, exid->flags, exid->spa_how);
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4d666e2f8583..d3e238b538d0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1528,26 +1528,13 @@ static __be32 nfsd4_decode_ssv_sp_parms(struct nfsd4_compoundargs *argp)
 	return nfserr_bad_xdr;
 }
 
-static __be32
-nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
-			 struct nfsd4_exchange_id *exid)
+static __be32 nfsd4_decode_state_protect4_a(struct nfsd4_compoundargs *argp,
+					    struct nfsd4_exchange_id *exid)
 {
-	DECODE_HEAD;
-	int dummy;
-
-	READ_BUF(NFS4_VERIFIER_SIZE);
-	COPYMEM(exid->verifier.data, NFS4_VERIFIER_SIZE);
-
-	status = nfsd4_decode_opaque(argp, &exid->clname);
-	if (status)
-		return nfserr_bad_xdr;
-
-	READ_BUF(4);
-	exid->flags = be32_to_cpup(p++);
+	__be32 status;
 
-	/* Ignore state_protect4_a */
-	READ_BUF(4);
-	exid->spa_how = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &exid->spa_how) < 0)
+		goto xdr_error;
 	switch (exid->spa_how) {
 	case SP4_NONE:
 		break;
@@ -1569,6 +1556,34 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 		goto xdr_error;
 	}
 
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
+static __be32
+nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
+			 struct nfsd4_exchange_id *exid)
+{
+	DECODE_HEAD;
+	int dummy;
+
+	status = nfsd4_decode_verifier4(argp, &exid->verifier);
+	if (status)
+		goto out;
+	status = nfsd4_decode_opaque(argp, &exid->clname);
+	if (status)
+		goto out;
+
+	READ_BUF(4);
+	exid->flags = be32_to_cpup(p++);
+
+	status = nfsd4_decode_state_protect4_a(argp, exid);
+	if (status)
+		goto out;
+
 	READ_BUF(4);    /* nfs_impl_id4 array length */
 	dummy = be32_to_cpup(p++);
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 6245004a9993..232529bc1b79 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -433,7 +433,7 @@ struct nfsd4_exchange_id {
 	u32		flags;
 	clientid_t	clientid;
 	u32		seqid;
-	int		spa_how;
+	u32		spa_how;
 	u32             spo_must_enforce[3];
 	u32             spo_must_allow[3];
 	struct xdr_netobj nii_domain;


