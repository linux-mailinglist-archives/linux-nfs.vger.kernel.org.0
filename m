Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32D93D31B
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404562AbfFKQ5z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 12:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404099AbfFKQ5z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 12:57:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E1CB859FE;
        Tue, 11 Jun 2019 16:57:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC49F5C219;
        Tue, 11 Jun 2019 16:57:52 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 1ABB2109C3D0; Tue, 11 Jun 2019 12:57:52 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     syzbot <syzbot+7fe11b49c1cc30e3fce2@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Cleanup if nfs_match_client is interrupted
Date:   Tue, 11 Jun 2019 12:57:52 -0400
Message-Id: <65b675cec79d140df64bc30def88b1def32bf87e.1560272160.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 11 Jun 2019 16:57:55 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Don't bail out before cleaning up a new allocation if the wait for
searching for a matching nfs client is interrupted.  Memory leaks.

Reported-by: syzbot+7fe11b49c1cc30e3fce2@syzkaller.appspotmail.com
Fixes: 950a578c6128 ("NFS: make nfs_match_client killable")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index d7e4f0848e28..4d90f5bf0b0a 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -406,10 +406,10 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 		clp = nfs_match_client(cl_init);
 		if (clp) {
 			spin_unlock(&nn->nfs_client_lock);
-			if (IS_ERR(clp))
-				return clp;
 			if (new)
 				new->rpc_ops->free_client(new);
+			if (IS_ERR(clp))
+				return clp;
 			return nfs_found_client(cl_init, clp);
 		}
 		if (new) {
-- 
2.20.1

