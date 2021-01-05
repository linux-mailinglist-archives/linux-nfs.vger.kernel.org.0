Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA942EAE57
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbhAEPbH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbhAEPbH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:07 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E09AC06179A
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:52 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j26so21033436qtq.8
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uVePB3ddDPjDzwgaIDdJ/pXJi4FgraPntM5j5zHTfSs=;
        b=TNhhSYLOpNMOMs5iPahMm07jTfwP0ihpJcj+z79dQ1jQlfp4DDQawwQVKB6bgiONOM
         zxxzowEIqEHZn2wcyeabXNGSVKgWg9CeYSCBKWrLhWIX5OWhMSI/7OTLJTun7J1LA1V0
         0aArjmlTHE5pBfPv38LBPD+H7x8TT7Xxqexl2OzIBL3UqHYsZpCYmR6yIPys1oYkHr5e
         tJDTuvp2ttZ1tuG1KZyquF3BfVAvW1RTArZBb4EyQwoyCOwb8zmGf0ke2C1V190FEHuL
         5PJ+9Tdk0MizcxUiM3QhvnLaLNa2QgEr4xwxnNqOd9/eoiZUEGMqDY8FkZpdpa8MKCFc
         ErGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=uVePB3ddDPjDzwgaIDdJ/pXJi4FgraPntM5j5zHTfSs=;
        b=EIUqxbf6U5txN8bUDy5tt/y87Jko4ENndbnhsk6tkFfk+RGwH1ycGApFNqvs0qYzfm
         w0kToI+D76LMs4ALOnUPzezCc5tDSU8TBt5EBFGuahzZ9hh5K3VoZzPWxIHM8KqQFleL
         a8rVbFo9SC6pBtzgwusDqxmu4Jr26NzJesdTpaAzQaMEAmN+2KMlGF/wsFDTbjW4hk/3
         SOrO/nSQGDqWpJax+jS+iRIXp1mWtDW8JPJm6sfKuZ/npOasm4upw2tXjtr+vVqoE3ON
         AEVt9rr5eSL70rC6g4QOh1kOuKGsLx2z/VMpaFRAuxAZ5cvmEZg6GszICINKAG0s2/p3
         +xRA==
X-Gm-Message-State: AOAM530KIAgniapi8DNcIHW5gmaFpIxbrlE3r7IQXBdRIuOJRY8iltEY
        ouzndZyfUWOf9dd4Ju6z+IArck3YLns=
X-Google-Smtp-Source: ABdhPJxF44k07OD5nrCnphMMJ64d5W/HtWoohT7DnUjXmXWuMZjBeg9b1DqkLQRBeY2htTWFUTW3lw==
X-Received: by 2002:ac8:4986:: with SMTP id f6mr34981qtq.43.1609860651060;
        Tue, 05 Jan 2021 07:30:51 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z15sm129754qkz.103.2021.01.05.07.30.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:50 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUnge020859
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:49 GMT
Subject: [PATCH v1 13/42] NFSD: Update the NFSv3 DIROPargs decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:49 -0500
Message-ID: <160986064935.5532.1976966532601912001.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index bda6f3aed1e3..7175b7315df0 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -117,6 +117,39 @@ decode_filename(__be32 *p, char **namp, unsigned int *lenp)
 	return p;
 }
 
+static bool
+svcxdr_decode_filename3(struct xdr_stream *xdr, char **name, unsigned int *len)
+{
+	u32 size, i;
+	__be32 *p;
+	char *c;
+
+	if (xdr_stream_decode_u32(xdr, &size) < 0)
+		return false;
+	if (size == 0 || size > NFS3_MAXNAMLEN)
+		return false;
+	p = xdr_inline_decode(xdr, size);
+	if (!p)
+		return false;
+
+	*len = size;
+	*name = (char *)p;
+	for (i = 0, c = *name; i < size; i++, c++) {
+		if (*c == '\0' || *c == '/')
+			return false;
+	}
+
+	return true;
+}
+
+static bool
+svcxdr_decode_diropargs3(struct xdr_stream *xdr, struct svc_fh *fhp,
+			 char **name, unsigned int *len)
+{
+	return svcxdr_decode_nfs_fh3(xdr, fhp) &&
+		svcxdr_decode_filename3(xdr, name, len);
+}
+
 static __be32 *
 decode_sattr3(__be32 *p, struct iattr *iap, struct user_namespace *userns)
 {
@@ -363,13 +396,10 @@ nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_diropargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh))
-	 || !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len);
 }
 
 int


