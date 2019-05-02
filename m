Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5724312106
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2019 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEBRbJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 May 2019 13:31:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEBRbJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 May 2019 13:31:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BDB880472;
        Thu,  2 May 2019 17:31:09 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-85.rdu2.redhat.com [10.10.122.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB53A233;
        Thu,  2 May 2019 17:31:09 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id B445021003; Thu,  2 May 2019 13:31:08 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: don't mark all open state for recovery when handling recallable state revoked flag
Date:   Thu,  2 May 2019 13:31:08 -0400
Message-Id: <20190502173108.8796-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 02 May 2019 17:31:09 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Only delegations and layouts can be recalled, so it shouldn't be
necessary to recover all opens when handling the status bit
SEQ4_STATUS_RECALLABLE_STATE_REVOKED.  We'll still wind up calling
nfs41_open_expired() when a TEST_STATEID returns NFS4ERR_DELEG_REVOKED.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 3de36479ed7a..4db9bcf93fad 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2346,8 +2346,8 @@ static void nfs41_handle_recallable_state_revoked(struct nfs_client *clp)
 {
 	/* FIXME: For now, we destroy all layouts. */
 	pnfs_destroy_all_layouts(clp);
-	/* FIXME: For now, we test all delegations+open state+locks. */
-	nfs41_handle_some_state_revoked(clp);
+	nfs_mark_test_expired_all_delegations(clp);
+	nfs4_schedule_state_manager(clp);
 	dprintk("%s: Recallable state revoked on server %s!\n", __func__,
 			clp->cl_hostname);
 }
-- 
2.17.2

