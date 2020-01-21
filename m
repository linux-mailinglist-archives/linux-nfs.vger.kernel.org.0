Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D743143854
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2020 09:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgAUIes (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jan 2020 03:34:48 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35987 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbgAUIes (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jan 2020 03:34:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ToHWo6T_1579595684;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHWo6T_1579595684)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:34:45 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] locked: remove nlmsvc_decode_norep/grantedres
Date:   Tue, 21 Jan 2020 16:34:42 +0800
Message-Id: <1579595682-251483-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These 2 macros are never used after first git commit Linux-2.6.12-rc2.
So guess better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org> 
Cc: Chuck Lever <chuck.lever@oracle.com> 
Cc: Trond Myklebust <trond.myklebust@hammerspace.com> 
Cc: Anna Schumaker <anna.schumaker@netapp.com> 
Cc: linux-nfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/lockd/svcproc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index d0bb7a6bf005..8b7565c71863 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -534,12 +534,10 @@ static __be32 nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp)
  */
 
 #define nlmsvc_encode_norep	nlmsvc_encode_void
-#define nlmsvc_decode_norep	nlmsvc_decode_void
 #define nlmsvc_decode_testres	nlmsvc_decode_void
 #define nlmsvc_decode_lockres	nlmsvc_decode_void
 #define nlmsvc_decode_unlockres	nlmsvc_decode_void
 #define nlmsvc_decode_cancelres	nlmsvc_decode_void
-#define nlmsvc_decode_grantedres	nlmsvc_decode_void
 
 #define nlmsvc_proc_none	nlmsvc_proc_null
 #define nlmsvc_proc_test_res	nlmsvc_proc_null
-- 
1.8.3.1

