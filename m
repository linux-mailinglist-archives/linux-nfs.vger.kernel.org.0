Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D60278F44
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYRAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYRAn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 13:00:43 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B947C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:43 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t13so3001988ile.9
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oSMLUsNfPgnswhogYws/CMy7vk2sJ4X5VkIdA6Og8TM=;
        b=JHX1uhytGLQt5aRNxIWalcLfVsoao5jmKb1vE3fBj8Z9tQ54njoxc7+a0V2y1MUh0W
         qJHmvGrR120muhi47kcV3sE+4WJaPQXDzk3h+ogS0Nbc6BPqwb5FIJwrAyLs7hOVec6g
         GYHqUutDt1d/5CrAllbY9AbQtY6rbxs8R4rSQxd7fTQQhzZ/J+UV93fFwWPiG1UxfNPw
         vt8FeJtIltlg1qjaEuB1dga0hNaky6QT4NODIghM3HYZDMekZVP/1jXS8IiSJfMi+NJ5
         +DDITHWheKkxN1t3O4gUetbBDW1IUQbHfjSHcjBPZXsiu4H62dVRA7GRM0hvnnYomB0v
         NzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=oSMLUsNfPgnswhogYws/CMy7vk2sJ4X5VkIdA6Og8TM=;
        b=AJIa0Kbtx2BqeKRu8thNxq303eccruhrnS3DObUlYpLbH0bpCY8g2imnNC1Ppa615W
         9O2c4DoQE85CaUmeGcLNE3zvgxOb0LgYChgrRMlkA1iyLWPo83q8iLZl7npMPXZl5933
         p5jMlWCIj3+DFAD0gMV6vRuEuFWO9jzBG+261YHHd0ZIFxNjbBpfRwuaWMChHpFhcI7V
         /1mZlgZVeHVy3KkjtX/OCTwzd3tjjpwemefbW/8hpYgWeJdpYGFRL0JivEICeuDu9kb6
         lXFe5ZGbhTpuB1IsIu2Vo10NCv+wMHYtYhFsr3mTFOZJUHjQwIGvLw3al5SDezjcv293
         Aq2w==
X-Gm-Message-State: AOAM533x8JpkW1Jxh2wgmKKkVj8Ko1jFIEtXf4WR9XhfoGXcN2NSGAmq
        DV67sO5z1Bg1h7sznpgqHNWINAlvq5fpjQ==
X-Google-Smtp-Source: ABdhPJwfMJ9oLTPxHXYP4yXfBK/XgHXoglpVWcHFNv/JrFUQk3kBp3S1qj2uG0l7navWuu1A6Nm9Xg==
X-Received: by 2002:a05:6e02:df1:: with SMTP id m17mr955842ilj.276.1601053242450;
        Fri, 25 Sep 2020 10:00:42 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e14sm1322474iow.16.2020.09.25.10.00.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:00:41 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08PH0e6J014545;
        Fri, 25 Sep 2020 17:00:40 GMT
Subject: [PATCH 9/9] NFSD: Set *statp in success path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 25 Sep 2020 13:00:40 -0400
Message-ID: <160105324081.19706.8622937614272635909.stgit@klimt.1015granger.net>
In-Reply-To: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
References: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

*statp is supposed to be set in every path through nfsd_dispatch().
The success case appears to leave *statp uninitialized.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index d389b276aa5e..2117cc70b493 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1063,6 +1063,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
 out_cached_reply:
+	*statp = rpc_success;
 	return 1;
 
 out_too_large:


