Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E355D2B1DFD
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKMPDf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgKMPDf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:35 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D041DC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:34 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id t191so9028815qka.4
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yKV9gezX41PryAOPaPnMSnhKk29MXDTt/s1weKRSU1Y=;
        b=oxpXnTuyGi6i2XA7UmmOkLNsfqbg0GcLmHreHCbRTUqylKUuRTRRZGA4kJ57h37pWv
         ttb7w+VFFJ8m/461XEJVGQ6FK1y9igHok8onio1IFbakI95lWLtzSkGGA6XSrJN8/7rv
         0L9u9sEKsWk7s6Zt3tZHEGdBMbVO19vfdTl1r4IPdrQ8w3Sc5z2oTLgC9oLKmUPBtxyo
         fWu+3lxrkIpFxoZ6c/oGRdLvXFgDFG2fencmP4hy9tTPOVwzKDVJgwMGlZ67lp6ZcBpX
         WhlVMywjaVQNrOYSzcpSUCc/LWHOYGuMd7L2uMhxr/mrbn3vlTdj11edk4zeiJTcwxJ0
         pcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yKV9gezX41PryAOPaPnMSnhKk29MXDTt/s1weKRSU1Y=;
        b=XgGrsEFOMGl3+w4cP45CyYwWMaDC8PamH5oKoTqpuWTJCsqV8LdrD/MJ07shhjBzfV
         bcRmM7J6nNVmpBJC636FTBiTxR/aOc3nWy+B1NKqX6fvS/LpspxfAnwGEi6YO6dgUpfj
         u5tQfe5rwzS7hAYP3s78PC09DzuSL6KMT0+P5ROpvovjXiPAhOQsgDY2dYSybPQIGyNm
         68NvkmNw7p3nTZAf/4iyhy+IktijmSzrbwgF/rQDJI8Pcgx9lYIZ481Pwrxkg051NL1o
         wmGXR7PUGMIkj8pGznFOlDa+FB/cfUOH+rchhdtltwH98bOcf0drqevfoHxBAyjTGtHw
         VpqA==
X-Gm-Message-State: AOAM532KpnCmMRC9p5AI3fcT9ftImM0hDw80G6kmzJgxEVahRFzHRfAa
        cabJbWQqCEEdycoZHzhlJWBGRIi6Y4M=
X-Google-Smtp-Source: ABdhPJxoBR2Fmo/5amlJR2iDz0plFUsN7ALCBwi7ZG7qNuTPgcluvwjpX8MvFwkrW4EV1o2YhlGYjg==
X-Received: by 2002:a37:4741:: with SMTP id u62mr2310816qka.155.1605279813303;
        Fri, 13 Nov 2020 07:03:33 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b12sm6643685qtj.12.2020.11.13.07.03.32
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:32 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3VGZ032676
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:31 GMT
Subject: [PATCH v1 13/61] NFSD: Replace READ* macros in nfsd4_decode_lock()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:31 -0500
Message-ID: <160527981188.6186.5472938610268206294.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c         |  121 +++++++++++++++++++++++++++++++++------------
 include/uapi/linux/nfs4.h |    1 
 2 files changed, 91 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c621a38e7874..35329e3d1339 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -484,6 +484,32 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	DECODE_TAIL;
 }
 
+static __be32 nfsd4_decode_clientid4(struct nfsd4_compoundargs *argp,
+				     clientid_t *clientid)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_CLIENTID_SIZE);
+	if (!p)
+		goto xdr_error;
+	memcpy(clientid, p, sizeof(*clientid));
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
+static __be32 nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
+					clientid_t *clientid,
+					struct xdr_netobj *owner)
+{
+	__be32 status;
+
+	status = nfsd4_decode_clientid4(argp, clientid);
+	if (status)
+		return status;
+	return nfsd4_decode_opaque(argp, owner);
+}
+
 static __be32
 nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 {
@@ -706,44 +732,77 @@ nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
 	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
 }
 
+static __be32
+nfsd4_decode_open_to_lock_owner4(struct nfsd4_compoundargs *argp,
+				 struct nfsd4_lock *lock)
+{
+	__be32 status;
+
+	lock->lk_is_new = 1;
+
+	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_new_open_seqid) < 0)
+		goto xdr_error;
+	status = nfsd4_decode_stateid4(argp, &lock->lk_new_open_stateid);
+	if (status)
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_new_lock_seqid) < 0)
+		goto xdr_error;
+	status = nfsd4_decode_state_owner4(argp, &lock->lk_new_clientid,
+					   &lock->lk_new_owner);
+
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
+static __be32
+nfsd4_decode_exist_lock_owner4(struct nfsd4_compoundargs *argp,
+			       struct nfsd4_lock *lock)
+{
+	__be32 status;
+
+	lock->lk_is_new = 0;
+
+	status = nfsd4_decode_stateid4(argp, &lock->lk_old_lock_stateid);
+	if (status)
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_old_lock_seqid) < 0)
+		goto xdr_error;
+
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32
 nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 {
-	DECODE_HEAD;
+	__be32 *p;
 
-	/*
-	* type, reclaim(boolean), offset, length, new_lock_owner(boolean)
-	*/
-	READ_BUF(28);
-	lock->lk_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_type) < 0)
+		goto xdr_error;
 	if ((lock->lk_type < NFS4_READ_LT) || (lock->lk_type > NFS4_WRITEW_LT))
 		goto xdr_error;
-	lock->lk_reclaim = be32_to_cpup(p++);
-	p = xdr_decode_hyper(p, &lock->lk_offset);
-	p = xdr_decode_hyper(p, &lock->lk_length);
-	lock->lk_is_new = be32_to_cpup(p++);
-
-	if (lock->lk_is_new) {
-		READ_BUF(4);
-		lock->lk_new_open_seqid = be32_to_cpup(p++);
-		status = nfsd4_decode_stateid4(argp, &lock->lk_new_open_stateid);
-		if (status)
-			return status;
-		READ_BUF(8 + sizeof(clientid_t));
-		lock->lk_new_lock_seqid = be32_to_cpup(p++);
-		COPYMEM(&lock->lk_new_clientid, sizeof(clientid_t));
-		lock->lk_new_owner.len = be32_to_cpup(p++);
-		READ_BUF(lock->lk_new_owner.len);
-		READMEM(lock->lk_new_owner.data, lock->lk_new_owner.len);
-	} else {
-		status = nfsd4_decode_stateid4(argp, &lock->lk_old_lock_stateid);
-		if (status)
-			return status;
-		READ_BUF(4);
-		lock->lk_old_lock_seqid = be32_to_cpup(p++);
-	}
+	p = xdr_inline_decode(argp->xdr, sizeof(__be32));
+	if (!p)
+		goto xdr_error;
+	lock->lk_reclaim = (*p == xdr_zero) ? 0 : 1;
+	if (xdr_stream_decode_u64(argp->xdr, &lock->lk_offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &lock->lk_length) < 0)
+		goto xdr_error;
+	p = xdr_inline_decode(argp->xdr, sizeof(__be32));
+	if (!p)
+		goto xdr_error;
+	if (*p != xdr_zero)
+		return nfsd4_decode_open_to_lock_owner4(argp, lock);
+	return nfsd4_decode_exist_lock_owner4(argp, lock);
 
-	DECODE_TAIL;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index ed5415e0f1c1..31072a653436 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -21,6 +21,7 @@
 #define NFS4_STATEID_SEQID_SIZE 4
 #define NFS4_STATEID_OTHER_SIZE 12
 #define NFS4_STATEID_SIZE	(NFS4_STATEID_SEQID_SIZE + NFS4_STATEID_OTHER_SIZE)
+#define NFS4_CLIENTID_SIZE	8
 #define NFS4_FHSIZE		128
 #define NFS4_MAXPATHLEN		PATH_MAX
 #define NFS4_MAXNAMLEN		NAME_MAX


