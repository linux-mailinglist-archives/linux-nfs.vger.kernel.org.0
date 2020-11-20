Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F375E2BB75D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgKTUig (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbgKTUig (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:36 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA88C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:36 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id l2so10269580qkf.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PkvRxXKbxE/hmkAq4ZjfEGSLtHeFPCbl574n04j5WCo=;
        b=JrXsMU3tvZ84iAitsAgEc/r51t+qYqWnO9PvG+GkIEPRbhoYz98A1cKc2cN87mpaTT
         Pcm2nnVewG+q8EuDHNwBmhifMM44yGVhHyLKpUbh/3xRmX1v7GOm1ZuoVEwjcVgK0Euv
         lW4TMYweVdU7YlR2exTWcEJ8BpBLHFdnS9NIpfR1WeKpWJReJKM43Kf5dLAC3OP9fswg
         5PtocIwCOwkiLVPuTLuTB+l0KBjA3jxD9CeBdYqqAUPJyqjLCLERlnyabL3DLU9t/NZJ
         n4roqNWMA2gl8MiyeHkg26Du85ZAK0ip3jTWR31zfOk/XOnbNGrQUjsI+VHmO9HtBlBT
         NRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PkvRxXKbxE/hmkAq4ZjfEGSLtHeFPCbl574n04j5WCo=;
        b=dbC50g4xjfuphmHNwqeshg72XnabpOoK5tPzwg8iHW4h3MPH+B4ag2M9EOwOE+S89A
         Y7LQGG4dmdJQhu4tDC3YKofTuvnooi+uhjH32l2rKn+p7PKE8re0NdqBLhn2H9TsnpTb
         aRHrJK3V+5eQJQZSK8huwpkXgTW+WwlNaMTCWyLIEQCzuuxGcMMhwUHrS5DU4Dk20KPa
         YMLhZjYAZ4pwKfgq3xXjaLqm0HIo3cgjGn0pW1GGxJFullH7DiaNqZ0B7hdd7otLHMCp
         4zQFHp1+GlMLZCizGJvalCMVqhdWSWCgPSynhUHYzo+hddeDhHYNvUMwB7Bcc4PVPBVN
         Roqw==
X-Gm-Message-State: AOAM532/GlA21m9tLwMU9KMAe82BKVV/sSbAw/C6SXDv2KR9VhoDDDmD
        G9xokSn0dR/L1bVrtYK8k88zfWk12As=
X-Google-Smtp-Source: ABdhPJw96YrpQv/9JzxEhVXob0tE23Tft5Vvvl0I6eZTgVBb9ua0endh9pnESeOIBm9wHCLsNFWvcA==
X-Received: by 2002:a37:a546:: with SMTP id o67mr19417091qke.167.1605904715117;
        Fri, 20 Nov 2020 12:38:35 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j124sm2873310qkf.113.2020.11.20.12.38.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:34 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKcXuf029365
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:33 GMT
Subject: [PATCH v2 054/118] NFSD: Add a separate decoder to handle
 state_protect_ops
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:33 -0500
Message-ID: <160590471363.1340.13844630450172330776.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity and de-duplication of code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   66 ++++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 43 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 48cb409f11c2..a74d86564eb7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -313,32 +313,6 @@ nfsd4_decode_verifier4(struct nfsd4_compoundargs *argp, nfs4_verifier *verf)
 	return nfs_ok;
 }
 
-static __be32
-nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
-{
-	u32 bmlen;
-	DECODE_HEAD;
-
-	bmval[0] = 0;
-	bmval[1] = 0;
-	bmval[2] = 0;
-
-	READ_BUF(4);
-	bmlen = be32_to_cpup(p++);
-	if (bmlen > 1000)
-		goto xdr_error;
-
-	READ_BUF(bmlen << 2);
-	if (bmlen > 0)
-		bmval[0] = be32_to_cpup(p++);
-	if (bmlen > 1)
-		bmval[1] = be32_to_cpup(p++);
-	if (bmlen > 2)
-		bmval[2] = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_nfsace4(struct nfsd4_compoundargs *argp, struct nfs4_ace *ace)
 {
@@ -1441,12 +1415,25 @@ static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_decode_state_protect_ops(struct nfsd4_compoundargs *argp,
+					     u32 *must_enforce, u32 me_len,
+					     u32 *must_allow, u32 ma_len)
+{
+	if (xdr_stream_decode_uint32_array(argp->xdr, must_enforce, me_len) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_uint32_array(argp->xdr, must_allow, ma_len) < 0)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)
 {
 	int dummy, tmp;
 	DECODE_HEAD;
+	u32 bm[3];
 
 	READ_BUF(NFS4_VERIFIER_SIZE);
 	COPYMEM(exid->verifier.data, NFS4_VERIFIER_SIZE);
@@ -1465,27 +1452,20 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 	case SP4_NONE:
 		break;
 	case SP4_MACH_CRED:
-		/* spo_must_enforce */
-		status = nfsd4_decode_bitmap(argp,
-					exid->spo_must_enforce);
-		if (status)
-			goto out;
-		/* spo_must_allow */
-		status = nfsd4_decode_bitmap(argp, exid->spo_must_allow);
+		status = nfsd4_decode_state_protect_ops(argp,
+							exid->spo_must_enforce,
+							ARRAY_SIZE(exid->spo_must_enforce),
+							exid->spo_must_allow,
+							ARRAY_SIZE(exid->spo_must_allow));
 		if (status)
-			goto out;
+			return status;
 		break;
 	case SP4_SSV:
 		/* ssp_ops */
-		READ_BUF(4);
-		dummy = be32_to_cpup(p++);
-		READ_BUF(dummy * 4);
-		p += dummy;
-
-		READ_BUF(4);
-		dummy = be32_to_cpup(p++);
-		READ_BUF(dummy * 4);
-		p += dummy;
+		status = nfsd4_decode_state_protect_ops(argp, bm, ARRAY_SIZE(bm),
+							bm, ARRAY_SIZE(bm));
+		if (status)
+			return status;
 
 		/* ssp_hash_algs<> */
 		READ_BUF(4);


