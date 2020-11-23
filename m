Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD212C15B0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgKWUGv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKWUGu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:50 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D866C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:50 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so14335433qtp.7
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DoH1LJ+J6z+aK1+GGXSqu4NL2ViFiMSAjVGf3jGoDEI=;
        b=kDrwvQ6TXNr17fJPA+48svunq7ZCiAu318I/8pXA55wfoUdn/mOfTudoGe/YYRqoMY
         FZX7Wa0jBtvwgBjSOUsz29Y5lZRfvIDFMc/VACGGmwi3N+n0exyU/UMwMIcXoWcw8prB
         sIrzVmvzAbv51t33ZqxcYQyumTyKJEiFKxS3z8V5k3qcz8bL2jvPIoPIDEcv5EN2xChL
         mBWwVEmaY6fDFICU3K+ohYZXfNFFYOV+hsiASsUg0lc6W78c1ERg8BLQzH9sLYMKCyPv
         D/ISn78Qoh1m66DIHxMw3y35e67eXSjFIjvaNVa/vNO/zST3V3Ipyp1+Fg0Kr4bThqbn
         keFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=DoH1LJ+J6z+aK1+GGXSqu4NL2ViFiMSAjVGf3jGoDEI=;
        b=rP4qdYPWgdqUb/r6M7cqTy/koicjWxUJxnaSyF1Qim9vZSKHeoHuxk/DMYxaDaAZUr
         azb6nN5xyzR88Z+/YZQWh1AsZgNh7vs4GCespZdqCTX2Su1oDvDXXIgZve2hcRYRljY7
         sgl4sYhk/AxU5p8KHm8kFnpiw57T4cN0bOPZKhjDibvbuqkaKU6NPxRmRZHLIo1H6S93
         rdR4qE2Z+1daPxoyVwnHRHw9U+hKXLhD1Akx+QiSrem0+WLmr/STOEdjAI4ENb2MJAlr
         g3xF4YSEPh9YVwzRKDKPPI80CokMJn/9yVNGZbFKuU1LqF2pOMkEJoOLnOToW20bcFBf
         w1Ew==
X-Gm-Message-State: AOAM530oKIjkikMNh5ZKGv8oWYNYXk68lofjDvsH+t2l9u919VUvn2DR
        /TVdYrJ7Oz62L47tYjwJDDPMhGlXliw=
X-Google-Smtp-Source: ABdhPJxf2wJ8f2ebRxQsDpxKSnSo8vdUMnGUCrrehipG5+DbPEF+6RMaoQWJOvHU5EMxKV6omhKMbQ==
X-Received: by 2002:ac8:678c:: with SMTP id b12mr902583qtp.258.1606162009382;
        Mon, 23 Nov 2020 12:06:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y44sm11541260qtb.50.2020.11.23.12.06.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:48 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6lQ8010364
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:47 GMT
Subject: [PATCH v3 32/85] NFSD: Add helper to decode OPEN's createhow4
 argument
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:47 -0500
Message-ID: <160616200767.51996.18156890288117799942.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   78 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7254c9e4e825..579139d727ea 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -946,6 +946,48 @@ nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup
 	return nfsd4_decode_component4(argp, &lookup->lo_name, &lookup->lo_len);
 }
 
+static __be32
+nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
+{
+	__be32 status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_createmode) < 0)
+		return nfserr_bad_xdr;
+	switch (open->op_createmode) {
+	case NFS4_CREATE_UNCHECKED:
+	case NFS4_CREATE_GUARDED:
+		status = nfsd4_decode_fattr4(argp, open->op_bmval,
+					     ARRAY_SIZE(open->op_bmval),
+					     &open->op_iattr, &open->op_acl,
+					     &open->op_label, &open->op_umask);
+		if (status)
+			return status;
+		break;
+	case NFS4_CREATE_EXCLUSIVE:
+		status = nfsd4_decode_verifier4(argp, &open->op_verf);
+		if (status)
+			return status;
+		break;
+	case NFS4_CREATE_EXCLUSIVE4_1:
+		if (argp->minorversion < 1)
+			return nfserr_bad_xdr;
+		status = nfsd4_decode_verifier4(argp, &open->op_verf);
+		if (status)
+			return status;
+		status = nfsd4_decode_fattr4(argp, open->op_bmval,
+					     ARRAY_SIZE(open->op_bmval),
+					     &open->op_iattr, &open->op_acl,
+					     &open->op_label, &open->op_umask);
+		if (status)
+			return status;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *share_access, u32 *deleg_want, u32 *deleg_when)
 {
 	__be32 *p;
@@ -1046,39 +1088,9 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	case NFS4_OPEN_NOCREATE:
 		break;
 	case NFS4_OPEN_CREATE:
-		READ_BUF(4);
-		open->op_createmode = be32_to_cpup(p++);
-		switch (open->op_createmode) {
-		case NFS4_CREATE_UNCHECKED:
-		case NFS4_CREATE_GUARDED:
-			status = nfsd4_decode_fattr4(argp, open->op_bmval,
-						     ARRAY_SIZE(open->op_bmval),
-						     &open->op_iattr, &open->op_acl,
-						     &open->op_label, &open->op_umask);
-			if (status)
-				goto out;
-			break;
-		case NFS4_CREATE_EXCLUSIVE:
-			status = nfsd4_decode_verifier4(argp, &open->op_verf);
-			if (status)
-				return status;
-			break;
-		case NFS4_CREATE_EXCLUSIVE4_1:
-			if (argp->minorversion < 1)
-				goto xdr_error;
-			status = nfsd4_decode_verifier4(argp, &open->op_verf);
-			if (status)
-				return status;
-			status = nfsd4_decode_fattr4(argp, open->op_bmval,
-						     ARRAY_SIZE(open->op_bmval),
-						     &open->op_iattr, &open->op_acl,
-						     &open->op_label, &open->op_umask);
-			if (status)
-				goto out;
-			break;
-		default:
-			goto xdr_error;
-		}
+		status = nfsd4_decode_createhow4(argp, open);
+		if (status)
+			return status;
 		break;
 	default:
 		goto xdr_error;


