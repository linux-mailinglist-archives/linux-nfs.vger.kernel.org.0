Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B01B9F2
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2019 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfEMP1G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 May 2019 11:27:06 -0400
Received: from fieldses.org ([173.255.197.46]:58466 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfEMP1F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 May 2019 11:27:05 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7B5FD2014; Mon, 13 May 2019 11:27:05 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/2] nfsd: fh_drop_write in nfsd_unlink
Date:   Mon, 13 May 2019 11:27:03 -0400
Message-Id: <1557761223-14483-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557761223-14483-1-git-send-email-bfields@redhat.com>
References: <1557761223-14483-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

fh_want_write() can now be called twice, but I'm also fixing up the
callers not to do that.

Other cases include setattr and create.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/vfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7dc98e14655d..fc24ee47eab5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1786,12 +1786,12 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	rdentry = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
-		goto out_nfserr;
+		goto out_drop_write;
 
 	if (d_really_is_negative(rdentry)) {
 		dput(rdentry);
-		err = nfserr_noent;
-		goto out;
+		host_err = -ENOENT;
+		goto out_drop_write;
 	}
 
 	if (!type)
@@ -1805,6 +1805,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		host_err = commit_metadata(fhp);
 	dput(rdentry);
 
+out_drop_write:
+	fh_drop_write(fhp);
 out_nfserr:
 	err = nfserrno(host_err);
 out:
-- 
2.21.0

