Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F245E530
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 15:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfGCNR5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 09:17:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46300 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Jul 2019 09:17:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id i8so1225839pgm.13;
        Wed, 03 Jul 2019 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DhkcjETGykRWOcYZqldQfk1NtaMUDjJ/hYXCLax0zE4=;
        b=ZNZZ9RSoNwvL+cnddohbyVvp47hG/QmG3WU+YTn0tPqVYJmDscYx2xHJv0EbxdfrI3
         KHL0RKs3rkFQ4XgVj8w+JFD+Q1+20UW0GZqBBSoUknoVmLEiAd2kcdmD0sTNBDayLqr5
         nvOmHdUKNk5eNv86a7cjcq5K/xxcjqr1c1pcd8gm3fs1jcdCXS9KeqrK7NXz97EOFwzU
         7IMwkVdxkWuD+Hjef5AYI5wHEU0g8My4nQZ2J/4AT9AldS3Ip4kkCe4PQF34W2KPQF2l
         pb8eo31Pyf9pDsOm5bqYqkP9LZ6a39cLOi/vF7OhSisVOOh3Ls9tHSi5V+GTgxL0gf8m
         tLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DhkcjETGykRWOcYZqldQfk1NtaMUDjJ/hYXCLax0zE4=;
        b=iuNCme/S7WwXOJdX+1s8AyWGIsRzSohTy9trJ1cNf4ejRJfbhrZa4v+FUNuZGH6XTf
         amnws3m9pnaRnuIhP9/DwhlkMVz+OVf+GcMqcDFVkvARAlYbmnuuSp4Addjs0IbQeGJ+
         Hx9diKzVWNpNV1dJaPom5KCpOsUF1XeUavCAxEIs2TRzR7feLWDhsj81KQPABDHuyE1l
         rOmYWvF7S6M46lrP7Xi7pI2H5x6YTLeNUJzdLJ5DH+4xkHdkg+0USRotRyNXC793S7Av
         dvQtkle5/FHJgOxS0MZ8Hm2NTgw+KAbU3CS3N/32GC0ju4xoBat4rUAfHCUItHyTnZbm
         mBbg==
X-Gm-Message-State: APjAAAV4yBbRAFucuB9NbLhc5lpYLwsES6bcFRHIUWr0z8XHgF2nliV6
        QOUr+RR7Yckw5VBiJ3ifQYI=
X-Google-Smtp-Source: APXvYqw4F3ONiBmBx1sD2lUl5EgXE/HuRpVGn+w4h11DiQsuklr6xiuqrqXiL0R2OetDH1ReNnkHHw==
X-Received: by 2002:a17:90a:9604:: with SMTP id v4mr12534689pjo.66.1562159876958;
        Wed, 03 Jul 2019 06:17:56 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id m10sm2201043pgq.67.2019.07.03.06.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:17:56 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 25/30] nfsd: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:17:47 +0800
Message-Id: <20190703131747.25827-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 fs/nfsd/nfscache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index da52b594362a..c0226f0281af 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -533,13 +533,12 @@ nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 	case RC_REPLBUFF:
 		cachv = &rp->c_replvec;
 		bufsize = len << 2;
-		cachv->iov_base = kmalloc(bufsize, GFP_KERNEL);
+		cachv->iov_base = kmemdup(statp, bufsize, GFP_KERNEL);
 		if (!cachv->iov_base) {
 			nfsd_reply_cache_free(b, rp);
 			return;
 		}
 		cachv->iov_len = bufsize;
-		memcpy(cachv->iov_base, statp, bufsize);
 		break;
 	case RC_NOCACHE:
 		nfsd_reply_cache_free(b, rp);
-- 
2.11.0

