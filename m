Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4734A2BB72D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgKTUfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbgKTUfV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:21 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09752C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:20 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so8121797qts.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iWet+vPSrNLB7LqDQAsHb+el1qBFpeHaLrIvpWrnbDo=;
        b=pZM2DPi7oUhzJAjU/X85VrPkYGVsgh5ajplC7um8qVCQ7h9WsPcUT6+r2xi5mKurWP
         31ncTuYrRpg9CkIpTdnJUn8h7VcPrIk2Ci22qxyQRGnF15HwUlJ0Mt9pgWLYscbnGHP3
         soM3XKmZdJ/AwEywj5P3PG3G0k46QIrqg6njQiDGltNdQi1paaex2/538barCHdiUXQF
         UKx5Sy53XeHQTAbKKEj7upf+Es/l5QVDSNI3pYO3PsaQSOEofLZMWVvQlpDkg3yDTZ6Z
         AcZQHzlssdOfKAXSP+ZqAoHqVbhKhW5udctt45qRJgiX4RbCtvBQ+IdmA/qBrBlC+kR+
         WK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=iWet+vPSrNLB7LqDQAsHb+el1qBFpeHaLrIvpWrnbDo=;
        b=MzlW5M6UvjcxtivGCR8zoQ68IT1rcAo9rGNoWtRrj8TI7llyPIc3Xo+JmxlZbe2/5P
         TeUYFBHlnbNx3cMEuvfrzsNXh+0RRAY9fl5+DFeC6OUBXIfrhP6+OMsD3J4klJ4f8jA7
         xOsP5IThNxJuXEIWqhc1YsY2JpJAajo/JAEatc2UtIjncKk2nxPLRbTnKzmyEJNaWuxG
         EDLewnEvaB5Pt6Fh4eZdq5L3DCleHAL9vYCeOesUzvxsoiSaImtl0WLi1onOf/xkbBOe
         7+28bASV0v9mtfPU1O5FE1nxhAQI0EzE6RyUaGebhQpg60sR+DuVh9hlxsYu2z99WC+T
         sjGw==
X-Gm-Message-State: AOAM533h7M+Ms0wbbledd2JWErnT4KrnYYXjEouiTUKZGw+cTO2ZAdLG
        9xfHRHElb/A0iFyvgdGEW2lZcN1tH6c=
X-Google-Smtp-Source: ABdhPJyZe4+Wyxva0NgmqpslSq09RayofZebM4QXkRTCg9oB9Gko4H8IqEp6CZmIGx/PvS61LqrRww==
X-Received: by 2002:ac8:5351:: with SMTP id d17mr17970332qto.235.1605904518265;
        Fri, 20 Nov 2020 12:35:18 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t126sm2801936qkh.133.2020.11.20.12.35.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:17 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZGX5029253
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:16 GMT
Subject: [PATCH v2 017/118] NFSD: Replace READ* macros that decode the fattr4
 security label attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:16 -0500
Message-ID: <160590451655.1340.10481103107579048902.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 16aded9bcf3a..a5207a36199c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -322,6 +322,33 @@ nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl)
 	return nfs_ok;
 }
 
+static noinline __be32
+nfsd4_decode_seclabel(struct nfsd4_compoundargs *argp,
+		      struct xdr_netobj *label)
+{
+	u32 lfs, pi, length;
+	__be32 *p;
+
+	if (xdr_stream_decode_u32(argp->xdr, &lfs) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &pi) < 0)
+		return nfserr_bad_xdr;
+
+	if (xdr_stream_decode_u32(argp->xdr, &length) < 0)
+		return nfserr_bad_xdr;
+	if (length > NFS4_MAXLABELLEN)
+		return nfserr_badlabel;
+	p = xdr_inline_decode(argp->xdr, length);
+	if (!p)
+		return nfserr_bad_xdr;
+	label->len = length;
+	label->data = svcxdr_dupstr(argp, p, length);
+	if (!label->data)
+		return nfserr_jukebox;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		   struct iattr *iattr, struct nfs4_acl **acl,
@@ -330,7 +357,6 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	unsigned int starting_pos;
 	u32 attrlist4_count;
 	u32 dummy32;
-	char *buf;
 
 	DECODE_HEAD;
 	iattr->ia_valid = 0;
@@ -438,24 +464,12 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 			return nfserr_bad_xdr;
 		}
 	}
-
 	label->len = 0;
 	if (IS_ENABLED(CONFIG_NFSD_V4_SECURITY_LABEL) &&
 	    bmval[2] & FATTR4_WORD2_SECURITY_LABEL) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++); /* lfs: we don't use it */
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++); /* pi: we don't use it either */
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		READ_BUF(dummy32);
-		if (dummy32 > NFS4_MAXLABELLEN)
-			return nfserr_badlabel;
-		READMEM(buf, dummy32);
-		label->len = dummy32;
-		label->data = svcxdr_dupstr(argp, buf, dummy32);
-		if (!label->data)
-			return nfserr_jukebox;
+		status = nfsd4_decode_seclabel(argp, label);
+		if (status)
+			return status;
 	}
 	if (bmval[2] & FATTR4_WORD2_MODE_UMASK) {
 		if (!umask)


