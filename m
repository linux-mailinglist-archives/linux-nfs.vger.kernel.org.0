Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB8612A5C3
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2019 04:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLYDMZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Dec 2019 22:12:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfLYDMZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Dec 2019 22:12:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3D8926CD8E7B592D1A2F;
        Wed, 25 Dec 2019 11:12:23 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 11:12:16 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 2/3] nfsd: use true,false for bool variable in nfs4proc.c
Date:   Wed, 25 Dec 2019 11:19:35 +0800
Message-ID: <1577243976-46389-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577243976-46389-1-git-send-email-zhengbin13@huawei.com>
References: <1577243976-46389-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes coccicheck warning:

fs/nfsd/nfs4proc.c:235:1-18: WARNING: Assignment of 0/1 to bool variable
fs/nfsd/nfs4proc.c:368:1-17: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/nfsd/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4798667..d7d910e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -232,7 +232,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	if (!*resfh)
 		return nfserr_jukebox;
 	fh_init(*resfh, NFS4_FHSIZE);
-	open->op_truncate = 0;
+	open->op_truncate = false;

 	if (open->op_create) {
 		/* FIXME: check session persistence and pnfs flags.
@@ -365,7 +365,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL)
 		return nfserr_inval;

-	open->op_created = 0;
+	open->op_created = false;
 	/*
 	 * RFC5661 18.51.3
 	 * Before RECLAIM_COMPLETE done, server should deny new lock
--
2.7.4

