Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CEA3880C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2019 12:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfFGKhy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jun 2019 06:37:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfFGKhy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 7 Jun 2019 06:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 280A23D37;
        Fri,  7 Jun 2019 10:37:54 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7A4482268;
        Fri,  7 Jun 2019 10:37:53 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 5F490109C550; Fri,  7 Jun 2019 06:37:30 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS4: Only set creation opendata if O_CREAT
Date:   Fri,  7 Jun 2019 06:37:30 -0400
Message-Id: <f30e28659d74b2d1ad06fc806174a5364748b51a.1559903672.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 07 Jun 2019 10:37:54 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We can end up in nfs4_opendata_alloc during task exit, in which case
current->fs has already been cleaned up.  This leads to a crash in
current_umask().

Fix this by only setting creation opendata if we are actually doing an open
with O_CREAT.  We can drop the check for NULL nfs4_open_createattrs, since
O_CREAT will never be set for the recovery path.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c29cbef6b53f..a07b5477d059 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1256,10 +1256,20 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct dentry *dentry,
 	atomic_inc(&sp->so_count);
 	p->o_arg.open_flags = flags;
 	p->o_arg.fmode = fmode & (FMODE_READ|FMODE_WRITE);
-	p->o_arg.umask = current_umask();
 	p->o_arg.claim = nfs4_map_atomic_open_claim(server, claim);
 	p->o_arg.share_access = nfs4_map_atomic_open_share(server,
 			fmode, flags);
+	if (flags & O_CREAT) {
+		p->o_arg.umask = current_umask();
+		p->o_arg.label = nfs4_label_copy(p->a_label, label);
+		if (c->sattr != NULL && c->sattr->ia_valid != 0) {
+			p->o_arg.u.attrs = &p->attrs;
+			memcpy(&p->attrs, c->sattr, sizeof(p->attrs));
+
+			memcpy(p->o_arg.u.verifier.data, c->verf,
+					sizeof(p->o_arg.u.verifier.data));
+		}
+	}
 	/* don't put an ACCESS op in OPEN compound if O_EXCL, because ACCESS
 	 * will return permission denied for all bits until close */
 	if (!(flags & O_EXCL)) {
@@ -1283,7 +1293,6 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct dentry *dentry,
 	p->o_arg.server = server;
 	p->o_arg.bitmask = nfs4_bitmask(server, label);
 	p->o_arg.open_bitmap = &nfs4_fattr_bitmap[0];
-	p->o_arg.label = nfs4_label_copy(p->a_label, label);
 	switch (p->o_arg.claim) {
 	case NFS4_OPEN_CLAIM_NULL:
 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
@@ -1296,13 +1305,6 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct dentry *dentry,
 	case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
 		p->o_arg.fh = NFS_FH(d_inode(dentry));
 	}
-	if (c != NULL && c->sattr != NULL && c->sattr->ia_valid != 0) {
-		p->o_arg.u.attrs = &p->attrs;
-		memcpy(&p->attrs, c->sattr, sizeof(p->attrs));
-
-		memcpy(p->o_arg.u.verifier.data, c->verf,
-				sizeof(p->o_arg.u.verifier.data));
-	}
 	p->c_arg.fh = &p->o_res.fh;
 	p->c_arg.stateid = &p->o_res.stateid;
 	p->c_arg.seqid = p->o_arg.seqid;
-- 
2.20.1

