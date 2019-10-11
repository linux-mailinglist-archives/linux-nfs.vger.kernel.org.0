Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB2D44E3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 18:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfJKQDB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 12:03:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:63466 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfJKQDB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Oct 2019 12:03:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 09:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="369457421"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Oct 2019 09:02:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E549B16A; Fri, 11 Oct 2019 19:02:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] nfsd: remove private bin2hex implementation
Date:   Fri, 11 Oct 2019 19:02:58 +0300
Message-Id: <20191011160258.8562-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Calling sprintf in a loop is not very efficient, and in any case,
we already have an implementation of bin-to-hex conversion in lib/
which we might as well use.

Note that original code used to nul-terminate the destination while
bin2hex doesn't. That's why replace kmalloc() with kzalloc().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/nfsd/nfs4recover.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index cdc75ad4438b..29dff4c6e752 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1850,19 +1850,14 @@ nfsd4_umh_cltrack_upcall(char *cmd, char *arg, char *env0, char *env1)
 static char *
 bin_to_hex_dup(const unsigned char *src, int srclen)
 {
-	int i;
-	char *buf, *hex;
+	char *buf;
 
 	/* +1 for terminating NULL */
-	buf = kmalloc((srclen * 2) + 1, GFP_KERNEL);
+	buf = kzalloc((srclen * 2) + 1, GFP_KERNEL);
 	if (!buf)
 		return buf;
 
-	hex = buf;
-	for (i = 0; i < srclen; i++) {
-		sprintf(hex, "%2.2x", *src++);
-		hex += 2;
-	}
+	bin2hex(buf, src, srclen);
 	return buf;
 }
 
-- 
2.23.0

