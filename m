Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B470B2BB7A4
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKTUnN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKTUnN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:13 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A5C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:13 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 199so10193770qkg.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=S6cJA85/cKLuYE4uenga9e/KdXiR9eVJLE1T9kzJtPk=;
        b=De3fVa9IFO3kfDSqnIawbAzIJvQJo/QOTiWkL26cC1P5hT/gicYHihRd0rxpwarzOt
         PD0QSbVGg4lnuSfaf+BbTb5Nkff3+HLX2wS7m25YRgaLWzxMFo7tNlodYVNn2iIAINfn
         2tn/oFHls8Aj9TTQf7fb78WTd+AlvB9yoxuw+JG8V7BQXIXoynpDiJhTdS277OM41Ukg
         AXII+9tVLccngpDAg7iPr1WYhb1ohcRFqcZiTupGM6nj0J9xDzA4tw9Si5hy2VpDNxfP
         cPvx9/09mPs2K8QRQnmuGDhIhIQVez610K3dvMPIBNU92lJzy8jM/Ty/aWsjzIKYH+IS
         kLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=S6cJA85/cKLuYE4uenga9e/KdXiR9eVJLE1T9kzJtPk=;
        b=REJrVxrvzqR7fkAqR0KrFxmvmaJNfxJmxoBMkbqKIZHJJRANwqbu14cxndJaPg3/DI
         FbQC5LwH6Y3qq1euzT88/KICv4rYT8vSPdM3aN4SPsgDrbudjy+wgBdaj2wO+5FAmfCI
         C3rJo1vJStsPxtsPDnYmbi0urSVSxSVcMn1rONgUbok5PzRK2tW8rX40dvgV9ByaFK8e
         NjnlfjlZRia2W+idAuikHzG0D/FdBKMDi7ZWNqTInpk1P5vaAraGwWmI0O7UmaPlchO9
         lXaW2aWUj2qjyal/pLVde0AngNyX94NozXj1/PdNdANb7H2nS26j7idIsvB13gejND0t
         QNyQ==
X-Gm-Message-State: AOAM533L+gmEj5+FUab33vydgynKwtCemXhKVVjUO95OgXs/20TZqL3v
        BCba5RQjjKEtkIkC+/GGzHUdOUccuiM=
X-Google-Smtp-Source: ABdhPJy4H0GvDp6URPJpvn0I+pE5Zpv+9ipA3iAMA1w3HccDYxSN44LVunWe4xiabltH6iNMFWZfXg==
X-Received: by 2002:a37:951:: with SMTP id 78mr18388905qkj.47.1605904992028;
        Fri, 20 Nov 2020 12:43:12 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i52sm2991921qtc.3.2020.11.20.12.43.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:11 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhA0A029532
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:10 GMT
Subject: [PATCH v2 106/118] NFSD: Update the NFSv2 SETATTR argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:10 -0500
Message-ID: <160590499026.1340.16944912190360448062.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 40def4a461df..c34446c650ca 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -174,6 +174,79 @@ decode_sattr(__be32 *p, struct iattr *iap, struct user_namespace *userns)
 	return p;
 }
 
+static enum xdr_decode_result
+svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+		    struct iattr *iap)
+{
+	u32 tmp1, tmp2;
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, sizeof(__be32) * 8);
+	if (!p)
+		return XDR_DECODE_FAILED;
+
+	iap->ia_valid = 0;
+
+	/*
+	 * Some Sun clients put 0xffff in the mode field when they
+	 * mean 0xffffffff.
+	 */
+	tmp1 = be32_to_cpup(p++);
+	if (tmp1 != (u32)-1 && tmp1 != 0xffff) {
+		iap->ia_valid |= ATTR_MODE;
+		iap->ia_mode = tmp1;
+	}
+
+	tmp1 = be32_to_cpup(p++);
+	if (tmp1 != (u32)-1) {
+		iap->ia_uid = make_kuid(nfsd_user_namespace(rqstp), tmp1);
+		if (uid_valid(iap->ia_uid))
+			iap->ia_valid |= ATTR_UID;
+	}
+
+	tmp1 = be32_to_cpup(p++);
+	if (tmp1 != (u32)-1) {
+		iap->ia_gid = make_kgid(nfsd_user_namespace(rqstp), tmp1);
+		if (gid_valid(iap->ia_gid))
+			iap->ia_valid |= ATTR_GID;
+	}
+
+	tmp1 = be32_to_cpup(p++);
+	if (tmp1 != (u32)-1) {
+		iap->ia_valid |= ATTR_SIZE;
+		iap->ia_size = tmp1;
+	}
+
+	tmp1 = be32_to_cpup(p++);
+	tmp2 = be32_to_cpup(p++);
+	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
+		iap->ia_atime.tv_sec = tmp1;
+		iap->ia_atime.tv_nsec = tmp2 * NSEC_PER_USEC;
+	}
+
+	tmp1 = be32_to_cpup(p++);
+	tmp2 = be32_to_cpup(p++);
+	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
+		iap->ia_mtime.tv_sec = tmp1;
+		iap->ia_mtime.tv_nsec = tmp2 * NSEC_PER_USEC;
+		/*
+		 * Passing the invalid value useconds=1000000 for mtime
+		 * is a Sun convention for "set both mtime and atime to
+		 * current server time".  It's needed to make permissions
+		 * checks for the "touch" program across v2 mounts to
+		 * Solaris and Irix boxes work correctly. See description of
+		 * sattr in section 6.1 of "NFS Illustrated" by
+		 * Brent Callaghan, Addison-Wesley, ISBN 0-201-32750-5
+		 */
+		if (tmp2 == 1000000)
+			iap->ia_valid &= ~(ATTR_ATIME_SET|ATTR_MTIME_SET);
+	}
+
+	return XDR_DECODE_DONE;
+}
+
 static __be32 *
 encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	     struct kstat *stat)
@@ -254,14 +327,12 @@ nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_sattrargs *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	p = decode_sattr(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_fhandle(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
 int


