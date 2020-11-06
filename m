Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680BF2A8EF5
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 06:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbgKFFlO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 00:41:14 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42296 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbgKFFlO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 00:41:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UEOe1Xg_1604641259;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEOe1Xg_1604641259)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 13:41:00 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     bfields@fieldses.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd/nfs3: remove unused macro nfsd3_fhandleres
Date:   Fri,  6 Nov 2020 13:40:57 +0800
Message-Id: <1604641257-6159-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The macro is unused, remove it to tame gcc warning:
fs/nfsd/nfs3proc.c:702:0: warning: macro "nfsd3_fhandleres" is not used
[-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org> 
Cc: Chuck Lever <chuck.lever@oracle.com> 
Cc: linux-nfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/nfsd/nfs3proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 781e265921aa..6e79bae0af4d 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -687,7 +687,6 @@
 #define nfsd3_mkdirargs			nfsd3_createargs
 #define nfsd3_readdirplusargs		nfsd3_readdirargs
 #define nfsd3_fhandleargs		nfsd_fhandle
-#define nfsd3_fhandleres		nfsd3_attrstat
 #define nfsd3_attrstatres		nfsd3_attrstat
 #define nfsd3_wccstatres		nfsd3_attrstat
 #define nfsd3_createres			nfsd3_diropres
-- 
1.8.3.1

