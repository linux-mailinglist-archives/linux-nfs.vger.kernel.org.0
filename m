Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1A5330C1
	for <lists+linux-nfs@lfdr.de>; Tue, 24 May 2022 20:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbiEXS5P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 May 2022 14:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbiEXS5O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 May 2022 14:57:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A395B3C6
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 11:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC9CCB81A76
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E19DC34100
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:57:11 +0000 (UTC)
Subject: [PATCH v2 3/6] blargh
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 24 May 2022 14:57:10 -0400
Message-ID: <165341863069.3187.13887522399281155313.stgit@bazille.1015granger.net>
In-Reply-To: <165341832236.3187.8388683641228729897.stgit@bazille.1015granger.net>
References: <165341832236.3187.8388683641228729897.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/locks.c          |    5 ++++-
 fs/nfsd/nfs4state.c |   10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index bfeb6c3de03f..80cc410f72b2 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -292,6 +292,7 @@ void locks_release_private(struct file_lock *fl)
 
 	if (fl->fl_lmops) {
 		if (fl->fl_lmops->lm_put_owner) {
+			trace_printk("lo=%p type=%d\n", fl->fl_owner, fl->fl_type);
 			fl->fl_lmops->lm_put_owner(fl->fl_owner,
 						   fl->fl_type == F_UNLCK);
 			fl->fl_owner = NULL;
@@ -373,8 +374,10 @@ static void locks_copy_conflock(struct file_lock *new, struct file_lock *fl,
 	new->fl_ops = NULL;
 
 	if (fl->fl_lmops) {
-		if (fl->fl_lmops->lm_get_owner)
+		if (fl->fl_lmops->lm_get_owner) {
+			trace_printk("lo=%p type=%d\n", fl->fl_owner, fl->fl_type);
 			fl->fl_lmops->lm_get_owner(fl->fl_owner, lock);
+		}
 	}
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7cedb0da888d..dd8749e96c9f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6742,6 +6742,10 @@ nfsd4_lm_get_owner(fl_owner_t owner, bool lock)
 	nfs4_get_stateowner(&lo->lo_owner);
 	if (lock)
 		atomic_inc(&lo->lo_lockcnt);
+	trace_printk("lo=%p lock=%s lockcnt=%d so_count=%d\n",
+		lo, lock ? "true" : "false",
+		atomic_read(&lo->lo_lockcnt),
+		atomic_read(&lo->lo_owner.so_count));
 	return owner;
 }
 
@@ -6751,6 +6755,10 @@ nfsd4_lm_put_owner(fl_owner_t owner, bool unlock)
 	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)owner;
 
 	if (lo) {
+		trace_printk("lo=%p unlock=%s lockcnt=%d so_count=%d\n",
+			lo, unlock ? "true" : "false",
+			atomic_read(&lo->lo_lockcnt),
+			atomic_read(&lo->lo_owner.so_count));
 		if (unlock)
 			atomic_dec(&lo->lo_lockcnt);
 		nfs4_put_stateowner(&lo->lo_owner);
@@ -7564,6 +7572,8 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 			continue;
 
 		lo = lockowner(sop);
+		trace_printk("lo=%p lockcnt=%d so_count=%d\n",
+			lo, atomic_read(&lo->lo_lockcnt), atomic_read(&sop->so_count));
 		if (atomic_read(&lo->lo_lockcnt) != 0) {
 			spin_unlock(&clp->cl_lock);
 			return nfserr_locks_held;


