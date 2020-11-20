Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EF22BB752
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgKTUhy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgKTUhx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:53 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B370FC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:53 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so10215441qkq.6
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mdgljYVHNYCz0loJivKI9b69H22GCTRdsoXG2D8sKXs=;
        b=DBAQiiIUWXlemATOJMai7L4zls/SUtzKlDT1Fz1chmEoJ1Zyj/YZ7M5ng/nOMbog8R
         ka2RpC145nSaM0FUJhn7S+OpR7MgmVmTZ5LIwt7FGBWagrqqsNFn6rE2U59QJUHOZCJP
         q1KZbXwVwaoOmVX/mLbm4znSGHAqs3MnQS71bHsL2rlWKJfvBJkwzfiK/HB/u1IuiTco
         6ERBC8qXZ223lCv6nmmrLsau+j5jybumtthuXkIelnH24cGhUBgzM5o4Snzo/k8a121O
         uvaIWynnm8rjzn3Il55gtVdvhbLyIjPcSUjN3boo6GGQMe209dFGkpAqVnXr5gaCMATo
         fScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=mdgljYVHNYCz0loJivKI9b69H22GCTRdsoXG2D8sKXs=;
        b=XabEi0uE3gRJ/H6c8LuqR0xlMAX/qE9XIJ/biPHbivjygi1W9DJ6rvNyf73+IrdXkS
         YJS9kf7y9X5qNBGFyjcZ5mniesRek7MrRZbmkLbYAMRoBH/ud27JRamkoyzw2I4IHnQT
         tkCo2dxMdYq+2HlJdHw51/0r/BTj6YqB9n1uQTb6u1zF97aBQj7RJjBGVApQRwVMJMfP
         CchM56rdW34oHHv7P1eSGPV0amXeD5rgQsHCdbYWfSP+gyYl3ZF5fvib+I+dr7qjh7Co
         l30DPp3PqvNIKlJBjutMSKKn985iaKT7R6EwR8UDO3FZfK2tO35VYDDNUj8w4jLkp01i
         EePA==
X-Gm-Message-State: AOAM530cT25Ql2emTdJYgfUvWc2Yyp58K9vf72i72FlvKy+xSztT4G+U
        ZwZ57eaKLEBOSijRFSYHNws9fWZPTuw=
X-Google-Smtp-Source: ABdhPJyU2N3eV35FDkAwgaaV/IWT8RUeTK1QqqO/kdNhFBDFezkxI47tkxWLUxzBK+wGsAehMKvCSA==
X-Received: by 2002:a37:8c03:: with SMTP id o3mr18953277qkd.41.1605904672689;
        Fri, 20 Nov 2020 12:37:52 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d3sm2651222qth.70.2020.11.20.12.37.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:52 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKbpOF029340
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:51 GMT
Subject: [PATCH v2 046/118] NFSD: Replace READ* macros in
 nfsd4_decode_setclientid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:51 -0500
Message-ID: <160590467100.1340.16637234239973341346.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 98297182118d..bd950ad7021c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1256,31 +1256,46 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
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
+		return status;
 	status = nfsd4_decode_opaque(argp, &setclientid->se_name);
 	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_prog) < 0)
 		return nfserr_bad_xdr;
-	READ_BUF(8);
-	setclientid->se_callback_prog = be32_to_cpup(p++);
-	setclientid->se_callback_netid_len = be32_to_cpup(p++);
-	READ_BUF(setclientid->se_callback_netid_len);
-	SAVEMEM(setclientid->se_callback_netid_val, setclientid->se_callback_netid_len);
-	READ_BUF(4);
-	setclientid->se_callback_addr_len = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_netid_len) < 0)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, setclientid->se_callback_netid_len);
+	if (!p)
+		return nfserr_bad_xdr;
+	setclientid->se_callback_netid_val = svcxdr_tmpalloc(argp,
+						setclientid->se_callback_netid_len);
+	if (!setclientid->se_callback_netid_val)
+		return nfserr_jukebox;
+	memcpy(setclientid->se_callback_netid_val, p,
+	       setclientid->se_callback_netid_len);
 
-	READ_BUF(setclientid->se_callback_addr_len);
-	SAVEMEM(setclientid->se_callback_addr_val, setclientid->se_callback_addr_len);
-	READ_BUF(4);
-	setclientid->se_callback_ident = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_addr_len) < 0)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, setclientid->se_callback_addr_len);
+	if (!p)
+		return nfserr_bad_xdr;
+	setclientid->se_callback_addr_val = svcxdr_tmpalloc(argp,
+						setclientid->se_callback_addr_len);
+	if (!setclientid->se_callback_addr_val)
+		return nfserr_jukebox;
+	memcpy(setclientid->se_callback_addr_val, p,
+	       setclientid->se_callback_addr_len);
+	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_ident) < 0)
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


