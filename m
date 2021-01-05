Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976E22EAE55
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbhAEPbC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbhAEPbC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:02 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3559C061798
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:46 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a6so21082312qtw.6
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mp4mJpNywkRAiHMDm8UhPidX7v6cBTArsuTPwx8KSRY=;
        b=us9cSBiYEBz0PM9iCHp6nMj3cXc/j2PSSY8ap5TOKegUkm8ahpIzU1w0XbaWUTHirE
         mkxJ2pO9oGXhWzuIBpwaFAmToJjHDhCevzwr0MBRKW/TGr8/xXl7g0E0dkGwOv7wowcF
         W3UW+XyM9aUc8DaVTVnS83n9J8mIiLsKMj57eE6eiePOF4KNFff3BS/NHS8FVluaW7o1
         Jlb9dpsZigINOv38kR1MaXlgNwOYYyA/Cb8/Nafhl6VpepZnTvY1NsUmzUc8K5gBWX/u
         XvGH8WNCYYtq3M+nI69Z+QMRS1gGD73iu0kYaWE+sXpyJTMOkf3plgAvrB4k61062rSa
         Ja6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=mp4mJpNywkRAiHMDm8UhPidX7v6cBTArsuTPwx8KSRY=;
        b=ZWwHQyXHbTEfTlYvPp2g/ZFDgwT+gZvftsXgnibrXNeLpgNNQ/rz2UFA6hYXGvaSu6
         heVpSDSlcwjY8VOMB9Ia7ZvSsVIVVyZJMzRpwkuwSrainJIgpX0pDa0rsDNzNqay+70K
         APDrqxXIzJUWcCkB2CFFEwo8AaD1f08yLzcULLgdv4QMHgMUtfB4NAnHlo2/Z6X4qDek
         ww5QTeD6olLqIE/RxcK4H2NXzcW/D0jCsie17Aw2MKy8BY2YHcWn8y7g5MEGjjWBwKBQ
         ofc/JJyFlH20bYR1noFeGhVQUaRvdhYPhJW9HgQ6ToMI/GxPvx5suU9vlFnSDP7jyumF
         lfLw==
X-Gm-Message-State: AOAM532W7hfGXEcndQNVrbbWpsXGwjGdVi6U/h+7g+SJcj4Xo4GB2CIm
        LXDXqmtNYyuzkUmOsNozMfPtQrVUxZM=
X-Google-Smtp-Source: ABdhPJz8xB4fXGMSnVVFDSMJZN5AySXxE9PvRjfsUQNdcNJoHtrUMtXY0prO8B7qU6ne3zKzym0CIQ==
X-Received: by 2002:ac8:7507:: with SMTP id u7mr15191qtq.217.1609860645752;
        Tue, 05 Jan 2021 07:30:45 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 134sm147311qkh.62.2021.01.05.07.30.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:45 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUiSk020856
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:44 GMT
Subject: [PATCH v1 12/42] NFSD: Update COMMIT3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:44 -0500
Message-ID: <160986064429.5532.15980289615760697662.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 6167955475e7..bda6f3aed1e3 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -601,14 +601,17 @@ nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_commitargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_commitargs *args = rqstp->rq_argp;
-	p = decode_fh(p, &args->fh);
-	if (!p)
+
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
 		return 0;
-	p = xdr_decode_hyper(p, &args->offset);
-	args->count = ntohl(*p++);
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 /*


