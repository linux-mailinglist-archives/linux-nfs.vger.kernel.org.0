Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F682B1DFE
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKMPDk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKMPDk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:40 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD4C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:39 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so9007426qke.8
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7F7toeXXpj1cwJokQan7OnHmRjpiJzeXTetH7DOMuLc=;
        b=ddgkbcRDsLXPLysqDknMaYN69+Wb+yFpSLhFAEKZ7cqf7bY7IUtIk/S9z3QwVC91zT
         ClDz6FXi+AaHZwz+g8HSDnAxg1Cu3dXlCjqxLPd3htX7yEKf/LUoqlaxa4rp6RW8Afu8
         Mio2R56gcFnVMSxBYZXprtG4JEm1z68xVPhuufC/FFCBwuZrhwAqVxFDBa+fTCjyXmbd
         UP1SE9edV4S6fDp6DK4nLk0APwg77yQdQbDMfKFIYaQTsOrWfzLOGVMysSf3kzlR07e1
         xQ4TDCiFck7kY4oriDM07ATXNzJJj/NB+j4HmD+T1U9wwaW2xYV09nord3JU2IBTRLFf
         N8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7F7toeXXpj1cwJokQan7OnHmRjpiJzeXTetH7DOMuLc=;
        b=BU96oKPpAq2C/gn3O1JOFBrLwCoh2gzXz1uYe0hSUA5UfNysoBshdRXr2XdaMa1tGt
         pPxN2XIIu+aETwA9zA8ojXOlGecftYJPeEdrNH+fEk6fVmKsVL+PMCZjeeDByq3r8Q1f
         8MD9Qq5M2TrGFiHAVKlpysoJqG9eia/PRYozb/waXkMe2HuYI8KShLVeOEkGqFB+DPT5
         iN8ys1IXrlWjUVJ56nUBIM/EoNkf8tqzvH76jv7lTMSuYEdvW+3Eb3MmgaEyRScCoNiW
         RfrdgPmACaQ7UqUXmHQCW4gY46sHQXs9yi9EGKtaS8yMbGyMfbyAiS3Tvj+MwiIiqYU3
         3BfQ==
X-Gm-Message-State: AOAM533PtCJAgEoDAg8g5ugfcaMErJOBcAF0UFPF8cmaM6DunLuejkTF
        P4Q/mGLksiH7LtIvUwSDe6xBqXSTJyA=
X-Google-Smtp-Source: ABdhPJwKarONXvy/krxil4HAm79cI/5QeiL87LJLd4CXDwfStCqVBahgWPzgHgMujyO+l5GOcqnt6w==
X-Received: by 2002:a05:620a:140d:: with SMTP id d13mr2449156qkj.470.1605279818719;
        Fri, 13 Nov 2020 07:03:38 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h6sm6399460qtm.68.2020.11.13.07.03.37
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:38 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3aeQ032679
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:36 GMT
Subject: [PATCH v1 14/61] NFSD: Replace READ* macros in nfsd4_decode_lockt()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:36 -0500
Message-ID: <160527981695.6186.15360339795390564596.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 35329e3d1339..3c4777cb4d38 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -808,20 +808,19 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 static __be32
 nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 {
-	DECODE_HEAD;
-		        
-	READ_BUF(32);
-	lockt->lt_type = be32_to_cpup(p++);
-	if((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT))
+	if (xdr_stream_decode_u32(argp->xdr, &lockt->lt_type) < 0)
+		goto xdr_error;
+	if ((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT))
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &lockt->lt_offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &lockt->lt_length) < 0)
 		goto xdr_error;
-	p = xdr_decode_hyper(p, &lockt->lt_offset);
-	p = xdr_decode_hyper(p, &lockt->lt_length);
-	COPYMEM(&lockt->lt_clientid, 8);
-	lockt->lt_owner.len = be32_to_cpup(p++);
-	READ_BUF(lockt->lt_owner.len);
-	READMEM(lockt->lt_owner.data, lockt->lt_owner.len);
+	return nfsd4_decode_state_owner4(argp, &lockt->lt_clientid,
+					 &lockt->lt_owner);
 
-	DECODE_TAIL;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


