Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63642BB782
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgKTUko (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgKTUko (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:44 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEE6C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:43 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id z17so5298056qvy.11
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JF5vHd/vretYpFNtvhWN9jzZosT2S7u/HmKvcWz+5+M=;
        b=G9jhztv4m81eUDLLp68k0ttLK2aczT/QGFEqsxgGONsqlM/mXCB3G+3VknDvTknKf2
         mMzgY12SWN94DP5qdqmYpIItrl33uR+Dd0vd2mSW8T76CKkFQygtb7OAZ/unFI6A8y+8
         YiyVkIdJk63F/zGKpglPbRPSSU/VzA+tJLoTkNWCwG0p+4qCFYirNCOaHoHQ6QS6Opg6
         EPupSgRv1u7p+ThgBaXlQmYAzGkFQt8bxU1nWHtSBZIxAKqySFTyRTq/0/uel1DV1Xjz
         INUQheXGKxURSZjVKh62MZLEZKKU+5AszVqq7SGNPr8ejsDqWJG73bLv4C5XDqXqkLcr
         pgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JF5vHd/vretYpFNtvhWN9jzZosT2S7u/HmKvcWz+5+M=;
        b=EILw4KMCrVuE+9rDwyxOINlasLCLG6oKcPAi3uOf79NcKMysqgC4DrcMr9VkDieTyz
         SmIh4k2e2fBSaXuKIhfK9SX8s34ca8F7Q30c9Y1+QhcUqGSZsSOHfplAMoAcbHTjzAgw
         gK/Gp7x9Zu3FbpNw7HczfKW+J4bqJNMV79ZoQBhot1X6//AKbgw2dgFPd38KWB8E1+QG
         QBkQw8uehjTWr8G1TRP9I1RP+wRWnWu/OhgQ/Kjg7bV3tElsUEW+YLXSgIPr12CVlOA2
         s9XTb+cszvRiFbH39pIodbfWhZtZtAg9sArh2LxUta/QUCxvNmYYbrgBvUaGjfWZN1uI
         wR/A==
X-Gm-Message-State: AOAM533S+7Ye4qvI8Lb9/inu5kr3r6qSeGWFJlyPYGJ0T50NAiL0C29u
        Gzc2bJlDG0XX0evQ1OH5wuRoeaaprMQ=
X-Google-Smtp-Source: ABdhPJzMovs+qNG1JEsUGk1haSbkVDzS6dAO/7TGBkmmaOEt/pM8cGT5J2mbOCdS3bzJKQuINSu/0Q==
X-Received: by 2002:a0c:a105:: with SMTP id d5mr18651955qva.35.1605904842873;
        Fri, 20 Nov 2020 12:40:42 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d21sm2607577qtn.75.2020.11.20.12.40.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:42 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKefjl029447
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:41 GMT
Subject: [PATCH v2 078/118] NFSD: Replace READ* macros in
 nfsd4_decode_listxattrs()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:41 -0500
Message-ID: <160590484108.1340.1915332985466950187.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6c471fa1fae3..84c95a255826 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2175,11 +2175,10 @@ static __be32
 nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 			struct nfsd4_listxattrs *listxattrs)
 {
-	DECODE_HEAD;
 	u32 maxcount;
 
-	READ_BUF(12);
-	p = xdr_decode_hyper(p, &listxattrs->lsxa_cookie);
+	if (xdr_stream_decode_u64(argp->xdr, &listxattrs->lsxa_cookie) < 0)
+		return nfserr_bad_xdr;
 
 	/*
 	 * If the cookie  is too large to have even one user.x attribute
@@ -2189,7 +2188,8 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 	    (XATTR_LIST_MAX / (XATTR_USER_PREFIX_LEN + 2)))
 		return nfserr_badcookie;
 
-	maxcount = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &maxcount) < 0)
+		return nfserr_bad_xdr;
 	if (maxcount < 8)
 		/* Always need at least 2 words (length and one character) */
 		return nfserr_inval;
@@ -2197,7 +2197,7 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 	maxcount = min(maxcount, svc_max_payload(argp->rqstp));
 	listxattrs->lsxa_maxcount = maxcount;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


