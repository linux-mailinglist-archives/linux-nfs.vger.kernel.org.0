Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293A71270B8
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 23:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLSWdh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 17:33:37 -0500
Received: from fieldses.org ([173.255.197.46]:38774 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLSWdh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Dec 2019 17:33:37 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id EA22247F; Thu, 19 Dec 2019 17:33:36 -0500 (EST)
Date:   Thu, 19 Dec 2019 17:33:36 -0500
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] generic/529: use an ACL that doesn't confuse NFS
Message-ID: <20191219223336.GC12026@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

For historical reasons having to do with Solaris ACL behavior, the Linux
client treats an ACL like the one used as an example here as equivalent
to a mode, causing listxattr to report that no ACL is set on the file.

(See the comment at the top of fs/nfs_common/nfsacl.c in the kernel
source for details, and the "bogus ACL_MASK entry" comment in the same
source file.)  This causes a spurious generic/529 failure on NFS.

As far as I can tell any ACL should trigger the original XFS problem.
So, modify it so as not to hit this odd NFS corner case.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 src/t_attr_corruption.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/t_attr_corruption.c b/src/t_attr_corruption.c
index e7d435b1791f..b5513d44a288 100644
--- a/src/t_attr_corruption.c
+++ b/src/t_attr_corruption.c
@@ -59,7 +59,7 @@ int main(int argc, char *argv[])
 		.e = {
 			{htole16(1), 0, 0},
 			{htole16(4), 0, 0},
-			{htole16(0x10), 0, 0},
+			{htole16(0x10), htole16(4), 0},
 			{htole16(0x20), 0, 0},
 		},
 	};
-- 
2.24.1

