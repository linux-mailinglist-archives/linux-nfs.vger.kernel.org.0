Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08975AEF0
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 14:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGTM7F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGTM7E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 08:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5058F269D
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 05:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689857900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sx/HzIS/UO4hgoN0aFqF4zaXoqar7pWy8ZsgfEG48iA=;
        b=P1PDCAB/sDBYxkp5v4AdnokcbOiChZ5zzdKSaTosWSmn/8tZezudgiJ9MhE/D97YVaCPYc
        dvL/S5TUKtIg6xo9SNjDsoX17MOPAaAnH7i4zKibtx+iPrRRqKRekbNytY4wqRBXPpXtLu
        TL814ffj55ep2KdDDZKQWOBaPcGK5SE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-_CkjmfvGM4KSkvHYZOIa2g-1; Thu, 20 Jul 2023 08:58:15 -0400
X-MC-Unique: _CkjmfvGM4KSkvHYZOIa2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C091185A795;
        Thu, 20 Jul 2023 12:58:14 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22A4D2166B25;
        Thu, 20 Jul 2023 12:58:14 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     chuck.lever@oracle.com
Cc:     jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, aahringo@redhat.com, agruenba@redhat.com
Subject: [RFC v6.5-rc2 1/3] fs: lockd: nlm_blocked list race fixes
Date:   Thu, 20 Jul 2023 08:58:04 -0400
Message-Id: <20230720125806.1385279-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch fixes races when lockd accessing the global nlm_blocked list.
It was mostly safe to access the list because everything was accessed
from the lockd kernel thread context but there exists cases like
nlmsvc_grant_deferred() that could manipulate the nlm_blocked list and
it can be called from any context.

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/lockd/svclock.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index c43ccdf28ed9..28abec5c451d 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -131,12 +131,14 @@ static void nlmsvc_insert_block(struct nlm_block *block, unsigned long when)
 static inline void
 nlmsvc_remove_block(struct nlm_block *block)
 {
+	spin_lock(&nlm_blocked_lock);
 	if (!list_empty(&block->b_list)) {
-		spin_lock(&nlm_blocked_lock);
 		list_del_init(&block->b_list);
 		spin_unlock(&nlm_blocked_lock);
 		nlmsvc_release_block(block);
+		return;
 	}
+	spin_unlock(&nlm_blocked_lock);
 }
 
 /*
@@ -152,6 +154,7 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
 				file, lock->fl.fl_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end, lock->fl.fl_type);
+	spin_lock(&nlm_blocked_lock);
 	list_for_each_entry(block, &nlm_blocked, b_list) {
 		fl = &block->b_call->a_args.lock.fl;
 		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
@@ -161,9 +164,11 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
 				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
 		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
 			kref_get(&block->b_count);
+			spin_unlock(&nlm_blocked_lock);
 			return block;
 		}
 	}
+	spin_unlock(&nlm_blocked_lock);
 
 	return NULL;
 }
@@ -185,16 +190,19 @@ nlmsvc_find_block(struct nlm_cookie *cookie)
 {
 	struct nlm_block *block;
 
+	spin_lock(&nlm_blocked_lock);
 	list_for_each_entry(block, &nlm_blocked, b_list) {
 		if (nlm_cookie_match(&block->b_call->a_args.cookie,cookie))
 			goto found;
 	}
+	spin_unlock(&nlm_blocked_lock);
 
 	return NULL;
 
 found:
 	dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
 	kref_get(&block->b_count);
+	spin_unlock(&nlm_blocked_lock);
 	return block;
 }
 
@@ -317,6 +325,7 @@ void nlmsvc_traverse_blocks(struct nlm_host *host,
 
 restart:
 	mutex_lock(&file->f_mutex);
+	spin_lock(&nlm_blocked_lock);
 	list_for_each_entry_safe(block, next, &file->f_blocks, b_flist) {
 		if (!match(block->b_host, host))
 			continue;
@@ -325,11 +334,13 @@ void nlmsvc_traverse_blocks(struct nlm_host *host,
 		if (list_empty(&block->b_list))
 			continue;
 		kref_get(&block->b_count);
+		spin_unlock(&nlm_blocked_lock);
 		mutex_unlock(&file->f_mutex);
 		nlmsvc_unlink_block(block);
 		nlmsvc_release_block(block);
 		goto restart;
 	}
+	spin_unlock(&nlm_blocked_lock);
 	mutex_unlock(&file->f_mutex);
 }
 
-- 
2.31.1

