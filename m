Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2074BC21F
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 22:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbiBRVbP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 16:31:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbiBRVbO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 16:31:14 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB9377C0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:56 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id c14so17244645qvl.12
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+EQAu6/JZZI4LlgaIWtI3TqryfLPflDV7aWi8ajn/D4=;
        b=LdXNJsWUDbL1H1Hz+FSNTmyMPU859xgGbBGks2/9WW5UVI/IVwF7/Q5LYvuziUmJ3p
         xUrDHK3J/i0pz1z/6kuGKUpy17IqiiZ0coUCZo0gWmu4T7uWuGIVZDJIiFVtswXMcDet
         oh11Te0m985E0F9wO1EX1+67E+wyloLbVDaZCw7ZxdsE6tcaVNBfs5r5I/dDjrVa6hfF
         YTa298ExqH42WhMjmeKMSQurl+YwC7morjv6EAGMlIT/wxngGxvj/jqGntc/+GPK2eU4
         7E1rew1O+NwtADw6pHxBfFWs94Os0EBkTp2dlAFdRAC4SwpScNYwlOKMbHxrLrP+o5uA
         LOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EQAu6/JZZI4LlgaIWtI3TqryfLPflDV7aWi8ajn/D4=;
        b=Mskwt2GYWNLVXpQJdEatC0QTAIOhtWTvG2siShQrWDTBjzvWGkxnne/fnWCahdMbqI
         EOPz+1TzQomqDOL0LKRHs4v5xh77HqziEjdblTSAntQz7wZrCvOE01/suP+0X3LnD+vp
         IfAtqufj/PlPIkbADOsP6rNT8qc6T/xL72Q9pEQF4Vcnb1yoWrfnRgrBEJBbYs0JDeyv
         RWjg+49MFhWgOFtxKO3MXa4hKIueD8RYirEvzz/rgats0j8jUcI6bvhZFDvLn09Qji3p
         I7m/e9VaS3bQ7iV9Pvfke+xcfMCIeN9K+6GeJzjDABlAEJ8K+z7KSiFrhnzFrt1rHAa1
         q2WA==
X-Gm-Message-State: AOAM530+lYNqnIf6CIECuzqnJ6dqSMrTq2EmRZHpuBtcp32Rtz9KAco6
        Ql5dJrbRtG1dFputDNaW+UcXbZCbyw==
X-Google-Smtp-Source: ABdhPJxaGZT5obRGOYj6xU3dJcPbdEJdCVfikzzEPINPso6CFyBq+SMUNY/xQOmaSfMged8vgUUHmA==
X-Received: by 2002:ad4:5943:0:b0:425:76d8:90cc with SMTP id eo3-20020ad45943000000b0042576d890ccmr7436605qvb.105.1645219855331;
        Fri, 18 Feb 2022 13:30:55 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id w22sm26928656qtk.7.2022.02.18.13.30.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:30:54 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 6/6] NFSv4: Ask for a full XDR buffer of readdir goodness
Date:   Fri, 18 Feb 2022 16:24:24 -0500
Message-Id: <20220218212424.1840077-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218212424.1840077-6-trond.myklebust@hammerspace.com>
References: <20220218212424.1840077-1-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-2-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-3-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-4-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-5-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of pretending that we know the ratio of directory info vs
readdirplus attribute info, just set the 'dircount' field to the same
value as the 'maxcount' field.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3xdr.c | 7 ++++---
 fs/nfs/nfs4xdr.c | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 9274c9c5efea..feb6e2e36138 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -1261,6 +1261,8 @@ static void nfs3_xdr_enc_readdir3args(struct rpc_rqst *req,
 static void encode_readdirplus3args(struct xdr_stream *xdr,
 				    const struct nfs3_readdirargs *args)
 {
+	uint32_t dircount = args->count;
+	uint32_t maxcount = args->count;
 	__be32 *p;
 
 	encode_nfs_fh3(xdr, args->fh);
@@ -1273,9 +1275,8 @@ static void encode_readdirplus3args(struct xdr_stream *xdr,
 	 * readdirplus: need dircount + buffer size.
 	 * We just make sure we make dircount big enough
 	 */
-	*p++ = cpu_to_be32(args->count >> 3);
-
-	*p = cpu_to_be32(args->count);
+	*p++ = cpu_to_be32(dircount);
+	*p = cpu_to_be32(maxcount);
 }
 
 static void nfs3_xdr_enc_readdirplus3args(struct rpc_rqst *req,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 8e70b92df4cc..b7780b97dc4d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1605,7 +1605,8 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 		FATTR4_WORD0_RDATTR_ERROR,
 		FATTR4_WORD1_MOUNTED_ON_FILEID,
 	};
-	uint32_t dircount = readdir->count >> 1;
+	uint32_t dircount = readdir->count;
+	uint32_t maxcount = readdir->count;
 	__be32 *p, verf[2];
 	uint32_t attrlen = 0;
 	unsigned int i;
@@ -1618,7 +1619,6 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 			FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
 			FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
 		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
-		dircount >>= 1;
 	}
 	/* Use mounted_on_fileid only if the server supports it */
 	if (!(readdir->bitmask[1] & FATTR4_WORD1_MOUNTED_ON_FILEID))
@@ -1634,7 +1634,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 	encode_nfs4_verifier(xdr, &readdir->verifier);
 	p = reserve_space(xdr, 12 + (attrlen << 2));
 	*p++ = cpu_to_be32(dircount);
-	*p++ = cpu_to_be32(readdir->count);
+	*p++ = cpu_to_be32(maxcount);
 	*p++ = cpu_to_be32(attrlen);
 	for (i = 0; i < attrlen; i++)
 		*p++ = cpu_to_be32(attrs[i]);
-- 
2.35.1

