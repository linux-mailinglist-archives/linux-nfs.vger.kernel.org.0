Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595212EAE5B
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbhAEPbN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbhAEPbM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:12 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA6C061795
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:57 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id et9so14816459qvb.10
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PUqZzFFjRPa9e7AkqA7LUtYdd4p21auipb3gQ5t02bU=;
        b=Ga5Aex1TGlB5SRGuWXm/GdtHvi8BOj9zit1Lob7CLk4apyo2D+5PJtaGxTontQYUus
         pQnTf0JorvM07DIga0MS3Z68HoDbbfAhPo+Xefase36Dui4WaoODvvx4rAvUneHjluQx
         nNsIWjhroTijR28TMiIoZhul7PkoW5Ki87n2TYY/+gwgZwxIJ8gPiuPTQgxsBqURL6vz
         GA4aEu5en77Dm4JX1HzHqI5b/EDFxruuS4gWB/5QmyMS+/zNUhK228KRvupGcxTLwy7f
         TiMKZfXLx0Q0MiIYkxflHGXW88eepIPvdx4Bd4743wWAayltJ+3wZyOu8I+KGLxyz8Ay
         bvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PUqZzFFjRPa9e7AkqA7LUtYdd4p21auipb3gQ5t02bU=;
        b=mmKnjdv5S+58etDqeU8LCQdd/PEt5tt4CCScwz64puqAGPKqwHNXkRnlYfV8dZlxo2
         F54lGiRStHJZJrk7remNwoN9j2P5dNzkB5Np6mXk+8xoEqN0DEP1vwGSkq7XEA0eoTUg
         0ws4ATa2H0Pk3fJOxuS3oxW05UwtZyLEUDnKZgMjlPk0DNfdTSpHy5xGfyKPMHPnun+l
         QbOctgUeAz10UT1NCfPyR/Y1acO+DER9nJ11ncIn2aa4PedPpOXTWsO4ezBcLc6nd8TD
         WlYG68cDdpt8u3W1OZ/wDcFBXWubjoXsFIYWBfZBZrz+iYpLi+xY+ETP27VOjXmuWJ3d
         jUFw==
X-Gm-Message-State: AOAM531l9ppMLU4l4KKeSEvKMSfT9CJ1EXvF0Z9rO1Zhced3sKuUtB15
        dJ8TBpRl29h2UyvBsWb5wzTG1oj3o6s=
X-Google-Smtp-Source: ABdhPJzVzHerZkuPS64cBeD1gccX397rDP0zq5rvux1fRwMzGqE0coTdRhlcQ2wCWq9pq8NDWqPQkQ==
X-Received: by 2002:ad4:496c:: with SMTP id p12mr157621qvy.40.1609860656148;
        Tue, 05 Jan 2021 07:30:56 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m65sm58568qtd.5.2021.01.05.07.30.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:55 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUsII020862
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:54 GMT
Subject: [PATCH v1 14/42] NFSD: Update the RENAME3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:54 -0500
Message-ID: <160986065463.5532.8561383822279453786.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 7175b7315df0..a5bbf9571821 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -562,15 +562,13 @@ nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_renameargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->ffh))
-	 || !(p = decode_filename(p, &args->fname, &args->flen))
-	 || !(p = decode_fh(p, &args->tfh))
-	 || !(p = decode_filename(p, &args->tname, &args->tlen)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs3(xdr, &args->ffh,
+					&args->fname, &args->flen) &&
+		svcxdr_decode_diropargs3(xdr, &args->tfh,
+					 &args->tname, &args->tlen);
 }
 
 int


