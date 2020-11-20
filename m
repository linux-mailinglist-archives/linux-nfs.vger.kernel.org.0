Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2551D2BB757
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgKTUiW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgKTUiW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:22 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BFAC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:20 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 9so1119152qvk.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=x0ThFeo0wMJpgriXQxuRTGkbLiB7jBTaA3sur/LOSbw=;
        b=RRR1v73ExaNzc6au/DFF3BMbABkA4F9WO9lsGORReviFpygmkZvKCp6BHPsGMu9joA
         tz85aoqt8I+bemUeIGJvGtpmQVmN4upTOeBuySaB33Xm4trShz1UR/Ef+dLpSO/a8W62
         O71y5mRxpE+1GvHjfBQa0zDnrx7qPCdD4g6wb5eUbx6PrY85iX61z1FZiVVZah5i2Ww3
         EAkflE1xOtiRHGKOnDEuWnK9asTTzgs6bxtkynQQoa9MC1VO3E8A6TkV6iIJoT4dh52l
         VrOcKKKVEnf9MLBxV1rcPJNHhvuXpn6GK1HZoBn3xbUX33Hy9jEguqVUIX5qpNzC6o1y
         ewcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=x0ThFeo0wMJpgriXQxuRTGkbLiB7jBTaA3sur/LOSbw=;
        b=U4H6v+a34cDjmMbBFANgIXrfaVhVrqeoyvk+Tj9R/uAUbqUm4YBDVYnnm4PRPtUGeg
         O+tWUPoq5VA5HXi8EKtJ2HzA4ufITtpjh60BJABhFisNzPVH4Kcv3GfFdK91SOrCZSmA
         zT9TUCpWsjZu1hj9JlUPlZ2ckdgpzH6sjOu/fadFMEKZifuS8vn31WVTlZpIfo4sJMGx
         khOti0B2D2bB7mbe+DHVUbvRn2XuPvJjQCObK/Zc9vBuIzjacxrtryLqEftel5Eia4v/
         BBoF4wVfOsjsInKZGwVRYGTbwURBfkcv2TqHjOOuPybvKgR3KTDADvnRimY+/jxpgQ/2
         U7DQ==
X-Gm-Message-State: AOAM533GMiulppewEYWEAEt/3NvOEWx6BgBMCspp7GsJ8Sf/4ttL4sVD
        wqp+trm4OMYic1S2BOY6t0kW2Ut/u9g=
X-Google-Smtp-Source: ABdhPJx23h3PwHW5FPRA+LtuBkZlLjvsvOb82AAxaqGPj4os1aXa1GBjL2Pa5g134rl1Cqb+TeRyaQ==
X-Received: by 2002:ad4:4743:: with SMTP id c3mr18093096qvx.62.1605904699312;
        Fri, 20 Nov 2020 12:38:19 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l79sm2863612qke.1.2020.11.20.12.38.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:18 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKcHnf029355
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:17 GMT
Subject: [PATCH v2 051/118] NFSD: Replace READ* macros in
 nfsd4_decode_cb_sec()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:17 -0500
Message-ID: <160590469760.1340.11225339390417699230.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |  165 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 107 insertions(+), 58 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8e2609658904..d9c57b2f3fcf 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -210,6 +210,25 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
  * NFSv4 basic data type decoders
  */
 
+/*
+ * This helper handles variable-length opaques which belong to protocol
+ * elements that this implementation does not support.
+ */
+static __be32
+nfsd4_decode_ignored_string(struct nfsd4_compoundargs *argp, u32 maxlen)
+{
+	u32 len;
+
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		return nfserr_bad_xdr;
+	if (maxlen && len > maxlen)
+		return nfserr_bad_xdr;
+	if (!xdr_inline_decode(argp->xdr, len))
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
 {
@@ -590,87 +609,117 @@ nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 	return nfs_ok;
 }
 
-static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
+/* Defined in Appendix A of RFC 5531 */
+static __be32
+nfsd4_decode_authsys_parms(struct nfsd4_compoundargs *argp,
+			   struct nfsd4_cb_sec *cbs)
 {
-	DECODE_HEAD;
-	struct user_namespace *userns = nfsd_user_namespace(argp->rqstp);
-	u32 dummy, uid, gid;
-	char *machine_name;
-	int i;
-	int nr_secflavs;
+	u32 stamp, gidcount, uid, gid;
+	__be32 *p, status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &stamp) < 0)
+		return nfserr_bad_xdr;
+	/* machine name */
+	status = nfsd4_decode_ignored_string(argp, 255);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &uid) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &gid) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &gidcount) < 0)
+		return nfserr_bad_xdr;
+	if (gidcount > 16)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, gidcount << 2);
+	if (!p)
+		return nfserr_bad_xdr;
+	if (cbs->flavor == (u32)(-1)) {
+		struct user_namespace *userns = nfsd_user_namespace(argp->rqstp);
+
+		kuid_t kuid = make_kuid(userns, uid);
+		kgid_t kgid = make_kgid(userns, gid);
+		if (uid_valid(kuid) && gid_valid(kgid)) {
+			cbs->uid = kuid;
+			cbs->gid = kgid;
+			cbs->flavor = RPC_AUTH_UNIX;
+		} else {
+			dprintk("RPC_AUTH_UNIX with invalid uid or gid, ignoring!\n");
+		}
+	}
+
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_decode_gss_cb_handles4(struct nfsd4_compoundargs *argp,
+			     struct nfsd4_cb_sec *cbs)
+{
+	__be32 status;
+	u32 service;
+
+	dprintk("RPC_AUTH_GSS callback secflavor not supported!\n");
+
+	if (xdr_stream_decode_u32(argp->xdr, &service) < 0)
+		return nfserr_bad_xdr;
+	if (service < RPC_GSS_SVC_NONE || service > RPC_GSS_SVC_PRIVACY)
+		return nfserr_bad_xdr;
+	/* gcbp_handle_from_server */
+	status = nfsd4_decode_ignored_string(argp, 0);
+	if (status)
+		return status;
+	/* gcbp_handle_from_client */
+	status = nfsd4_decode_ignored_string(argp, 0);
+	if (status)
+		return status;
+
+	return nfs_ok;
+}
+
+/* a counted array of callback_sec_parms4 */
+static __be32
+nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
+{
+	u32 i, secflavor, nr_secflavs;
+	__be32 status;
 
 	/* callback_sec_params4 */
-	READ_BUF(4);
-	nr_secflavs = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &nr_secflavs) < 0)
+		return nfserr_bad_xdr;
 	if (nr_secflavs)
 		cbs->flavor = (u32)(-1);
 	else
 		/* Is this legal? Be generous, take it to mean AUTH_NONE: */
 		cbs->flavor = 0;
+
 	for (i = 0; i < nr_secflavs; ++i) {
-		READ_BUF(4);
-		dummy = be32_to_cpup(p++);
-		switch (dummy) {
+		if (xdr_stream_decode_u32(argp->xdr, &secflavor) < 0)
+			return nfserr_bad_xdr;
+		switch (secflavor) {
 		case RPC_AUTH_NULL:
-			/* Nothing to read */
+			/* void */
 			if (cbs->flavor == (u32)(-1))
 				cbs->flavor = RPC_AUTH_NULL;
 			break;
 		case RPC_AUTH_UNIX:
-			READ_BUF(8);
-			/* stamp */
-			dummy = be32_to_cpup(p++);
-
-			/* machine name */
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			SAVEMEM(machine_name, dummy);
-
-			/* uid, gid */
-			READ_BUF(8);
-			uid = be32_to_cpup(p++);
-			gid = be32_to_cpup(p++);
-
-			/* more gids */
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy * 4);
-			if (cbs->flavor == (u32)(-1)) {
-				kuid_t kuid = make_kuid(userns, uid);
-				kgid_t kgid = make_kgid(userns, gid);
-				if (uid_valid(kuid) && gid_valid(kgid)) {
-					cbs->uid = kuid;
-					cbs->gid = kgid;
-					cbs->flavor = RPC_AUTH_UNIX;
-				} else {
-					dprintk("RPC_AUTH_UNIX with invalid"
-						"uid or gid ignoring!\n");
-				}
-			}
+			status = nfsd4_decode_authsys_parms(argp, cbs);
+			if (status)
+				return status;
 			break;
 		case RPC_AUTH_GSS:
-			dprintk("RPC_AUTH_GSS callback secflavor "
-				"not supported!\n");
-			READ_BUF(8);
-			/* gcbp_service */
-			dummy = be32_to_cpup(p++);
-			/* gcbp_handle_from_server */
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			p += XDR_QUADLEN(dummy);
-			/* gcbp_handle_from_client */
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
+			status = nfsd4_decode_gss_cb_handles4(argp, cbs);
+			if (status)
+				return status;
 			break;
 		default:
-			dprintk("Illegal callback secflavor\n");
 			return nfserr_inval;
 		}
 	}
-	DECODE_TAIL;
+
+	return nfs_ok;
 }
 
+
 /*
  * NFSv4 operation argument decoders
  */


