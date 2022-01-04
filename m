Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D203484AA5
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jan 2022 23:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiADWYq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jan 2022 17:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiADWYq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jan 2022 17:24:46 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85E1C061761
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jan 2022 14:24:45 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2A12872F7; Tue,  4 Jan 2022 17:24:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2A12872F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641335085;
        bh=gnlPJfVq0juSsFwdAVk5gsjcd5RsGD159xB2VHLYKLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQy9NJoLl1L/otkRtkiI2dn7arlIAavefelZY3z1mPGq25m18wW0XPwVEZGzCd+O/
         Bw0ACngkbUDwrdQgHPYd9qjMQ2YlXNBq1Bgjt8qFoHCRmpX0sNO7iUi+0Jey2u4RSo
         y0oVyy+3XmZkIblp5knNYNR8J13DKwmr01E1l0k8=
Date:   Tue, 4 Jan 2022 17:24:45 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsdcld: use WAL journal for faster commits
Message-ID: <20220104222445.GF12040@fieldses.org>
References: <20211201174205.GB26415@fieldses.org>
 <20211201180339.GC26415@fieldses.org>
 <20211201195050.GE26415@fieldses.org>
 <20211203212200.GB3930@fieldses.org>
 <20211203215531.GC3930@fieldses.org>
 <469DF1ED-C2AB-43CE-AB70-BFD2AFC2A68D@oracle.com>
 <20211203223921.GA6151@fieldses.org>
 <915221EC-387C-4F50-83C6-8DCF02DD2A5D@oracle.com>
 <20211204012402.GA7805@fieldses.org>
 <57EA2D75-823E-4164-9000-E7C7C970C60B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57EA2D75-823E-4164-9000-E7C7C970C60B@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Currently nfsdcld is doing three fdatasyncs for each upcall.  Based on
SQLite documentation, WAL mode should also be safe, and I can confirm
from an strace that it results in only one fdatasync each.

This may be a bottleneck e.g. when lots of clients are being created or
expired at once (e.g. on reboot).

Not bothering with error checking, as this is just an optimization and
nfsdcld will still function without.  (Might be better to log something
on failure, though.)

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 aclocal/libsqlite3.m4  | 2 +-
 utils/nfsdcld/sqlite.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

Resending to make sure SteveD saw this....--b.

diff --git a/aclocal/libsqlite3.m4 b/aclocal/libsqlite3.m4
index 8c38993cbba8..c3beb4d56f0c 100644
--- a/aclocal/libsqlite3.m4
+++ b/aclocal/libsqlite3.m4
@@ -22,7 +22,7 @@ AC_DEFUN([AC_SQLITE3_VERS], [
 		int vers = sqlite3_libversion_number();
 
 		return vers != SQLITE_VERSION_NUMBER ||
-			vers < 3003000;
+			vers < 3007000;
 	}
        ], [libsqlite3_cv_is_recent=yes], [libsqlite3_cv_is_recent=no],
        [libsqlite3_cv_is_recent=unknown])
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 03016fb95823..eabb0daa95f5 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -826,6 +826,8 @@ sqlite_prepare_dbh(const char *topdir)
 		goto out_close;
 	}
 
+	sqlite3_exec(dbh, "PRAGMA journal_mode = WAL;", NULL, NULL, NULL);
+
 	ret = sqlite_query_schema_version();
 	switch (ret) {
 	case CLD_SQLITE_LATEST_SCHEMA_VERSION:
-- 
2.33.1

