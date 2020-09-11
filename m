Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0912B266865
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Sep 2020 20:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKSry (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Sep 2020 14:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKSrv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Sep 2020 14:47:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6EC061573
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 11:47:50 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v123so10852699qkd.9
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xSfW6wIwUq3YUihnsN2UPFH/Xgm9Me+WED1TbujSKTc=;
        b=euHCAfnsvfIgZiOhkwSxeKDVLl0KJnkHc3MbqnmSmGLMlL+QoxA0d+MDBHIkzvnmbu
         nXRW6JdaLZ9mqX+J2dSfHoUG/gO4aoY/PryeK4zKjLDuktEZfIGH8iPfME54U/kiu4m/
         qpDfzm7WN1+Q4utga6Ty8xpv2Ms1autl1R8TlyYzMHfGTEGJJOHkM00/ihH66NNc3wvW
         FQlRoO7R2U0nNzFVakEz6yip4S34T0Smr1n9MNHkHqkSciPhVNJOb4X+hu39u1QisoEf
         fEtp+l/j9p435tv0yyxWBS2UOU12YT5+p+jtpd5qx6Lsr0SNRz7fIWZfxjqRbj5mr4ML
         myPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=xSfW6wIwUq3YUihnsN2UPFH/Xgm9Me+WED1TbujSKTc=;
        b=Pzg3VGF59PmHhD13uyJQK114XVI98OzpYFjIH/q77pMDSN4XRMTftZA4EGhwwWbyeO
         nMHPS+adEjzAAcCwIGzIdWPJPSk13xqfymxiVltcA3fZTxoQdpslTHisW11ti4uEa8ZN
         p31gePKLnPN5S1KF5Ezluge900sK55PuIZIp98W8YNa4OGzfUujiCb9i20PNxPhbTZtg
         Fo2OpNfOpUdux4zw2h/MjzW9EjdMy29adgyEJSYyPumu1hBWBJrPtnpnSmo92/f3q5vo
         +v6DKBD7iJ61vaDyHez5LKKZyN5LNTnei1lN7RxVTsGoIFO1xzC4ngsl0rvyZzuz3zPq
         ApTQ==
X-Gm-Message-State: AOAM532AW3FPghCuDEFi6VXmbabfbm6i7eFRWwJSvilj7i6SpKJwLHFP
        4gXelfqt8BlhzJiM53UvVEJIlH4csPA=
X-Google-Smtp-Source: ABdhPJxjv5b1kNEdnVxrkT3zruy3p6aX3SKxxwCK7Ru7834XGrZj4/LybQfIgd1nIRVebMFchHEMlw==
X-Received: by 2002:a37:e118:: with SMTP id c24mr2969950qkm.167.1599850070167;
        Fri, 11 Sep 2020 11:47:50 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 15sm3371019qka.96.2020.09.11.11.47.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:47:49 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08BIlmm3000609;
        Fri, 11 Sep 2020 18:47:48 GMT
Subject: [PATCH 1/3] NFSD: Correct type annotations in user xattr helpers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 11 Sep 2020 14:47:48 -0400
Message-ID: <159985006858.2942.16920859739287624589.stgit@klimt.1015granger.net>
In-Reply-To: <159985000766.2942.3348280669087987448.stgit@klimt.1015granger.net>
References: <159985000766.2942.3348280669087987448.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Squelch some sparse warnings:

/home/cel/src/linux/linux/fs/nfsd/vfs.c:2264:13: warning: incorrect type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2264:13:    expected int err
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2264:13:    got restricted __be32
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2266:24: warning: incorrect type in return expression (different base types)
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2266:24:    expected restricted __be32
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2266:24:    got int err
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2288:13: warning: incorrect type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2288:13:    expected int err
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2288:13:    got restricted __be32
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2290:24: warning: incorrect type in return expression (different base types)
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2290:24:    expected restricted __be32
/home/cel/src/linux/linux/fs/nfsd/vfs.c:2290:24:    got int err

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index aba5af9df328..1ecaceebee13 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2259,7 +2259,8 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char **bufp,
 __be32
 nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 {
-	int err, ret;
+	__be32 err;
+	int ret;
 
 	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_WRITE);
 	if (err)
@@ -2283,7 +2284,8 @@ __be32
 nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 	      void *buf, u32 len, u32 flags)
 {
-	int err, ret;
+	__be32 err;
+	int ret;
 
 	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_WRITE);
 	if (err)


