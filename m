Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD272C15A4
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgKWUFs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKWUFs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:48 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEBEC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:47 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so14311028qtb.10
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rp5bisnZRIlvkOVcULc9p3rwK/sWuztjt2k1H7KDAfQ=;
        b=S3jZdnmgKQQeQohuI3wBOCv9WK2XxeOiRlvlTa6yjAZSKK71IzN8iWYhWN090R+r/0
         5B3M5uVZkhq9aod7OKBkNdzkMpx0y165AMBe8VizpY09/ie+YCMLgAc1n0Hj4p3+xNTF
         vVHsH/+OGf1ocEr9VgLwVlSEooK3BgndoLyOryvTJ0sP944Rr74LUxjG4xVmBByKtkH/
         p08HMp82ICqGCIc0RjPe5AJ08NTVcdQa7a+8o7ewntwRU8XlwhDNhwoEvHFxQZBiwdfl
         JX3/1OFaZ+uiJLxigDRVk9NJ4XA0qACtQpdiIErTNynhNX7XTMmgRe0Z41EX5k++2hY2
         ORHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=rp5bisnZRIlvkOVcULc9p3rwK/sWuztjt2k1H7KDAfQ=;
        b=cBFNw8Fd0ioJc7ow/Y2X1WzzKrjTGbdmJeFj5hnDHxmfHozcG1jBCA2I+GhHZ3Qzxh
         KpP/8P/ppwfWkVriRBtAHoQ4yWEM+EmzxfteWe9BlGi8lHSToRlwXQLBu/wSucvTdufu
         jdLi9V73r0JtBUQmhHniM0d8lwbo31yRVGF9P7z2gWAF3z1fUt7fGGNruMqytqJh3Rp8
         MtLyZl0RXAg8ALGVsWxnzj4iImLSnfRxgqX/LqgCpo89RaQVA8r++77HyBf7siTWEP/Q
         wyT/xrAjsBuYzmc404qqfTUzCbZGEs1Zg5Hgl+Tqqn66XiHxqTZhlHdHyVGK7r99UVf8
         19qQ==
X-Gm-Message-State: AOAM531bx1ooJw0m0CDYUc54NBP+gw1TA6oNTi8Vl9TkUoL2B4m+Q1WI
        NQvQhu2EpUa1rfm79RNyX2vxUL1Y+4U=
X-Google-Smtp-Source: ABdhPJwTVN+wi8jQkjmarRFNIV3OaYZvRk1Tl74M8e7Ibeul8aEQeJx6ip506QOlgS45sOWqWwybHg==
X-Received: by 2002:ac8:4802:: with SMTP id g2mr844465qtq.235.1606161946045;
        Mon, 23 Nov 2020 12:05:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q20sm10483657qke.0.2020.11.23.12.05.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:45 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK5iiG010328
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:44 GMT
Subject: [PATCH v3 20/85] NFSD: Replace READ* macros in nfsd4_decode_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:44 -0500
Message-ID: <160616194425.51996.675897939196905539.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
index 9b295c810ef3..59f5cd2575bc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -92,6 +92,8 @@ check_filename(char *str, int len)
 
 	if (len == 0)
 		return nfserr_inval;
+	if (len > NFS4_MAXNAMLEN)
+		return nfserr_nametoolong;
 	if (isdotent(str, len))
 		return nfserr_badname;
 	for (i = 0; i < len; i++)
@@ -205,6 +207,27 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
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
@@ -698,24 +721,27 @@ nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit
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
@@ -723,22 +749,18 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
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


