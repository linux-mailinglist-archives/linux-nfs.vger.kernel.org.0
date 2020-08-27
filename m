Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72482551A8
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Aug 2020 01:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgH0XhG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Aug 2020 19:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgH0XhG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Aug 2020 19:37:06 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA8C061264
        for <linux-nfs@vger.kernel.org>; Thu, 27 Aug 2020 16:37:05 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w3so6281514ilh.5
        for <linux-nfs@vger.kernel.org>; Thu, 27 Aug 2020 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=j4teMh/kAjn8PUpMfpQIZDuEVxIhi8Jv1W5WJLwFFnQ=;
        b=Um1w9cISfTl5NDZI1K2h1wYqMMq4KevdEQcBrVZOFO8ODvv8MOkPTf3pFvOAmY/2Gs
         KEHtK/M5WDS7l+Oq/ljOY6/OfAdWqzy3i0JblmBOKtek7neln47RCJ+d8Y4orfJzksH4
         bOH9U29ZoomtroAVABchw1INK2re1beFcblK9/V4+8K6riWNECXRaECwI8h7kd6b5Dke
         wnPA+W58CyZoDJDa3ITiWtREmx8FiqHnq/SRkrDsY0LYWpKLuim/ngFiH8DN17wGWGGJ
         08/oIFhjXTl8ingx06q6QVLHHOUA4+4B23uofHJRvA920pupYdmvYFpWD1mHQ8fbW1j2
         5zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=j4teMh/kAjn8PUpMfpQIZDuEVxIhi8Jv1W5WJLwFFnQ=;
        b=WKsuj2SVepeJtun/Y5AoSivm7rRLC5FMabCz7aoxtCZTIQw4TaqQTg+lNF36PDIKvD
         +2HafhAzKYYjmF/QH7a1M9G8XHSWUukrK7d3PDBs+dnbcTcuucjcVQpNfd2U336PITa7
         aJU0/pUKGftzrXe9uXxlr8jf1R/GlO18ia9AE5VqaHYeOWlBizdWQUfTc5gQvRBUKtqZ
         W5PtVjDmFW7M/JsOxqWFJ75q6aY77eQSqUcIK+KokeSeNAme56ufYmqU+fHOr6HY4W+r
         EzxjGuj/bIwKoeXlLip4KbJ9/m5lJAx4KYLBjUUSDSKtscLpaw5f0WHt7QJXOu6VrLZf
         Mt4A==
X-Gm-Message-State: AOAM532U0lzmGsWu4T0jh/69g7MIWDCj8BdV5Nc1RsExyecdmN1e0f8y
        RPomS2GddYpai0juJmZ1ifQzuD5XyiE=
X-Google-Smtp-Source: ABdhPJzsBh4lEG2SArbuIgSBq9dWlVeXseDrA+rvlnUts7X4AeCaWMqTrdzdLbM9b2+d+TPYykO4uw==
X-Received: by 2002:a92:9181:: with SMTP id e1mr18512303ill.274.1598571424802;
        Thu, 27 Aug 2020 16:37:04 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v2sm1806038ilh.33.2020.08.27.16.37.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 16:37:03 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 07RNb1CJ001132;
        Thu, 27 Aug 2020 23:37:02 GMT
Subject: [PATCH] NFSD: Correct type annotations in user xattr helpers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     fllinden@amazon.com
Date:   Thu, 27 Aug 2020 19:37:01 -0400
Message-ID: <159857138796.5733.7512487939045729999.stgit@klimt.1015granger.net>
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

Fixes: 32119446bb65 ("nfsd: define xattr functions to call into their vfs counterparts")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

I plan to send this with the next -rc pull request.


diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7d2933b85b65..0e1e1bba24c9 100644
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


