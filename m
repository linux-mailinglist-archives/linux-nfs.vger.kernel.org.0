Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4FC2C15C1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgKWUIP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgKWUIO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:14 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E42C061A4D
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:14 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id es6so691366qvb.7
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/9+6pTI7jWoQ5xYJuv0PkuSmbXpI9rSJ2d5sfikdqwI=;
        b=IOOxs9pglGd6f9wYAU+BuI2rq+msoSVQxsMFOKWX6XbKXXdVal3kQvBq+mMIUqhrii
         U09WwYJgQADzy9QVvJFDe+qL4BIWWg815om3Ym8620qQOD2rdiU6bujRFtZ4fcxFS9sj
         GazZxnfHywI8SHy8xPowB+RiR2K/EI0k3crd8BHbLvyP0EPyuYr1w6oYz4nPSA4Hf4mX
         qWButXFindanNXtuHj4CPzYWPzm43eEjNNOYS32Kq2Z42Q45GdfJvbMPsC4ft8IxwVC6
         oer5FkeII7TqroX9Sejj9yN2BsvDeZTaW8S3OxGkBO9zOPg2vJoNr4vYhqTlZ5hFii9U
         8RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/9+6pTI7jWoQ5xYJuv0PkuSmbXpI9rSJ2d5sfikdqwI=;
        b=W0Ic9vYIat3pjeIMZlaZ6eCCauqWggM2L3SfRweMpLmH8cowjq3/W02Gu0xHKc3MPD
         FRarw7pc1A+TqmA0Fb9fZ8KSYNPIMh0iMnvrAMRSdnmBi3JwoZMMK6uG+HANPTG048MI
         lbySlwtqaoUGWZyxcRVx9JTJbhHObRhIR1Xt2XmZYSPS37q10S0S9xC1J3cgWXFwxZLb
         tPSveP7WIZiPrCS8M0+OAf3eVC1KgcN56o4Te/YC1WebiKgW5bcfvtJIZLbmTtENOtpW
         crSPKmTx36yf3+SpQin7zE1TV77fWssFhyH7I0xHwrV19M5trb121jERICP+Tt6bOjOB
         xWWQ==
X-Gm-Message-State: AOAM530RmoXrPg6AU1ixbRZ/LYjMyZL5duxO9k0Lnt6vB3OaceKrHxpA
        HT05BtzWrV8UMPOTma2cgi4tDJZmFyE=
X-Google-Smtp-Source: ABdhPJzN3pKIbd0ll8iGU3BXf+xlqsBKkwH8F+181iUSoF4Zcu5yDF3g+2EJyGDeU5+a9NEJoB4H+Q==
X-Received: by 2002:a0c:b181:: with SMTP id v1mr1123992qvd.36.1606162093256;
        Mon, 23 Nov 2020 12:08:13 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q62sm527806qkf.86.2020.11.23.12.08.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:12 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8BUB010420
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:11 GMT
Subject: [PATCH v3 48/85] NFSD: Replace READ* macros in
 nfsd4_decode_setclientid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:11 -0500
Message-ID: <160616209164.51996.2207710435528521213.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
index 5a1d92290e6f..550d38ee926d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1310,31 +1310,46 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
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


