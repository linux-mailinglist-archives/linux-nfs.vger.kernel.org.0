Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7805E910
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 18:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfGCQbf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 12:31:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43367 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfGCQbf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Jul 2019 12:31:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so1514256plb.10;
        Wed, 03 Jul 2019 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BLFyaOdYHKpWV9FodMEilP4BpCc1KRMqeXoJ4Bn9qQI=;
        b=AlCjbJ7MtXwkZWg+ypGc07u3/sC1nbMOJ8pEO5q+VEHTZBwvHb06fTFslWxyQ22Kim
         /JSSehyKi4FfMiruBoB7Cd6WDbBgGoZ9PRw9MarGNHYr7+aHM2jfkRHgQc36DK3QUJoh
         Q3HsGcGbheFG0auroFWtfzLDltLZIyptxdgb3qHtVox3pfapbtKigAuiKPRt/HX8g/nS
         w8ZOp66dTc3vyWerfl8XSOtKN0k+R8hbl98ByFED8LNgEchZh+YOGM++1CFfAVrtUzHE
         cl4aWnP9O5Ms9C+GXpvWAOZHL+Sy/G7jRgXc7UYdP2nEw6Iu2JHM5mLkKYvkrtbQrfFE
         Fv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BLFyaOdYHKpWV9FodMEilP4BpCc1KRMqeXoJ4Bn9qQI=;
        b=OpF+ckMVnAjJ2BB6kqA8VMtnyphZ8vvdIH7hexdOb3m7iLfiOns2KYC5RqYt1tSeSr
         yohRtmvVU89WiOTUEar2gILH2TYb/TA70rkH/PDmCllukAlWt3cIFEOJZKpuajRbzPGx
         13D4aVrf58DxnJ1sGRokG7uZmFKoPKfndwSwAWHAQ8vM2+Oh81rh7h6nZNZR7zX3dfuW
         btJpht6oEwVvtNnK/PkEy4HC93BFdqb/+hbEnOkLfG2cB3v0CKJrvO0mVoYPVT5C1VaF
         rnq2f7quvaB3ENisC9KGo+MH0tCAyeySRUJO78/7Jdz3EvqmOYWvdTWmqhXaAZP0Bczw
         RmlQ==
X-Gm-Message-State: APjAAAX8WJ8NqrhNpvzUMHqlioNKvfwDy2FgDwq4AY/8ojx2XRI2d/lS
        uFggAgGX4cGLPN/h3H1YUFc=
X-Google-Smtp-Source: APXvYqwB1yONZbpLsiO8fKoAxYuHi2PoBLN99OgnxiiHvQC7nKcQNrM1uZX4uXa5EyXbJbqxxClKew==
X-Received: by 2002:a17:902:9896:: with SMTP id s22mr31237253plp.4.1562171494548;
        Wed, 03 Jul 2019 09:31:34 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q3sm2456747pgv.21.2019.07.03.09.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:31:34 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 29/35] nfsd: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:31:26 +0800
Message-Id: <20190703163126.761-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

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

