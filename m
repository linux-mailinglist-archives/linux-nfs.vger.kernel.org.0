Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3330B465F90
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Dec 2021 09:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhLBIjP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Dec 2021 03:39:15 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:52910 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230398AbhLBIjP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Dec 2021 03:39:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uz9YS2j_1638434144;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uz9YS2j_1638434144)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 16:35:51 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] NFSD: Fix inconsistent indenting
Date:   Thu,  2 Dec 2021 16:35:42 +0800
Message-Id: <1638434142-44998-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Eliminate the follow smatch warning:

fs/nfsd/nfs4xdr.c:4766 nfsd4_encode_read_plus_hole() warn: inconsistent
indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/nfsd/nfs4xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c286690..3031126 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4763,8 +4763,8 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 		return nfserr_resource;
 
 	*p++ = htonl(NFS4_CONTENT_HOLE);
-	 p   = xdr_encode_hyper(p, read->rd_offset);
-	 p   = xdr_encode_hyper(p, count);
+	p = xdr_encode_hyper(p, read->rd_offset);
+	p = xdr_encode_hyper(p, count);
 
 	*eof = (read->rd_offset + count) >= f_size;
 	*maxcount = min_t(unsigned long, count, *maxcount);
-- 
1.8.3.1

