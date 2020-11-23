Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1C2C15D0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgKWUIl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbgKWUIk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:40 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7CC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:40 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so18225979qkk.10
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VVVrypne4AeSywEEvRqVh0zfmtCtzGNwJ8y/AUKcfes=;
        b=YtPthJMG1OU0/8Zq7TrDFdM0lpBiDFyaK+oPIVup/gI8YdBCgm9niOzM2hWTwQfqYV
         XhEf9fBTcoihcDckwZjtJZvNWqDvIueJJvSsX3alu/aVdwELlnkDjFnY3PJsoP5kZUF3
         DMiWWIq93jPhLLN5MCVpEaBtAoj+KrYOKhtHCVFpNoGVLquZlAGDILZBGR4NtZ2AWq4T
         uBINDydUbRJuY33Q30ulVcdQDAkh/07N2Y0inMNk2VdG6NnmS9tJhSGl7dHeh4wvIvJ/
         q26pOs4Tt2/RmSKL6FdiaLVo2TrS/sZ4cSLsHHXi3k5+bSX+hOa8dKKP7HCkvjWMd/Wh
         vZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=VVVrypne4AeSywEEvRqVh0zfmtCtzGNwJ8y/AUKcfes=;
        b=GmW43pI9ypWZjh+RufmDQ/OSeLeqGbXsxysuUQ6vlkzudfBZs3wI3wvNhHpFpgin6s
         b3/nTrqRDknrfZFoGQm4syMv/+DJWue1XFeHHlGJlxT71ppK5s/lTpQZJmlY5/UZAxJg
         2g37ROi8LQOwJB8weCCGXstwCso1tbw5VnnEsMNDG51iIPVUFWhi7sKEcek0HUGleVcl
         zgQ3sEk60uPekTbgMmJF8wiloNRQHAbRmEY+Xjzvs85aRYbcbSzkQd2qSSC3kaX6xwJq
         xAddniK4kqBTyBYIBPcBOB8V73z7Z8cF3XsCj0L0VcYFOOr4d+XeReEjjwAl004c6UCG
         dDoQ==
X-Gm-Message-State: AOAM531tntdPqIu7eLZtXq9rhaspvh1zltwLRZLjSkbzBqYj9rEZlsJj
        4wh+m7W2F+fUX5CpdtkCXEao/+z9x88=
X-Google-Smtp-Source: ABdhPJzKTZ2bo/B3A1giXbXEeEQzEwTtTLc/sW3K8wA4L8VizyQx8UUwyR2p7QS1oBJpFErCLnNAbQ==
X-Received: by 2002:a37:9dd1:: with SMTP id g200mr1249493qke.376.1606162119682;
        Mon, 23 Nov 2020 12:08:39 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e9sm7966969qtr.95.2020.11.23.12.08.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:39 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8ceH010435
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:38 GMT
Subject: [PATCH v3 53/85] NFSD: Replace READ* macros in nfsd4_decode_cb_sec()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:38 -0500
Message-ID: <160616211806.51996.1070194178927932232.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
index 0a2474542309..acbe461e03ae 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -212,6 +212,25 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
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
@@ -645,87 +664,117 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_opaque(argp, owner);
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
+/* a counted array of callback_sec_parms4 items */
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


