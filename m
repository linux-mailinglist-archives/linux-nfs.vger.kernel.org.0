Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED22C15DE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgKWUJI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgKWUJI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:08 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7CC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:07 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so14320808qtb.10
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GpTokXGaANHYCBj89Ram3lgk4u3OFzBS+0QdJdDIbvc=;
        b=I4V3aSFcTIfOYL2QoXnpKoHs8JOr37Fzo1h6T3/s4Bk12p7QGe89F81SLl79qVohzx
         WYGI/eTkulIaB59Swhkd/CzTRicuJ2yDhbsohg1NPDCPUmRYODtIZckorQazSYv42ITj
         K4HYEahDMOkaIVAM9iwpvxrzpW/vHdWfgwxLyZQV5TsyGOrZmMRCGEhM5wF5Js9R7eVa
         AWJChh00B1PHRCa1Qgaa1pMRzEyv/UwtL1GOesWhThh8b+iCqevAzdBX0y14lKuWs2VR
         sB6Pp2T3WMk4Sng9N10s+xdKyNiVwEYOxjGW7liZlE5q41TH8kcB+AAas0GduT+NkozP
         jPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=GpTokXGaANHYCBj89Ram3lgk4u3OFzBS+0QdJdDIbvc=;
        b=klS827eeF80bJkAL+A/b7XX/8RfLWenKmrq1bRHLaAiZip6XvYlz1hsN6IsRKt5cnU
         EmywuEYCy62t6UQmXKb2zCQirE5pzl51WAm3eGvr3qcC9dwqAHk8pT2phwn105+Df22h
         ql5v2pslLzkNIhiBA9dr294Ge1fKcqhn7CxbFchX9LM6F9Vbk8gUl1oOsQVdL+Hi4+Sc
         HWjqSH695A3No1IteQHlNWvS8Wj8UZ8H/3IjHW9KrRHV0EJmO3hnsXBd8+bx1oTkQVp0
         92iuUKLRlhfjDQ4AyMHwUXBCF4klzytlsgexK1Y2TC0k20p+buqvrMnzD9KMyeIDN5u/
         aTMQ==
X-Gm-Message-State: AOAM530agxAfAbXo7n0Oh0R551JZLb/Rgtnk001NnEg0uwOI466Z8/F2
        +CXR0/4Ma5LhDTnoAu2Jhh3mI+NXTc8=
X-Google-Smtp-Source: ABdhPJyRHSxNgzMfwCtXYLZKF/4Ee8MKbmK2ufb4s0flLB0OiF1llmiJ9peH/QKEB+KAdc6AYwC+fA==
X-Received: by 2002:ac8:5304:: with SMTP id t4mr891674qtn.77.1606162145906;
        Mon, 23 Nov 2020 12:09:05 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p65sm10083280qkb.92.2020.11.23.12.09.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:05 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK94MS010450
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:04 GMT
Subject: [PATCH v3 58/85] NFSD: Add a helper to decode state_protect4_a
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:04 -0500
Message-ID: <160616214430.51996.12356284605153624353.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c   |   44 +++++++++++++++++++++++++++-----------------
 fs/nfsd/xdr4.h      |    2 +-
 3 files changed, 29 insertions(+), 19 deletions(-)

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
index 86147f53f5e7..ecae29ba9bb7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1531,25 +1531,13 @@ nfsd4_decode_ssv_sp_parms(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
-			 struct nfsd4_exchange_id *exid)
+nfsd4_decode_state_protect4_a(struct nfsd4_compoundargs *argp,
+			      struct nfsd4_exchange_id *exid)
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
@@ -1564,9 +1552,31 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
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


