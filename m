Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1973841C17C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 11:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbhI2JTm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 05:19:42 -0400
Received: from m12-13.163.com ([220.181.12.13]:47546 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhI2JTl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Sep 2021 05:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hlirU
        B/yAn/dC1uLqVE443efNbcN20xlJKTntEUyl+M=; b=Irc7MT5OpBf0aVccoOa/x
        Bhq4PsW7mb8GBVQcNbsg9s+ZtdloeGnKP5r8xwWCn1BirLdF/ajucjZ2fFuD9Jz8
        19zZkfMvaG7XGdQJJw+/QbLqteqNvsWNUjOdErGvwOa1PFNDhu00siJVTAehy49+
        /zAp9eLVpZW9BwizPll7fs=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowAC3q7gBL1RhSilEGg--.19878S2;
        Wed, 29 Sep 2021 17:16:52 +0800 (CST)
From:   dingsenjie@163.com
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] fs: nfsd: Simplify the return expression of numeric_name_to_id
Date:   Wed, 29 Sep 2021 17:16:26 +0800
Message-Id: <20210929091626.11828-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAC3q7gBL1RhSilEGg--.19878S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4UXrykCw4UJFWDtw1DKFg_yoWfZFc_Gw
        4Iq3y8uFs0yrW5CrZ8JFWjqryvvayktr10g3yIgay7GF98Jw48Zrs3AF9rGFyUWFWrXF98
        ur1xGrWak3W09jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8ltC7UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiYwUdyFaEEsHVfgAAsZ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Simplify the return expression in the nfs4idmap.c

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 fs/nfsd/nfs4idmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index f92161c..dc5926c 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -603,7 +603,6 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
 static bool
 numeric_name_to_id(struct svc_rqst *rqstp, int type, const char *name, u32 namelen, u32 *id)
 {
-	int ret;
 	char buf[11];
 
 	if (namelen + 1 > sizeof(buf))
@@ -612,8 +611,7 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
 	/* Just to make sure it's null-terminated: */
 	memcpy(buf, name, namelen);
 	buf[namelen] = '\0';
-	ret = kstrtouint(buf, 10, id);
-	return ret == 0;
+	return kstrtouint(buf, 10, id) == 0;
 }
 
 static __be32
-- 
1.9.1


