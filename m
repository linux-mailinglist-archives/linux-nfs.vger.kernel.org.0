Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD282B1DF8
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgKMPDP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgKMPDO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:14 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914C9C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:14 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q22so9018030qkq.6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qRk/sfW4bwcD+Ts7SzXfR9EqT4+NA8QCdXiccKkiWFk=;
        b=qGteZ/jAuYmjBw8lUihoGUpMAf5K3jYCyU0//pVM6K+NQhFd6GzuZENeVuRqsSplHr
         ilx0xD/kMwPVhVVjk5j03omQ6hVU2Hea59tyE6jLhhi8yckf44g3Bi+NKdgzUxlnWEO1
         ukqDbdvd8PdUUg6h/f2Rj4+t/tH00FuZZYVh+NvrkBdwHLEFLk57ySRIQKpgzCeOw284
         MeN4vOzo1ZQIohvOpx/u1S573/21Tx4FRdYCpaT7RdGI2Q6dKHQwV1bLjkVgmTi0irHm
         phq6CpbFgV07uEaC//E56DQAfMVwNLTzhHpZsccKzr8Rc53DonZGSXa+2M2GBJLW3kbR
         MXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qRk/sfW4bwcD+Ts7SzXfR9EqT4+NA8QCdXiccKkiWFk=;
        b=STuZNYt/QuPuVty1/wp9ZZ5c8aGa/ObdHCU//YpR31uyWwM1wmiQOh6WxparhhRujB
         /cOgiT7Tcy/Domi5N3PaK9xnfZpfOsNK+yfrLn1Sdw9YiN9YAGGqu1GWQRFZEV6BEaWZ
         KZHCZfpzVi/BqWmNA1hloKztb6ODjI6BxKmExMqvUF+tqKNthEv+w/ggGQ5Hf5eMi5ac
         7dMV6n7JKuCVqdya6viouyxbW01IkLZaBOdOroCw9AIpZmNnKLcySvi//Lh3oLSzr3Y7
         eYO93EDixlxx+LRm7cFZEocsh8qU6u37ivd5z40jHwLn57TpvQKmVt4X+ti/8uFJ9hPR
         9DJQ==
X-Gm-Message-State: AOAM5301GuoNsKT16aKOPt/sY5CGyrauX0is39+67jmZvZNe/FBMbeFK
        xqZhfDu0LH5CSRR0qm/mNJG+nmeFTms=
X-Google-Smtp-Source: ABdhPJwCDs6LMEm4g4OlwfNEyM5UG6aXlYJm5LPwBobuEQbQ4dL/ku8Os/mmFGn/+uQuHrSYDXsq8g==
X-Received: by 2002:a37:7641:: with SMTP id r62mr2274348qkc.465.1605279792610;
        Fri, 13 Nov 2020 07:03:12 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x5sm7254964qtx.61.2020.11.13.07.03.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:11 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3AP4032664
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:10 GMT
Subject: [PATCH v1 09/61] NFSD: Replace READ* macros in nfsd4_decode_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:10 -0500
Message-ID: <160527979096.6186.164949251806384511.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   65 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2c69bf10d556..3cd5b2c843d8 100644
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
@@ -203,6 +205,32 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
 	return ret;
 }
 
+static __be32 nfsd4_decode_component4(struct nfsd4_compoundargs *argp,
+				      char **namp, u32 *lenp)
+{
+	__be32 *p, status;
+
+	if (xdr_stream_decode_u32(argp->xdr, lenp) < 0)
+		goto xdr_error;
+	p = xdr_inline_decode(argp->xdr, *lenp);
+	if (!p)
+		goto xdr_error;
+	status = check_filename((char *)p, *lenp);
+	if (status)
+		goto out;
+	*namp = svcxdr_tmpalloc(argp, *lenp);
+	if (!*namp)
+		goto nomem;
+	memcpy(*namp, p, *lenp);
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserr_jukebox;
+}
+
 static __be32
 nfsd4_decode_time(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 {
@@ -583,24 +611,27 @@ nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit
 static __be32
 nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create)
 {
-	DECODE_HEAD;
+	__be32 *p, status;
 
-	READ_BUF(4);
-	create->cr_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &create->cr_type) < 0)
+		goto xdr_error;
 	switch (create->cr_type) {
 	case NF4LNK:
-		READ_BUF(4);
-		create->cr_datalen = be32_to_cpup(p++);
-		READ_BUF(create->cr_datalen);
+		if (xdr_stream_decode_u32(argp->xdr, &create->cr_datalen) < 0)
+			goto xdr_error;
+		p = xdr_inline_decode(argp->xdr, create->cr_datalen);
+		if (!p)
+			goto xdr_error;
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
+			goto xdr_error;
+		if (xdr_stream_decode_u32(argp->xdr, &create->cr_specdata2) < 0)
+			goto xdr_error;
 		break;
 	case NF4SOCK:
 	case NF4FIFO:
@@ -609,20 +640,20 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 		break;
 	}
 
-	READ_BUF(4);
-	create->cr_namelen = be32_to_cpup(p++);
-	READ_BUF(create->cr_namelen);
-	SAVEMEM(create->cr_name, create->cr_namelen);
-	if ((status = check_filename(create->cr_name, create->cr_namelen)))
-		return status;
-
+	status = nfsd4_decode_component4(argp, &create->cr_name,
+					 &create->cr_namelen);
+	if (status)
+		goto out;
 	status = nfsd4_decode_fattr(argp, create->cr_bmval, &create->cr_iattr,
 				    &create->cr_acl, &create->cr_label,
 				    &create->cr_umask);
 	if (status)
 		goto out;
 
-	DECODE_TAIL;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static inline __be32


