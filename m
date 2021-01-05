Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F142B2EAE63
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbhAEPbo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbhAEPbo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:44 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B923C061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:29 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z11so26787363qkj.7
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Mahf9IRkHH9EZ+lU/nog2IaIVN+9KiP4zb4gqG5Mkq4=;
        b=F3YqwcD9pt8+0oxRkRuHvZaeUGUqT1xza0WYjdn9JEWHndcL6PQQhBk/oxKTGI4FwE
         I8bkasyNs86d1WH5y3Q+jPjH8/l+2oHAho3lBp+YV8BmqLVNZX7QlTcR183I41FWgedr
         FkSeyZ6N+a+VDIDzKSab9U4qPcTxIrR0o5hGFU8Nqp88ym6x9emL9Xz37JB+kKdaB2Q/
         Vr3zozoxZqrMMCMHjdQvGqjF5+4+b6QvvZ0JErK3L/rth+CY/X454NZ9sAHhvkLr3Ugo
         B+qpwZBx6bJvcuE8crYazjzLM2YCIhuYNhYiIgyT226XXV4x6cvfbRw1jBd7Ru9K/+Fg
         +S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mahf9IRkHH9EZ+lU/nog2IaIVN+9KiP4zb4gqG5Mkq4=;
        b=FzwHO2lNa4piAKpMLfrUiTkKfjhrjIBsVWmtoORjU1huuL098Gqc0xwvKAwprhbF3r
         Vk8ishzMUGNjxBowycz4DlYutx4TKWIWSIWN4Zm0gzjnpDtAW8K2rNXr29AXxDUmhyof
         uh+cDDg45mz4io2KEqI3f0vZXly1mncDDJHlJXVxtbSQB00hu2sHRYkW97xYe5N91g4c
         wSqKUnoURp3Gkjh4jByd9zHplbHVScdb7wnv8hg2n9QDZjHab4NgkmB7i4d6tB56uo53
         28pqjlkvdxIwlAMrixwUZrvBYw/iq7L0hCjPnqxfXd6iFMeasw7gnQOhlNRfIWeqbbq8
         zBNA==
X-Gm-Message-State: AOAM530tgXbNleSIz+HJquapPbux6DZp+kOtqLh39UE7J+U46nlOekY2
        hqWPjC2pmaONc2udmiGBM1r5YC3B1ts=
X-Google-Smtp-Source: ABdhPJy8LV6EoaCtqegikBen5z24X+p0N0GeFEaZtoLEMUIuswm82ggaByRYORn+5vJvtF2f04B9Qw==
X-Received: by 2002:a37:a50c:: with SMTP id o12mr90976qke.98.1609860687930;
        Tue, 05 Jan 2021 07:31:27 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r22sm147514qkk.67.2021.01.05.07.31.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:27 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVQ13020880
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:26 GMT
Subject: [PATCH v1 20/42] NFSD: Update the MKNOD3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:26 -0500
Message-ID: <160986068625.5532.13338988223363460604.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |  107 +++++++++++++++++------------------------------------
 1 file changed, 35 insertions(+), 72 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index e599d1481b2d..5fb7e8a599c4 100644
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
 static bool
 svcxdr_decode_filename3(struct xdr_stream *xdr, char **name, unsigned int *len)
 {
@@ -262,49 +242,26 @@ svcxdr_decode_sattrguard3(struct xdr_stream *xdr, struct nfsd3_sattrargs *args)
 	return true;
 }
 
-static __be32 *
-decode_sattr3(__be32 *p, struct iattr *iap, struct user_namespace *userns)
+static bool
+svcxdr_decode_specdata3(struct xdr_stream *xdr, struct nfsd3_mknodargs *args)
 {
-	u32	tmp;
+	__be32 *p;
 
-	iap->ia_valid = 0;
+	p = xdr_inline_decode(xdr, XDR_UNIT * 2);
+	if (!p)
+		return false;
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
+	return true;
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
+static bool
+svcxdr_decode_devicedata3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+			  struct nfsd3_mknodargs *args)
+{
+	return svcxdr_decode_sattr3(rqstp, xdr, &args->attrs) &&
+		svcxdr_decode_specdata3(xdr, args);
 }
 
 static __be32 *encode_fsid(__be32 *p, struct svc_fh *fhp)
@@ -644,24 +601,30 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_mknodargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh))
-	 || !(p = decode_filename(p, &args->name, &args->len)))
+	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->ftype) < 0)
+		return 0;
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
 		return 0;
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
 	}
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 int


