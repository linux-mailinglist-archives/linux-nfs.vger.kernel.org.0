Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B686F1CD93B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 14:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEKMBK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 08:01:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729416AbgEKMBJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 11 May 2020 08:01:09 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5EE5B974246F5E3FBDED;
        Mon, 11 May 2020 20:01:07 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 20:01:01 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] nfsd: Fix old-style function definition
Date:   Mon, 11 May 2020 20:07:08 +0800
Message-ID: <1589198828-11226-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix warning:

fs/nfsd/nfssvc.c:604:6: warning: old-style function definition [-Wold-style-definition]
 bool i_am_nfsd()
      ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 fs/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 4f588c0..b603dfc 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -601,7 +601,7 @@ static const struct svc_serv_ops nfsd_thread_sv_ops = {
 	.svo_module		= THIS_MODULE,
 };

-bool i_am_nfsd()
+bool i_am_nfsd(void)
 {
 	return kthread_func(current) == nfsd;
 }
--
2.6.2

