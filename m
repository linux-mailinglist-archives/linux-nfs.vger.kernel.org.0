Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C52BB75E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgKTUim (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbgKTUil (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:41 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988B9C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:41 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so8132604qtp.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PRD5IJDUYim/vtvxyk+sitr0lSHX3HA5IU0Ccu4DtoI=;
        b=X7DYxj2Yd4No04cmxSDLznNGWTgOlK5DCiuDWS/Sxhr55ANwOLGjKMFgBV0AFQua4s
         tfDjZDANXUOYTXSwicQt5cibB+1EPey/F6twQ+iUFm3sxidEDwwt2ZnR53pXTK4Njmvt
         D5KWiHJtqyfPbUjsnxe4g9RbIPZTmeKwipsvibXw+dkDYqJd42l0wlmn/CAtA5nNPKzF
         Nc6AT5agSeHkotyLieIFlx+nmBTntJ4X4FFuqSBllS1qFci+ITsHvaA+XjxuCu16Z84E
         UVufwVVVaO3WAeJW+mjTChSNxwXQ3dgagxNoQtG2H29NUvexsWa9v000SuOkK+YCXJoi
         6t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PRD5IJDUYim/vtvxyk+sitr0lSHX3HA5IU0Ccu4DtoI=;
        b=uNXHXAXO0rJlrUvdpdtM7OxuyDlDlHm1i+30Rh8Mn1hv0eU4yAr7i58wruXYKmOoAy
         81qTZI3PDKPTqAwbeY+YBwjwLRexf39QEBGOYJI1j0qkejRwjbLOzzqDrMtXAIDg57Vj
         N5S9wsawC4m7iVlWZnGx8hSHW42Am/yE9wvQS80fwHPTaQmr9ry9jmGv8ORM+mIvAyam
         JKyB3wrBj3Sp43gjwglZz3flAVD9JduZCK8mbVmvomsJ69GVXOez6kaYloFmP1uHzwvt
         gqmN0F+Eu7Rh+RcYGIwa4Q8FKR747Jo0gotM2rob0UErJ3paVH0b/k+4ELukv+S2XV/Y
         9kMQ==
X-Gm-Message-State: AOAM5335T6GD2LtoWjsi/4f0fEjTq+KiIjRy07xfT0gWJ04h/b748G4p
        7mK2sEJoPtHdauZxcWOrxYll24y628A=
X-Google-Smtp-Source: ABdhPJw5GYrJH1LAek+tcnWtQNgbaScXpfX0nfOltUmlFI1IIr6qP1DQ6MZdJdDWJ8Z1Q8qEPE5moQ==
X-Received: by 2002:ac8:36bc:: with SMTP id a57mr17710423qtc.193.1605904720524;
        Fri, 20 Nov 2020 12:38:40 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k4sm2759475qtp.5.2020.11.20.12.38.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:39 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKccIr029368
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:38 GMT
Subject: [PATCH v2 055/118] NFSD: Add a separate decoder for ssv_sp_parms
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:38 -0500
Message-ID: <160590471875.1340.10002189081894492301.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   71 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a74d86564eb7..dc39b004bcb4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1427,13 +1427,53 @@ static __be32 nfsd4_decode_state_protect_ops(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+/*
+ * This implementation currently does not support SP4_SSV.
+ * This decoder simply skips over these arguments.
+ */
+static __be32 nfsd4_decode_ssv_sp_parms(struct nfsd4_compoundargs *argp)
+{
+	u32 bm[3], count, window, num_gss_handles;
+	__be32 status;
+
+	/* ssp_ops */
+	status = nfsd4_decode_state_protect_ops(argp, bm, ARRAY_SIZE(bm),
+						bm, ARRAY_SIZE(bm));
+	if (status)
+		return status;
+
+	/* ssp_hash_algs<> */
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+	while (count--) {
+		status = nfsd4_decode_ignored_string(argp, 0);
+		if (status)
+			return status;
+	}
+
+	/* ssp_encr_algs<> */
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+	while (count--) {
+		status = nfsd4_decode_ignored_string(argp, 0);
+		if (status)
+			return status;
+	}
+
+	if (xdr_stream_decode_u32(argp->xdr, &window) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &num_gss_handles) < 0)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
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
@@ -1461,34 +1501,9 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			return status;
 		break;
 	case SP4_SSV:
-		/* ssp_ops */
-		status = nfsd4_decode_state_protect_ops(argp, bm, ARRAY_SIZE(bm),
-							bm, ARRAY_SIZE(bm));
+		status = nfsd4_decode_ssv_sp_parms(argp);
 		if (status)
 			return status;
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


