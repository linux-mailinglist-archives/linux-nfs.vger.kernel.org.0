Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC66F2BB77E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgKTUkX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgKTUkW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:22 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7DC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:22 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id x13so5309873qvk.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zhIHg8FeAPtzkYR53vnosXPYQvT+Jw2ttxtGJ7KfFKQ=;
        b=tY1F3vrP0aBOkdAGvC2zSYbJoJVcEajWYCxX6vpVL7ryuiRR6pIDATBMHT0jme/aYv
         LSUY/ri2C32KOVyzpCLeEBrBb9EyUXdz8QEzXXamubvdiDWc1FexdlMRt9vDEDdc5nUa
         Q45XVHlBQ6Ck8mtjoqiC+oDgOBpcUESsXVvFyYd7ljDoSZ/qyznI4qwjL8eNbHMtRweQ
         SWgEzZk3Q7KFVM5e9zCFnX/WJyXtbfTWvsBvxCOxoaIlxa1U7IEeBZm/P3OnM2Kztc6n
         1Ak+X7wxER40vlXXVjvoASFjndTPSH65NwOynpQ6Ouyoe/sBO8A+aYlbTKhinpzEWfOQ
         VbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zhIHg8FeAPtzkYR53vnosXPYQvT+Jw2ttxtGJ7KfFKQ=;
        b=drLaZMJJwj6K67XTN7PxD58PGiLbXQ+eaQktjzDIIx0b6D3JF92y6nNJw3Kiasiyl+
         c1Co9N8vIJhH8/cdm6xDs+Ut5QGQsRsEzT09uC/veDHOlLOXZYJTDF+jBE2zpKnlAOEj
         7rKCC3SwOoXjL6JTnur42I1UDgM7kN1yIGc0SkyFZmZ/Hd7KEkNwq7qTI1AFhHg4gDDZ
         QR8ppZPlYEdNNzPcDdYFZDXQfqHP8A6tmtK+BkhkIp8Ul9ZVUys1DQq2j44TkUkxBW22
         cn68JdD3c6+nfv+jODEAxRJRUGNZOWPipAZyHM29HZLGXBy5XRPozQ5v6NcsLmFK6Ed0
         3ElA==
X-Gm-Message-State: AOAM531MIk2/IOCWBTJ195n8STVdQAGXCZ9QLxez71uWUQs/4zTZt0m7
        FD/7c8ISUCJcaLcN2BnRtNsDZz45Amw=
X-Google-Smtp-Source: ABdhPJzmO+fvUhnxqNUTUBqOoJ4pNOA3KnGxgMzLDtrhC6GbQ2GBQhDpfK1zQ3hlqEL+E7pj0zkT8w==
X-Received: by 2002:ad4:548b:: with SMTP id q11mr17398748qvy.44.1605904821386;
        Fri, 20 Nov 2020 12:40:21 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c6sm3015918qkg.54.2020.11.20.12.40.20
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:20 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKeJ84029435
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:19 GMT
Subject: [PATCH v2 074/118] NFSD: Replace READ* macros in nfsd4_decode_copy()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:19 -0500
Message-ID: <160590481959.1340.9874410868824433151.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   37 ++++++++++++++++++++-----------------
 fs/nfsd/xdr4.h    |    2 +-
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6108f8ff36b2..84d69c436fd3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1924,9 +1924,9 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 {
-	DECODE_HEAD;
 	struct nl4_server *ns_dummy;
-	int i, count;
+	u32 consecutive, i, count;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &copy->cp_src_stateid);
 	if (status)
@@ -1934,30 +1934,34 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	status = nfsd4_decode_stateid4(argp, &copy->cp_dst_stateid);
 	if (status)
 		return status;
+	if (xdr_stream_decode_u64(argp->xdr, &copy->cp_src_pos) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &copy->cp_dst_pos) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &copy->cp_count) < 0)
+		return nfserr_bad_xdr;
+	/* ca_consecutive: we always do consecutive copies */
+	if (xdr_stream_decode_u32(argp->xdr, &consecutive) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &copy->cp_synchronous) < 0)
+		return nfserr_bad_xdr;
 
-	READ_BUF(8 + 8 + 8 + 4 + 4 + 4);
-	p = xdr_decode_hyper(p, &copy->cp_src_pos);
-	p = xdr_decode_hyper(p, &copy->cp_dst_pos);
-	p = xdr_decode_hyper(p, &copy->cp_count);
-	p++; /* ca_consecutive: we always do consecutive copies */
-	copy->cp_synchronous = be32_to_cpup(p++);
-
-	count = be32_to_cpup(p++);
-
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
 	copy->cp_intra = false;
 	if (count == 0) { /* intra-server copy */
 		copy->cp_intra = true;
-		goto intra;
+		return nfs_ok;
 	}
 
-	/* decode all the supplied server addresses but use first */
+	/* decode all the supplied server addresses but use only the first */
 	status = nfsd4_decode_nl4_server(argp, &copy->cp_src);
 	if (status)
 		return status;
 
 	ns_dummy = kmalloc(sizeof(struct nl4_server), GFP_KERNEL);
 	if (ns_dummy == NULL)
-		return nfserrno(-ENOMEM);
+		return nfserrno(-ENOMEM);	/* XXX: jukebox? */
 	for (i = 0; i < count - 1; i++) {
 		status = nfsd4_decode_nl4_server(argp, ns_dummy);
 		if (status) {
@@ -1966,9 +1970,8 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 		}
 	}
 	kfree(ns_dummy);
-intra:
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32
@@ -4718,7 +4721,7 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 	__be32 *p;
 
 	nfserr = nfsd42_encode_write_res(resp, &copy->cp_res,
-			copy->cp_synchronous);
+					 !!copy->cp_synchronous);
 	if (nfserr)
 		return nfserr;
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 232529bc1b79..facc5762bf83 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -554,7 +554,7 @@ struct nfsd4_copy {
 	bool			cp_intra;
 
 	/* both */
-	bool		cp_synchronous;
+	u32			cp_synchronous;
 
 	/* response */
 	struct nfsd42_write_res	cp_res;


