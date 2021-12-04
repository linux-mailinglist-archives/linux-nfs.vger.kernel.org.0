Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA554681C7
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Dec 2021 02:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383955AbhLDB12 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 20:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbhLDB12 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 20:27:28 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE661C061751
        for <linux-nfs@vger.kernel.org>; Fri,  3 Dec 2021 17:24:03 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id F206B5FF7; Fri,  3 Dec 2021 20:24:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org F206B5FF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638581042;
        bh=nAS39s0Cl0xEl8NOVCiELpdd2r76k98dUEV5AHOKla0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRrPrFBbARq4pmpge2SWq+dYcU+7GUU0KqCIaIhWp/tYhzGCpG6J6iyN92bATOXpp
         mKmPQerR51NpALubz4YAPD+CEJ639ts2cUjOhOby56eVsypQV8Ijq2u7hjdtnoJ9f5
         hVR7AnY8UhXX6UjQ9DQ0bEC9L/XJTC9QFOz/T6Fk=
Date:   Fri, 3 Dec 2021 20:24:02 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Steve Dickson <SteveD@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsdcld: use WAL journal for faster commits
Message-ID: <20211204012402.GA7805@fieldses.org>
References: <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org>
 <20211201174205.GB26415@fieldses.org>
 <20211201180339.GC26415@fieldses.org>
 <20211201195050.GE26415@fieldses.org>
 <20211203212200.GB3930@fieldses.org>
 <20211203215531.GC3930@fieldses.org>
 <469DF1ED-C2AB-43CE-AB70-BFD2AFC2A68D@oracle.com>
 <20211203223921.GA6151@fieldses.org>
 <915221EC-387C-4F50-83C6-8DCF02DD2A5D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <915221EC-387C-4F50-83C6-8DCF02DD2A5D@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Dec 04, 2021 at 12:35:11AM +0000, Chuck Lever III wrote:
> 
> > On Dec 3, 2021, at 5:39 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > ﻿On Fri, Dec 03, 2021 at 10:07:19PM +0000, Chuck Lever III wrote:
> >> 
> >> 
> >>>> On Dec 3, 2021, at 4:55 PM, Bruce Fields <bfields@fieldses.org> wrote:
> >>> 
> >>> From: "J. Bruce Fields" <bfields@redhat.com>
> >>> 
> >>> Currently nfsdcld is doing three fdatasyncs for each upcall.  Based on
> >>> SQLite documentation, WAL mode should also be safe, and I can confirm
> >>> from an strace that it results in only one fdatasync each.
> >>> 
> >>> This may be a bottleneck e.g. when lots of clients are being created or
> >>> expired at once (e.g. on reboot).
> >>> 
> >>> Not bothering with error checking, as this is just an optimization and
> >>> nfsdcld will still function without.  (Might be better to log something
> >>> on failure, though.)
> >> 
> >> I'm in full philosophical agreement for performance improvements
> >> in this area. There are some caveats for WAL:
> >> 
> >> - It requires SQLite v3.7.0 (2010). configure.ac may need to be
> >>   updated.
> > 
> > Makes sense.  But I dug around a bit, and how to do this is a total
> > mystery to me....
> 
> aclocal/libsqlite3.m4 has an SQLITE_VERSION_NUMBER check.

I looked got stuck trying to figure out why the #%^ it's comparing to
SQLITE_VERSION_NUMBER.  OK, I see now, it's just some sanity check.
Here's take 2.

--b.

From c22d3a2d8576273934773fefac933d4f8e04776b Mon Sep 17 00:00:00 2001
From: "J. Bruce Fields" <bfields@redhat.com>
Date: Fri, 3 Dec 2021 10:27:53 -0500
Subject: [PATCH] nfsdcld: use WAL journal for faster commits

Currently nfsdcld is doing three fdatasyncs for each upcall.  Based on
SQLite documentation, WAL mode should also be safe, and I can confirm
from an strace that it results in only one fdatasync each.

This may be a bottleneck e.g. when lots of clients are being created or
expired at once (e.g. on reboot).

Not bothering with error checking, as this is just an optimization and
nfsdcld will still function without.  (Might be better to log something
on failure, though.)

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 aclocal/libsqlite3.m4  | 2 +-
 utils/nfsdcld/sqlite.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

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

