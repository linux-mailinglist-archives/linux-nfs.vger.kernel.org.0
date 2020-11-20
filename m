Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266F02BB799
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgKTUmV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbgKTUmV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:21 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2096DC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:20 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so10197783qkk.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PEcrhSATQpFl3fXEVUtsV51ONe71tAfVltBDG9jXBjA=;
        b=r28Cnwy18ifPf7hPhUGRwIyfnFCMrUq0q1HCuJOZiiF01nFA9ghuzpibmRkEig7xFl
         E+J8OMSe+24ShPlFI1NXDnp0+B/Yxfp1JiFla+kZBz/Uv+GRIfAh0+iuWPRqDkbOLVis
         gzaw3NVu5YxTORoyvDYI6ICIjxlGb82r6gOWPEwfzwVxENfAolpJHX0C71zNTT94OgrG
         n2ouU44Dsc1xt+m59YB2fhUhwgBVp0bxGX/5u5V3h5UCikAKoNVtSdemNdpAL3NSH6tX
         y82BSiKBAnD5E2m3t3g1nGG0srmnaOibiItYz9Syvh5f5qwd7h/95ujJ262PkkEY611y
         gQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PEcrhSATQpFl3fXEVUtsV51ONe71tAfVltBDG9jXBjA=;
        b=UO0CqrR9ZSCr1OA0G1xSQ7kuzz69oji+hyHdW5HEFtK0UdOB8URv6V+SVYs8nj4/hV
         K+h0+Xi/GcpoY1OS0Ap85V0HW1DUdvj5YhEJFExbwOqO95btSfULRcTi0GKe7iRDOW5g
         lg4QcVC/NHjk7AG5U3vBrn4uGmQXTogj+tbclKTDkzIBuErYKMOPFI+avX5soSEv+XQQ
         LWGkVouAoY1yop7SjM2ov+muI03R9Ad7MEXUUXhPrmGgbiqPJAGfN5CqXH10n8eUQSYL
         vBFEuOkof2F626TzX8S34X16+meDXChAnWXk+zUzj1sVpxMLIeSFgAPgzwafYiu+Jcos
         yP5w==
X-Gm-Message-State: AOAM533hAN+BCa+OY0fKJVCOZUMC8BKhhkwJ0k6X9CyKunTdKkMdTx+U
        IfqXEPCy2qRfOv2qnHu64bcCcyWh6is=
X-Google-Smtp-Source: ABdhPJzImaXFWp+dGDf+5uG5UBX7xnzqYiybGyKTPB8wriOg2H6zaR7uUMBqFT2Lq4SW5jQjnZi7Pw==
X-Received: by 2002:a37:9ac4:: with SMTP id c187mr13839542qke.159.1605904938942;
        Fri, 20 Nov 2020 12:42:18 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p72sm2897220qke.110.2020.11.20.12.42.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:18 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgHdt029501
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:17 GMT
Subject: [PATCH v2 096/118] NFSD: Update the MKNOD3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:17 -0500
Message-ID: <160590493716.1340.15655083491324688448.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This commit removes the last usage of the original decode_sattr3(),
so it is removed as a clean-up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |  110 ++++++++++++++++++-----------------------------------
 1 file changed, 37 insertions(+), 73 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 6dfab4bd6c2c..df593dd9924b 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -103,26 +103,6 @@ encode_fh(__be32 *p, struct svc_fh *fhp)
 	return p + XDR_QUADLEN(size);
 }
 
-/*
- * Decode a file name and make sure that the path contains
- * no slashes or null bytes.
- */
-static __be32 *
-decode_filename(__be32 *p, char **namp, unsigned int *lenp)
-{
-	char		*name;
-	unsigned int	i;
-
-	if ((p = xdr_decode_string_inplace(p, namp, lenp, NFS3_MAXNAMLEN)) != NULL) {
-		for (i = 0, name = *namp; i < *lenp; i++, name++) {
-			if (*name == '\0' || *name == '/')
-				return NULL;
-		}
-	}
-
-	return p;
-}
-
 static enum xdr_decode_result
 svcxdr_decode_filename3(struct xdr_stream *xdr, char **name, unsigned int *len)
 {
@@ -273,49 +253,27 @@ svcxdr_decode_sattrguard3(struct xdr_stream *xdr, struct nfsd3_sattrargs *args)
 	return XDR_DECODE_DONE;
 }
 
-static __be32 *
-decode_sattr3(__be32 *p, struct iattr *iap, struct user_namespace *userns)
+static enum xdr_decode_result
+svcxdr_decode_specdata3(struct xdr_stream *xdr, struct nfsd3_mknodargs *args)
 {
-	u32	tmp;
+	__be32 *p;
 
-	iap->ia_valid = 0;
+	p = xdr_inline_decode(xdr, sizeof(__be32) * 2);
+	if (!p)
+		return XDR_DECODE_FAILED;
+	args->major = be32_to_cpup(p++);
+	args->minor = be32_to_cpup(p);
 
-	if (*p++) {
-		iap->ia_valid |= ATTR_MODE;
-		iap->ia_mode = ntohl(*p++);
-	}
-	if (*p++) {
-		iap->ia_uid = make_kuid(userns, ntohl(*p++));
-		if (uid_valid(iap->ia_uid))
-			iap->ia_valid |= ATTR_UID;
-	}
-	if (*p++) {
-		iap->ia_gid = make_kgid(userns, ntohl(*p++));
-		if (gid_valid(iap->ia_gid))
-			iap->ia_valid |= ATTR_GID;
-	}
-	if (*p++) {
-		u64	newsize;
+	return XDR_DECODE_DONE;
+}
 
-		iap->ia_valid |= ATTR_SIZE;
-		p = xdr_decode_hyper(p, &newsize);
-		iap->ia_size = min_t(u64, newsize, NFS_OFFSET_MAX);
-	}
-	if ((tmp = ntohl(*p++)) == 1) {	/* set to server time */
-		iap->ia_valid |= ATTR_ATIME;
-	} else if (tmp == 2) {		/* set to client time */
-		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
-		iap->ia_atime.tv_sec = ntohl(*p++);
-		iap->ia_atime.tv_nsec = ntohl(*p++);
-	}
-	if ((tmp = ntohl(*p++)) == 1) {	/* set to server time */
-		iap->ia_valid |= ATTR_MTIME;
-	} else if (tmp == 2) {		/* set to client time */
-		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
-		iap->ia_mtime.tv_sec = ntohl(*p++);
-		iap->ia_mtime.tv_nsec = ntohl(*p++);
-	}
-	return p;
+static enum xdr_decode_result
+svcxdr_decode_devicedata3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+			  struct nfsd3_mknodargs *args)
+{
+	if (!svcxdr_decode_sattr3(rqstp, xdr, &args->attrs))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_specdata3(xdr, args);
 }
 
 static __be32 *encode_fsid(__be32 *p, struct svc_fh *fhp)
@@ -651,24 +609,30 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_mknodargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh))
-	 || !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-
-	args->ftype = ntohl(*p++);
-
-	if (args->ftype == NF3BLK  || args->ftype == NF3CHR
-	 || args->ftype == NF3SOCK || args->ftype == NF3FIFO)
-		p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	if (args->ftype == NF3BLK || args->ftype == NF3CHR) {
-		args->major = ntohl(*p++);
-		args->minor = ntohl(*p++);
+	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &args->ftype) < 0)
+		return XDR_DECODE_FAILED;
+	switch (args->ftype) {
+	case NF3CHR:
+	case NF3BLK:
+		return svcxdr_decode_devicedata3(rqstp, xdr, args);
+	case NF3SOCK:
+	case NF3FIFO:
+		return svcxdr_decode_sattr3(rqstp, xdr, &args->attrs);
+	case NF3REG:
+	case NF3DIR:
+	case NF3LNK:
+		/* Valid XDR but illegal file types */
+		break;
+	default:
+		return XDR_DECODE_FAILED;
 	}
 
-	return xdr_argsize_check(rqstp, p);
+	return XDR_DECODE_DONE;
 }
 
 int


