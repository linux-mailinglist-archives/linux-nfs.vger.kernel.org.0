Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569722BB77F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgKTUk2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgKTUk2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:28 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A60C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:27 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so10191980qkk.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kwGZdKBVDc8TkG1gXeyRsEQ9Zz66h6YnIiC1LGdZjgU=;
        b=ay3nSpNal1JnbGhn/FFL8uyd4vUwFbta+kOsNPR8v65svPGtfzfk+sD876td7qpE3M
         nmM8LwnbhSRjjGcBvIMuP2siqSaBZWEIjLlNqthKpqNA4iaylN2UjhrW5cOcud5nC5eo
         pgnUy+gkPn5Bm8H+69f8co/C4A8NxyJYX/sC+MsvMeqKQTnNhSAtsXX7QY09r4+RtlQL
         bBlB0/2IK5EDNN36XWePCncyUzO47WI+peZxHY4TXsMIdiw0nrE68IHl4YEg+23Yp+7Y
         lloWrkQp24naMh4X45TShmBiLQyzgrCKWDB/IrzXlOa7wJjcZGZlZs0v7nPPRyTjjpGS
         cvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=kwGZdKBVDc8TkG1gXeyRsEQ9Zz66h6YnIiC1LGdZjgU=;
        b=FyF1sfFusbFTTygvzL7aqo1ySP2gP4rWEKkKYrayEB0eN81r9DwzV8ceu+m3h6Ksg/
         jo19syLxpAvBSk29kSuUULwYBUsctuHWuPshp9tThO9mKTowcXEnjQOHtBrRZl8nHP+b
         kC7Cuz7OFQSN3AMEfPHMq1kMpn+1iIMTGm7YKUw6W9b/v7H9YDwXznNYjZc2t5Y36B5q
         sRP0I7cDocYFokt/n11wCEcLGsGp9Mpw7LxNOmmU1tYEv5VM7s908UmGwDMkrXHUPDi2
         ZtGNY9Yh3yxzBsRMBBW5jnIdj6bWAUB8TsuVqZrsm5YJEkRlZ1C9IdqROR19BqV3mZgI
         8fdA==
X-Gm-Message-State: AOAM532ESpz0EFQrcyvRgr4mdO5biqPsr2HRFMvLtPrrpUi/BXCJvzQK
        5PXiyuMuOI8cTwjAanKMogT7FVizHpo=
X-Google-Smtp-Source: ABdhPJy1ir9iw7f9/rSM/H0gzPvSlWjv1N0KN1vAce1jlHJ2mxUu9jbLSGGPXJSeA7cItsNtZxW1aA==
X-Received: by 2002:a37:696:: with SMTP id 144mr18809955qkg.369.1605904826736;
        Fri, 20 Nov 2020 12:40:26 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z133sm2980646qka.20.2020.11.20.12.40.25
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:26 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKeOci029438
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:24 GMT
Subject: [PATCH v2 075/118] NFSD: Replace READ* macros in nfsd4_decode_seek()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:24 -0500
Message-ID: <160590482493.1340.8090487886701999410.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 84d69c436fd3..520a3c78ea5b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1996,17 +1996,17 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &seek->seek_stateid);
 	if (status)
 		return status;
+	if (xdr_stream_decode_u64(argp->xdr, &seek->seek_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &seek->seek_whence) < 0)
+		return nfserr_bad_xdr;
 
-	READ_BUF(8 + 4);
-	p = xdr_decode_hyper(p, &seek->seek_offset);
-	seek->seek_whence = be32_to_cpup(p);
-
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 /*


