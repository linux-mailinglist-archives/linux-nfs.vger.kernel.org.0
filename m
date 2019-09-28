Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B60C0F95
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Sep 2019 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfI1EXe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Sep 2019 00:23:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbfI1EXe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Sep 2019 00:23:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EA4987B802DAB0B9EB8C;
        Sat, 28 Sep 2019 12:23:30 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 12:23:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <trondmy@gmail.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] nfsd: remove set but not used variable 'len'
Date:   Sat, 28 Sep 2019 12:21:56 +0800
Message-ID: <20190928042156.43228-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/nfsd/nfs4xdr.c: In function nfsd4_encode_splice_read:
fs/nfsd/nfs4xdr.c:3464:7: warning: variable len set but not used [-Wunused-but-set-variable]

It is not used since commit 83a63072c815 ("nfsd: fix nfs read eof detection")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/nfsd/nfs4xdr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 533d0fc..1883370 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3461,7 +3461,6 @@ static __be32 nfsd4_encode_splice_read(
 	struct xdr_stream *xdr = &resp->xdr;
 	struct xdr_buf *buf = xdr->buf;
 	u32 eof;
-	long len;
 	int space_left;
 	__be32 nfserr;
 	__be32 *p = xdr->p - 2;
@@ -3470,7 +3469,6 @@ static __be32 nfsd4_encode_splice_read(
 	if (xdr->end - xdr->p < 1)
 		return nfserr_resource;
 
-	len = maxcount;
 	nfserr = nfsd_splice_read(read->rd_rqstp, read->rd_fhp,
 				  file, read->rd_offset, &maxcount, &eof);
 	read->rd_length = maxcount;
-- 
2.7.4


