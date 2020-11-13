Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975BF2B1E1D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgKMPFl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKMPFk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:40 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E3C0617A7
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:40 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d28so8994819qka.11
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=r8Yab2+tDNnVlki6NOnGAygA7iZsesb/6/wOoAhA1Cc=;
        b=Fi9SQumTgSMCTIxBhLte9oqVkAY4ajjuP+Trw1/fMTFyBP5TlNL4D9kRjok1M+J1f2
         uNFMNIqot24jTfcZqb5W9ihlvx/KktIELifgBQShAtPMon6091RNuKQZtkk34CYz5x2q
         FVlfBy4Et7yu2RVi5Zlo24nA7h9ZUQW/maJMbyIb1NcasLh//6tIw2hKSpFcdFYvS1lE
         UKkG9rJfzZkhAiFwYXNFmfHafpq/N0FwzPPVlQ06fE9a+jnUdYvMRFJdPG/KPySCJhKV
         E+FgPLJHYpTGKLQ5mD6q/Se9ciyUPF1bfgCXman6XpzyeN/1xDd6IPMxTjO3hVzOEkaX
         xB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=r8Yab2+tDNnVlki6NOnGAygA7iZsesb/6/wOoAhA1Cc=;
        b=ZcochZDNQVInQ8rBeLNyTAZBYr8f/Vca9cpI/8lLAj0uFZn0GD7k5/Yh9qBijN6AMN
         zRL5s0loTHfLhP3xYWtKz6s43JTqvGJ6bPYYUY0rFjS6kHMVk+2SZsRGr+u4PHpgnADP
         4n/iLY7G7bh0o/LhlMJW4PF+Ge/ct8A280O5jBkgEb3kSfPMtA2qTtArnMXnoE4I+Kb1
         CSAHQJnEu7R72+shaNistRECnMHVivGjk4aXhDRNhIVhaSoz/xlS/FJYuBRsQpz8DmGW
         CFRd7h85lGoIHN0N64EWl0bGRfXQW6Owxy3tzvP+yNUMaOZJUPkZUJ5NQTVXi+fM3HiS
         iNlQ==
X-Gm-Message-State: AOAM531sO4RFKqyHCtQGUu1RyoIE7rc1j4sTkAVcmlRRPkG13b1HoEQA
        5I4dE4DuFXAR2gjiMviFR5R43VOY0fA=
X-Google-Smtp-Source: ABdhPJwJWWX5RYesOV2MKTWFJ8GXQ9jR5w4SIQqPDPfm5HhZhBqhfcEugF1BblriKrctAEMkhR2UQA==
X-Received: by 2002:a37:6351:: with SMTP id x78mr2278032qkb.301.1605279939338;
        Fri, 13 Nov 2020 07:05:39 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 9sm7050743qke.6.2020.11.13.07.05.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:38 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5bVh032748
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:37 GMT
Subject: [PATCH v1 37/61] NFSD: Add a separate decoder to handle
 state_protect_ops
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:37 -0500
Message-ID: <160527993774.6186.12332332687540138715.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 73a4b23849e2..ece4e8afe19e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1470,12 +1470,25 @@ static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
 	return nfserr_bad_xdr;
 }
 
+static __be32 nfsd4_decode_state_protect_ops(struct nfsd4_compoundargs *argp,
+					     u32 *must_enforce, u32 me_len,
+					     u32 *must_allow, u32 ma_len)
+{
+	__be32 status;
+
+	status = nfsd4_decode_bitmap4(argp, must_enforce, me_len);
+	if (status)
+		return status;
+	return nfsd4_decode_bitmap4(argp, must_allow, ma_len);
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
@@ -1494,28 +1507,20 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 	case SP4_NONE:
 		break;
 	case SP4_MACH_CRED:
-		/* spo_must_enforce */
-		status = nfsd4_decode_bitmap4(argp, exid->spo_must_enforce,
-					      ARRAY_SIZE(exid->spo_must_enforce));
-		if (status)
-			goto out;
-		/* spo_must_allow */
-		status = nfsd4_decode_bitmap4(argp, exid->spo_must_allow,
-					      ARRAY_SIZE(exid->spo_must_allow));
+		status = nfsd4_decode_state_protect_ops(argp,
+							exid->spo_must_enforce,
+							ARRAY_SIZE(exid->spo_must_enforce),
+							exid->spo_must_allow,
+							ARRAY_SIZE(exid->spo_must_allow));
 		if (status)
 			goto out;
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
+			goto out;
 
 		/* ssp_hash_algs<> */
 		READ_BUF(4);


