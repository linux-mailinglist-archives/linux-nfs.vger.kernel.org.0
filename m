Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BC4B8DFA
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiBPQ2l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Feb 2022 11:28:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiBPQ2j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Feb 2022 11:28:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0682AE71A
        for <linux-nfs@vger.kernel.org>; Wed, 16 Feb 2022 08:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AB2AB81E61
        for <linux-nfs@vger.kernel.org>; Wed, 16 Feb 2022 16:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C2FC004E1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Feb 2022 16:28:23 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Clean up _lm_ operation names
Date:   Wed, 16 Feb 2022 11:28:22 -0500
Message-Id:  <164502889689.39081.3337081158232370849.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; h=from:subject:message-id; bh=81XFPntv811TARMKyTPkiHah54EUXWjx+qP/bXWSVKQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDSYhcBrSs6t7zGSUDzLOJdBy0oRPbHAMUdDGDrai v4nNTPSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg0mIQAKCRAzarMzb2Z/l/R9D/ 9Iph9x1Em5A+wjRhTl0Qn3BMbOhpheierOpfd+72p5CA6UDoB/VbYujgVcQBBRDyJf2KZog75j7aGW uIm/XGj07CVTYoGrOUagwTNHiSx+JGxvTIMZQDiWI+eCJheFITT/gX3LH7EcpqdyMN5CprLQtKu/D/ ZG6Xha8mPbrD8D7s4WUXnYfXXfeR5J3kYdnGFH668ElrUsZzAK5owckK0dBLJvnDO9tbe5zfgt2LIv zlbH76XWgbXyTLWYhONXS7DXVV2dOHvHf43UNSZNJkAgTzMg7DpCkRi67eLFQ2DT/HZ/aTE0q7NPLn mbMAgmy8ssN5t6EjG1XWMBR+GuQQGYDW80ZPiwG0CNrtS5x4kOer4USFoUEu9yFUW2PLvvAtd8jElT 2mBF637tAUe+kr9qOO+lbjkRQgmcgfA6tpI1NgXqu1QiOjQDsDdhxAHltvdpJ6fxHEszi1vfOjFfrm oYwxYLwacLH+B85mxmZj/FagDZJaeIzaGd5mhZy+TGUP9LDjDs+EJdtoFlPiuTQsUlbuEuFrZT2p5+ PChdUZth14hlFmw7N0MrKWqKUKhF3Jp+oS7MgilfGJfpAmKJY/UVvwlQQRfvKmDt2bj3kSLrJ3ayPK 1hNBqCBaeSVgbF/c7Gq8pANWzTRWrBOyY8Ypd4r/ABiD3EHBlh8FJcw0dLDg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The common practice is to name function instances the same as the
method names, but with a uniquifying prefix. Commit aef9583b234a
("NFSD: Get reference of lockowner when coping file_lock") missed
this -- the new function names should both have been of the form
"nfsd4_lm_*".

Before more _lm_ functions are added in NFSD, rename these two
functions for consistency.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f3b71fd1d134..234e852fcdfa 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6534,7 +6534,7 @@ nfs4_transform_lock_offset(struct file_lock *lock)
 }
 
 static fl_owner_t
-nfsd4_fl_get_owner(fl_owner_t owner)
+nfsd4_lm_get_owner(fl_owner_t owner)
 {
 	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)owner;
 
@@ -6543,7 +6543,7 @@ nfsd4_fl_get_owner(fl_owner_t owner)
 }
 
 static void
-nfsd4_fl_put_owner(fl_owner_t owner)
+nfsd4_lm_put_owner(fl_owner_t owner)
 {
 	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)owner;
 
@@ -6578,8 +6578,8 @@ nfsd4_lm_notify(struct file_lock *fl)
 
 static const struct lock_manager_operations nfsd_posix_mng_ops  = {
 	.lm_notify = nfsd4_lm_notify,
-	.lm_get_owner = nfsd4_fl_get_owner,
-	.lm_put_owner = nfsd4_fl_put_owner,
+	.lm_get_owner = nfsd4_lm_get_owner,
+	.lm_put_owner = nfsd4_lm_put_owner,
 };
 
 static inline void

