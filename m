Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5334FD9752
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 18:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405164AbfJPQ23 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 12:28:29 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59510 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404056AbfJPQ23 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Oct 2019 12:28:29 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKm9u-0005Zl-LF; Wed, 16 Oct 2019 17:28:22 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKm9u-0004sY-4d; Wed, 16 Oct 2019 17:28:22 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [V2] NFSv4: add declaration of current_stateid
Date:   Wed, 16 Oct 2019 17:28:21 +0100
Message-Id: <20191016162821.18711-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

The current_stateid is exported from nfs4state.c but not
declared in any of the headers. Add to nfs4_fs.h to
remove the following warning:

fs/nfs/nfs4state.c:80:20: warning: symbol 'current_stateid' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

chnages since v1:
- removed extra definition of current_stateid
- renamed nfs4_stateid_is_current's current_stateid to avoid shadow
---
 fs/nfs/nfs4_fs.h  | 2 ++
 fs/nfs/nfs4proc.c | 6 +++---
 fs/nfs/pnfs.c     | 2 --
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 16b2e5cc3e94..330f45268060 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -445,6 +445,8 @@ extern void nfs4_set_lease_period(struct nfs_client *clp,
 
 
 /* nfs4state.c */
+extern const nfs4_stateid current_stateid;
+
 const struct cred *nfs4_get_clid_cred(struct nfs_client *clp);
 const struct cred *nfs4_get_machine_cred(struct nfs_client *clp);
 const struct cred *nfs4_get_renew_cred(struct nfs_client *clp);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ab8ca20fd579..ef914d8ba5b7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5101,12 +5101,12 @@ static bool nfs4_stateid_is_current(nfs4_stateid *stateid,
 		const struct nfs_lock_context *l_ctx,
 		fmode_t fmode)
 {
-	nfs4_stateid current_stateid;
+	nfs4_stateid _current_stateid;
 
 	/* If the current stateid represents a lost lock, then exit */
-	if (nfs4_set_rw_stateid(&current_stateid, ctx, l_ctx, fmode) == -EIO)
+	if (nfs4_set_rw_stateid(&_current_stateid, ctx, l_ctx, fmode) == -EIO)
 		return true;
-	return nfs4_stateid_match(stateid, &current_stateid);
+	return nfs4_stateid_match(stateid, &_current_stateid);
 }
 
 static bool nfs4_error_stateid_expired(int err)
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index bb80034a7661..cec3070ab577 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2160,8 +2160,6 @@ _pnfs_grab_empty_layout(struct inode *ino, struct nfs_open_context *ctx)
 	return NULL;
 }
 
-extern const nfs4_stateid current_stateid;
-
 static void _lgopen_prepare_attached(struct nfs4_opendata *data,
 				     struct nfs_open_context *ctx)
 {
-- 
2.23.0

