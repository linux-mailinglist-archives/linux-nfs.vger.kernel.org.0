Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F8C2EAE69
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbhAEPcE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbhAEPcE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:04 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB722C061796
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:23 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id b9so21086774qtr.2
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JIjn3vuBDM7Pb4LQaHHXPilj0m1OshyLTk1RWQWz7f8=;
        b=Hy4NzIkviqUoU2A5GrTOJsxKx093NzL083ZFgAdUpU9UW0gF3khIXeNLYMVKva3EEi
         Cn3E/pXfrIITt7aPbFbZi7hUksxmI+s1YbLTzfMdAPh6+Csa2SrS7nXxhyb60bo3jfll
         e2L71DC/CqMjDDyAtv9dV516aJzym1EeBvK+kdfED6zjlVG7z0xvVj7l5+BUf0L5bk7W
         fxXBmbt3M1IV1DKVJTwb3W4Bi/Aq+d8aYqWy8EeStqV5lubLN3V5zu8enzfhJeSJU6Kj
         Yn115muMRx4Ny74USZExAFDWEtwWB8w63ZRu3OnANCdMTfh/Y+ude4Jz3csVTmNZNN18
         jLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JIjn3vuBDM7Pb4LQaHHXPilj0m1OshyLTk1RWQWz7f8=;
        b=gMzZOY7zrwFCruPESbRM9yWKWgOC2CV5ozyj12QD1YCCSLfJeOpeXvBj8lUKrlpgY0
         s2gfek70jwUvGzVXlH5PXE312NiCSYQgNK30sPWpQS2gIIe/WhKcsCyv/ET7773RthJp
         9XQ5EUjcadOcd3IsJn04xIyLs/KCY0cLnuLkQdrVqtOmF/3WVZCKk2D1wSTm1i/Zvnzl
         HwDo8+uUi293+1XzgthtFOPUDd+wUpQ4gdbOfIaOkSyOItyMDplGYVAtvrQG3CtDnPu7
         myMGt3A1T3YjWboaPPhvw/4Lh7wL/t2DCeYUfUjBhLh4mBJBDs85ysSC/wUQX2N95JdR
         v6PA==
X-Gm-Message-State: AOAM530H95f31YHubsSoguE3x7OEZPnrLYzQB6ispzPZ9jDbaJ6qWEVr
        biU7qabb2pDa76mB5LnwmBTpPoPDDO0=
X-Google-Smtp-Source: ABdhPJwau1C9QBIkhLCW3FCcNAZNywZCAT4fNQWDlrGmdE9wgtI7rrjzdgGtOw9ciP8Cun0Uugg/Xg==
X-Received: by 2002:aed:2f64:: with SMTP id l91mr266qtd.363.1609860682661;
        Tue, 05 Jan 2021 07:31:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m41sm55825qtc.28.2021.01.05.07.31.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:21 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVLaM020877
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:21 GMT
Subject: [PATCH v1 19/42] NFSD: Update the SYMLINK3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:21 -0500
Message-ID: <160986068119.5532.7090899294624791804.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Similar to the WRITE decoder, code that checks the sanity of the
payload size is re-wired to work with xdr_stream infrastructure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 45975fdb033e..e599d1481b2d 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -616,25 +616,28 @@ nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_symlinkargs *args = rqstp->rq_argp;
-	char *base = (char *)p;
-	size_t dlen;
+	struct kvec *head = rqstp->rq_arg.head;
+	struct kvec *tail = rqstp->rq_arg.tail;
+	size_t remaining;
 
-	if (!(p = decode_fh(p, &args->ffh)) ||
-	    !(p = decode_filename(p, &args->fname, &args->flen)))
+	if (!svcxdr_decode_diropargs3(xdr, &args->ffh, &args->fname, &args->flen))
+		return 0;
+	if (!svcxdr_decode_sattr3(rqstp, xdr, &args->attrs))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
 		return 0;
-	p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
 
-	args->tlen = ntohl(*p++);
+	/* request sanity */
+	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
+	remaining -= xdr_stream_pos(xdr);
+	if (remaining < xdr_align_size(args->tlen))
+		return 0;
 
-	args->first.iov_base = p;
-	args->first.iov_len = rqstp->rq_arg.head[0].iov_len;
-	args->first.iov_len -= (char *)p - base;
+	args->first.iov_base = xdr->p;
+	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 
-	dlen = args->first.iov_len + rqstp->rq_arg.page_len +
-	       rqstp->rq_arg.tail[0].iov_len;
-	if (dlen < XDR_QUADLEN(args->tlen) << 2)
-		return 0;
 	return 1;
 }
 


