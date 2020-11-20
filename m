Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49092BB754
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgKTUiG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgKTUiG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:06 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B3C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:04 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id a13so10237223qkl.4
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=05pjzhfvTczQgq0W/N7Vxd6yLCuv/XD+uc2gfGybPxQ=;
        b=C5MkKmAx/uWmN6r/Ov9ho2rirdF12uQdD270zzDcKgypDINASsxQeMq3JnGfde+Rnj
         O4aBXjebEaxxl80D6mWewW6ynUSKjn2ND9f7STJKoAWefm/J0rN5LVGcwHOkdn3jdseb
         69kyAnbZXX2UOFXKuzIDqetGvKGpxTW3qy/uNhcEfYw9fxAQRuRuapemWX8SjprWlG9b
         f+0JKeCg67mWUptmXqH9qKE2G8FvOakaggkClCIqH/G4OaFcnoQR6KS56opcceb6ajoj
         d21/FUj1S5QIURxKVkYSoTeX6dJab1tBtkyOB/vjGk2TX8aLY2vWNCJhHnBVIi2THck0
         tV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=05pjzhfvTczQgq0W/N7Vxd6yLCuv/XD+uc2gfGybPxQ=;
        b=HIc1iaQFBPy7r7JF1jHUyLaaf3tYyZDcR+D/6Wvmi/Gm0oEB7pNKfFbPnJ2PNF28Rc
         8KDWGQyf6lidGgIDD2vXT6R7Vi+kW/LA6xD5Qndg3Y6BjvMoZsNuuBFTbGplQEw78nRI
         zQ8B41xziLtnIrPoTmB0FoG3+5DZNcCRYROMhd+MkOgr5eH6oii1IV8na6PLDNGD8HJF
         /IEVHr/QlM/MRf9KBYy3YWNzZGv3SPhxGQJR36df3ziyBEBWuUgpuhirYAT59u3MtTLP
         yUz2Xb40ZhYbrRRHgBmksLDvU/3gZeDVWinCdMseWo4P1WqGW5JYCk8eyOgJyCELMktI
         KDWA==
X-Gm-Message-State: AOAM530Og6sePMrpZGMxyfO+Nk+z/hmuUkM70MNK2dCYb2tHwgXUKjeY
        rVzk2Bv+pdmUxCuVjXWVITSvsCEcgr8=
X-Google-Smtp-Source: ABdhPJwSLq+ISkq91TbMEP2qZrLXj5BdXUD2FsfFE3DeCEzOy9eINy/PfRkjOEjJv0RN2NW8xxvzWA==
X-Received: by 2002:a05:620a:5a5:: with SMTP id q5mr18264058qkq.199.1605904683435;
        Fri, 20 Nov 2020 12:38:03 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d48sm3068512qta.26.2020.11.20.12.38.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:02 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKc1dc029346
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:01 GMT
Subject: [PATCH v2 048/118] NFSD: Replace READ* macros in
 nfsd4_decode_verify()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:01 -0500
Message-ID: <160590468171.1340.13282973653265827766.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5266a5a1bdc6..69262f9ea5a5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1316,20 +1316,26 @@ nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_s
 static __be32
 nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify)
 {
-	DECODE_HEAD;
+	__be32 *p;
 
-	if ((status = nfsd4_decode_bitmap(argp, verify->ve_bmval)))
-		goto out;
+	if (xdr_stream_decode_uint32_array(argp->xdr, verify->ve_bmval,
+					   ARRAY_SIZE(verify->ve_bmval)) < 0)
+		return nfserr_bad_xdr;
 
 	/* For convenience's sake, we compare raw xdr'd attributes in
 	 * nfsd4_proc_verify */
 
-	READ_BUF(4);
-	verify->ve_attrlen = be32_to_cpup(p++);
-	READ_BUF(verify->ve_attrlen);
-	SAVEMEM(verify->ve_attrval, verify->ve_attrlen);
+	if (xdr_stream_decode_u32(argp->xdr, &verify->ve_attrlen) < 0)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, verify->ve_attrlen);
+	if (!p)
+		return nfserr_bad_xdr;
+	verify->ve_attrval = svcxdr_tmpalloc(argp, verify->ve_attrlen);
+	if (!verify->ve_attrval)
+		return nfserr_jukebox;
+	memcpy(verify->ve_attrval, p, verify->ve_attrlen);
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


