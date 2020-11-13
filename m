Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE2E2B1E14
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKMPE7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPE6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:58 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF09C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:58 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d28so8992364qka.11
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fOHEgvtZ5sJGF0ttmuJtyWaAjKqDGfg4lvaqpxotxao=;
        b=Bng5Wi8J0FtY+GEg5bvCdKkeMCvZsYY5eW90kJCJwiZlO25mDlESh9OQck9HJANGdv
         5U1b1jVJG+DpqvbyD2LmBJGBYwaQWbACv1b17/1PFhjRhUTiD2T+1gxOrbxIIOVidbux
         mrCtHD0h2GPo3BHh7One/Km03sfHCkNyM5LIDAJRyHStHys0Q2vuAU6kjko6oxluVSYa
         D2kHzn7XM7LN1BXZrfHAc5N/QMz/ErMOtuH2L6m+skaCgbFpQ/6Xxl7xH+JoRiXtcQBi
         51VCiIWJrhMhE0a+a5RHN9voPT0KOdEE1Uq9U6MnYW+dcEFegofTIRdGsmdMOcS1WIVr
         U25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=fOHEgvtZ5sJGF0ttmuJtyWaAjKqDGfg4lvaqpxotxao=;
        b=Md5F9M5q6uVioAEN0zGKzmV6Qr9Cdp5u0hPGqawDL5lO9+8QRblMQW59EZ5hr4xWJM
         OfDYCvczO9e1p3fRBcEn6GyuYNsf1vZ1fWVAdn6CeTAEkZ9x/HGDph2wutFG4X0Igiup
         LGBF89joeuAPBYJ3AeWC5/lLOINt+STCpQiJeOeX00W/Wm9gITltBZIuYFHPmCJm39fG
         WmSh05dF/KWsWa4kvRI2QiaJtPL2SMalZYq08lkdFVDI46lz+Tq4Z1QbD/krBF/w+bSx
         iLPB6CMEixmsBiWdxdhhwoLTH2v/KRV+/fm7zoioVhkP7PdfSdwO7zkbKYMMJgw3Bofb
         +q8Q==
X-Gm-Message-State: AOAM530QtxxziLGssg5lffvZnHQwsWA/OJLWqH5PohfIqmcOeF3Kk0ua
        iG6rtGWn8DwwgXxmoAcNi51qVO8DRwg=
X-Google-Smtp-Source: ABdhPJxVZSR/c7WO/0BXFgS6t5lY2DueL+f1Dh1R7XLfTN5e5KOpOOUG18D2mJwABuHGKuQlTuSawA==
X-Received: by 2002:a37:4782:: with SMTP id u124mr2362758qka.122.1605279897553;
        Fri, 13 Nov 2020 07:04:57 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d184sm6919073qkf.136.2020.11.13.07.04.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:56 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF4toa032724
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:55 GMT
Subject: [PATCH v1 29/61] NFSD: Replace READ* macros in
 nfsd4_decode_setclientid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:55 -0500
Message-ID: <160527989583.6186.16688438933091997482.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   55 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bbae2b1726ac..82d599887f92 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1284,31 +1284,52 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 static __be32
 nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid *setclientid)
 {
-	DECODE_HEAD;
+	__be32 *p, status;
 
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
-	READ_BUF(NFS4_VERIFIER_SIZE);
-	COPYMEM(setclientid->se_verf.data, NFS4_VERIFIER_SIZE);
-
+	status = nfsd4_decode_verifier4(argp, &setclientid->se_verf);
+	if (status)
+		goto out;
 	status = nfsd4_decode_opaque(argp, &setclientid->se_name);
 	if (status)
-		return nfserr_bad_xdr;
-	READ_BUF(8);
-	setclientid->se_callback_prog = be32_to_cpup(p++);
-	setclientid->se_callback_netid_len = be32_to_cpup(p++);
-	READ_BUF(setclientid->se_callback_netid_len);
-	SAVEMEM(setclientid->se_callback_netid_val, setclientid->se_callback_netid_len);
-	READ_BUF(4);
-	setclientid->se_callback_addr_len = be32_to_cpup(p++);
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_prog) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_netid_len) < 0)
+		goto xdr_error;
+	p = xdr_inline_decode(argp->xdr, setclientid->se_callback_netid_len);
+	if (!p)
+		goto xdr_error;
+	setclientid->se_callback_netid_val = svcxdr_tmpalloc(argp,
+						setclientid->se_callback_netid_len);
+	if (!setclientid->se_callback_netid_val)
+		goto nomem;
+	memcpy(setclientid->se_callback_netid_val, p,
+	       setclientid->se_callback_netid_len);
 
-	READ_BUF(setclientid->se_callback_addr_len);
-	SAVEMEM(setclientid->se_callback_addr_val, setclientid->se_callback_addr_len);
-	READ_BUF(4);
-	setclientid->se_callback_ident = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_addr_len) < 0)
+		goto xdr_error;
+	p = xdr_inline_decode(argp->xdr, setclientid->se_callback_addr_len);
+	if (!p)
+		goto xdr_error;
+	setclientid->se_callback_addr_val = svcxdr_tmpalloc(argp,
+						setclientid->se_callback_addr_len);
+	if (!setclientid->se_callback_addr_val)
+		goto nomem;
+	memcpy(setclientid->se_callback_addr_val, p,
+	       setclientid->se_callback_addr_len);
+	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_ident) < 0)
+		goto xdr_error;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserr_jukebox;
 }
 
 static __be32


