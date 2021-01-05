Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE922EAE78
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbhAEPch (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbhAEPch (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:37 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A46C061793
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:21 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 22so26752713qkf.9
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=temuZmKg8BP/QtAx+9SL0bWe9hueqt1h36Kd+rp2CVY=;
        b=Y4EjMgKiByI36krKwk1qYu3s29E7JMqGY6tWBCk0e7YG84ywtdKlIT/JJmPjZR2jXv
         yhGFj1NVmbLvdLSu8PwLkX3lzhc4B7OEGAer/15KbO3+dPECAOpma7ZXaLwp8a+h5E7C
         FzpELJyglTIK+ZQdd7VkwwKCMdFygsqrO4roi0vM+VZWa0Ouxgc4pLU7jkF/U8MTdXZ0
         p/9vmW9Ul1pN+w3QdBIrXf/yyg1ME/ygNzr17Vvlil30RKrJe/sKJdlviQk9b45PY6hD
         T5otWPKTwzAapSiCGfoLWYIgKpEkMJD3ebqSjUemiYYOkU5LPoFMjQHJdE1hh86p/wYQ
         I4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=temuZmKg8BP/QtAx+9SL0bWe9hueqt1h36Kd+rp2CVY=;
        b=sUwhgyRu/5Z0y6emwdx0pAK+pJ+ZmGAgrhuqMBI72qiJhBtGHUQkLZKMmvmSVZVlGU
         svfpBpwXpdJTP97lfx7YuJJXp4huYM+PzZiPccAyTvlUSsPDcw3zFfe/Y8muOrev+uZF
         eYk8IBkrOr2HtVH0ZO+6EZhycYfLSq1sedeOhpU0GDzTg/KM+6wRt/45kb+d3H/H9QfS
         7rPvEQ4YolD5W3bBvhr2Ye+Szd7PSc5zuqkwT8uhrrhTIHYGHCfAPB6neHHMv7JcU4FO
         mC30DqozyMDlPgSnTpGYBn88WnxboBsrkN/CoXdQhxIVrDqYGltjEm2wc68fQaeU1SSA
         H4uA==
X-Gm-Message-State: AOAM531NDd2Xl21MYYPZE6DMiiszLICTOiPUVIee5J0zS7jiWXlkg9FF
        7qfR/A6YuRia9wxxitaPyS2TyhZj5wQ=
X-Google-Smtp-Source: ABdhPJxaXBQGabZGoJQjRu6SMOutjKK4TVX5cV8bRxlcjPAqehggP17o9YufweSTN+xdKHXyxt2uEA==
X-Received: by 2002:a37:4a4e:: with SMTP id x75mr39133qka.89.1609860740756;
        Tue, 05 Jan 2021 07:32:20 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h25sm24149qtp.80.2021.01.05.07.32.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:20 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FWJt3020910
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:19 GMT
Subject: [PATCH v1 30/42] NFSD: Update the NFSv2 SETATTR argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:19 -0500
Message-ID: <160986073909.5532.13408794874690782313.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 3d0fe03a3fb9..6c87ea8f3876 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -173,6 +173,79 @@ decode_sattr(__be32 *p, struct iattr *iap, struct user_namespace *userns)
 	return p;
 }
 
+static bool
+svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+		    struct iattr *iap)
+{
+	u32 tmp1, tmp2;
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, XDR_UNIT * 8);
+	if (!p)
+		return false;
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
+	return true;
+}
+
 static __be32 *
 encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	     struct kstat *stat)
@@ -253,14 +326,11 @@ nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_sattrargs *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	p = decode_sattr(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_fhandle(xdr, &args->fh) &&
+		svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
 int


