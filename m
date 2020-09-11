Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957A82657DC
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Sep 2020 06:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgIKEDg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Sep 2020 00:03:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgIKEDb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Sep 2020 00:03:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D20A43D6DBB88964D9F0;
        Fri, 11 Sep 2020 12:03:29 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 12:03:19 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next] nfsd: fix comparison to bool warning
Date:   Fri, 11 Sep 2020 12:10:14 +0800
Message-ID: <20200911041014.120723-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes coccicheck warning:

fs/nfsd/nfs4proc.c:3234:5-29: WARNING: Comparison to bool

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eaf50eafa935..63e5a4844d8c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3231,7 +3231,7 @@ bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 	if (!cstate->minorversion)
 		return false;

-	if (cstate->spo_must_allowed == true)
+	if (cstate->spo_must_allowed)
 		return true;

 	opiter = resp->opcnt;
--
2.26.0.106.g9fadedd

