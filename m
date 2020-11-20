Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0465C2BB747
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgKTUhQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbgKTUhQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:16 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA6C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:16 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id a13so10235036qkl.4
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kKlFrNj26iWOwNXxO4zNteTIOXxE8vsJlSRRXw0plhg=;
        b=kyQ1L2CfJkWVHUM9oiVs5ryhBWHXEszBXrPeVo/aZkvWxODzP503HPiWc05x65ot1W
         31uuaXt6FQDUPDkVkNc1a1YIUFUo47QQ30vB3i7dlMIlrKUHVwPdzpqQx7k9d9G+Wn2I
         Ham2q+aDqv3I05HLyE2lrJjIII54l+4dJaMt70VzNkqJtRRazJeLtvGQO7SSiBqxSMLw
         N7+x9q/Vp7lNmFcM4jFn7fCwCyJVjqat/D86r7u5wSbrAk1fWJtrh+SzJnH3OYvLCy8u
         WTKSSuc8yNyPwZjzmZ7p5xY4ZUsPUegYF7DJHu72LV1bFkJ48SuRZ0EM89gtAQDOj2NX
         5+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=kKlFrNj26iWOwNXxO4zNteTIOXxE8vsJlSRRXw0plhg=;
        b=GiCpbszBqz2ohsxb1TqXY/gicawtwq0xHfTo13UzeoUhl7bp79ec9uxXUrmIZbz2ao
         5AcVNs+IDFEkXGhshbvx9hS09w4Z1gbADbrTN01GHFSPKcFZfxHAJ+L/zW5anzKxZjB5
         XqflwbsTh1yn6GPNCvfSALfgfau5UfJ4Y3HYpAd/BwWmiQS8DFI/jCYDLBr5zcLjIgvl
         +Um/S124hMF5iZ+UWAZWxlvuHvQkc94qYiC+yYbHzvu4dGmY9u/JPl5NgNtAWTloF4ck
         ricptv0TiJdkkF7eNFDqUp4rn7xdyUP2Q6hKPXVBwdd8yCqOnPbxS7FEeKze8Z2vxmDT
         LhXw==
X-Gm-Message-State: AOAM530krEG4ibYXb5piUVzs8k7cPFkFfocf7GR5ZimwzlWagquO0iEo
        09y7xhuAM3ZRjDRbhn+cj8i3G0uCNlg=
X-Google-Smtp-Source: ABdhPJx8X63Eaq3rkNetooDW+3YYBBfi5JQaZZGbISgPtxAp4EBiO7+4hRrDTyZ5mN4/yEX+ccd+rw==
X-Received: by 2002:a05:620a:4c8:: with SMTP id 8mr17935517qks.182.1605904635062;
        Fri, 20 Nov 2020 12:37:15 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e10sm2736244qkn.126.2020.11.20.12.37.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:14 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKbDFp029319
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:13 GMT
Subject: [PATCH v2 039/118] NFSD: Replace READ* macros in nfsd4_decode_putfh()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:13 -0500
Message-ID: <160590463328.1340.7042515486859858087.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index fdc6ba702132..1f06101a3b36 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1136,16 +1136,21 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_d
 static __be32
 nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 {
-	DECODE_HEAD;
+	__be32 *p;
 
-	READ_BUF(4);
-	putfh->pf_fhlen = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &putfh->pf_fhlen) < 0)
+		return nfserr_bad_xdr;
 	if (putfh->pf_fhlen > NFS4_FHSIZE)
-		goto xdr_error;
-	READ_BUF(putfh->pf_fhlen);
-	SAVEMEM(putfh->pf_fhval, putfh->pf_fhlen);
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, putfh->pf_fhlen);
+	if (!p)
+		return nfserr_bad_xdr;
+	putfh->pf_fhval = svcxdr_tmpalloc(argp, putfh->pf_fhlen);
+	if (!putfh->pf_fhval)
+		return nfserr_jukebox;
+	memcpy(putfh->pf_fhval, p, putfh->pf_fhlen);
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


