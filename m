Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC812BB75F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgKTUir (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730726AbgKTUiq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:46 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A30C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:46 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ek7so5321354qvb.6
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=K5498zebdvhhOUBPszMRXJTT3KyxwJIy+dG8JVJZVcw=;
        b=UZVmhbfRxL4tAVGTQtYOC3O/un6r9ytSeuoh2g7r7ABMh4QCNzlsd/0hY9h1lm1a4u
         6kcBXo4mI0OYPVHOGIbTB5NWxPGD9vIwO4ufh+tkoHYc6i/V1f+/TL/uwV9WictNEdfx
         AZ6v4sgI9IqwLaY/xJscoOvPKMLxe3NIIbaIE5I1tErQmjGbMrsuxT0JtVo3pnNgN26a
         aHGB+TDz7UvSS8giyoiUp6SjTDWU8P01Abf9o4Jd9+l97M42uuVX2lfpHFg4CeCKUnt+
         xoh0XrTfaptC7yrOTMkgR3uEzceF6rdh29Ib4NzDp8VXOUofqA3jC2hiqqODqR2yoM3O
         ulfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=K5498zebdvhhOUBPszMRXJTT3KyxwJIy+dG8JVJZVcw=;
        b=hJsGypHlzLxjQ7J3EVjjZAvr7lJ4Xy8ANFDSjbMNKZUlv5+LeQjeBl4Iqv2Ul+P4BU
         +GFzjSp4PILNSu8tAQSyOqvPUqYExlRTfBRjRh7s9aHv22qxcAnyeiC5zOh/SsLye4w9
         FIbW+CU9CB+Pl4imo/lHufk+ht95qBkkz6suDGS+ey/1m3zbLEgd/DLGzD07Xfj3VN0/
         4tRkcHVs0dFatDRzF7FsL43m/phHWMaUbB9htL7ReE8TM3Q8XlCp/Qv8c2VXL80usfhg
         Ty1g4kY4HDg3BCLQaaL+sRQLoqiSeXc7Fu77R8N1UYZUg21KxlJ+xWFdb/CW7CkTPQEr
         00Fg==
X-Gm-Message-State: AOAM532H/OwqxjxyU9pl5ulZgV0uAXixyMlgJlpIYbBx1auBEmTM1xuA
        XWWSZlDK8JjYQcxdCv5Er2bSEyVj+H8=
X-Google-Smtp-Source: ABdhPJyfsITtj6Aor8PNHiymZbnjTe4PzbAi9qiZlCzfKi/jCRoZplZMyAuaAblULN+ewj3vYhqWkw==
X-Received: by 2002:a05:6214:6a2:: with SMTP id s2mr18178153qvz.58.1605904725567;
        Fri, 20 Nov 2020 12:38:45 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g8sm2823051qkk.131.2020.11.20.12.38.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:44 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKci0h029371
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:44 GMT
Subject: [PATCH v2 056/118] NFSD: Add a helper to decode state_protect4_a
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:44 -0500
Message-ID: <160590472409.1340.12180918142294931542.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c   |   45 +++++++++++++++++++++++++++------------------
 fs/nfsd/xdr4.h      |    2 +-
 3 files changed, 29 insertions(+), 20 deletions(-)

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
index dc39b004bcb4..bb2e83ad61a4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1468,26 +1468,13 @@ static __be32 nfsd4_decode_ssv_sp_parms(struct nfsd4_compoundargs *argp)
 	return nfs_ok;
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
+	__be32 status;
 
-	status = nfsd4_decode_opaque(argp, &exid->clname);
-	if (status)
+	if (xdr_stream_decode_u32(argp->xdr, &exid->spa_how) < 0)
 		return nfserr_bad_xdr;
-
-	READ_BUF(4);
-	exid->flags = be32_to_cpup(p++);
-
-	/* Ignore state_protect4_a */
-	READ_BUF(4);
-	exid->spa_how = be32_to_cpup(p++);
 	switch (exid->spa_how) {
 	case SP4_NONE:
 		break;
@@ -1506,9 +1493,31 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			return status;
 		break;
 	default:
-		goto xdr_error;
+		return nfserr_bad_xdr;
 	}
 
+	return nfs_ok;
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
+		return status;
+	status = nfsd4_decode_opaque(argp, &exid->clname);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &exid->flags) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_state_protect4_a(argp, exid);
+	if (status)
+		return status;
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


