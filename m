Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7152BB749
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgKTUh1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbgKTUh1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:27 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B1C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:26 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id e10so652998qte.4
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WtXGxSYABNe5RS+FSzALJn3Qx1xwkenkkx4T2G1fPAI=;
        b=jboGwWzz33IQuh71CyjLEz01+DVYF20YDhq7ac3WgU23SaYyCpM7dxgBFekTWKUdN5
         +oWlfAYFnyWX3E3E5Pc0u3acBhQ2lzlwTEDDCHJiWnhCH3SgpT+wox2MWnplAWimKDvR
         Fi6xreoNcHJNWnrzIvR6T86X8bYLTDy8ftkao/eEcICYPKxLdNh/XyN9M/UCnMM3G/KQ
         jHgkZOrRgL7QSNtwpurz+B0egQRMq/I9w9SErh6i5wHIaanoEhgdpZSsCvm6xaUimruP
         iXmZOuHpLVUqQTl+VYoLUVO7oUdecrbq3ywbUkibjCdXW23wiwSUxsNBZRB2ScdoRzna
         RY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WtXGxSYABNe5RS+FSzALJn3Qx1xwkenkkx4T2G1fPAI=;
        b=DJ6+GDAEIc0dAT8AWf3ZyAcIsXJrv2uXPpNNg9hI4X4BeEsSF673r8B4xGy3KSkoZe
         hbWWvxAmXtMFkUSCVNl/rhta8RDVH1p1iLZJDqFWDcPNfSr59JsHNDVaG3nQJLFoLxR3
         8NYd11nLPj1uWhH4p3kkGKBBN72LxbBTiBQYeA01XI3bQEypY6ZZWzOsjl95sGEIGpZc
         vVCBCAdNfnbMVYWkhOniYiO+uGupLtZLfaHsVs5F1MtwwRpM4D8UiufEN8z0CALMuhI3
         gNKnSLsfJBRT7E69K3JFTMJn35qoVyvdoSok8LaZCnjv6kBWwAjs68enzSdQobrGSoEK
         zq5A==
X-Gm-Message-State: AOAM531d4/ox6AZPBSR/C/OLfpk7Tk42hylS4qdMEUdDiHFZVyJ/VG0d
        aKgIYTruTjr2u8LT5PFxJhMLocuI3a4=
X-Google-Smtp-Source: ABdhPJzcr1hFqm2RON9lMQ2TuoRnIkyf29ozNl0fduSTc8FTgqXaiYm/lRRgSOQzyUNQMF3ZJN4cPw==
X-Received: by 2002:a05:622a:d4:: with SMTP id p20mr17827368qtw.172.1605904645939;
        Fri, 20 Nov 2020 12:37:25 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 7sm2838526qko.106.2020.11.20.12.37.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:25 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKbO6R029325
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:24 GMT
Subject: [PATCH v2 041/118] NFSD: Replace READ* macros in
 nfsd4_decode_readdir()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:24 -0500
Message-ID: <160590464406.1340.17161947753688573465.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ecc922cd5d29..3a7b615aef62 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1180,17 +1180,22 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 static __be32
 nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *readdir)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	READ_BUF(24);
-	p = xdr_decode_hyper(p, &readdir->rd_cookie);
-	COPYMEM(readdir->rd_verf.data, sizeof(readdir->rd_verf.data));
-	readdir->rd_dircount = be32_to_cpup(p++);
-	readdir->rd_maxcount = be32_to_cpup(p++);
-	if ((status = nfsd4_decode_bitmap(argp, readdir->rd_bmval)))
-		goto out;
+	if (xdr_stream_decode_u64(argp->xdr, &readdir->rd_cookie) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_verifier4(argp, &readdir->rd_verf);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &readdir->rd_dircount) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &readdir->rd_maxcount) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_uint32_array(argp->xdr, readdir->rd_bmval,
+					   ARRAY_SIZE(readdir->rd_bmval)) < 0)
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


