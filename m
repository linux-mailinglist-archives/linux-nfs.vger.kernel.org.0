Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0D12B1E1F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgKMPFq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKMPFq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:46 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1321C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:45 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so6856875qtp.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4iNM5JIof41jZIa8kmWrkYKBkDRyEFaKtaLABM9gns0=;
        b=DzI+NoebAp6WwL+3e7xaNWifcrgjZU574KYCMbYFmE10jAbPoI9WH/KBIad2l5YPAM
         abyykBO76vMtg7rfioAHtQZB4qVIbcjxn0XZrPhhJ3L1I2nREl6hiRkvWEbwTu0QaVh+
         DdlxmAuddau4jZJfz9bRNRjXOQzUiXAkNVzKxnGEPZxQl9R5IV1SfjW4V/UhOjxAA+7n
         qNiT3lbtkiw8fYRmZ9DCHphGtgzSxqfYb8OMiUw7IO8EZlFd8YTbyg6EovadLIOyqr6D
         eb85Nd+MR2eUD1D10ReU1pt0yf8PSfEMs+nlz9j9jNxO9S0AoFUIKRKqb17Xa5u5ukDM
         iYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=4iNM5JIof41jZIa8kmWrkYKBkDRyEFaKtaLABM9gns0=;
        b=Of+6lhqw5qsnTROPAZx2x9ucqyWHZ5nHwRLzMmwsJWL4uLN3BOAeHNsbuLX/2qkLUY
         1x+MZdy7NBLxNQ5ISf0QzFZrG7TsyHgSLKy7QQgFb8vhwo2qsKnRulbK0fT6bcAvvjDH
         c4InJeCuqDPl/WutXcvoLpAlvC5PGf8anKntpsMJNXDkzmMieAKIAs0wYXoRH+A7YkqV
         EL7i/jvzwucMuPThs8K04scQWhcce+CmR6ISQu7dxaWdoPRhxDgh6/Kks77CWzpsnh8k
         A2cOJaZLQjjLf3wPrnK+ZPbNybdCLJOXoUtqvJf1JY0CyHdWqG3siawlxYu3W2kCkXsd
         G/Aw==
X-Gm-Message-State: AOAM530fw8ibMWiF9xzG87crBSEuMDfV2BCt6QPx/96gIOaOMh6NZyjs
        6U36TgvlGzfyXV9Go+LYFLc4q0lU3LM=
X-Google-Smtp-Source: ABdhPJxwYGr2HYne9/22tXzWnns/CjP6YjfYYgpsdLYtHssQHL3vXQjShzNyiJNDzqaZQpqESu1ydg==
X-Received: by 2002:aed:3a63:: with SMTP id n90mr2414209qte.133.1605279944635;
        Fri, 13 Nov 2020 07:05:44 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c14sm6830563qko.29.2020.11.13.07.05.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:44 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5hKR032751
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:43 GMT
Subject: [PATCH v1 38/61] NFSD: Add a separate decoder for ssv_sp_parms
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:43 -0500
Message-ID: <160527994303.6186.1989247630725102385.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   86 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ece4e8afe19e..4d666e2f8583 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -222,11 +222,13 @@ static __be32 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_ne
 	p = xdr_inline_decode(argp->xdr, len);
 	if (!p)
 		goto xdr_error;
-	o->data = svcxdr_tmpalloc(argp, len);
-	if (!o->data)
-		goto nomem;
-	o->len = len;
-	memcpy(o->data, p, len);
+	if (o) {
+		o->data = svcxdr_tmpalloc(argp, len);
+		if (!o->data)
+			goto nomem;
+		o->len = len;
+		memcpy(o->data, p, len);
+	}
 
 	return nfs_ok;
 xdr_error:
@@ -1482,13 +1484,56 @@ static __be32 nfsd4_decode_state_protect_ops(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_bitmap4(argp, must_allow, ma_len);
 }
 
+/*
+ * This implementation currently does not support SP4_SSV.
+ * This decoder simply skips over these arguments.
+ */
+static __be32 nfsd4_decode_ssv_sp_parms(struct nfsd4_compoundargs *argp)
+{
+	u32 bm[3], count;
+	__be32 status;
+
+	/* ssp_ops */
+	status = nfsd4_decode_state_protect_ops(argp, bm, ARRAY_SIZE(bm),
+						bm, ARRAY_SIZE(bm));
+	if (status)
+		goto out;
+
+	/* ssp_hash_algs<> */
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		goto xdr_error;
+	while (count--) {
+		status = nfsd4_decode_opaque(argp, NULL);
+		if (status)
+			goto out;
+	}
+
+	/* ssp_encr_algs<> */
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		goto xdr_error;
+	while (count--) {
+		status = nfsd4_decode_opaque(argp, NULL);
+		if (status)
+			goto out;
+	}
+
+	/* ssp_window and ssp_num_gss_handles are ignored */
+	if (!xdr_inline_decode(argp->xdr, sizeof(__be32) * 2))
+		goto xdr_error;
+
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)
 {
-	int dummy, tmp;
 	DECODE_HEAD;
-	u32 bm[3];
+	int dummy;
 
 	READ_BUF(NFS4_VERIFIER_SIZE);
 	COPYMEM(exid->verifier.data, NFS4_VERIFIER_SIZE);
@@ -1516,34 +1561,9 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			goto out;
 		break;
 	case SP4_SSV:
-		/* ssp_ops */
-		status = nfsd4_decode_state_protect_ops(argp, bm, ARRAY_SIZE(bm),
-							bm, ARRAY_SIZE(bm));
+		status = nfsd4_decode_ssv_sp_parms(argp);
 		if (status)
 			goto out;
-
-		/* ssp_hash_algs<> */
-		READ_BUF(4);
-		tmp = be32_to_cpup(p++);
-		while (tmp--) {
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			p += XDR_QUADLEN(dummy);
-		}
-
-		/* ssp_encr_algs<> */
-		READ_BUF(4);
-		tmp = be32_to_cpup(p++);
-		while (tmp--) {
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			p += XDR_QUADLEN(dummy);
-		}
-
-		/* ignore ssp_window and ssp_num_gss_handles: */
-		READ_BUF(8);
 		break;
 	default:
 		goto xdr_error;


