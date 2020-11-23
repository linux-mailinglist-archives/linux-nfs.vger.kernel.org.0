Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0E92C15DA
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgKWUI7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgKWUI5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:57 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730DC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:56 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ek7so9450835qvb.6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=avIS2zgACPqncgzUYiQJ+I+WSzAGG86j1QUPQ+4zttg=;
        b=qOF9/Wefpgd5Rr6l5VIzb6GWQwkFPpkXncnPgmjZtlnMTX9A0+F2nC69jgUYSHD1kw
         3ChTU0Q+RWJ57QpPE4bk+MhWdTjCPRgNp5Ma9Tj+wxZt75aAhCZyo/vqKbbg4PIXQGj1
         SYyDOXVbfAmsaloB3DDhNOKC9aIwdT4sFBWRNksgctQDL3L4N7J18m834AagThT8rCdh
         HuI3E2EbMOmFXLA0ZP+rYo9JhcaIMAjQ6WTY3uMz2Nm1PDHwTaNxsi2SIYNIIItBW3sY
         AhyuwesmcpGIrDLAzG4QejrzF2lfHUbfM2Fm/TJfVIlQzzigijHGDNcfo9Lbu0W88nPK
         Unww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=avIS2zgACPqncgzUYiQJ+I+WSzAGG86j1QUPQ+4zttg=;
        b=H77ZpBTMJ9caKeOdOIQCuoNpe5IlDkeaSoaLq2Ua1QlStWwYCEfB4ubzmUpf2I5VdR
         wORGAHzX0LLsSLL09uG5eyrGSrSNi1SIlSPtKVVAz3+3EdkqUvB7RwstLtTAOYuPu7kn
         LeFgYLedCbwFMRyUOpYjytflVzMo/8P1r5L+5EsN5PUN3Rtk+woksVGx5Vu+OrpFWlI6
         EvZW3X8DXHCpVj2Zc/Z5alXxR1F7khyMcmOLKk+f1fbkbs/xfYoQEYf+HwblTxBzw91b
         gig2SVuGX0eVY2ZsAd6nLHxZoXJR5Ljuob4bcjA/PoqH7unUotjthW2MvhbaXKoTBF1b
         pqPg==
X-Gm-Message-State: AOAM530IGYwIVM1tP1mUHQoQO8ztyQtCo40mQLeixruJKsKV0gaxnJjW
        jzMuqyn6R/5UGQqYojbe2tzCpWxabF4=
X-Google-Smtp-Source: ABdhPJwc0qPiVz3AqZPVFNw9GFEe1VUyWtyO2aoktQYD1CyYpI4UpWf2H43/GjneYChX0qJD4fyf2w==
X-Received: by 2002:a0c:e443:: with SMTP id d3mr1150494qvm.18.1606162135536;
        Mon, 23 Nov 2020 12:08:55 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t15sm8782588qkm.114.2020.11.23.12.08.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:54 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8rJC010444
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:53 GMT
Subject: [PATCH v3 56/85] NFSD: Add a separate decoder to handle
 state_protect_ops
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:53 -0500
Message-ID: <160616213392.51996.13089999437533932245.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
index 9989a6dfb2d4..165591c435bc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -315,32 +315,6 @@ nfsd4_decode_verifier4(struct nfsd4_compoundargs *argp, nfs4_verifier *verf)
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
 /**
  * nfsd4_decode_bitmap4 - Decode an NFSv4 bitmap4
  * @argp: NFSv4 compound argument structure
@@ -1496,6 +1470,24 @@ static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_state_protect_ops(struct nfsd4_compoundargs *argp,
+			       struct nfsd4_exchange_id *exid)
+{
+	__be32 status;
+
+	status = nfsd4_decode_bitmap4(argp, exid->spo_must_enforce,
+				      ARRAY_SIZE(exid->spo_must_enforce));
+	if (status)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_bitmap4(argp, exid->spo_must_allow,
+				      ARRAY_SIZE(exid->spo_must_allow));
+	if (status)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)
@@ -1520,27 +1512,15 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
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
+		status = nfsd4_decode_state_protect_ops(argp, exid);
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
+		status = nfsd4_decode_state_protect_ops(argp, exid);
+		if (status)
+			return status;
 
 		/* ssp_hash_algs<> */
 		READ_BUF(4);


