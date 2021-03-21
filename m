Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD72343201
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Mar 2021 11:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCUKu5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Mar 2021 06:50:57 -0400
Received: from smtp.h3c.com ([60.191.123.56]:1565 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCUKu2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 21 Mar 2021 06:50:28 -0400
X-Greylist: delayed 6991 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2021 06:50:27 EDT
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 12L8rrZp088876;
        Sun, 21 Mar 2021 16:53:53 +0800 (GMT-8)
        (envelope-from xi.fengfei@h3c.com)
Received: from DAG2EX05-BASE.srv.huawei-3com.com ([10.8.0.68])
        by h3cspam01-ex.h3c.com with ESMTP id 12L8r01H088652;
        Sun, 21 Mar 2021 16:53:00 +0800 (GMT-8)
        (envelope-from xi.fengfei@h3c.com)
Received: from localhost.localdomain (10.99.222.162) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Mar 2021 16:53:03 +0800
From:   Fengfei Xi <xi.fengfei@h3c.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>
CC:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fengfei Xi <xi.fengfei@h3c.com>
Subject: [PATCH] nfs_common: modify the comments for locks_end_grace and locks_in_grace
Date:   Sun, 21 Mar 2021 16:38:06 +0800
Message-ID: <20210321083806.842-1-xi.fengfei@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.222.162]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 12L8rrZp088876
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch moves the comment for the @net parameter to the right place.

Signed-off-by: Fengfei Xi <xi.fengfei@h3c.com>
---
 fs/nfs_common/grace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
index 26f2a50ec..9b1a5c7d3 100644
--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -42,7 +42,6 @@ EXPORT_SYMBOL_GPL(locks_start_grace);
 
 /**
  * locks_end_grace
- * @net: net namespace that this lock manager belongs to
  * @lm: who this grace period is for
  *
  * Call this function to state that the given lock manager is ready to
@@ -82,6 +81,7 @@ __state_in_grace(struct net *net, bool open)
 
 /**
  * locks_in_grace
+ * @net: net namespace that this lock manager belongs to
  *
  * Lock managers call this function to determine when it is OK for them
  * to answer ordinary lock requests, and when they should accept only
-- 
2.17.1

