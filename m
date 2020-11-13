Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1472B1E3C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKMPHi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgKMPHi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:38 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306FC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:38 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id r7so9052870qkf.3
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=COrvmwlddej0CGMOGx4wlESLR75B8NOG7RYuqdB3xT4=;
        b=gnk4ecCw0RYG4qgaI6bxlFSeWPZcEXYxxz4VycIhA40xTSYGfrAmug3UfXDht/4Zl0
         o+5W/MVRtznM160GsyJzII5OVoniDHae/4P6aNEO8wqQ3N2biQMGDSR7UsimOjQX4pXH
         UaDrvx53pPYvNneZKpTe2lz+xmg2DUbwdTpElDun7Xu6whwQztGabAcqDeTeKWRGSRdv
         t8FBrmoWyTSclSSGaj0XXRxLoWwqoKhWNvY/KLX0AkRVck0ndZh0NA7xg8r7HPT5mLR5
         D5TlsFxIB2lfF83Eo8OJ/JuOB9sTK/jhCzzGHHZSZPjUdgBUDLlEZ8pQH0zWg8gZ9rtb
         x3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=COrvmwlddej0CGMOGx4wlESLR75B8NOG7RYuqdB3xT4=;
        b=VQD6rhVBddjIZTKTM6T9PU8/VhkeFuQRKR/UVTQRkRxg0+SvyFySM2awZkAO+jjxZD
         rihFqF4CKRJqD76swa7IkwI67Mk1s30V2vKJED45J6nZp6KxRrhW0EejB/S88qRJFag+
         j/33SK23BL3FV1+f8XtwejEBjr5leBp9lUX2dDvAcrqjuSXaYinBaU0A1m+nWa/3u6iM
         PqULo/hajAThwDBLP85Rf6+MVG1pybF4i2/WxsG3/L9MQoRy3er1b+5mUlnW6jQ87qE2
         EjZTEh+R7hdIaz2i3aMsfxNesgzPt2AqGS6vwyTG+EZnejxjdz3NXutMFyxIFmwXD5Oj
         jkJg==
X-Gm-Message-State: AOAM5335QwQMzcjW4j7XqaNG98tqM7CRXgPRlu4LRe23csyxvM5woBas
        UWmZ1KrfKJV/MTCDUVWmgIUOAtnBw3Q=
X-Google-Smtp-Source: ABdhPJx5OhvC+a/gkEEEj8s7Iw/pfmwcCUT1c4tVnOxH7KdPogl+vP8zn/D4RO4C2J+RZRdmG8wA0w==
X-Received: by 2002:a37:b642:: with SMTP id g63mr2304459qkf.460.1605280055724;
        Fri, 13 Nov 2020 07:07:35 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a23sm6663937qtj.56.2020.11.13.07.07.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:07:35 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF7Y2S000346
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:07:34 GMT
Subject: [PATCH v1 59/61] NFSD: Replace READ* macros in
 nfsd4_decode_listxattrs()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:07:34 -0500
Message-ID: <160528005406.6186.6799824894457553423.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 760aac341fab..4332b16cfdc8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2306,11 +2306,10 @@ static __be32
 nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 			struct nfsd4_listxattrs *listxattrs)
 {
-	DECODE_HEAD;
 	u32 maxcount;
 
-	READ_BUF(12);
-	p = xdr_decode_hyper(p, &listxattrs->lsxa_cookie);
+	if (xdr_stream_decode_u64(argp->xdr, &listxattrs->lsxa_cookie) < 0)
+		goto xdr_error;
 
 	/*
 	 * If the cookie  is too large to have even one user.x attribute
@@ -2320,15 +2319,20 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 	    (XATTR_LIST_MAX / (XATTR_USER_PREFIX_LEN + 2)))
 		return nfserr_badcookie;
 
-	maxcount = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &maxcount) < 0)
+		goto xdr_error;
 	if (maxcount < 8)
 		/* Always need at least 2 words (length and one character) */
-		return nfserr_inval;
+		goto inval_arg;
 
 	maxcount = min(maxcount, svc_max_payload(argp->rqstp));
 	listxattrs->lsxa_maxcount = maxcount;
 
-	DECODE_TAIL;
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+inval_arg:
+	return nfserr_inval;
 }
 
 static __be32


