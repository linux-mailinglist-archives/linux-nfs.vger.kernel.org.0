Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480E12BB7BC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgKTUn5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgKTUn5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:57 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF95BC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:55 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id n132so10263449qke.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jPE4amyDK4g2Ujqay2CvxQr6Ju06D5HBawt7WO41Waw=;
        b=JkT6La3oCSqsB6kNU+/CuSSEK8Wzo77JSMjCmWsmJ/CkTmplhh56YhhC1GZQ6+lwY1
         ZHmOi388GCFyL8MB+3YBLr9LfecKWV2mSHnCRyq42RZ/imQUSs6wAQfn3AC0v7dLiZI8
         o1XJ6TVA1XZfpcJAobBjbDwjW1FcyUIeUgrTh1XwC8wYjrYfyjErshJn82843KCg3t7Z
         vwTaTlVbAJbqcAcOsEnIoqKVoUF7yjxd4ZJN2fwsA1rmm5v8BRtebfvIj5q89Duzs8Ze
         UbShBXTiZ7BPy/vuCJ+D2Me+j2IDcVzwRF7y4pZCeetkYYPLWyT0RQ9AI8KIfSiwOqTc
         3n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jPE4amyDK4g2Ujqay2CvxQr6Ju06D5HBawt7WO41Waw=;
        b=tJw/n+eeUxECcCuWGWfmFUbeTr+vIfCqbvXEhjkz1aI8EXDAFQyZaNwE7euzYZLp4Q
         u+Iwyl0dlApnKrwOr3KbfzCmkFd0bE0DbhZL7vbWANmMNz1UCUts9YJu050en+/DQYqv
         7FhIQJKruj4v0/vdb01+I1V7VU5VuvalXOYQUDPymxRCRXs5KlGvbNhoH8/ankzaXwOQ
         yvQ4nmCVDAq1Vimc/XJN2CXLXPBC8R6SL14mqdFY5OJNYk7+bNHqVm3r8knkwTVgGFtL
         Y9E1XcWaumWQXvSu7L3sVECj348qQ4ZePC9jZJJuh+fKiaTfLu/hCzkAPObi88uScm2+
         B51w==
X-Gm-Message-State: AOAM533sT9Ansk4TtggRSdn0p7gfMxqS88FCdm7T+ZDLbHvRXO9xkW7I
        Il1AW3VPaMmDpyXBoIR5BhjZFQjyjUU=
X-Google-Smtp-Source: ABdhPJxaDm7Jtzj/wzfbQQXefsHIsWQmN8glXAQkgAd8OH6kqLZ3QWr/RKcthZRYhBZa+0mvtamnng==
X-Received: by 2002:a05:620a:11b7:: with SMTP id c23mr15744723qkk.156.1605905034855;
        Fri, 20 Nov 2020 12:43:54 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 205sm2877851qki.50.2020.11.20.12.43.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:54 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhr9Q029556
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:53 GMT
Subject: [PATCH v2 114/118] NFSD: Update the NFSv2 ACL ACCESS argument decoder
 to use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:53 -0500
Message-ID: <160590503308.1340.3406027763771152476.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs2acl.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index bc5303f654e5..fa8c2d746df2 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -222,14 +222,14 @@ static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 
 static int nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nfsd3_accessargs *argp = rqstp->rq_argp;
-
-	p = nfs2svc_decode_fh(p, &argp->fh);
-	if (!p)
-		return 0;
-	argp->access = ntohl(*p++);
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
+	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_fhandle(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &args->access) < 0)
+		return XDR_DECODE_FAILED;
+	return XDR_DECODE_DONE;
 }
 
 /*


