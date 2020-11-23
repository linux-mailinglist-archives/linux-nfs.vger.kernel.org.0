Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D3E2C15AB
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgKWUGY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgKWUGY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:24 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36454C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:24 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id v143so18259178qkb.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SjMO1Gd0veW9RySsvYEzSSao9vGqUk4dSoiUgcwekcs=;
        b=IEp3LFTJ3trN33al2uOHPkBeODmzQCEjAUUefhzg9VdLOghbgJVRGeB3yrODjcc0xE
         FFSRIST+PdRjZvEp2j06Tond3pISIe7PcVnVdlXs92jlFvCNYDHmCajZOFkwH3njghMI
         kolaru+/x3BSKC2WJZCGNstWYNkzuyre1wVYUY9yPfC3hB7AoqBFwwxXQQXk0gDCGhGj
         laJ/fSob4clC99J7BqHnMQgZOzfILsq6Ohzr/0huyilHsk09v7bNDdcxizBYQJYZjek9
         NLVHpfqmdKWXM8IxfHcPvGgNJsWtj5yFaTXhgWZauvbzYsv8UoRVx+tSI3UQ469lqfdB
         g3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SjMO1Gd0veW9RySsvYEzSSao9vGqUk4dSoiUgcwekcs=;
        b=stNXyH/qVWDmT6NR4IoGc4+Vhb5v3vDtiFUSXzh+3chgCq6gdOr4x1mXwwmVHBhE2R
         l8+llOQ+SerFPXeq0GcaHfSI4E+pkCE/9fHfQryVT2oUKNQQwZ5NPwIqJWjym3wQcNcD
         pZIfJtEevJTy/KG8TTXhQg3ZVdCFjMQH81H53GRUW2kVEAZy7lXCyUEWp94X8NVcttSc
         CK5RbXC4MLvzOPvybGYSlABapSQC7mJBCepk9RqVCoMzJUFrX5rjnypWwR7PE9N+iWIW
         j9irkMF9HMk8s0ee1HADRWvSs9Hmu49FgLFntWYjykOY8725iHyj4PAvY8SiMdr09Ygn
         nbOQ==
X-Gm-Message-State: AOAM531Z+M0T0LVG3mFq3MteQLOuORZ/Z2wPPKtt0ad62nuC8o72NUeF
        62v/h7MTZLNf10gasEja/MC76oLHLyI=
X-Google-Smtp-Source: ABdhPJyoKlupbwtVWLfX4amMJQ85qzTidF4dmqGg1yUsSFUjbWtMKiCSSf6bMpZp0UU6KlMHBVQoSA==
X-Received: by 2002:a05:620a:1590:: with SMTP id d16mr1296447qkk.88.1606161983088;
        Mon, 23 Nov 2020 12:06:23 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a20sm9696207qta.6.2020.11.23.12.06.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:22 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6Lmo010349
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:21 GMT
Subject: [PATCH v3 27/85] NFSD: Replace READ* macros in nfsd4_decode_lock()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:21 -0500
Message-ID: <160616198125.51996.11334770723860822177.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a209f3c8ec06..884ab920bcf8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -878,21 +878,17 @@ nfsd4_decode_locker4(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 static __be32
 nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 {
-	DECODE_HEAD;
-
-	/*
-	* type, reclaim(boolean), offset, length, new_lock_owner(boolean)
-	*/
-	READ_BUF(28);
-	lock->lk_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_type) < 0)
+		return nfserr_bad_xdr;
 	if ((lock->lk_type < NFS4_READ_LT) || (lock->lk_type > NFS4_WRITEW_LT))
-		goto xdr_error;
-	lock->lk_reclaim = be32_to_cpup(p++);
-	p = xdr_decode_hyper(p, &lock->lk_offset);
-	p = xdr_decode_hyper(p, &lock->lk_length);
-	status = nfsd4_decode_locker4(argp, lock);
-
-	DECODE_TAIL;
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_bool(argp->xdr, &lock->lk_reclaim) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lock->lk_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lock->lk_length) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_locker4(argp, lock);
 }
 
 static __be32


