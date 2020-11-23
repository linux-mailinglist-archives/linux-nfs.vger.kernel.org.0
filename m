Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D765F2C1618
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgKWULJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgKWULI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:11:08 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C53C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:07 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h11so6674658qkl.4
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=u66n5aUMhzsCE97i4gsrGV9OfwPKtnOH6hPiaybQXyE=;
        b=Qvauw+U9+TD0v4ZUhuzXqJtEMG5kGj+YXqoObWabwsZePrdViFOUIGOHK3YJweh+uQ
         7K/vhYeRKiv3mYr5dy3Te4QpSvgtYhx93E7FIm+Mex8xrorP9MdM2ZDl3ftJAWtsgTB5
         gY8CpOUPKmHysioC7nvvBiX/8EckIBatibXlLFuoNzzdsipKpKYHt//8YzgLIkqlZDrO
         pI5hGn1osiJBlJsOvgYO6i5EijrFRML40CqlXhwJILsXlN13q5AKpFDBmBkWEWEHKVda
         5oWM+ePgky1vWZXRUey2A7qZhZAogCkwhQ07ucjlBnl6oZ5McueBTZFrRr6pYyNImKEi
         jtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=u66n5aUMhzsCE97i4gsrGV9OfwPKtnOH6hPiaybQXyE=;
        b=hnlr26kUljrHE7TcDVKfTe12K6nnP4J65skGJ4rkzuFj6nQ+ZI+loeki/X4cWficwe
         WkYj/9slm8lnpFOxcIfdcS1Z9JN0dHsQDrqTeaKZ3pN4rHmZIjVUaf8ebbfNFkIfuI/l
         0jDNJ7zbt9p3dfRhjH9fl6R9b68f8xCqRj5jSfDKeIfyptqzMnCgpKMukPPbuDhZBxnw
         z4tCcnPbg6xi9MmNTsMrPvP1Xw6C2s0n92J+j1i8ZA64vmZv5vjHZ59c0SzT2N+GwfmU
         ap8ohk4r3DyS3HbCJAulJC6XTa6gN75rIMMM3ty/PI/upGgQyfZ0VyGrh1gDO9fe7iJE
         sIlA==
X-Gm-Message-State: AOAM530JnBRFPg+QpAQvlhjICoceaoBoa82cKaqcNu2PY6YWPGlzwH6z
        YevyWOltd208KGuh6IEaaLIQ0/deQSY=
X-Google-Smtp-Source: ABdhPJy7DAMoBFHwS0NuuCdAVepW2p+SOjSJMUpBeE0cWPdwupTBPCLGZ3XfkGsdmwVcneHxA+aagA==
X-Received: by 2002:a37:8ec5:: with SMTP id q188mr1321157qkd.85.1606162266485;
        Mon, 23 Nov 2020 12:11:06 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k188sm10736649qkd.98.2020.11.23.12.11.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:11:05 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKB4n7010527
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:11:04 GMT
Subject: [PATCH v3 81/85] NFSD: Replace READ* macros in
 nfsd4_decode_setxattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:11:04 -0500
Message-ID: <160616226477.51996.17111388682770526823.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 90068c32a566..2f47fef17b59 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2184,11 +2184,11 @@ static __be32
 nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 		      struct nfsd4_setxattr *setxattr)
 {
-	DECODE_HEAD;
 	u32 flags, maxcount, size;
+	__be32 status;
 
-	READ_BUF(4);
-	flags = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &flags) < 0)
+		return nfserr_bad_xdr;
 
 	if (flags > SETXATTR4_REPLACE)
 		return nfserr_inval;
@@ -2201,8 +2201,8 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 	maxcount = svc_max_payload(argp->rqstp);
 	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
 
-	READ_BUF(4);
-	size = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &size) < 0)
+		return nfserr_bad_xdr;
 	if (size > maxcount)
 		return nfserr_xattr2big;
 
@@ -2211,12 +2211,12 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 		struct xdr_buf payload;
 
 		if (!xdr_stream_subsegment(argp->xdr, &payload, size))
-			goto xdr_error;
+			return nfserr_bad_xdr;
 		status = nfsd4_vbuf_from_vector(argp, &payload,
 						&setxattr->setxa_buf, size);
 	}
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


