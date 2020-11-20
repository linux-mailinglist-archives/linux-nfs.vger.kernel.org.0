Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB6F2BB730
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgKTUfh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbgKTUfh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:37 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA2C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:35 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id 9so1115540qvk.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MvJoz3c9VAMHOM2nRqmv18CkcSDqWkfS+0Cao0Hj5Dc=;
        b=BNcyoR7qeuJIb0XD3gJt0YiIne/8HwCTpTq7lZ9O2Ws0kiy1A+rExmmDRumWWtqbfD
         QQQfa0Lvq6lWXIEx1diQmINjEN5Iin6QloOz28eAhC0T7SjtyCJftoo0bCU0aX6iUCjT
         gdqj7AwKzbsrOlyPLJJRJpK1Zha1tiFvxZ7VojqEcyINmao6P9DDG8TyCFlBrT002L5L
         Dq8pGMt3AkMfMdRtLYS3PgvdkRFH0b473Y+Q4PSr8CHDV8K8Jy87Uvqscmlw+pR3A0Fm
         EEG8VPlK4L2kbNcBaFPdIJ/3hVEo2UeAcxHN3MkcgR3U2hdsoxIzkwQFcU1irh9R8rRH
         idPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=MvJoz3c9VAMHOM2nRqmv18CkcSDqWkfS+0Cao0Hj5Dc=;
        b=H0iD+jGdECpP9SOlb6Fx/yLeluxWDYAimGLSXdsLm1fqcKvUxOyVnK6BXZW07O4aOI
         QuJAAjis9HUGhr7FVrRHMH6m3igfcaAoHBroPJ1II4jZbeLzIpY+7qFB/8kgtj1cp05+
         Omq6cnYnS4xHtNFfGQb6XFpzgqK1ufzIhVvJ81BanL4JqKBVcKNNRmZjdpGfonS/ezGo
         wkqbw3Esb7AMysb8uS2d1Tnymkhzua8AI3kbw8oNaKOPNn9dtNLo91d+hcRcvSR1xhdK
         EJQIbSAN8WFLnAxCbTzDFnUPbYq+Cv4cQVtw+D6uOTMvNKtsTra9lX2ReaATC4a1mV4i
         Etig==
X-Gm-Message-State: AOAM530z4ZxSQBZbsbFhIn65rXPGM3Qk7UeY8qpjnvaHTqUK/0vgV8/k
        BQSnL+uGX3alknZL+DO2MEb0vKSYlGc=
X-Google-Smtp-Source: ABdhPJwpfhQUrOwh9FYF0KXGyKvM2+3RYlSJ6wAaK2p4ccQVnMTl4/yvVwNhh+lyc2XMEq/lceGwEQ==
X-Received: by 2002:a05:6214:40c:: with SMTP id z12mr18062181qvx.25.1605904534402;
        Fri, 20 Nov 2020 12:35:34 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l22sm2799729qke.118.2020.11.20.12.35.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:33 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZWA2029262
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:32 GMT
Subject: [PATCH v2 020/118] NFSD: Replace READ* macros in
 nfsd4_decode_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:32 -0500
Message-ID: <160590453273.1340.8609162090280267676.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A dedicated decoder for component4 is introduced here, which will be
used by other operation decoders in subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   58 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c7f14f0db432..4a5b7bc21dab 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -90,6 +90,8 @@ check_filename(char *str, int len)
 
 	if (len == 0)
 		return nfserr_inval;
+	if (len > NFS4_MAXNAMLEN)
+		return nfserr_nametoolong;
 	if (isdotent(str, len))
 		return nfserr_badname;
 	for (i = 0; i < len; i++)
@@ -203,6 +205,27 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
 	return ret;
 }
 
+static __be32
+nfsd4_decode_component4(struct nfsd4_compoundargs *argp, char **namp, u32 *lenp)
+{
+	__be32 *p, status;
+
+	if (xdr_stream_decode_u32(argp->xdr, lenp) < 0)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, *lenp);
+	if (!p)
+		return nfserr_bad_xdr;
+	status = check_filename((char *)p, *lenp);
+	if (status)
+		return status;
+	*namp = svcxdr_tmpalloc(argp, *lenp);
+	if (!*namp)
+		return nfserr_jukebox;
+	memcpy(*namp, p, *lenp);
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_time(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 {
@@ -643,24 +666,27 @@ nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit
 static __be32
 nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create)
 {
-	DECODE_HEAD;
+	__be32 *p, status;
 
-	READ_BUF(4);
-	create->cr_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &create->cr_type) < 0)
+		return nfserr_bad_xdr;
 	switch (create->cr_type) {
 	case NF4LNK:
-		READ_BUF(4);
-		create->cr_datalen = be32_to_cpup(p++);
-		READ_BUF(create->cr_datalen);
+		if (xdr_stream_decode_u32(argp->xdr, &create->cr_datalen) < 0)
+			return nfserr_bad_xdr;
+		p = xdr_inline_decode(argp->xdr, create->cr_datalen);
+		if (!p)
+			return nfserr_bad_xdr;
 		create->cr_data = svcxdr_dupstr(argp, p, create->cr_datalen);
 		if (!create->cr_data)
 			return nfserr_jukebox;
 		break;
 	case NF4BLK:
 	case NF4CHR:
-		READ_BUF(8);
-		create->cr_specdata1 = be32_to_cpup(p++);
-		create->cr_specdata2 = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &create->cr_specdata1) < 0)
+			return nfserr_bad_xdr;
+		if (xdr_stream_decode_u32(argp->xdr, &create->cr_specdata2) < 0)
+			return nfserr_bad_xdr;
 		break;
 	case NF4SOCK:
 	case NF4FIFO:
@@ -668,22 +694,18 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 	default:
 		break;
 	}
-
-	READ_BUF(4);
-	create->cr_namelen = be32_to_cpup(p++);
-	READ_BUF(create->cr_namelen);
-	SAVEMEM(create->cr_name, create->cr_namelen);
-	if ((status = check_filename(create->cr_name, create->cr_namelen)))
+	status = nfsd4_decode_component4(argp, &create->cr_name,
+					 &create->cr_namelen);
+	if (status)
 		return status;
-
 	status = nfsd4_decode_fattr4(argp, create->cr_bmval,
 				    ARRAY_SIZE(create->cr_bmval),
 				    &create->cr_iattr, &create->cr_acl,
 				    &create->cr_label, &create->cr_umask);
 	if (status)
-		goto out;
+		return status;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static inline __be32


