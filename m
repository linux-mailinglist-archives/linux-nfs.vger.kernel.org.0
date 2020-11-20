Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677862BB73F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgKTUge (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731437AbgKTUgd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:33 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53B8C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:33 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id x13so5304776qvk.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cG/Gml7uczdP64/XPKiRPWOstwxwlYHF7gwENmq3ZLc=;
        b=drwo0ZQhX+SUCJwY9dkJnMrGosVc1pLLzWqQ4qDCwqgjzB+wvueyD52tLmwd2l/fB8
         sp7chP8YC7fjprfYq74GkQ52bxnoS1lZzFkmR6/cITBO77uY5Cmyj71GWqg3ei7X7nEZ
         KfgVQE46zjh8zWAWcjo/gqWUGHrzO7F649haJ+GxeJ72AYvoQxpLClA8IoaXqmIfWn14
         xpyZkasxmV8N0Xn7Qf5XS7he741RLjsUOCzX8LEXzQh+lOmjO+0bYlEqWCxBNGVFNBM0
         5XqoYzsohVoPsabVm+FPHW7x4QZZQYLicn9r8+1IZMX6S29N3A4Po7Ns0pVMQuW/Wm25
         kd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=cG/Gml7uczdP64/XPKiRPWOstwxwlYHF7gwENmq3ZLc=;
        b=c738SWmXXK2ncTXhOdUjAd93tIkpvAkgMgwCjGsX+6LHtJ6NZdzB/EmSrn/tZvf58I
         lfppZpZA2gNBpZ3mtpFr7z8W3wpzdSsGeTc15rd8qMHxj0rFAMJ3ENffst/hfGgI/G6I
         SbSLEjmOwpA95rnUhSATpe0wNsYtK6CSuiQEnp9+ym/NsFzR7mIH/bXRJAOeDZouUtV7
         CFa0+RsIXGLsF4ivMWcDllT3xz/z1wLMkzsbCqnuKcbDcMKzyN6tgTj0EFoq1qj5b8sh
         OH4OC1BGYDrd32xuYTl2fY9El3HT0bPgHVIuZPBpHrsZacAIoCKUVGK2P3mAFVy3xN1q
         Zo0Q==
X-Gm-Message-State: AOAM531NdSJDaN52IuJPm5W5d/MziwiA7Xvp0W0GgGLWFy2OTtHaXG0m
        ipWYP5nFzfL2vJ8Qt4n1GsxhpWc5XAs=
X-Google-Smtp-Source: ABdhPJzOkmEzghbjKiTLZwCZQ3fEK+VlWwjUct85jPaYWa829B7g9rDWW+VIlZERf6Fg6dxH0/HmuQ==
X-Received: by 2002:a0c:b59a:: with SMTP id g26mr17537919qve.26.1605904592551;
        Fri, 20 Nov 2020 12:36:32 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b64sm2837861qkg.19.2020.11.20.12.36.31
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:31 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKaV4Y029295
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:31 GMT
Subject: [PATCH v2 031/118] NFSD: Add helper to decode OPEN's createhow4
 argument
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:31 -0500
Message-ID: <160590459114.1340.3318665743129206416.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   78 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1bbb637d4625..e8646f1e0b6a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -893,6 +893,48 @@ nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup
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
@@ -993,39 +1035,9 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
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


