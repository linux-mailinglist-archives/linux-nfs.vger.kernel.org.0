Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA5376F9
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 16:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfFFOkG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 10:40:06 -0400
Received: from fieldses.org ([173.255.197.46]:36502 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfFFOkG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jun 2019 10:40:06 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C8DD11C95; Thu,  6 Jun 2019 10:40:05 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/2] nfsd: use 64-bit seconds fields in nfsd v4 code
Date:   Thu,  6 Jun 2019 10:40:03 -0400
Message-Id: <1559832004-26631-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

After commit 95582b008388 "vfs: change inode times to use struct
timespec64" there are spots in the NFSv4 decoding where we decode the
protocol into a struct timeval and then convert that into a timeval64.

That's unnecesary in the NFSv4 case since the on-the-wire protocol also
uses 64-bit values.  So just fix up our code to use timeval64 everywhere.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/blocklayout.c |  8 +++-----
 fs/nfsd/nfs4xdr.c     | 13 ++++---------
 fs/nfsd/xdr4.h        |  2 +-
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 4fb1f72a25fb..66d4c55eb48e 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -121,15 +121,13 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 {
 	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
-	struct timespec ts;
 	int error;
 
-	ts = timespec64_to_timespec(inode->i_mtime);
 	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
-	    timespec_compare(&lcp->lc_mtime, &ts) < 0)
-		lcp->lc_mtime = timespec64_to_timespec(current_time(inode));
+	    timespec64_compare(&lcp->lc_mtime, &inode->i_mtime) < 0)
+		lcp->lc_mtime = current_time(inode);
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
-	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = timespec_to_timespec64(lcp->lc_mtime);
+	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
 
 	if (new_size > i_size_read(inode)) {
 		iattr.ia_valid |= ATTR_SIZE;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 52c4f6daa649..73e6753fb213 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -274,14 +274,12 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
  * we ignore all 32 bits of 'nseconds'.
  */
 static __be32
-nfsd4_decode_time(struct nfsd4_compoundargs *argp, struct timespec *tv)
+nfsd4_decode_time(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 {
 	DECODE_HEAD;
-	u64 sec;
 
 	READ_BUF(12);
-	p = xdr_decode_hyper(p, &sec);
-	tv->tv_sec = sec;
+	p = xdr_decode_hyper(p, &tv->tv_sec);
 	tv->tv_nsec = be32_to_cpup(p++);
 	if (tv->tv_nsec >= (u32)1000000000)
 		return nfserr_inval;
@@ -320,7 +318,6 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		   struct iattr *iattr, struct nfs4_acl **acl,
 		   struct xdr_netobj *label, int *umask)
 {
-	struct timespec ts;
 	int expected_len, len = 0;
 	u32 dummy32;
 	char *buf;
@@ -422,8 +419,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
 			len += 12;
-			status = nfsd4_decode_time(argp, &ts);
-			iattr->ia_atime = timespec_to_timespec64(ts);
+			status = nfsd4_decode_time(argp, &iattr->ia_atime);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
@@ -442,8 +438,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
 			len += 12;
-			status = nfsd4_decode_time(argp, &ts);
-			iattr->ia_mtime = timespec_to_timespec64(ts);
+			status = nfsd4_decode_time(argp, &iattr->ia_mtime);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index feeb6d4bdffd..c2b631eefc6d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -472,7 +472,7 @@ struct nfsd4_layoutcommit {
 	u32			lc_reclaim;	/* request */
 	u32			lc_newoffset;	/* request */
 	u64			lc_last_wr;	/* request */
-	struct timespec		lc_mtime;	/* request */
+	struct timespec64	lc_mtime;	/* request */
 	u32			lc_layout_type;	/* request */
 	u32			lc_up_len;	/* layout length */
 	void			*lc_up_layout;	/* decoded by callback */
-- 
2.21.0

