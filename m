Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610582A8D51
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 04:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgKFDDo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 22:03:44 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:59561 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKFDDo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 22:03:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UENtB6e_1604631821;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UENtB6e_1604631821)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 11:03:42 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     trond.myklebust@hammerspace.com, chuck.lever@oracle.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/lockd: remove unused NLM4_void_sz to tame compiler
Date:   Fri,  6 Nov 2020 11:03:38 +0800
Message-Id: <1604631818-78131-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This macro isn't used, so let's remove it to tame gcc.
fs/lockd/clnt4xdr.c:34:0: warning: macro "NLM4_void_sz" is not used
[-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com> 
Cc: Anna Schumaker <anna.schumaker@netapp.com> 
Cc: "J. Bruce Fields" <bfields@fieldses.org> 
Cc: Chuck Lever <chuck.lever@oracle.com> 
Cc: linux-nfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/lockd/clnt4xdr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 7df6324ccb8a..7b1823b2034a 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -31,7 +31,6 @@
  * Declare the space requirements for NLM arguments and replies as
  * number of 32bit-words
  */
-#define NLM4_void_sz		(0)
 #define NLM4_cookie_sz		(1+(NLM_MAXCOOKIELEN>>2))
 #define NLM4_caller_sz		(1+(NLMCLNT_OHSIZE>>2))
 #define NLM4_owner_sz		(1+(NLMCLNT_OHSIZE>>2))
-- 
1.8.3.1

