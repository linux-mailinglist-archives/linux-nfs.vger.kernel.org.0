Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC2399443
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 22:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhFBUIX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 16:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFBUIX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 16:08:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93080C06174A
        for <linux-nfs@vger.kernel.org>; Wed,  2 Jun 2021 13:06:39 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2AD381504; Wed,  2 Jun 2021 16:06:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2AD381504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1622664399;
        bh=UvHJO9Z7G5dy2g+RkhXdMP0YWbL3xe2eieEUe8maNQI=;
        h=Date:To:Subject:From:From;
        b=m9IPLSD095FWmsCosEW25mdF7R6/yTuufoGd9iMXv9a4ko04nhev9jF0dv4EHB9YY
         MPX5FDqkfcGpBI6bgNhnl+NoI1Tnp1qwvks7O28Y0/haSuj/9VKQ3bacAnfwPLbDG/
         unOiO+z2ashhHV8pfmZ0+vLOaE/NicO09ZGhsbe4=
Date:   Wed, 2 Jun 2021 16:06:39 -0400
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: move fsnotify on client creation outside spinlock
Message-ID: <20210602200639.GC6995@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This was causing a "sleeping function called from invalid context"
warning.

I don't think we need the set_and_test_bit() here; clients move from
unconfirmed to confirmed only once, under the client_lock.

The (conf == unconf) is a way to check whether we're in that confirming
case, hopefully that's not too obscure.

Fixes: 472d155a0631 "nfsd: report client confirmation status in "info" file"
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 99dfc668f605..c01ecb7b3fd3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2824,11 +2824,8 @@ move_to_confirmed(struct nfs4_client *clp)
 	list_move(&clp->cl_idhash, &nn->conf_id_hashtbl[idhashval]);
 	rb_erase(&clp->cl_namenode, &nn->unconf_name_tree);
 	add_clp_to_name_tree(clp, &nn->conf_name_tree);
-	if (!test_and_set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags)) {
-		trace_nfsd_clid_confirmed(&clp->cl_clientid);
-		if (clp->cl_nfsd_dentry && clp->cl_nfsd_info_dentry)
-			fsnotify_dentry(clp->cl_nfsd_info_dentry, FS_MODIFY);
-	}
+	set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags);
+	trace_nfsd_clid_confirmed(&clp->cl_clientid);
 	renew_client_locked(clp);
 }
 
@@ -3487,6 +3484,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	/* cache solo and embedded create sessions under the client_lock */
 	nfsd4_cache_create_session(cr_ses, cs_slot, status);
 	spin_unlock(&nn->client_lock);
+	if (conf == unconf)
+		fsnotify_dentry(conf->cl_nfsd_info_dentry, FS_MODIFY);
 	/* init connection and backchannel */
 	nfsd4_init_conn(rqstp, conn, new);
 	nfsd4_put_session(new);
@@ -4095,6 +4094,8 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 	}
 	get_client_locked(conf);
 	spin_unlock(&nn->client_lock);
+	if (conf == unconf)
+		fsnotify_dentry(conf->cl_nfsd_info_dentry, FS_MODIFY);
 	nfsd4_probe_callback(conf);
 	spin_lock(&nn->client_lock);
 	put_client_renew_locked(conf);
-- 
2.31.1

