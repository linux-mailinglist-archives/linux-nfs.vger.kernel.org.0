Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FB31438C2
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2020 09:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAUIuC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jan 2020 03:50:02 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50184 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727962AbgAUIuB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jan 2020 03:50:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHXcih_1579596597;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHXcih_1579596597)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:58 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: remove unused macros
Date:   Tue, 21 Jan 2020 16:49:56 +0800
Message-Id: <1579596596-258247-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

MNT_fhs_status_sz/MNT_fhandle3_sz are never used after they were
introduced. So better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com> 
Cc: Anna Schumaker <anna.schumaker@netapp.com> 
Cc: linux-nfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/nfs/mount_clnt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/mount_clnt.c b/fs/nfs/mount_clnt.c
index cb7c10e9721e..35c8cb2d7637 100644
--- a/fs/nfs/mount_clnt.c
+++ b/fs/nfs/mount_clnt.c
@@ -29,9 +29,7 @@
  */
 #define encode_dirpath_sz	(1 + XDR_QUADLEN(MNTPATHLEN))
 #define MNT_status_sz		(1)
-#define MNT_fhs_status_sz	(1)
 #define MNT_fhandle_sz		XDR_QUADLEN(NFS2_FHSIZE)
-#define MNT_fhandle3_sz		(1 + XDR_QUADLEN(NFS3_FHSIZE))
 #define MNT_authflav3_sz	(1 + NFS_MAX_SECFLAVORS)
 
 /*
-- 
1.8.3.1

